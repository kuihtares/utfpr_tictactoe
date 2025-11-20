defmodule RuleTest do
  use ExUnit.Case
  doctest Rule

  describe "check_winner/1" do
    test "detects horizontal win in first row (4 symbols)" do
      board = [
        :x, :x, :x, :x,
        :o, " ", " ", " ",
        " ", " ", " ", " ",
        " ", " ", " ", " "
      ]

      assert Rule.check_winner(board) == {:winner, :x}
    end

    test "detects horizontal win in second row (4 symbols)" do
      board = [
        :x, :o, " ", " ",
        :o, :o, :o, :o,
        :x, " ", " ", " ",
        " ", " ", " ", " "
      ]

      assert Rule.check_winner(board) == {:winner, :o}
    end

    test "detects horizontal win in third row (4 symbols)" do
      board = [
        :o, :x, " ", :o,
        :o, " ", " ", " ",
        :x, :x, :x, :x,
        " ", " ", " ", " "
      ]

      assert Rule.check_winner(board) == {:winner, :x}
    end

    test "detects horizontal win in fourth row (4 symbols)" do
      board = [
        :x, :o, " ", " ",
        :x, " ", " ", " ",
        :o, " ", " ", " ",
        :+, :+, :+, :+
      ]

      assert Rule.check_winner(board) == {:winner, :+}
    end

    test "detects vertical win in first column (4 symbols)" do
      board = [
        :x, :o, " ", " ",
        :x, :o, " ", " ",
        :x, " ", " ", " ",
        :x, " ", " ", " "
      ]

      assert Rule.check_winner(board) == {:winner, :x}
    end

    test "detects vertical win in second column (4 symbols)" do
      board = [
        :x, :o, " ", " ",
        " ", :o, :x, " ",
        " ", :o, " ", " ",
        " ", :o, " ", " "
      ]

      assert Rule.check_winner(board) == {:winner, :o}
    end

    test "detects vertical win in third column (4 symbols)" do
      board = [
        :o, :x, :+, " ",
        :o, " ", :+, " ",
        :x, " ", :+, " ",
        " ", " ", :+, " "
      ]

      assert Rule.check_winner(board) == {:winner, :+}
    end

    test "detects vertical win in fourth column (4 symbols)" do
      board = [
        :o, :x, :o, :x,
        :o, " ", " ", :x,
        " ", " ", :+, :x,
        " ", " ", " ", :x
      ]

      assert Rule.check_winner(board) == {:winner, :x}
    end

    test "detects main diagonal win (0,5,10,15) - 4 symbols" do
      board = [
        :x, :o, " ", " ",
        :o, :x, " ", " ",
        " ", " ", :x, " ",
        " ", " ", " ", :x
      ]

      assert Rule.check_winner(board) == {:winner, :x}
    end

    test "detects anti-diagonal win (3,6,9,12) - 4 symbols" do
      board = [
        :o, " ", " ", :x,
        :o, " ", :x, " ",
        " ", :x, " ", " ",
        :x, " ", " ", " "
      ]

      assert Rule.check_winner(board) == {:winner, :x}
    end

    test "returns no winner when board has no winning condition" do
      board = [
        :x, :o, :x, :+,
        :+, :x, :o, :o,
        :o, :+, :+, :x,
        :x, :o, :x, :+
      ]

      assert Rule.check_winner(board) == :no_winner
    end

    test "returns no winner for empty board" do
      board = [
        " ", " ", " ", " ",
        " ", " ", " ", " ",
        " ", " ", " ", " ",
        " ", " ", " ", " "
      ]

      assert Rule.check_winner(board) == :no_winner
    end

    test "returns no winner when only 2 in a row" do
      board = [
        :x, :x, :o, " ",
        :o, :o, :x, " ",
        " ", " ", " ", " ",
        " ", " ", " ", " "
      ]

      assert Rule.check_winner(board) == :no_winner
    end
  end

  describe "winning_board?/2" do
    test "returns true when specified symbol wins horizontally (4 symbols)" do
      board = [
        1, 1, 1, 1,
        3, 2, 3, 4,
        3, " ", " ", " ",
        " ", " ", " ", " "
      ]

      assert Rule.winning_board?(board, 1) == true
    end

    test "returns false when specified symbol doesn't win" do
      board = [
        1, 1, 1, 2,
        3, 2, 3, 4,
        3, " ", " ", " ",
        " ", " ", " ", " "
      ]

      assert Rule.winning_board?(board, 2) == false
    end

    test "returns true when symbol wins on second row (4 symbols)" do
      board = [
        1, 2, 1, 3,
        2, 2, 2, 2,
        3, 4, 3, " ",
        " ", " ", " ", " "
      ]

      assert Rule.winning_board?(board, 2) == true
    end

    test "returns true when symbol wins on third row (4 symbols)" do
      board = [
        1, 2, 1, " ",
        2, 3, 2, " ",
        3, 3, 3, 3,
        " ", " ", " ", " "
      ]

      assert Rule.winning_board?(board, 3) == true
    end

    test "returns true when symbol wins vertically (4 symbols)" do
      board = [
        1, 2, 1, " ",
        1, 3, 2, " ",
        1, 5, 3, " ",
        1, " ", " ", " "
      ]

      assert Rule.winning_board?(board, 1) == true
    end

    test "returns true when symbol wins on main diagonal (4 symbols)" do
      board = [
        6, 2, 4, " ",
        3, 6, 4, " ",
        1, 2, 6, " ",
        " ", " ", " ", 6
      ]

      assert Rule.winning_board?(board, 6) == true
    end

    test "returns true when symbol wins on anti-diagonal (4 symbols)" do
      board = [
        6, 2, 7, 7,
        3, 7, 7, " ",
        7, 7, 6, " ",
        7, " ", " ", " "
      ]

      assert Rule.winning_board?(board, 7) == true
    end
  end

  describe "board_full?/1" do
    test "returns true when board is completely filled" do
      board = [
        :x, :o, :x, :o,
        :o, :x, :o, :x,
        :x, :o, :x, :o,
        :o, :x, :o, :x
      ]

      assert Rule.board_full?(board) == true
    end

    test "returns false when board has empty spaces" do
      board = [
        :x, :o, :x, :o,
        :o, :x, :o, :x,
        :x, :o, " ", :o,
        :o, :x, :o, :x
      ]

      assert Rule.board_full?(board) == false
    end

    test "returns false for empty board" do
      board = [
        " ", " ", " ", " ",
        " ", " ", " ", " ",
        " ", " ", " ", " ",
        " ", " ", " ", " "
      ]

      assert Rule.board_full?(board) == false
    end

    test "works with Board struct" do
      board = %Board{
        cells: [
          :x, :o, :x, :o,
          :o, :x, :o, :x,
          :x, :o, :x, :o,
          :o, :x, :o, :x
        ]
      }

      assert Rule.board_full?(board) == true
    end
  end
end
