defmodule ExNric do
  @moduledoc """
  Documentation for ExNric.
  """

  @doc """
  Validates Singapore NRIC

  ## Examples

      iex> ExNric.validate("S7343684B")
      {:ok, "S7343684B"}

      iex> ExNric.validate("T9901744E")
      {:ok, "T9901744E"}

      iex> ExNric.validate("F4365949U")
      {:ok, "F4365949U"}

      iex> ExNric.validate("G0047750N")
      {:ok, "G0047750N"}

      iex> ExNric.validate("G0047750U")
      {:error, "checksum failed"}

      iex> ExNric.validate("X")
      {:error, "not an NRIC"}

  """
  @spec validate(String.t()) :: {atom(), String.t()}
  def validate(nric) when is_binary(nric) do
    nric_pattern = ~r/^([STFG])(\d{7})([A-Z])$/

    case Regex.run(nric_pattern, nric) do
      [_, prefix, digits, checksum] ->
        calculated_checksum = calculate_checksum(prefix, numberize(digits))
        do_check(calculated_checksum, checksum, nric)

      _ ->
        {:error, "not an NRIC"}
    end
  end

  defp do_check(calculated_checksum, checksum, nric) do
    if calculated_checksum == checksum do
      {:ok, nric}
    else
      {:error, "checksum failed"}
    end
  end

  defp numberize(digits) do
    digits |> String.codepoints() |> Enum.map(&String.to_integer/1)
  end

  defp calculate_checksum("S", digits), do: calculate_checksum_uin(digits, 0)
  defp calculate_checksum("T", digits), do: calculate_checksum_uin(digits, 4)
  defp calculate_checksum("F", digits), do: calculate_checksum_fin(digits, 0)
  defp calculate_checksum("G", digits), do: calculate_checksum_fin(digits, 4)

  defp calculate_checksum_uin(digits, d0) do
    d = digits |> calculate_d(d0) |> Integer.mod(11)
    ds() |> Enum.zip(uin_checksums()) |> Enum.into(%{}) |> Map.get(d)
  end

  defp calculate_checksum_fin(digits, d0) do
    d = digits |> calculate_d(d0) |> Integer.mod(11)
    ds() |> Enum.zip(fin_checksums()) |> Enum.into(%{}) |> Map.get(d)
  end

  defp calculate_d(digits, d0) do
    d0 + (digits |> Enum.zip(weights()) |> Enum.map(fn {a, b} -> a * b end) |> Enum.sum())
  end

  defp weights do
    [2, 7, 6, 5, 4, 3, 2]
  end

  defp ds do
    [10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
  end

  defp uin_checksums do
    "A B C D E F G H I Z J" |> String.split()
  end

  defp fin_checksums do
    "K L M N P Q R T U W X" |> String.split()
  end
end
