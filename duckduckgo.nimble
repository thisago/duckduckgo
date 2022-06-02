# Package

version       = "0.1.4"
author        = "Thiago Navarro"
description   = "Duckduckgo search"
license       = "mit"
srcDir        = "src"


# Dependencies

requires "nim >= 1.5.1" # Lower this
requires "scraper"
requires "https://gitlab.com/lurlo/useragent"

task gen_docs, "Generates the documentation":
  exec "nim doc --project --out:docs src/duckduckgo.nim"
