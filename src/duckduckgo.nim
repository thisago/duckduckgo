## DuckDuckGo search API implementation in Nim

from std/httpclient import newAsyncHttpClient, close, getContent, newHttpHeaders
import std/asyncdispatch
from std/uri import encodeUrl

import pkg/scraper/html
from pkg/useragent import mozilla

type
  Search* = ref object
    term*: string
    results*: seq[SearchResult]
  SearchResult* = object
    title*, description*, url*, icon*: string

const url = "https://duckduckgo.com/html/?q="

proc search*(query: string): Future[Search] {.async.} =
  ## Searches in html Duckduckgo version and scrapes the content
  new result
  result.term = query
  let
    client = newAsyncHttpClient(headers = newHttpHeaders({
      "User-Agent": mozilla,
      "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
    }))
    html = parseHtml await client.getContent url & encodeUrl query
  close client

  block results:
    for el in html.findAll("div", {"class": "result results_links results_links_deep web-result"}):
      var res: SearchResult
      let link = el.findAll("a", {"class": "result__a"})
      res.title = link.text
      res.url = link.attr "href"
      res.description = el.findAll("a", {"class": "result__snippet"}).text
      res.icon = el.findAll("img", {"class": "result__icon__img"}).attr "src"
      if res.icon[0] == '/':
        res.icon = "https:" & res.icon

      result.results.add res

when isMainModule:
  import std/[json, jsonutils]
  let res = waitFor search "test"
  echo pretty res.toJson
