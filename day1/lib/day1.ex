defmodule Day1 do
  def final_frequency do
    r = file_input
    {total, lst} = Enum.reduce(r, {0, [0]}, &list_of_frequencies/2)
    total
  end

  def get_duplicate do
    _get_duplicate(0, [0], [])
  end

  defp _get_duplicate(current_freq, current_freq_lst, [h | _]), do: h

  defp _get_duplicate(current_freq, current_freq_lst, []) do
    t = file_input
    {total, lst} = Enum.reduce(t, {current_freq, current_freq_lst}, &list_of_frequencies/2)
    t = file_input
    unique = Enum.uniq(lst)

    if Enum.count(lst) == Enum.count(unique) do
      _get_duplicate(total, lst, [])
    else
      _get_duplicate(total, lst, lst -- unique)
    end
  end

  defp file_input do
    {:ok, result} = File.read("input.txt")
    String.split(result, "\n")
  end

  defp list_of_frequencies(x, {acc, lst}) do
    symbol = String.slice(x, 0..0)
    num = num_from_string(x)

    case symbol do
      "+" ->
        val = acc + num
        {val, lst ++ [val]}

      "-" ->
        val = acc - num
        {val, lst ++ [val]}

      _ ->
        {acc, lst}
    end
  end

  defp num_from_string(x) do
    x
    |> String.slice(1..-1)
    |> to_integer
  end

  defp to_integer(""), do: 0
  defp to_integer(x), do: String.to_integer(x)
end
