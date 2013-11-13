defmodule Ecto.Mixfile do
  use Mix.Project

  def project do
    [ app: :ecto,
      version: "0.0.1",
      deps: deps(Mix.env),
      env: envs,
      name: "Ecto",
      source_url: "https://github.com/elixir-lang/ecto",
      elixir: "~> 0.11.1" ]
  end

  def application do
    []
  end

  defp deps(:prod) do
    [ { :poolboy, github: "devinus/poolboy" } ]
  end

  defp deps(_) do
    deps(:prod) ++
      [ { :ex_doc, github: "elixir-lang/ex_doc" },
        { :emysql, "0.2", github: "Eonblast/Emysql", ref: "dc2d1d26db0aee512c923e36b798dbfe3b919af9" },
        { :pgsql, github: "ericmj/pgsql", branch: "elixir" } ]
  end

  defp envs do
    [ pg: [ test_paths: ["integration_test/pg"] ],
      mysql: [test_paths: ["integration_test/mysql"] ],
      all: [ test_paths: ["test", "integration_test/pg", "integartion_test/mysql"] ] ]
  end
end

defmodule Mix.Tasks.Release_docs do
  @shortdoc "Releases docs"

  def run(_) do
    Mix.Task.run "docs"

    File.rm_rf "../elixir-lang.github.com/docs/ecto"
    File.cp_r "docs/.", "../elixir-lang.github.com/docs/ecto/"
    File.rm_rf "docs"
  end
end
