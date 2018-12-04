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

  defp list_of_frequencies("", val), do: val
  defp list_of_frequencies(x, {acc, lst}) do
    num = String.to_integer(x)
    val = acc + num
    {val, lst ++ [val]}
  end

end
