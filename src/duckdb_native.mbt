///|
#external
priv type NativeResult

///|
#external
priv type NativeChunk

///|
#borrow(path)
extern "C" fn native_connect(path : Bytes) -> Connection = "duckdb_mb_connect"

///|
#borrow(path, config)
extern "C" fn native_connect_with_config(
  path : Bytes,
  config : Config,
) -> Connection = "duckdb_mb_connect_with_config"

///|
extern "C" fn native_config_create() -> Config = "duckdb_mb_config_create"

///|
#borrow(config)
extern "C" fn native_config_destroy(config : Config) = "duckdb_mb_config_destroy"

///|
#borrow(config, key, value)
extern "C" fn native_config_set(
  config : Config,
  key : Bytes,
  value : Bytes,
) -> Bool = "duckdb_mb_config_set"

///|
extern "C" fn native_config_error(config : Config) -> Bytes = "duckdb_mb_config_error"

// ============================================================================
// Appender FFI Declarations
// ============================================================================

///|
#borrow(conn, schema, table)
extern "C" fn native_appender_create(
  conn : Connection,
  schema : Bytes,
  table : Bytes,
) -> Appender = "duckdb_mb_appender_create"

///|
#borrow(append)
extern "C" fn native_appender_destroy(append : Appender) = "duckdb_mb_appender_destroy"

///|
#borrow(append)
extern "C" fn native_appender_error(append : Appender) -> Bytes = "duckdb_mb_appender_error"

///|
#borrow(append)
extern "C" fn native_appender_begin_row(append : Appender) -> Bool = "duckdb_mb_begin_row"

///|
#borrow(append, value)
extern "C" fn native_appender_append_int(
  append : Appender,
  value : Int32,
) -> Bool = "duckdb_mb_append_int"

///|
#borrow(append, value)
extern "C" fn native_appender_append_bigint(
  append : Appender,
  value : Int32,
) -> Bool = "duckdb_mb_append_bigint"

///|
#borrow(append, value)
extern "C" fn native_appender_append_double(
  append : Appender,
  value : Double,
) -> Bool = "duckdb_mb_append_double"

///|
#borrow(append, val)
extern "C" fn native_appender_append_varchar(
  append : Appender,
  val : Bytes,
) -> Bool = "duckdb_mb_append_varchar"

///|
#borrow(append, value)
extern "C" fn native_appender_append_bool(
  append : Appender,
  value : Bool,
) -> Bool = "duckdb_mb_append_bool"

///|
#borrow(append)
extern "C" fn native_appender_append_null(append : Appender) -> Bool = "duckdb_mb_append_null"

///|
#borrow(append)
extern "C" fn native_appender_end_row(append : Appender) -> Bool = "duckdb_mb_end_row"

///|
#borrow(append)
extern "C" fn native_appender_flush(append : Appender) -> Bool = "duckdb_mb_flush"

///|
extern "C" fn native_is_null_appender(append : Appender) -> Bool = "duckdb_mb_is_null_appender"

// ============================================================================
// Date/Timestamp FFI Declarations
// ============================================================================

///|
#borrow(stmt)
extern "C" fn native_bind_date(
  stmt : PreparedStatement,
  index : Int32,
  days : Int32,
) -> Bool = "duckdb_mb_bind_date"

///|
#borrow(stmt)
extern "C" fn native_bind_timestamp(
  stmt : PreparedStatement,
  index : Int32,
  micros : Int64,
) -> Bool = "duckdb_mb_bind_timestamp"

///|
#borrow(append)
extern "C" fn native_appender_append_date(
  append : Appender,
  days : Int32,
) -> Bool = "duckdb_mb_append_date"

///|
#borrow(append)
extern "C" fn native_appender_append_timestamp(
  append : Appender,
  micros : Int64,
) -> Bool = "duckdb_mb_append_timestamp"

// ============================================================================
// Advanced Data Types FFI Declarations
// ============================================================================

// ----------------------------------------------------------------------------
// Blob Type
// ----------------------------------------------------------------------------

///|
#borrow(stmt, data)
extern "C" fn native_bind_blob(
  stmt : PreparedStatement,
  index : Int32,
  data : Bytes,
  length : Int32,
) -> Bool = "duckdb_mb_bind_blob"

///|
#borrow(append, data)
extern "C" fn native_appender_append_blob(
  append : Appender,
  data : Bytes,
  length : Int32,
) -> Bool = "duckdb_mb_append_blob"

// ----------------------------------------------------------------------------
// Decimal Type
// ----------------------------------------------------------------------------

///|
#borrow(stmt)
extern "C" fn native_bind_decimal(
  stmt : PreparedStatement,
  index : Int32,
  width : Int32,
  scale : Int32,
  lower : Int32,
  upper : Int32,
) -> Bool = "duckdb_mb_bind_decimal"

///|
#borrow(append)
extern "C" fn native_appender_append_decimal(
  append : Appender,
  width : Int32,
  scale : Int32,
  lower : Int32,
  upper : Int32,
) -> Bool = "duckdb_mb_append_decimal"

// ----------------------------------------------------------------------------
// Interval Type
// ----------------------------------------------------------------------------

///|
#borrow(stmt)
extern "C" fn native_bind_interval(
  stmt : PreparedStatement,
  index : Int32,
  months : Int32,
  days : Int32,
  micros : Int64,
) -> Bool = "duckdb_mb_bind_interval"

///|
#borrow(append)
extern "C" fn native_appender_append_interval(
  append : Appender,
  months : Int32,
  days : Int32,
  micros : Int64,
) -> Bool = "duckdb_mb_append_interval"

// ----------------------------------------------------------------------------
// List Type
// ----------------------------------------------------------------------------

///|
#borrow(stmt, values)
extern "C" fn native_bind_list_varchar(
  stmt : PreparedStatement,
  index : Int32,
  values : Array[Bytes],
  count : Int32,
) -> Bool = "duckdb_mb_bind_list_varchar"

// ----------------------------------------------------------------------------
// Struct Type
// ----------------------------------------------------------------------------

///|
#borrow(stmt, field_names, field_values)
extern "C" fn native_bind_struct_varchar(
  stmt : PreparedStatement,
  index : Int32,
  field_names : Array[Bytes],
  field_values : Array[Bytes],
  field_count : Int32,
) -> Bool = "duckdb_mb_bind_struct_varchar"

// ----------------------------------------------------------------------------
// Map Type
// ----------------------------------------------------------------------------

///|
#borrow(stmt, keys, values)
extern "C" fn native_bind_map_varchar_varchar(
  stmt : PreparedStatement,
  index : Int32,
  keys : Array[Bytes],
  values : Array[Bytes],
  entry_count : Int32,
) -> Bool = "duckdb_mb_bind_map_varchar_varchar"

// ----------------------------------------------------------------------------
// Advanced Type Appender Functions
// ----------------------------------------------------------------------------

///|
#borrow(appender, values)
extern "C" fn native_appender_append_list_varchar(
  appender : Appender,
  values : Array[Bytes],
  count : Int32,
) -> Bool = "duckdb_mb_append_list_varchar"

///|
#borrow(appender, field_names, field_values)
extern "C" fn native_appender_append_struct_varchar(
  appender : Appender,
  field_names : Array[Bytes],
  field_values : Array[Bytes],
  field_count : Int32,
) -> Bool = "duckdb_mb_append_struct_varchar"

///|
#borrow(appender, keys, values)
extern "C" fn native_appender_append_map_varchar_varchar(
  appender : Appender,
  keys : Array[Bytes],
  values : Array[Bytes],
  entry_count : Int32,
) -> Bool = "duckdb_mb_append_map_varchar_varchar"

///|
#borrow(conn)
extern "C" fn native_disconnect(conn : Connection) = "duckdb_mb_disconnect"

///|
#borrow(conn, sql)
extern "C" fn native_query(conn : Connection, sql : Bytes) -> NativeResult = "duckdb_mb_query"

///|
#borrow(conn, sql)
extern "C" fn native_query_stream(
  conn : Connection,
  sql : Bytes,
) -> ResultStream = "duckdb_mb_query_stream"

///|
#borrow(result)
extern "C" fn native_result_destroy(result : NativeResult) = "duckdb_mb_result_destroy"

///|
#borrow(result)
extern "C" fn native_result_column_count(result : NativeResult) -> Int32 = "duckdb_mb_result_column_count"

///|
#borrow(result)
extern "C" fn native_result_row_count(result : NativeResult) -> Int32 = "duckdb_mb_result_row_count"

///|
#borrow(result)
extern "C" fn native_result_column_name(
  result : NativeResult,
  col : Int32,
) -> Bytes = "duckdb_mb_result_column_name"

///|
#borrow(result)
extern "C" fn native_result_column_type(
  result : NativeResult,
  col : Int32,
) -> Int32 = "duckdb_mb_result_column_type"

///|
#borrow(result)
extern "C" fn native_result_is_null(
  result : NativeResult,
  col : Int32,
  row : Int32,
) -> Bool = "duckdb_mb_result_is_null"

///|
#borrow(result)
extern "C" fn native_result_value(
  result : NativeResult,
  col : Int32,
  row : Int32,
) -> Bytes = "duckdb_mb_result_value"

///|
#borrow(stream)
extern "C" fn native_stream_destroy(stream : ResultStream) = "duckdb_mb_stream_destroy"

///|
#borrow(stream)
extern "C" fn native_stream_column_count(stream : ResultStream) -> Int32 = "duckdb_mb_stream_column_count"

///|
#borrow(stream, col)
extern "C" fn native_stream_column_name(
  stream : ResultStream,
  col : Int32,
) -> Bytes = "duckdb_mb_stream_column_name"

///|
#borrow(stream)
extern "C" fn native_stream_fetch_chunk(stream : ResultStream) -> NativeChunk = "duckdb_mb_stream_fetch_chunk"

///|
#borrow(chunk)
extern "C" fn native_chunk_destroy(chunk : NativeChunk) = "duckdb_mb_chunk_destroy"

///|
#borrow(chunk)
extern "C" fn native_chunk_row_count(chunk : NativeChunk) -> Int32 = "duckdb_mb_chunk_row_count"

///|
#borrow(chunk)
extern "C" fn native_chunk_column_count(chunk : NativeChunk) -> Int32 = "duckdb_mb_chunk_column_count"

///|
#borrow(chunk, col, row)
extern "C" fn native_chunk_is_null(
  chunk : NativeChunk,
  col : Int32,
  row : Int32,
) -> Bool = "duckdb_mb_chunk_is_null"

///|
#borrow(chunk, col, row)
extern "C" fn native_chunk_value(
  chunk : NativeChunk,
  col : Int32,
  row : Int32,
) -> Bytes = "duckdb_mb_chunk_value"

///|
extern "C" fn native_last_error() -> Bytes = "duckdb_mb_last_error"

///|
#borrow(conn)
extern "C" fn native_is_null_conn(conn : Connection) -> Bool = "duckdb_mb_is_null_conn"

///|
#borrow(result)
extern "C" fn native_is_null_result(result : NativeResult) -> Bool = "duckdb_mb_is_null_result"

///|
#borrow(stream)
extern "C" fn native_is_null_stream(stream : ResultStream) -> Bool = "duckdb_mb_is_null_stream"

///|
#borrow(chunk)
extern "C" fn native_is_null_chunk(chunk : NativeChunk) -> Bool = "duckdb_mb_is_null_chunk"

///|
fn bytes_to_string(bytes : Bytes) -> String {
  @utf8.decode_lossy(bytes)
}

///|
fn last_error(fallback : String) -> String {
  let msg = bytes_to_string(native_last_error())
  if msg is "" {
    fallback
  } else {
    msg
  }
}

///|
pub fn connect(
  on_ready~ : (Result[Connection, DuckDBError]) -> Unit,
  path~ : String = ":memory:",
  backend~ : JsBackend = JsBackend::Auto,
) -> Unit {
  touch_public_types(backend)
  let path_bytes = @utf8.encode(path)
  let conn = native_connect(path_bytes)
  if native_is_null_conn(conn) {
    on_ready(Err(DuckDBError::Message(last_error("duckdb_open failed"))))
  } else {
    on_ready(Ok(conn))
  }
}

///|
pub fn Connection::close(
  self : Connection,
  on_done~ : (Result[Unit, DuckDBError]) -> Unit,
) -> Unit {
  native_disconnect(self)
  on_done(Ok(()))
}

///|
pub fn Connection::query(
  self : Connection,
  sql : String,
  on_done~ : (Result[QueryResult, DuckDBError]) -> Unit,
) -> Unit {
  let result = native_query(self, @utf8.encode(sql))
  if native_is_null_result(result) {
    on_done(Err(DuckDBError::Message(last_error("duckdb_query failed"))))
  } else {
    let column_count = native_result_column_count(result)
    let row_count = native_result_row_count(result)
    let columns : Array[String] = []
    let column_types : Array[ColumnType] = []
    for col = 0; col < column_count; col = col + 1 {
      columns.push(bytes_to_string(native_result_column_name(result, col)))
      column_types.push(
        column_type_from_id(native_result_column_type(result, col)),
      )
    } nobreak {
      ()
    }
    let rows : Array[Array[String]] = []
    let nulls : Array[Array[Bool]] = []
    for row = 0; row < row_count; row = row + 1 {
      let row_values : Array[String] = []
      let row_nulls : Array[Bool] = []
      for col = 0; col < column_count; col = col + 1 {
        let is_null = native_result_is_null(result, col, row)
        row_nulls.push(is_null)
        if is_null {
          row_values.push("")
        } else {
          row_values.push(
            bytes_to_string(native_result_value(result, col, row)),
          )
        }
      } nobreak {
        ()
      }
      rows.push(row_values)
      nulls.push(row_nulls)
    } nobreak {
      ()
    }
    native_result_destroy(result)
    on_done(Ok({ columns, column_types, rows, nulls, }))
  }
}

///|
pub fn Connection::query_stream(
  self : Connection,
  sql : String,
  on_done~ : (Result[ResultStream, DuckDBError]) -> Unit,
) -> Unit {
  let stream = native_query_stream(self, @utf8.encode(sql))
  if native_is_null_stream(stream) {
    on_done(Err(DuckDBError::Message(last_error("duckdb_stream failed"))))
  } else {
    on_done(Ok(stream))
  }
}

///|
pub fn ResultStream::column_count(self : ResultStream) -> Int32 {
  native_stream_column_count(self)
}

///|
pub fn ResultStream::columns(self : ResultStream) -> Array[String] {
  let column_count = self.column_count()
  let columns : Array[String] = []
  for col = 0; col < column_count; col = col + 1 {
    columns.push(bytes_to_string(native_stream_column_name(self, col)))
  } nobreak {
    ()
  }
  columns
}

///|
pub fn ResultStream::next(
  self : ResultStream,
  on_done~ : (Result[DataChunk?, DuckDBError]) -> Unit,
) -> Unit {
  let chunk = native_stream_fetch_chunk(self)
  if native_is_null_chunk(chunk) {
    let msg = bytes_to_string(native_last_error())
    if msg is "" {
      on_done(Ok(None))
    } else {
      on_done(Err(DuckDBError::Message(msg)))
    }
  } else {
    let row_count = native_chunk_row_count(chunk)
    let column_count = native_chunk_column_count(chunk)
    if row_count <= 0 || column_count <= 0 {
      native_chunk_destroy(chunk)
      on_done(Ok(None))
    } else {
      let columns = self.columns()
      let rows : Array[Array[String]] = []
      let nulls : Array[Array[Bool]] = []
      for row = 0; row < row_count; row = row + 1 {
        let row_values : Array[String] = []
        let row_nulls : Array[Bool] = []
        for col = 0; col < column_count; col = col + 1 {
          let is_null = native_chunk_is_null(chunk, col, row)
          row_nulls.push(is_null)
          if is_null {
            row_values.push("")
          } else {
            row_values.push(
              bytes_to_string(native_chunk_value(chunk, col, row)),
            )
          }
        } nobreak {
          ()
        }
        rows.push(row_values)
        nulls.push(row_nulls)
      } nobreak {
        ()
      }
      native_chunk_destroy(chunk)
      on_done(Ok(Some({ columns, rows, nulls, })))
    }
  }
}

///|
pub fn ResultStream::close(
  self : ResultStream,
  on_done~ : (Result[Unit, DuckDBError]) -> Unit,
) -> Unit {
  native_stream_destroy(self)
  on_done(Ok(()))
}

// ============================================================================
// Configuration API Implementation
// ============================================================================

///|
fn config_error(cfg : Config, fallback : String) -> String {
  let msg = bytes_to_string(native_config_error(cfg))
  if msg is "" {
    fallback
  } else {
    msg
  }
}

///|
pub fn Config::create() -> Config {
  native_config_create()
}

///|
pub fn Config::set(
  self : Config,
  key : String,
  value : String,
) -> Result[Unit, DuckDBError] {
  if native_config_set(self, @utf8.encode(key), @utf8.encode(value)) {
    Ok(())
  } else {
    Err(DuckDBError::Message(config_error(self, "config_set failed")))
  }
}

///|
pub fn connect_with_config(
  on_ready~ : (Result[Connection, DuckDBError]) -> Unit,
  config : Config?,
  path~ : String = ":memory:",
  backend~ : JsBackend = JsBackend::Auto,
) -> Unit {
  touch_public_types(backend)
  match config {
    Some(cfg) => {
      let path_bytes = @utf8.encode(path)
      let conn = native_connect_with_config(path_bytes, cfg)
      native_config_destroy(cfg)
      if native_is_null_conn(conn) {
        on_ready(
          Err(
            DuckDBError::Message(last_error("duckdb_open with config failed")),
          ),
        )
      } else {
        on_ready(Ok(conn))
      }
    }
    None => {
      let path_bytes = @utf8.encode(path)
      let conn = native_connect(path_bytes)
      if native_is_null_conn(conn) {
        on_ready(Err(DuckDBError::Message(last_error("duckdb_open failed"))))
      } else {
        on_ready(Ok(conn))
      }
    }
  }
}

// ============================================================================
// Prepared Statement FFI Declarations
// ============================================================================

///|
#borrow(conn, sql)
extern "C" fn native_prepare(
  conn : Connection,
  sql : Bytes,
) -> PreparedStatement = "duckdb_mb_prepare"

///|
#borrow(stmt)
extern "C" fn native_statement_destroy(stmt : PreparedStatement) = "duckdb_mb_statement_destroy"

///|
#borrow(stmt)
extern "C" fn native_statement_error(stmt : PreparedStatement) -> Bytes = "duckdb_mb_statement_error"

///|
#borrow(stmt)
extern "C" fn native_bind_int(
  stmt : PreparedStatement,
  index : Int32,
  value : Int32,
) -> Bool = "duckdb_mb_bind_int"

///|
#borrow(stmt)
extern "C" fn native_bind_bigint(
  stmt : PreparedStatement,
  index : Int32,
  value : Int32,
) -> Bool = "duckdb_mb_bind_bigint"

///|
#borrow(stmt)
extern "C" fn native_bind_double(
  stmt : PreparedStatement,
  index : Int32,
  value : Double,
) -> Bool = "duckdb_mb_bind_double"

///|
#borrow(stmt, val)
extern "C" fn native_bind_varchar(
  stmt : PreparedStatement,
  index : Int32,
  val : Bytes,
) -> Bool = "duckdb_mb_bind_varchar"

///|
#borrow(stmt)
extern "C" fn native_bind_bool(
  stmt : PreparedStatement,
  index : Int32,
  value : Bool,
) -> Bool = "duckdb_mb_bind_bool"

///|
#borrow(stmt)
extern "C" fn native_bind_null(stmt : PreparedStatement, index : Int32) -> Bool = "duckdb_mb_bind_null"

///|
#borrow(stmt)
extern "C" fn native_clear_bindings(stmt : PreparedStatement) -> Bool = "duckdb_mb_clear_bindings"

///|
#borrow(stmt)
extern "C" fn native_execute_prepared(stmt : PreparedStatement) -> NativeResult = "duckdb_mb_execute_prepared"

///|
#borrow(stmt)
extern "C" fn native_execute_prepared_stream(
  stmt : PreparedStatement,
) -> ResultStream = "duckdb_mb_execute_prepared_stream"

///|
#borrow(stmt)
extern "C" fn native_is_null_statement(stmt : PreparedStatement) -> Bool = "duckdb_mb_is_null_statement"

// ============================================================================
// Prepared Statement API Implementation
// ============================================================================

///|
fn statement_error(stmt : PreparedStatement, fallback : String) -> String {
  let msg = bytes_to_string(native_statement_error(stmt))
  if msg is "" {
    fallback
  } else {
    msg
  }
}

///|
pub fn Connection::prepare(
  self : Connection,
  sql : String,
  on_done~ : (Result[PreparedStatement, DuckDBError]) -> Unit,
) -> Unit {
  let stmt = native_prepare(self, @utf8.encode(sql))
  if native_is_null_statement(stmt) {
    on_done(
      Err(DuckDBError::Message(statement_error(stmt, "duckdb_prepare failed"))),
    )
  } else {
    on_done(Ok(stmt))
  }
}

///|
pub fn PreparedStatement::bind_int(
  self : PreparedStatement,
  index : Int32,
  value : Int32,
) -> Result[Unit, DuckDBError] {
  if native_bind_int(self, index, value) {
    Ok(())
  } else {
    Err(DuckDBError::Message(statement_error(self, "bind_int failed")))
  }
}

///|
pub fn PreparedStatement::bind_bigint(
  self : PreparedStatement,
  index : Int32,
  value : Int32,
) -> Result[Unit, DuckDBError] {
  if native_bind_bigint(self, index, value) {
    Ok(())
  } else {
    Err(DuckDBError::Message(statement_error(self, "bind_bigint failed")))
  }
}

///|
pub fn PreparedStatement::bind_double(
  self : PreparedStatement,
  index : Int32,
  value : Double,
) -> Result[Unit, DuckDBError] {
  if native_bind_double(self, index, value) {
    Ok(())
  } else {
    Err(DuckDBError::Message(statement_error(self, "bind_double failed")))
  }
}

///|
pub fn PreparedStatement::bind_varchar(
  self : PreparedStatement,
  index : Int32,
  value : String,
) -> Result[Unit, DuckDBError] {
  if native_bind_varchar(self, index, @utf8.encode(value)) {
    Ok(())
  } else {
    Err(DuckDBError::Message(statement_error(self, "bind_varchar failed")))
  }
}

///|
pub fn PreparedStatement::bind_bool(
  self : PreparedStatement,
  index : Int32,
  value : Bool,
) -> Result[Unit, DuckDBError] {
  if native_bind_bool(self, index, value) {
    Ok(())
  } else {
    Err(DuckDBError::Message(statement_error(self, "bind_bool failed")))
  }
}

///|
pub fn PreparedStatement::bind_null(
  self : PreparedStatement,
  index : Int32,
) -> Result[Unit, DuckDBError] {
  if native_bind_null(self, index) {
    Ok(())
  } else {
    Err(DuckDBError::Message(statement_error(self, "bind_null failed")))
  }
}

///|
pub fn PreparedStatement::clear_bindings(
  self : PreparedStatement,
) -> Result[Unit, DuckDBError] {
  if native_clear_bindings(self) {
    Ok(())
  } else {
    Err(DuckDBError::Message(statement_error(self, "clear_bindings failed")))
  }
}

///|
pub fn PreparedStatement::execute(
  self : PreparedStatement,
  on_done~ : (Result[QueryResult, DuckDBError]) -> Unit,
) -> Unit {
  let result = native_execute_prepared(self)
  if native_is_null_result(result) {
    on_done(
      Err(
        DuckDBError::Message(statement_error(self, "execute_prepared failed")),
      ),
    )
  } else {
    let column_count = native_result_column_count(result)
    let row_count = native_result_row_count(result)
    let columns : Array[String] = []
    let column_types : Array[ColumnType] = []
    for col = 0; col < column_count; col = col + 1 {
      columns.push(bytes_to_string(native_result_column_name(result, col)))
      column_types.push(
        column_type_from_id(native_result_column_type(result, col)),
      )
    } nobreak {
      ()
    }
    let rows : Array[Array[String]] = []
    let nulls : Array[Array[Bool]] = []
    for row = 0; row < row_count; row = row + 1 {
      let row_values : Array[String] = []
      let row_nulls : Array[Bool] = []
      for col = 0; col < column_count; col = col + 1 {
        let is_null = native_result_is_null(result, col, row)
        row_nulls.push(is_null)
        if is_null {
          row_values.push("")
        } else {
          row_values.push(
            bytes_to_string(native_result_value(result, col, row)),
          )
        }
      } nobreak {
        ()
      }
      rows.push(row_values)
      nulls.push(row_nulls)
    } nobreak {
      ()
    }
    native_result_destroy(result)
    on_done(Ok({ columns, column_types, rows, nulls, }))
  }
}

///|
pub fn PreparedStatement::execute_stream(
  self : PreparedStatement,
  on_done~ : (Result[ResultStream, DuckDBError]) -> Unit,
) -> Unit {
  let stream = native_execute_prepared_stream(self)
  if native_is_null_stream(stream) {
    on_done(
      Err(DuckDBError::Message(statement_error(self, "execute_stream failed"))),
    )
  } else {
    on_done(Ok(stream))
  }
}

///|
pub fn PreparedStatement::close(
  self : PreparedStatement,
  on_done~ : (Result[Unit, DuckDBError]) -> Unit,
) -> Unit {
  native_statement_destroy(self)
  on_done(Ok(()))
}

// ============================================================================
// Appender API Implementation
// ============================================================================

///|
fn appender_error(append : Appender, fallback : String) -> String {
  let msg = bytes_to_string(native_appender_error(append))
  if msg is "" {
    fallback
  } else {
    msg
  }
}

///|
pub fn Connection::create_appender(
  self : Connection,
  schema : String,
  table : String,
  on_done~ : (Result[Appender, DuckDBError]) -> Unit,
) -> Unit {
  let append = native_appender_create(
    self,
    @utf8.encode(schema),
    @utf8.encode(table),
  )
  if native_is_null_appender(append) {
    on_done(Err(DuckDBError::Message("create_appender failed")))
  } else {
    on_done(Ok(append))
  }
}

///|
pub fn Appender::begin_row(self : Appender) -> Result[Unit, DuckDBError] {
  if native_appender_begin_row(self) {
    Ok(())
  } else {
    Err(DuckDBError::Message(appender_error(self, "begin_row failed")))
  }
}

///|
pub fn Appender::append_int(
  self : Appender,
  value : Int32,
) -> Result[Unit, DuckDBError] {
  if native_appender_append_int(self, value) {
    Ok(())
  } else {
    Err(DuckDBError::Message(appender_error(self, "append_int failed")))
  }
}

///|
pub fn Appender::append_bigint(
  self : Appender,
  value : Int32,
) -> Result[Unit, DuckDBError] {
  if native_appender_append_bigint(self, value) {
    Ok(())
  } else {
    Err(DuckDBError::Message(appender_error(self, "append_bigint failed")))
  }
}

///|
pub fn Appender::append_double(
  self : Appender,
  value : Double,
) -> Result[Unit, DuckDBError] {
  if native_appender_append_double(self, value) {
    Ok(())
  } else {
    Err(DuckDBError::Message(appender_error(self, "append_double failed")))
  }
}

///|
pub fn Appender::append_varchar(
  self : Appender,
  value : String,
) -> Result[Unit, DuckDBError] {
  if native_appender_append_varchar(self, @utf8.encode(value)) {
    Ok(())
  } else {
    Err(DuckDBError::Message(appender_error(self, "append_varchar failed")))
  }
}

///|
pub fn Appender::append_bool(
  self : Appender,
  value : Bool,
) -> Result[Unit, DuckDBError] {
  if native_appender_append_bool(self, value) {
    Ok(())
  } else {
    Err(DuckDBError::Message(appender_error(self, "append_bool failed")))
  }
}

///|
pub fn Appender::append_null(self : Appender) -> Result[Unit, DuckDBError] {
  if native_appender_append_null(self) {
    Ok(())
  } else {
    Err(DuckDBError::Message(appender_error(self, "append_null failed")))
  }
}

///|
pub fn Appender::end_row(self : Appender) -> Result[Unit, DuckDBError] {
  if native_appender_end_row(self) {
    Ok(())
  } else {
    Err(DuckDBError::Message(appender_error(self, "end_row failed")))
  }
}

///|
pub fn Appender::flush(self : Appender) -> Result[Unit, DuckDBError] {
  if native_appender_flush(self) {
    Ok(())
  } else {
    Err(DuckDBError::Message(appender_error(self, "flush failed")))
  }
}

///|
pub fn Appender::close(
  self : Appender,
  on_done~ : (Result[Unit, DuckDBError]) -> Unit,
) -> Unit {
  native_appender_destroy(self)
  on_done(Ok(()))
}

// ============================================================================
// Date/Timestamp API Implementation
// ============================================================================

///|
pub fn PreparedStatement::bind_date(
  self : PreparedStatement,
  index : Int32,
  days : Int32,
) -> Result[Unit, DuckDBError] {
  if native_bind_date(self, index, days) {
    Ok(())
  } else {
    Err(DuckDBError::Message(statement_error(self, "bind_date failed")))
  }
}

///|
pub fn PreparedStatement::bind_timestamp(
  self : PreparedStatement,
  index : Int32,
  micros : Int64,
) -> Result[Unit, DuckDBError] {
  if native_bind_timestamp(self, index, micros) {
    Ok(())
  } else {
    Err(DuckDBError::Message(statement_error(self, "bind_timestamp failed")))
  }
}

///|
pub fn Appender::append_date(
  self : Appender,
  days : Int32,
) -> Result[Unit, DuckDBError] {
  if native_appender_append_date(self, days) {
    Ok(())
  } else {
    Err(DuckDBError::Message(appender_error(self, "append_date failed")))
  }
}

///|
pub fn Appender::append_timestamp(
  self : Appender,
  micros : Int64,
) -> Result[Unit, DuckDBError] {
  if native_appender_append_timestamp(self, micros) {
    Ok(())
  } else {
    Err(DuckDBError::Message(appender_error(self, "append_timestamp failed")))
  }
}

///|
/// Check if a year is a leap year in the Gregorian calendar.
fn _is_leap_year(year : Int32) -> Bool {
  (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
}

///|
/// Get the number of days in each month (for non-leap years).
fn _days_in_month(m : Int32) -> Int32 {
  match m {
    1 => 31
    2 => 28
    3 => 31
    4 => 30
    5 => 31
    6 => 30
    7 => 31
    8 => 31
    9 => 30
    10 => 31
    11 => 30
    12 => 31
    _ => 30
  }
}

///|
/// Cumulative days before each month (for non-leap years).
fn days_before_month(m : Int32) -> Int32 {
  match m {
    1 => 0
    2 => 31
    3 => 59
    4 => 90
    5 => 120
    6 => 151
    7 => 181
    8 => 212
    9 => 243
    10 => 273
    11 => 304
    12 => 334
    _ => 0
  }
}

///|
/// Count leap years between year 1 and the given year (exclusive).
fn count_leap_years_before(year : Int32) -> Int32 {
  let y = year - 1
  y / 4 - y / 100 + y / 400
}

///|
/// Convert year, month, day to days since 1970-01-01 (Unix epoch).
/// Uses accurate Gregorian calendar calculation with leap year support.
pub fn date_from_ymd(year : Int32, month : Int32, day : Int32) -> Int32 {
  // Days from 1970 to the beginning of the given year
  let year_delta = year - 1970
  let leap_years = count_leap_years_before(year) - count_leap_years_before(1970)
  let year_days = year_delta * 365 + leap_years

  // Days from beginning of year to beginning of month
  let month_days = days_before_month(month)

  // Add leap day if past February in a leap year
  let leap_day = if month > 2 && _is_leap_year(year) { 1 } else { 0 }

  // Day of month (0-indexed)
  let day_days = day - 1
  year_days + month_days + leap_day + day_days
}

///|
/// Convert days since 1970-01-01 to year, month, day.
/// Uses accurate Gregorian calendar calculation with leap year support.
pub fn date_to_ymd(total_days : Int32) -> (Int32, Int32, Int32) {
  // Use a simpler algorithm: count years from 1970
  let mut days = total_days
  let mut year = 1970

  // Count years forward
  while days >= 365 {
    let leap = if _is_leap_year(year) { 1 } else { 0 }
    let days_in_year = 365 + leap
    if days >= days_in_year {
      days = days - days_in_year
      year = year + 1
    } else {
      break
    }
  }

  // Find month
  let is_leap = _is_leap_year(year)
  let mut month = 1
  let mut remaining = days

  // Cumulative days for each month
  while month <= 12 {
    let dim = match month {
      2 => if is_leap { 29 } else { 28 }
      4 | 6 | 9 | 11 => 30
      _ => 31
    }
    if remaining < dim {
      break
    }
    remaining = remaining - dim
    month = month + 1
  }
  let day = remaining + 1
  (year, month, day)
}

///|
/// Convert date components to a timestamp (microseconds since 1970-01-01).
/// Note: This is a simplified calculation. For production use, use a proper date library.
pub fn timestamp_from_ymd_hms(
  year : Int32,
  month : Int32,
  day : Int32,
  hour : Int32,
  minute : Int32,
  second : Int32,
) -> Int64 {
  let date_days = date_from_ymd(year, month, day)
  // Use Int64 to avoid overflow (Int is 32-bit for WASM compatibility)
  let date_days_64 = date_days.to_int64()
  let hour_64 = hour.to_int64()
  let minute_64 = minute.to_int64()
  let second_64 = second.to_int64()
  let day_micros = date_days_64 * 86400L * 1000000L
  let time_micros = (hour_64 * 3600L + minute_64 * 60L + second_64) * 1000000L
  day_micros + time_micros
}

///|
/// Convert timestamp (microseconds since 1970-01-01) to date components.
/// Note: This is a simplified calculation. For production use, use a proper date library.
pub fn timestamp_to_ymd_hms(
  micros : Int64,
) -> (Int32, Int32, Int32, Int32, Int32, Int32) {
  let total_seconds = micros / 1000000L
  let mut days = total_seconds / 86400L
  let mut seconds_in_day = total_seconds % 86400L

  // Handle negative seconds_in_day (fix for negative modulo)
  if seconds_in_day < 0L {
    days = days - 1L
    seconds_in_day = seconds_in_day + 86400L
  }
  let hour = (seconds_in_day / 3600L).to_int()
  let remaining_seconds = seconds_in_day % 3600L
  let minute = (remaining_seconds / 60L).to_int()
  let second = (remaining_seconds % 60L).to_int()
  let (year, month, day) = date_to_ymd(days.to_int())
  (year, month, day, hour, minute, second)
}

// ============================================================================
// Advanced Data Types API Implementation
// ============================================================================

// ----------------------------------------------------------------------------
// Blob Type
// ----------------------------------------------------------------------------

///|
pub fn PreparedStatement::bind_blob(
  self : PreparedStatement,
  index : Int32,
  value : Bytes,
) -> Result[Unit, DuckDBError] {
  if native_bind_blob(self, index, value, Bytes::length(value)) {
    Ok(())
  } else {
    Err(DuckDBError::Message(statement_error(self, "bind_blob failed")))
  }
}

///|
pub fn Appender::append_blob(
  self : Appender,
  value : Bytes,
) -> Result[Unit, DuckDBError] {
  if native_appender_append_blob(self, value, Bytes::length(value)) {
    Ok(())
  } else {
    Err(DuckDBError::Message(appender_error(self, "append_blob failed")))
  }
}

// ----------------------------------------------------------------------------
// Decimal Type
// ----------------------------------------------------------------------------

// Helper function for power of 10

///|
fn _int_pow10(exp : Int32) -> Int32 {
  let mut result = 1
  let mut i = 0
  while i < exp {
    result = result * 10
    i = i + 1
  }
  result
}

///|
pub fn PreparedStatement::bind_decimal(
  self : PreparedStatement,
  index : Int32,
  value : Decimal,
) -> Result[Unit, DuckDBError] {
  // Use 128-bit representation directly from lower/upper parts
  if native_bind_decimal(
      self,
      index,
      value.width,
      value.scale,
      value.lower,
      value.upper,
    ) {
    Ok(())
  } else {
    Err(DuckDBError::Message(statement_error(self, "bind_decimal failed")))
  }
}

///|
pub fn Appender::append_decimal(
  self : Appender,
  value : Decimal,
) -> Result[Unit, DuckDBError] {
  // Use 128-bit representation directly from lower/upper parts
  if native_appender_append_decimal(
      self,
      value.width,
      value.scale,
      value.lower,
      value.upper,
    ) {
    Ok(())
  } else {
    Err(DuckDBError::Message(appender_error(self, "append_decimal failed")))
  }
}

///|
/// Create a decimal from a floating-point value with specified precision.
/// Note: This is approximate due to floating-point representation.
/// For values exceeding 64-bit range, use decimal_from_hugeint instead.
pub fn decimal_from_double(
  value : Double,
  width : Int32,
  scale : Int32,
) -> Decimal {
  let multiplier = _int_pow10(scale)
  let scaled = (value * Double::from_int(multiplier)).to_int()
  // For 64-bit range: upper=0 for positive, upper=-1 for negative
  let upper = if scaled >= 0 { 0 } else { -1 }
  { width, scale, lower: scaled, upper, }
}

///|
/// Convert decimal to floating-point (approximate).
/// For decimals with upper != 0, returns approximation based on lower part only.
pub fn decimal_to_double(decimal : Decimal) -> Double {
  let divisor = Double::from_int(_int_pow10(decimal.scale))
  Double::from_int(decimal.lower) / divisor
}

///|
/// Create a decimal from integer parts (64-bit range).
/// For values exceeding 64-bit range, use decimal_from_hugeint instead.
pub fn decimal_from_parts(
  whole : Int32,
  fractional : Int32,
  scale : Int32,
) -> Decimal {
  let divisor = _int_pow10(scale)
  let value = if whole < 0 {
    whole * divisor - fractional
  } else {
    whole * divisor + fractional
  }
  let width = if whole == 0 {
    String::length(fractional.to_string())
  } else {
    String::length(whole.to_string()) + scale
  }
  let upper = if value >= 0 { 0 } else { -1 }
  { width: width.max(1), scale, lower: value, upper, }
}

///|
/// Get the whole and fractional parts of a decimal (64-bit range).
pub fn decimal_to_parts(decimal : Decimal) -> (Int32, Int32) {
  let divisor = _int_pow10(decimal.scale)
  let whole = decimal.lower / divisor
  let remainder = decimal.lower % divisor
  let fractional = if remainder < 0 { Int32::abs(remainder) } else { remainder }
  (whole, fractional)
}

///|
/// Create a decimal from 128-bit parts.
/// Allows specifying the full 128-bit value for maximum precision.
pub fn decimal_from_hugeint(
  lower : Int32,
  upper : Int32,
  width : Int32,
  scale : Int32,
) -> Decimal {
  { width, scale, lower, upper, }
}

// ----------------------------------------------------------------------------
// Interval Type
// ----------------------------------------------------------------------------

///|
pub fn PreparedStatement::bind_interval(
  self : PreparedStatement,
  index : Int32,
  value : Interval,
) -> Result[Unit, DuckDBError] {
  if native_bind_interval(self, index, value.months, value.days, value.micros) {
    Ok(())
  } else {
    Err(DuckDBError::Message(statement_error(self, "bind_interval failed")))
  }
}

///|
pub fn Appender::append_interval(
  self : Appender,
  value : Interval,
) -> Result[Unit, DuckDBError] {
  if native_appender_append_interval(
      self,
      value.months,
      value.days,
      value.micros,
    ) {
    Ok(())
  } else {
    Err(DuckDBError::Message(appender_error(self, "append_interval failed")))
  }
}

///|
/// Create an interval from months, days, and microseconds.
pub fn interval_from_parts(
  months : Int32,
  days : Int32,
  micros : Int64,
) -> Interval {
  { months, days, micros, }
}

///|
/// Create an interval from days.
pub fn interval_from_days(days : Int32) -> Interval {
  { months: 0, days, micros: 0, }
}

///|
/// Create an interval from hours.
pub fn interval_from_hours(hours : Int32) -> Interval {
  let micros = hours.to_int64() * 3600L * 1000000L
  { months: 0, days: 0, micros, }
}

///|
/// Create an interval from minutes.
pub fn interval_from_minutes(minutes : Int32) -> Interval {
  let micros = minutes.to_int64() * 60L * 1000000L
  { months: 0, days: 0, micros, }
}

///|
/// Create an interval from seconds.
pub fn interval_from_seconds(seconds : Int32) -> Interval {
  let micros = seconds.to_int64() * 1000000L
  { months: 0, days: 0, micros, }
}

///|
/// Create an interval from months.
pub fn interval_from_months(months : Int32) -> Interval {
  { months, days: 0, micros: 0, }
}

///|
/// Get the total microseconds equivalent of this interval.
/// Note: This is approximate since months have varying lengths.
pub fn interval_to_micros(interval : Interval) -> Int64 {
  let days_micros = interval.days.to_int64() * 86400L * 1000000L
  interval.micros + days_micros
}

// ----------------------------------------------------------------------------
// List Type
// ----------------------------------------------------------------------------

///|
pub fn PreparedStatement::bind_list_varchar(
  self : PreparedStatement,
  index : Int32,
  values : Array[String],
) -> Result[Unit, DuckDBError] {
  let encoded = values.map(fn(v) { @utf8.encode(v) })
  if native_bind_list_varchar(self, index, encoded, encoded.length()) {
    Ok(())
  } else {
    Err(DuckDBError::Message(statement_error(self, "bind_list_varchar failed")))
  }
}

///|
/// Create a list from string array.
pub fn list_from_strings(elements : Array[String]) -> List {
  { elements, }
}

///|
/// Get list length.
pub fn list_length(list : List) -> Int32 {
  list.elements.length()
}

///|
/// Get element at index.
pub fn list_get(list : List, index : Int32) -> String? {
  if index >= 0 && index < list.elements.length() {
    Some(list.elements[index])
  } else {
    None
  }
}

// ----------------------------------------------------------------------------
// Struct Type
// ----------------------------------------------------------------------------

///|
pub fn PreparedStatement::bind_struct(
  self : PreparedStatement,
  index : Int32,
  value : Struct,
) -> Result[Unit, DuckDBError] {
  let encoded_names = value.fields.map(fn(f) { @utf8.encode(f) })
  let encoded_values = value.values.map(fn(v) { @utf8.encode(v) })
  if native_bind_struct_varchar(
      self,
      index,
      encoded_names,
      encoded_values,
      value.fields.length(),
    ) {
    Ok(())
  } else {
    Err(DuckDBError::Message(statement_error(self, "bind_struct failed")))
  }
}

///|
/// Create a struct from field names and values.
pub fn struct_from_arrays(
  fields : Array[String],
  values : Array[String],
) -> Struct {
  { fields, values, }
}

///|
/// Create a struct from key-value pairs.
pub fn struct_from_pairs(pairs : Array[(String, String)]) -> Struct {
  let fields = pairs.map(fn(p) { p.0 })
  let values = pairs.map(fn(p) { p.1 })
  { fields, values, }
}

// Helper function to find index in array

///|
fn array_index_of(arr : Array[String], val : String) -> Int32? {
  let mut i = 0
  while i < arr.length() {
    if arr[i] == val {
      return Some(i)
    }
    i = i + 1
  }
  None
}

///|
/// Get field value by name.
pub fn struct_get(s : Struct, field_name : String) -> String? {
  let idx = array_index_of(s.fields, field_name)
  match idx {
    Some(i) => if i < s.values.length() { Some(s.values[i]) } else { None }
    None => None
  }
}

///|
/// Get struct field count.
pub fn struct_field_count(s : Struct) -> Int32 {
  s.fields.length()
}

// ----------------------------------------------------------------------------
// Map Type
// ----------------------------------------------------------------------------

///|
pub fn PreparedStatement::bind_map(
  self : PreparedStatement,
  index : Int32,
  map : Map,
) -> Result[Unit, DuckDBError] {
  let encoded_keys = map.keys.map(fn(k) { @utf8.encode(k) })
  let encoded_values = map.values.map(fn(v) { @utf8.encode(v) })
  if native_bind_map_varchar_varchar(
      self,
      index,
      encoded_keys,
      encoded_values,
      map.keys.length(),
    ) {
    Ok(())
  } else {
    Err(DuckDBError::Message(statement_error(self, "bind_map failed")))
  }
}

///|
/// Create a map from key and value arrays.
pub fn map_from_arrays(keys : Array[String], values : Array[String]) -> Map {
  { keys, values, }
}

///|
/// Create a map from an array of key-value pairs.
pub fn map_from_pairs(pairs : Array[(String, String)]) -> Map {
  let keys = pairs.map(fn(p) { p.0 })
  let values = pairs.map(fn(p) { p.1 })
  { keys, values, }
}

///|
/// Get value by key.
pub fn map_get(m : Map, key : String) -> String? {
  let idx = array_index_of(m.keys, key)
  match idx {
    Some(i) => if i < m.values.length() { Some(m.values[i]) } else { None }
    None => None
  }
}

///|
/// Get map size.
pub fn map_size(map : Map) -> Int32 {
  map.keys.length()
}

// ============================================================================
// Advanced Type Appender Methods
// ============================================================================

///|
/// Append a list of string values to the appender.
pub fn Appender::append_list_varchar(
  self : Appender,
  values : Array[String],
) -> Result[Unit, DuckDBError] {
  let encoded = values.map(fn(v) { @utf8.encode(v) })
  if native_appender_append_list_varchar(self, encoded, encoded.length()) {
    Ok(())
  } else {
    Err(
      DuckDBError::Message(appender_error(self, "append_list_varchar failed")),
    )
  }
}

///|
/// Append a struct value to the appender.
pub fn Appender::append_struct(
  self : Appender,
  value : Struct,
) -> Result[Unit, DuckDBError] {
  let encoded_names = value.fields.map(fn(f) { @utf8.encode(f) })
  let encoded_values = value.values.map(fn(v) { @utf8.encode(v) })
  if native_appender_append_struct_varchar(
      self,
      encoded_names,
      encoded_values,
      value.fields.length(),
    ) {
    Ok(())
  } else {
    Err(DuckDBError::Message(appender_error(self, "append_struct failed")))
  }
}

///|
/// Append a map value to the appender.
pub fn Appender::append_map(
  self : Appender,
  map : Map,
) -> Result[Unit, DuckDBError] {
  let encoded_keys = map.keys.map(fn(k) { @utf8.encode(k) })
  let encoded_values = map.values.map(fn(v) { @utf8.encode(v) })
  if native_appender_append_map_varchar_varchar(
      self,
      encoded_keys,
      encoded_values,
      map.keys.length(),
    ) {
    Ok(())
  } else {
    Err(DuckDBError::Message(appender_error(self, "append_map failed")))
  }
}

// ============================================================================
// List Appender using DuckDB DataChunk API
// ============================================================================

///|
/// Append a list literal as VARCHAR.
/// This serializes the list and relies on DuckDB casting when appropriate.
pub fn Appender::append_list_varchar_value(
  self : Appender,
  values : Array[String],
) -> Result[Unit, DuckDBError] {
  // Build a list literal and rely on DuckDB's cast from VARCHAR to LIST.
  fn escape_list_item(s : String) -> String {
    let sb = StringBuilder()
    for c in s {
      if c == '\'' {
        let _ = sb..write_char('\'')..write_char('\'')
      } else {
        let _ = sb..write_char(c)
      }
    }
    sb.to_string()
  }

  let sb = StringBuilder()
  let _ = sb..write_char('[')
  for i, v in values {
    if i > 0 {
      let _ = sb..write_char(',')..write_char(' ')
    }
    let _ = sb..write_char('\'')
    let _ = sb..write_view(escape_list_item(v))
    let _ = sb..write_char('\'')
  }
  let _ = sb..write_char(']')
  self.append_varchar(sb.to_string())
}
