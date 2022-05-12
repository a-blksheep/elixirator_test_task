# Elixirator.FuelCalculator

Test task for Elixirator backend position.

## Running the application

After checking out the code and from an iex session run:

`iex> Elixirator.FuelCalculator.calculate(28801, [{:land, 9.807}])`

## Tests

I've added some initial doctests in the calculator which can be called
using

`mix test`

## Additional Considerations

Were this a real-world application there are several other points, I would have taken into account:

- The introduction of [Decimal](https://hexdocs.pm/decimal/readme.html)
- Better testing
- Would have added code quality packages. EG: Credo, etc
- Would have added Github actions for CI/CD
- Would have introduced Gitflow as a branching model, rather than working directly off of master branch
