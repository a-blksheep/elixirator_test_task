defmodule Elixirator.CalculatorBehaviour do
  @typedoc """
  The total mass of equipment or fuel.
  """
  @type mass :: number()

  @typedoc """
  The direction of a move.
  """
  @type dir :: :launch | :land

  @typedoc """
  The gravity of a planet.
  """
  @type gravity :: number()

  @typedoc """
  An individual move to or from a planet
  """
  @type move :: {dir, gravity}

  @typedoc """
  A list of moves or journeys.
  """
  @type moves :: list(move)

  @doc """
  Calculates the amount of fuel required
  for journeys through space.
  """
  @callback calculate(mass, moves) :: number()
end
