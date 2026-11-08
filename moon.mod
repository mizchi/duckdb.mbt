name = "mizchi/duckdb"

version = "0.6.6"

import {
  "moonbitlang/quickcheck@0.15.1",
}

readme = "README.mbt.md"

repository = "https://github.com/mizchi/duckdb.mbt"

license = "Apache-2.0"

keywords = [ "duckdb" ]

description = "MoonBit bindings for DuckDB (fork of f4ah6o/duckdb that builds on current MoonBit toolchains)"

source = "src"

// Keep the Result-based public API and target-specific imports.

warnings = "-result_error_return-unused_package"
