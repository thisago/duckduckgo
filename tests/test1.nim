import std/unittest
import duckduckgo

suite "duckduckgo":
  test "Can say":
    const msg = "Hello from duckduckgo test"
    check msg == say msg
