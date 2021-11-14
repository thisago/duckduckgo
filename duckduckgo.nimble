# Package

version       = "0.1.0"
author        = "Luciano Lorenzo"
description   = "Duckduckgo search"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.5.1" # Lower this
requires "scraper"
requires "useragent"

bin = @["duckduckgo"]
binDir = "build"

task gen_docs, "Generates the documentation":
  exec "nim doc --project --out:docs src/duckduckgo.nim"
