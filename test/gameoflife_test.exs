defrecord Cell, alive: false, x: 0, y: 0

defmodule CellTest do
  use ExUnit.Case

  test "can init a cell with the right params" do
    cell = Cell.new(alive: true, x: 1, y: 1)

    assert cell.x == 1
    assert cell.y == 1
    assert cell.alive == true
  end
end

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
end

defmodule BoardTest do
  use ExUnit.Case

  test "gives a list of cells" do
    board = Board.create(5, 5)
    assert Enum.count(board) == 25
  end

  test "can get a cell from x and y coords" do
    board = Board.create(5, 5)
    cell  = Board.cell_at(board, 0,0)
    assert cell.x == 0
    assert cell.y == 0
  end

  test "can get a list of neighbors from a cell" do
    board     = Board.create(5, 5)

    neighbors = Board.neighbors(board, 0,0)
    assert Enum.count(neighbors) == 3

    neighbors = Board.neighbors(board, 1,1)
    assert Enum.count(neighbors) == 8

    neighbors = Board.neighbors(board, 0,1)
    assert Enum.count(neighbors) == 5 
  end

end
