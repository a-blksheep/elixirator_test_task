defmodule Elixirator.FuelCalculator do
  @moduledoc """
  Documentation for `Elixirator.FuelCalculator`.
  """

  @doc """
  Calculate the amount of fuel required for
  a space journey, based on spec requirements.

  ## Examples
    iex> Elixirator.FuelCalculator.calculate(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])
    51819.0
    iex> Elixirator.FuelCalculator.calculate(14606, [{:launch, 9.807}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}])
    33352.0

  """
  def calculate(mass, moves) when is_list(moves) do
    moves
    |> Enum.reduce(0, fn move, acc ->
      total = acc + calculate(mass, move)
      total + calculate_additional_fuel(total, move)
    end)
  end

  def calculate(mass, {dir, gravity}) when dir == :launch do
    total = mass * gravity * 0.042 - 33

    cond do
      total > 0 -> total | Float.floor()
      true -> 0
    end
  end

  def calculate(mass, {dir, gravity}) when dir == :land do
    total = mass * gravity * 0.033 - 42

    cond do
      total > 0 -> total |> Float.floor()
      true -> 0
    end
  end

  def calculate(_, _), do: 0

  def calculate_additional_fuel(total, move, acc \\ 0)

  def calculate_additional_fuel(total, move, acc) when total > 0 do
    total = calculate(total, move)
    calculate_additional_fuel(total, move, Decimal.add(acc, total))
  end

  def calculate_additional_fuel(_total, _move, acc), do: acc
end
