# ExNric

[![Hex.pm Version](http://img.shields.io/hexpm/v/ex_nric.svg?style=flat)](https://hex.pm/packages/ex_nric)

  * [Documentation](https://hexdocs.pm/ex_nric)
  
## About

Validation for Singapore National Registration Identity Card numbers (NRIC)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_nric` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_nric, "~> 0.2.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_nric](https://hexdocs.pm/ex_nric).

## Usage

```elixir

import ExNric

{:ok, "S7343684B"} = validate("S7343684B")

{:error, :invalid_format} = validate("x")
{:error, :invalid_format} = validate("x")
{:error, :checksum_error} = validate("G0047750U")

```

## Contributing

Pull requests to contribute new or improved features, and extend documentation are most welcome.

Please follow the existing coding conventions, or refer to the [Elixir style guide](https://github.com/niftyn8/elixir_style_guide).

You should include unit tests to cover any changes. Run `mix test` to execute the test suite.
You should also ensure that dialyzer checks pass. Run `mix dialyzer` to verify. 