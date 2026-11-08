///|
#external
pub type ArrowResult

// ============================================================================
// Arrow FFI Declarations
// ============================================================================

///|
#borrow(conn, sql)
extern "C" fn native_query_arrow(conn : Connection, sql : Bytes) -> ArrowResult = "duckdb_mb_query_arrow"

///|
#borrow(result)
extern "C" fn native_arrow_destroy(result : ArrowResult) = "duckdb_mb_arrow_destroy"

///|
#borrow(result)
extern "C" fn native_arrow_column_count(result : ArrowResult) -> Int32 = "duckdb_mb_arrow_column_count"

///|
#borrow(result)
extern "C" fn native_arrow_row_count(result : ArrowResult) -> Int32 = "duckdb_mb_arrow_row_count"

///|
#borrow(result)
extern "C" fn native_arrow_schema(result : ArrowResult) -> Bytes = "duckdb_mb_arrow_schema"

///|
#borrow(result, col)
extern "C" fn native_arrow_get_column_int32(
  result : ArrowResult,
  col : Int32,
) -> Bytes = "duckdb_mb_arrow_get_column_int32"

///|
#borrow(result, col)
extern "C" fn native_arrow_get_column_int64(
  result : ArrowResult,
  col : Int32,
) -> Bytes = "duckdb_mb_arrow_get_column_int64"

///|
#borrow(result, col)
extern "C" fn native_arrow_get_column_double(
  result : ArrowResult,
  col : Int32,
) -> Bytes = "duckdb_mb_arrow_get_column_double"

///|
#borrow(result, col)
extern "C" fn native_arrow_get_column_string(
  result : ArrowResult,
  col : Int32,
) -> Bytes = "duckdb_mb_arrow_get_column_string"

///|
#borrow(result, col)
extern "C" fn native_arrow_get_column_bool(
  result : ArrowResult,
  col : Int32,
) -> Bytes = "duckdb_mb_arrow_get_column_bool"

///|
#borrow(result, col)
extern "C" fn native_arrow_get_column_int32_nullable(
  result : ArrowResult,
  col : Int32,
) -> Bytes = "duckdb_mb_arrow_get_column_int32_nullable"

///|
#borrow(result, col)
extern "C" fn native_arrow_get_column_int64_nullable(
  result : ArrowResult,
  col : Int32,
) -> Bytes = "duckdb_mb_arrow_get_column_int64_nullable"

///|
#borrow(result, col)
extern "C" fn native_arrow_get_column_double_nullable(
  result : ArrowResult,
  col : Int32,
) -> Bytes = "duckdb_mb_arrow_get_column_double_nullable"

///|
#borrow(result, col)
extern "C" fn native_arrow_get_column_string_nullable(
  result : ArrowResult,
  col : Int32,
) -> Bytes = "duckdb_mb_arrow_get_column_string_nullable"

///|
#borrow(result, col)
extern "C" fn native_arrow_get_column_bool_nullable(
  result : ArrowResult,
  col : Int32,
) -> Bytes = "duckdb_mb_arrow_get_column_bool_nullable"

///|
extern "C" fn native_is_null_arrow_result(result : ArrowResult) -> Bool = "duckdb_mb_is_null_arrow_result"

///|
#borrow(data, offset)
extern "C" fn native_bytes_to_double(data : Bytes, offset : Int32) -> Double = "duckdb_mb_bytes_to_double"

// ============================================================================
// Public API
// ============================================================================

///|
pub struct ArrowField {
  name : String
  nullable : Bool
  type_id : String
}

///|
pub struct ArrowSchemaInfo {
  fields : Array[ArrowField]
}

///|
pub fn Connection::query_arrow(
  self : Connection,
  sql : String,
  on_done~ : (Result[ArrowResult, DuckDBError]) -> Unit,
) -> Unit {
  let sql_bytes = @utf8.encode(sql)
  let result = native_query_arrow(self, sql_bytes)
  if native_is_null_arrow_result(result) {
    on_done(Err(DuckDBError::Message(last_error("arrow query failed"))))
  } else {
    on_done(Ok(result))
  }
}

///|
pub fn ArrowResult::column_count(self : ArrowResult) -> Int32 {
  native_arrow_column_count(self)
}

///|
pub fn ArrowResult::row_count(self : ArrowResult) -> Int32 {
  native_arrow_row_count(self)
}

///|
pub fn ArrowResult::get_schema(
  self : ArrowResult,
) -> Result[ArrowSchemaInfo, DuckDBError] {
  let json_bytes = native_arrow_schema(self)
  // Use unsafe conversion for JSON bytes to string
  let json_str = json_str_from_bytes(json_bytes)
  match parse_arrow_schema_json(json_str) {
    Ok(fields) => Ok(ArrowSchemaInfo::{ fields, })
    Err(msg) => Err(DuckDBError::Message("schema parse failed: " + msg))
  }
}

// Helper function to convert Bytes to String

///|
fn json_str_from_bytes(bytes : Bytes) -> String {
  @utf8.decode_lossy(bytes)
}

// Unsafe conversion from Int to Char

///|
fn parse_arrow_schema_json(json : String) -> Result[Array[ArrowField], String] {
  if json.length() < 2 {
    return Err("empty json")
  }

  // Skip outer brackets
  let mut pos = 0
  if json[0] != '[' {
    return Err("not an array")
  }
  pos = pos + 1
  let fields : Array[ArrowField] = []
  while pos < json.length() {
    // Skip whitespace
    while pos < json.length() &&
          (json[pos] == ' ' || json[pos] == '\n' || json[pos] == '\t') {
      pos = pos + 1
    }
    if pos >= json.length() || json[pos] == ']' {
      break
    }
    if json[pos] == '{' {
      pos = pos + 1
      let mut name : String = ""
      let mut nullable : Bool = false
      let mut type_id : String = ""

      // Parse object fields
      while pos < json.length() && json[pos] != '}' {
        // Skip whitespace
        while pos < json.length() &&
              (
                json[pos] == ' ' ||
                json[pos] == ',' ||
                json[pos] == '\n' ||
                json[pos] == '\t'
              ) {
          pos = pos + 1
        }
        if pos >= json.length() || json[pos] == '}' {
          break
        }

        // Find field name
        if json[pos] == '"' {
          pos = pos + 1
          let field_start = pos
          while pos < json.length() && json[pos] != '"' {
            pos = pos + 1
          }
          let field_name = json[field_start:pos].to_owned()
          pos = pos + 1 // skip closing quote

          // Skip to colon
          while pos < json.length() && json[pos] != ':' {
            pos = pos + 1
          }
          pos = pos + 1 // skip colon

          // Skip to value
          while pos < json.length() && (json[pos] == ' ' || json[pos] == '\t') {
            pos = pos + 1
          }

          // Parse value
          if field_name == "name" || field_name == "type_id" {
            if json[pos] == '"' {
              pos = pos + 1
              let value_start = pos
              while pos < json.length() && json[pos] != '"' {
                pos = pos + 1
              }
              let value = json[value_start:pos].to_owned()
              pos = pos + 1 // skip closing quote
              if field_name == "name" {
                name = value
              } else if field_name == "type_id" {
                type_id = value
              }
            }
          } else if field_name == "nullable" {
            if json[pos] == 't' &&
              pos + 4 <= json.length() &&
              json[pos:pos + 4].to_owned() == "true" {
              nullable = true
              pos = pos + 4
            } else if json[pos] == 'f' &&
              pos + 5 <= json.length() &&
              json[pos:pos + 5].to_owned() == "false" {
              nullable = false
              pos = pos + 5
            } else {
              pos = pos + 1
            }
          }
        } else {
          pos = pos + 1
        }
      }
      if pos < json.length() && json[pos] == '}' {
        pos = pos + 1
      }
      fields.push(ArrowField::{ name, nullable, type_id, })
    } else {
      pos = pos + 1
    }
  }
  Ok(fields)
}

///|
pub fn ArrowResult::get_column_int32(
  self : ArrowResult,
  col : Int32,
) -> Array[Int32] {
  let data = native_arrow_get_column_int32(self, col)
  decode_int32_array(data)
}

///|
fn decode_int32_array(data : Bytes) -> Array[Int32] {
  if data.length() < 4 {
    return []
  }
  let count = read_int32_le(data, 0)
  if count <= 0 || count > 1000000 {
    return []
  }
  let expected_len = 4 + count * 4
  if data.length() < expected_len {
    return []
  }
  let result = Array::make(count, 0)
  let mut i = 0
  while i < count {
    result[i] = read_int32_le(data, 4 + i * 4)
    i = i + 1
  }
  result
}

///|
fn read_int32_le(data : Bytes, offset : Int32) -> Int32 {
  if offset + 4 > data.length() {
    return 0
  }
  // Little-endian int32
  let b0 = data[offset].to_int()
  let b1 = data[offset + 1].to_int()
  let b2 = data[offset + 2].to_int()
  let b3 = data[offset + 3].to_int()
  b0 | (b1 << 8) | (b2 << 16) | (b3 << 24)
}

///|
pub fn ArrowResult::get_column_int64(
  self : ArrowResult,
  col : Int32,
) -> Array[Int32] {
  let data = native_arrow_get_column_int64(self, col)
  if data.length() < 4 {
    return []
  }
  let count = read_int32_le(data, 0)
  if count <= 0 || count > 1000000 {
    return []
  }
  let expected_len = 4 + count * 8
  if data.length() < expected_len {
    return []
  }
  let result = Array::make(count, 0)
  let mut i = 0
  while i < count {
    // Int64 values - read as Int (MoonBit Int is int64)
    let base = 4 + i * 8
    let b0 = data[base].to_int()
    let b1 = data[base + 1].to_int()
    let b2 = data[base + 2].to_int()
    let b3 = data[base + 3].to_int()
    let b4 = data[base + 4].to_int()
    let b5 = data[base + 5].to_int()
    let b6 = data[base + 6].to_int()
    let b7 = data[base + 7].to_int()
    result[i] = b0 |
      (b1 << 8) |
      (b2 << 16) |
      (b3 << 24) |
      (b4 << 32) |
      (b5 << 40) |
      (b6 << 48) |
      (b7 << 56)
    i = i + 1
  }
  result
}

///|
pub fn ArrowResult::get_column_double(
  self : ArrowResult,
  col : Int32,
) -> Array[Double] {
  let data = native_arrow_get_column_double(self, col)
  if data.length() < 4 {
    return []
  }
  let count = read_int32_le(data, 0)
  if count <= 0 || count > 1000000 {
    return []
  }
  let expected_len = 4 + count * 8
  if data.length() < expected_len {
    return []
  }
  let result = Array::make(count, 0.0)
  let mut i = 0
  while i < count {
    let base = 4 + i * 8
    // Read 8 bytes as double
    let value = bytes_to_double(data, base)
    result[i] = value
    i = i + 1
  }
  result
}

///|
fn bytes_to_double(data : Bytes, offset : Int32) -> Double {
  // Use C FFI to properly convert 8 bytes to double (IEEE 754 bit-cast)
  if offset + 8 > data.length() {
    return 0.0
  }
  native_bytes_to_double(data, offset)
}

///|
pub fn ArrowResult::get_column_string(
  self : ArrowResult,
  col : Int32,
) -> Array[String] {
  let data = native_arrow_get_column_string(self, col)
  if data.length() < 8 {
    return []
  }
  let count = read_int32_le(data, 0)
  if count <= 0 || count > 1000000 {
    return []
  }
  let result = Array::make(count, "")
  let mut pos = 8 // Skip count and total_data_len headers
  let mut i = 0
  while i < count {
    let start_pos = pos
    // Find null terminator
    while pos < data.length() && data[pos] != 0 {
      pos = pos + 1
    }
    if start_pos < data.length() {
      // Convert BytesView to String using UTF-8 decode
      let bytes_view = data.exact_view(start=start_pos, end=pos)
      result[i] = @utf8.decode_lossy(bytes_view)
    }
    pos = pos + 1 // Skip null terminator
    i = i + 1
  }
  result
}

///|
pub fn ArrowResult::get_column_bool(
  self : ArrowResult,
  col : Int32,
) -> Array[Bool] {
  let data = native_arrow_get_column_bool(self, col)
  if data.length() < 4 {
    return []
  }
  let count = read_int32_le(data, 0)
  if count <= 0 || count > 1000000 {
    return []
  }
  let expected_len = 4 + count
  if data.length() < expected_len {
    return []
  }
  let result = Array::make(count, false)
  let data_start = 4
  let mut i = 0
  while i < count {
    result[i] = data[data_start + i] != 0
    i = i + 1
  }
  result
}

///|
pub fn ArrowResult::close(
  self : ArrowResult,
  on_done~ : (Result[Unit, DuckDBError]) -> Unit,
) -> Unit {
  native_arrow_destroy(self)
  on_done(Ok(()))
}

// ============================================================================
// Nullable Column Getters - Return (values, validity) tuples
// ============================================================================

///|
pub fn ArrowResult::get_column_int32_nullable(
  self : ArrowResult,
  col : Int32,
) -> (Array[Int32], Array[Bool]) {
  let data = native_arrow_get_column_int32_nullable(self, col)
  decode_int32_nullable_array(data)
}

///|
fn decode_int32_nullable_array(data : Bytes) -> (Array[Int32], Array[Bool]) {
  if data.length() < 4 {
    return ([], [])
  }
  let count = read_int32_le(data, 0)
  if count <= 0 || count > 1000000 {
    return ([], [])
  }
  let values_len = count * 4
  let expected_len = 4 + values_len + count
  if data.length() < expected_len {
    return ([], [])
  }
  let values = Array::make(count, 0)
  let validity = Array::make(count, false)
  let values_start = 4
  let validity_start = 4 + values_len
  let mut i = 0
  while i < count {
    values[i] = read_int32_le(data, values_start + i * 4)
    validity[i] = data[validity_start + i] != 0
    i = i + 1
  }
  (values, validity)
}

///|
pub fn ArrowResult::get_column_int64_nullable(
  self : ArrowResult,
  col : Int32,
) -> (Array[Int32], Array[Bool]) {
  let data = native_arrow_get_column_int64_nullable(self, col)
  decode_int64_nullable_array(data)
}

///|
fn decode_int64_nullable_array(data : Bytes) -> (Array[Int32], Array[Bool]) {
  if data.length() < 4 {
    return ([], [])
  }
  let count = read_int32_le(data, 0)
  if count <= 0 || count > 1000000 {
    return ([], [])
  }
  let values_len = count * 8
  let expected_len = 4 + values_len + count
  if data.length() < expected_len {
    return ([], [])
  }
  let values = Array::make(count, 0)
  let validity = Array::make(count, false)
  let values_start = 4
  let validity_start = 4 + values_len
  let mut i = 0
  while i < count {
    let base = values_start + i * 8
    let b0 = data[base].to_int()
    let b1 = data[base + 1].to_int()
    let b2 = data[base + 2].to_int()
    let b3 = data[base + 3].to_int()
    let b4 = data[base + 4].to_int()
    let b5 = data[base + 5].to_int()
    let b6 = data[base + 6].to_int()
    let b7 = data[base + 7].to_int()
    values[i] = b0 |
      (b1 << 8) |
      (b2 << 16) |
      (b3 << 24) |
      (b4 << 32) |
      (b5 << 40) |
      (b6 << 48) |
      (b7 << 56)
    validity[i] = data[validity_start + i] != 0
    i = i + 1
  }
  (values, validity)
}

///|
pub fn ArrowResult::get_column_double_nullable(
  self : ArrowResult,
  col : Int32,
) -> (Array[Double], Array[Bool]) {
  let data = native_arrow_get_column_double_nullable(self, col)
  decode_double_nullable_array(data)
}

///|
fn decode_double_nullable_array(data : Bytes) -> (Array[Double], Array[Bool]) {
  if data.length() < 4 {
    return ([], [])
  }
  let count = read_int32_le(data, 0)
  if count <= 0 || count > 1000000 {
    return ([], [])
  }
  let values_len = count * 8
  let expected_len = 4 + values_len + count
  if data.length() < expected_len {
    return ([], [])
  }
  let values = Array::make(count, 0.0)
  let validity = Array::make(count, false)
  let values_start = 4
  let validity_start = 4 + values_len
  let mut i = 0
  while i < count {
    let base = values_start + i * 8
    values[i] = bytes_to_double(data, base)
    validity[i] = data[validity_start + i] != 0
    i = i + 1
  }
  (values, validity)
}

///|
pub fn ArrowResult::get_column_string_nullable(
  self : ArrowResult,
  col : Int32,
) -> (Array[String], Array[Bool]) {
  let data = native_arrow_get_column_string_nullable(self, col)
  decode_string_nullable_array(data)
}

///|
fn decode_string_nullable_array(data : Bytes) -> (Array[String], Array[Bool]) {
  if data.length() < 8 {
    return ([], [])
  }
  let count = read_int32_le(data, 0)
  let total_data_len = read_int32_le(data, 4)
  if count <= 0 || count > 1000000 {
    return ([], [])
  }
  let expected_len = 8 + total_data_len + count
  if data.length() < expected_len {
    return ([], [])
  }
  let values = Array::make(count, "")
  let validity = Array::make(count, false)
  let data_start = 8
  let validity_start = 8 + total_data_len
  let mut pos = data_start
  let mut i = 0
  while i < count {
    let start_pos = pos
    // Find null terminator
    while pos < data.length() && data[pos] != 0 {
      pos = pos + 1
    }
    if start_pos < data.length() {
      let bytes_view = data.exact_view(start=start_pos, end=pos)
      values[i] = @utf8.decode_lossy(bytes_view)
    }
    pos = pos + 1 // Skip null terminator
    validity[i] = data[validity_start + i] != 0
    i = i + 1
  }
  (values, validity)
}

///|
pub fn ArrowResult::get_column_bool_nullable(
  self : ArrowResult,
  col : Int32,
) -> (Array[Bool], Array[Bool]) {
  let data = native_arrow_get_column_bool_nullable(self, col)
  decode_bool_nullable_array(data)
}

///|
fn decode_bool_nullable_array(data : Bytes) -> (Array[Bool], Array[Bool]) {
  if data.length() < 4 {
    return ([], [])
  }
  let count = read_int32_le(data, 0)
  if count <= 0 || count > 1000000 {
    return ([], [])
  }
  let expected_len = 4 + count + count
  if data.length() < expected_len {
    return ([], [])
  }
  let values = Array::make(count, false)
  let validity = Array::make(count, false)
  let values_start = 4
  let validity_start = 4 + count
  let mut i = 0
  while i < count {
    values[i] = data[values_start + i] != 0
    validity[i] = data[validity_start + i] != 0
    i = i + 1
  }
  (values, validity)
}
