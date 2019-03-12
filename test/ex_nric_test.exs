defmodule ExNricTest do
  use ExUnit.Case
  doctest ExNric

  test "valid nrics" do
    valid_nrics = """
    S1218016J
    S9660397E
    S6122768G
    S9529751Z
    T1772860H
    T1031261I
    T8441818D
    T2090984B
    T0262247A
    F4514977M
    F3232106L
    F5148675R
    G8053325Q
    G7280494K
    G7444948X
    """

    valid_nrics
    |> String.split()
    |> Enum.each(fn nric -> assert {:ok, nric} == ExNric.validate(nric) end)
  end
end
