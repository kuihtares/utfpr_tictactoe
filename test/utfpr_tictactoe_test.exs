defmodule UtfprTictactoeTest do
  use ExUnit.Case
  doctest UtfprTictactoe

  describe "Game integration tests with winning conditions" do
    test "player X wins with horizontal line on first row (4 symbols)" do
      board = %Board{
        cells: [
          :x, :x, :x, :x,
          :o, :o, " ", " ",
          :+, " ", " ", " ",
          " ", " ", " ", " "
        ]
      }

      assert Rule.check_winner(board.cells) == {:winner, :x}
    end

    test "player O wins with vertical line (4 symbols)" do
      board = %Board{
        cells: [
          :x, :o, :x, " ",
          :x, :o, " ", " ",
          :+, :o, " ", " ",
          " ", :o, " ", " "
        ]
      }

      assert Rule.check_winner(board.cells) == {:winner, :o}
    end

    test "player + wins with diagonal line (4 symbols)" do
      board = %Board{
        cells: [
          :+, :o, :x, " ",
          :x, :+, :o, " ",
          :o, :x, :+, " ",
          " ", " ", " ", :+
        ]
      }

      assert Rule.check_winner(board.cells) == {:winner, :+}
    end

    test "no winner in partially filled board" do
      board = %Board{
        cells: [
          :x, :o, :x, " ",
          :o, :x, :o, " ",
          :+, " ", " ", " ",
          " ", " ", " ", " "
        ]
      }

      assert Rule.check_winner(board.cells) == :no_winner
    end

    test "draw game - board full with no winner" do
      board = %Board{
        cells: [
          :x, :o, :x, :+,
          :+, :x, :o, :o,
          :o, :+, :+, :x,
          :x, :o, :x, :+
        ]
      }

      assert Rule.check_winner(board.cells) == :no_winner
      assert Rule.board_full?(board) == true
    end

    test "game continues when board not full and no winner" do
      board = %Board{
        cells: [
          :x, :o, " ", " ",
          :o, :x, " ", " ",
          " ", " ", " ", " ",
          " ", " ", " ", " "
        ]
      }

      assert Rule.check_winner(board.cells) == :no_winner
      assert Rule.board_full?(board) == false
    end
  end

  describe "Board and Player integration" do
    test "players can make moves and check for winner" do
      board = Board.new()
      player_x = Player.new(:x, 1)
      board = Board.play(board, player_x, 1)
      assert Enum.at(board.cells, 0) == :x

      assert Rule.check_winner(board.cells) == :no_winner
    end

    test "complete game scenario with winner (4 in a row)" do
      board = Board.new()
      player_x = Player.new(:x, 1)
      player_o = Player.new(:o, 2)

      # Simulate a game where X wins by filling the first row
      board = Board.play(board, player_x, 1)  # X at (1,1)
      board = Board.play(board, player_o, 5)  # O at (2,1)
      board = Board.play(board, player_x, 2)  # X at (1,2)
      board = Board.play(board, player_o, 6)  # O at (2,2)
      board = Board.play(board, player_x, 3)  # X at (1,3)
      board = Board.play(board, player_o, 7)  # O at (2,3)
      board = Board.play(board, player_x, 4)  # X at (1,4) - X wins

      assert Rule.check_winner(board.cells) == {:winner, :x}
    end
  end
end
