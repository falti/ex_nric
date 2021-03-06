defmodule ExNric.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_nric,
      version: "0.2.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: "Validation for Singapore National Registration Identity Card numbers (NRIC)",
      package: package(),
      docs: docs(),
      deps: deps(),
      dialyzer: [
        flags: ~w(-Wunmatched_returns -Werror_handling -Wrace_conditions -Wno_opaque -Wunderspecs)
      ],
      preferred_cli_env: [
        docs: :docs,
        "hex.publish": :docs
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:dialyxir, "~> 0.5.1", only: :dev},
      {:ex_doc, "~> 0.18.0", only: [:docs]}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Frank Falkenberg"],
      licenses: ["MIT"],
      links: %{GitHub: "https://github.com/falti/ex_nric"}
    ]
  end

  defp docs do
    [
      main: "readme",
      formatter_opts: [gfm: true],
      extras: [
        "README.md"
      ]
    ]
  end
end
