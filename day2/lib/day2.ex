defmodule Day2 do
  def checksum() do
    input_from_file
    |> Enum.map(&get_duplicates/1)
    |> build_checksum
  end

  defp build_checksum(dups), do: count_duplicates(dups) * count_triples(dups)

  def correct_box() do
    input = input_from_file
    lsts = Enum.map(input, &String.graphemes(&1))

    {{one, two}, []} =
      Enum.reduce(lsts, {{}, lsts}, fn x, {r, [_ | t]} ->
        g =
          Enum.find(t, fn tt ->
            diff = x -- tt
            diff2 = tt -- x

            if Enum.count(diff) == 1 do
              a = List.delete(x, List.first(diff))
              b = List.delete(tt, List.first(diff2))
              a == b
            else
              false
            end
          end)

        if g != nil do
          {{g, x}, t}
        else
          {r, t}
        end
      end)

    diff = one -- two
    actual = Enum.join(List.delete(one, List.first(diff)))
  end

  defp input_from_file do
    {:ok, result} = File.read("input.txt")
    String.split(result, "\n")
  end

  defp count_duplicates(dups), do: Enum.count(dups, fn {x, _} -> x end)

  defp count_triples(dups), do: Enum.count(dups, fn {_, y} -> y end)

  defp get_duplicates(str) do
    str
    |> String.graphemes()
    |> Enum.reduce(%{}, &build_letter_count/2)
    |> count_tuple
  end

  defp count_tuple(mp), do: {has_double?(mp), has_triple?(mp)}

  defp build_letter_count(x, acc) do
    if Map.has_key?(acc, x) do
      Map.update!(acc, x, &(&1 + 1))
    else
      Map.put_new(acc, x, 1)
    end
  end

  defp has_double?(map), do: Enum.any?(map, fn {_, count} -> count == 2 end)

  defp has_triple?(map), do: Enum.any?(map, fn {_, count} -> count == 3 end)
end
