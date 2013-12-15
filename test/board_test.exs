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

  test "can get a list of neighbors" do
    board     = Board.create(5, 5)

    neighbors = Board.neighbors(board, 0,0)
    assert Enum.count(neighbors) == 3

    neighbors = Board.neighbors(board, 1,1)
    assert Enum.count(neighbors) == 8

    neighbors = Board.neighbors(board, 0,1)
    assert Enum.count(neighbors) == 5 
  end

  test "can get a list of alive neighbors" do
    [cell | tail]   = Board.create(5, 5)
    cell = cell.alive(true)

    alive_neighbors = Board.alive_neighbors([cell | tail], 1,0)
    assert Enum.count(alive_neighbors) == 1
  end
  
  test "should_live is false when there are less than 2 alive neighbors" do
    assert Board.should_live?(1) == false
  end

  test "should_live is false when there are more than 3 alive neighbors" do
    assert Board.should_live?(4) == false
  end

  test "should_live is true when alive neighbors is 2 or 3" do
    assert Board.should_live?(3) == true
    assert Board.should_live?(2) == true
  end

  test "should loop and mark appropriate cells dead" do
    [cell | tail]   = Board.create(5, 5)
    cell = cell.alive(true)


    board  = [cell | tail]
    alive_neighbors = Board.alive_neighbors(board, 1, 0)
    assert Enum.count(alive_neighbors) == 1

    board = Board.loop(board)
    assert Board.cell_at(board, 0, 0).alive == false
  end
end
