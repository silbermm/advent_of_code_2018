defmodule Day2 do
  def checksum() do
    input = input_from_file
    dups = Enum.map(input, &get_duplicates/1)
    count_duplicates(dups) * count_triples(dups)
  end

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

  defp count_duplicates(dups) do
    doubles =
      dups
      |> Enum.filter(fn {x, _} -> x end)
      |> Enum.count()
  end

  defp count_triples(dups) do
    doubles =
      dups
      |> Enum.filter(fn {_, y} -> y end)
      |> Enum.count()
  end

  defp get_duplicates(str) do
    lst = String.graphemes(str)
    dups = lst -- Enum.uniq(lst)

    mp =
      Enum.reduce(lst, %{}, fn x, acc ->
        if Map.has_key?(acc, x) do
          Map.update!(acc, x, &(&1 + 1))
        else
          Map.put_new(acc, x, 1)
        end
      end)

    {has_double?(mp), has_triple?(mp)}
  end

  defp has_double?(map) do
    Enum.any?(map, fn {_, count} -> count == 2 end)
  end

  defp has_triple?(map) do
    Enum.any?(map, fn {_, count} -> count == 3 end)
  end
end
