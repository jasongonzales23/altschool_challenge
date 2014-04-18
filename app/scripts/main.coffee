randomColor = ->
  color = "##{Math.floor(Math.random()*16777215).toString(16)}"

whitenize = (tilesWide, tilesHigh)->
  i = 0
  tiles = document.querySelectorAll('.tile')
  for x in [0...tilesWide]
    for y in [0...tilesHigh]
      if tilesArr[x][y]
        tile = tiles[i]
        tile.style.background = "#fff"
        tilesArr[x][y] = false
      i++

save = ->
  data = JSON.stringify(tilesArr)
  localStorage.board = data
  $.ajax(
    url: 'http://myserver.com/api/endpoint'
    data: data
  )

handleTileClick = (e) ->
  tile = e.target
  x = tile.dataset.x
  y = tile.dataset.y

  if tilesArr[x][y]
    tile.style.background = "#fff"
    tilesArr[x][y] = false
  else
    color = randomColor()
    tile.style.background = color
    tilesArr[x][y] = color

tilesArr = []

generateTileBoard = (el, tilesWide, tilesHigh) ->
  board = document.querySelector(el)
  boardWidth = board.offsetWidth

  @tileWidth = boardWidth / tilesWide - 4

  tilesArr = new Array(tilesWide)
  for x in [0...tilesWide]
    tilesArr[x] = new Array(tilesHigh)
    for y in [0...tilesHigh]
      #use boolean to toggle tile state
      tilesArr[x][y] = false

      @tile = document.createElement("div")
      @tile.className = 'tile'
      @tile.dataset.x = x
      @tile.dataset.y = y
      board.appendChild @tile
      @tile.style.width = "#{@tileWidth}px"
      @tile.style.height = "#{@tileWidth}px"
      @tile.addEventListener "click", handleTileClick, false

  whitenizer = document.getElementById('whitenizer')
  whitenizer.addEventListener "click", (->
     whitenize tilesWide, tilesHigh
     return
  ),
  false

  saverizer = document.getElementById('saverizer')
  saverizer.addEventListener "click", save, false

tileBoard = new generateTileBoard('#gameboard', 8, 8)

