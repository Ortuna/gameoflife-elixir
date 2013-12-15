defmodule CellTest do
  use ExUnit.Case

  test "can init a cell with the right params" do
    cell = Cell.new(alive: true, x: 1, y: 1)

    assert cell.x == 1
    assert cell.y == 1
    assert cell.alive == true
  end
end

