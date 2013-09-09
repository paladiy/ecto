defmodule Ecto.Query.NameResolutionTest do
  use ExUnit.Case, async: true

  alias Ecto.Query
  alias Ecto.Query.NameResolution

  defmodule Foo do
    use Ecto.Model
    queryable "foo" do
    end
  end

  defmodule Bar do
    use Ecto.Model
    queryable "bar" do
    end
  end

  defmodule F do
    use Ecto.Model
    queryable "f" do
    end
  end

  test "use first letter and number for name" do
    query = Query.Query[models: {Foo}]
    assert NameResolution.create_names(query) == {{Foo, "f0"}}
  end

  test "allows for multiple models" do
    query = Query.Query[models: {Foo, Bar}]
    assert NameResolution.create_names(query) == {{Foo, "f0"},{Bar, "b0"}}
  end

  test "increments the number for collisions" do
    query = Query.Query[models: {Foo, F}]
    assert NameResolution.create_names(query) == {{Foo, "f0"},{F, "f1"}}
  end
end
