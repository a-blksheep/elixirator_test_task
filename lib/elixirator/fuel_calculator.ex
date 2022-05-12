defmodule Elixirator.FuelCalculator do
  @moduledoc """
  Documentation for `Elixirator.FuelCalculator`.
  """
  alias Elixirator.CalculatorBehaviour

  @behaviour CalculatorBehaviour

  @doc """
  Calculate the amount of fuel required for
  a space journey, based on spec requirements.

  ## Examples
    iex> Elixirator.FuelCalculator.calculate(28801, [{:land, 9.807}])
    13447
    iex> Elixirator.FuelCalculator.calculate(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])
    51819
    iex> Elixirator.FuelCalculator.calculate(14606, [{:launch, 9.807}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}])
    33352
    iex> Elixirator.FuelCalculator.calculate(75432, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}])
    212024
  """
  def calculate(mass, moves) when is_list(moves) do
    moves
    |> Enum.reduce(0, fn move, acc ->
      total = acc + calculate(mass, move)
      total + calculate_additional_fuel(total, move)
    end)
  end

  def calculate(mass, {dir, gravity}) do
    cond do
      dir == :launch ->
        mass * gravity * 0.042 - 33

      dir == :land ->
        mass * gravity * 0.033 - 42
    end
    |> format()
  end

  def calculate(_, _), do: 0

  defp calculate_additional_fuel(total, move, acc \\ 0)

  defp calculate_additional_fuel(total, move, acc) when total > 0 do
    total = calculate(total, move)
    calculate_additional_fuel(total, move, acc + total)
  end

  defp calculate_additional_fuel(_total, _move, acc), do: acc

  defp format(value) when value > 0 do
    value
    |> floor()
  end

  defp format(value) when value <= 0, do: 0
end
