defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  @lower ?a..?z

  @upper ?A..?Z

  @numbers ?0..?9

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(<<char::utf8, rest::binary>>, shift) do
    rotate_reduce(process(char, shift), rest, shift)
  end

  def rotate_reduce(acc, "", _), do: acc

  def rotate_reduce(acc, <<char::utf8, rest::binary>>, shift) do
    rotate_reduce(acc <> process(char, shift), rest, shift)
  end

  def process(char, shift) do
    compute(char, shift)
  end

  def compute(char, shift) when char in @lower do
    compute(char + shift, ?a, ?z)
  end

  def compute(char, shift) when char in @upper do
    compute(char + shift, ?A, ?Z)
  end

  def compute(char, _shift) when char in @numbers, do: <<char::utf8>>

  def compute(char, _shift), do: <<char::utf8>>

  def compute(n, startn, endn) do
    if n > endn do
      <<startn + (n - endn - 1)>>
    else
      <<n>>
    end
  end
end
