defmodule Rule do
  @doc """
  Checks if there is a winner on the board.  A player wins by completely filling a row, column, or diagonal (4 matching symbols).  Returns {:winner, symbol} if there is a winner, or :no_winner otherwise.
  """
  def check_winner(board) when is_list(board) and length(board) == 16 do
    winning_lines()
    |> Enum.find_value(:no_winner, fn positions ->
      check_positions(board, positions)
    end)
  end

  defp winning_lines do
    horizontal_lines() ++ vertical_lines() ++ diagonal_lines()
  end

  defp horizontal_lines do
    [
      [0, 1, 2, 3],
      [4, 5, 6, 7],
      [8, 9, 10, 11],
      [12, 13, 14, 15]
    ]
  end

  defp vertical_lines do
    [
      [0, 4, 8, 12],
      [1, 5, 9, 13],
      [2, 6, 10, 14],
      [3, 7, 11, 15]
    ]
  end

  defp diagonal_lines do
    [
      [0, 5, 10, 15],
      [3, 6, 9, 12]
    ]
  end

  defp check_positions(board, [pos1, pos2, pos3, pos4]) do
    symbol1 = Enum.at(board, pos1)
    symbol2 = Enum.at(board, pos2)
    symbol3 = Enum.at(board, pos3)
    symbol4 = Enum.at(board, pos4)

    if symbol1 == symbol2 and symbol2 == symbol3 and symbol3 == symbol4 and symbol1 != " " do
      {:winner, symbol1}
    else
      nil
    end
  end

  def board_full?(%Board{cells: cells}) do
    Enum.all?(cells, fn cell -> cell != " " end)
  end

  def board_full?(cells) when is_list(cells) do
    Enum.all?(cells, fn cell -> cell != " " end)
  end

  def winning_board?(board, symbol) do
    case check_winner(board) do
      {:winner, ^symbol} -> true
      _ -> false
    end
  end
end
