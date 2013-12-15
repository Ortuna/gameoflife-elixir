defmodule Board do
  def create(width, height) do
    lc x inlist Enum.to_list(0..width-1), y inlist Enum.to_list(0..height-1) do
      Cell.new(alive: false, x: x, y: y)
    end
  end

  def cell_at(board, x, y) do
    Enum.find(board, fn(cell) ->
      cell.x == x && cell.y == y
    end)
  end

  def neighbors(board, x, y) do
    Enum.filter(board, fn(cell) ->
      !((cell.x == x && cell.y == y) ||
      (cell.x > x+1 || cell.x < x-1) ||
      (cell.y > y+1 || cell.y < y-1))
    end)
  end

  def alive_neighbors(board, x, y) do
    neighbors = neighbors(board, x , y)
    Enum.filter(neighbors, fn(cell) -> 
    cell.alive end)
  end

  def should_live?(alive_neighbors) when
    alive_neighbors < 2 or alive_neighbors > 3 do
    false
  end

  def should_live?(_) do
    true 
  end

  def loop(board) do
    Enum.map(board, fn (cell)->
      alive_neighbors = Enum.count(alive_neighbors(board, cell.x, cell.y))
      should_live     = should_live?(alive_neighbors)
      cell = cell.alive(should_live)
      cell
    end)
  end
end


