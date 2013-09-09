defmodule Ecto.Query.NameResolution do
  @moduledoc false

  def create_names(query) do
    models = query.models |> tuple_to_list
    Enum.reduce(models, [], fn(model, names) ->
      table = model.__ecto__(:name) |> String.first
      name = unique_name(names, table, 0)
      [{ model, name }|names]
    end) |> Enum.reverse |> list_to_tuple
  end

  defp unique_name(names, name, counter) do
    cnt_name = name <> integer_to_binary(counter)
    if Enum.any?(names, fn({ _, n }) -> n == cnt_name end) do
      unique_name(names, name, counter+1)
    else
      cnt_name
    end
  end
end
