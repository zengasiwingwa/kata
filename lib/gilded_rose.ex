defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]
  @passes "Backstage passes to a TAFKAL80ETC concert"

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%Item{name: "Aged Brie", sell_in: sell_in} = item) when sell_in <= 0 do
    item |> time_passed() |> improve(2)
  end

  def update_item(%Item{name: "Aged Brie", sell_in: sell_in} = item) when sell_in <= 0 do
    item |> time_passed() |> improve(2)
  end

  def update_item(%Item{name: "Aged Brie"} = item) do
    item |> time_passed() |> improve(1)
  end

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item) do
    item |> quality(80)
  end

  def update_item(%Item{name: @passes, sell_in: sell_in} = item) when sell_in <= 0 do
    item |> time_passed() |> quality(0)
  end

  def update_item(%Item{name: @passes, sell_in: sell_in} = item) when sell_in <= 5 do
    item |> time_passed() |> improve(3)
  end

  def update_item(%Item{name: @passes, sell_in: sell_in} = item) when sell_in <= 10 do
    item |> time_passed() |> improve(2)
  end

  def update_item(%Item{name: @passes} = item) do
    item |> time_passed() |> improve(1)
  end

  def update_item(%Item{name: "Conjured Mana Cake", sell_in: sell_in} = item)
      when sell_in <= 0 do
    item |> time_passed() |> degrade(4)
  end

  def update_item(%Item{name: "Conjured Mana Cake"} = item) do
    item |> time_passed() |> degrade(2)
  end

  def update_item(%Item{sell_in: sell_in} = item) when sell_in <= 0 do
    item |> time_passed() |> degrade(2)
  end

  def update_item(%Item{} = item) do
    item |> time_passed() |> degrade(1)
  end

  defp time_passed(%Item{} = item) do
    %Item{item | sell_in: item.sell_in - 1}
  end

  defp degrade(%Item{} = item, rate) do
    %Item{item | quality: max(item.quality - rate, 0)}
  end

  defp improve(%Item{} = item, rate) do
    %Item{item | quality: min(item.quality + rate, 50)}
  end

  defp quality(%Item{} = item, quality) do
    %Item{item | quality: quality}
  end
end
