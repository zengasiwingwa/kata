defmodule GildedRoseTest do
  use ExUnit.Case

  describe "generic item" do
    test "quality degrades by one" do
      item = %Item{name: "Unspecified Item", sell_in: 10, quality: 20}
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 19
    end

    test "quality degrades by two after sell by date" do
      item = %Item{name: "Unspecified Item", sell_in: -5, quality: 20}
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 18
    end
  end

  describe "Aged Brie" do
    test "quality increases" do
      item = %Item{name: "Aged Brie", sell_in: 10, quality: 30}
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 31
    end

    test "quality increases by two after sell date" do
      item = %Item{name: "Aged Brie", sell_in: -5, quality: 30}
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 32
    end
  end

  describe "General Tests" do
    test "quality is always 80" do
      item = %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 10, quality: 80}
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 80
    end

    test "quality increases" do
      item = %Item{
        name: "Backstage passes to a TAFKAL80ETC concert",
        sell_in: 15,
        quality: 30
      }

      next_item = GildedRose.update_item(item)
      assert next_item.quality == 31
    end

    test "quality increases by 2 when 10 days or less" do
      item = %Item{
        name: "Backstage passes to a TAFKAL80ETC concert",
        sell_in: 10,
        quality: 15
      }

      next_item = GildedRose.update_item(item)
      assert next_item.quality == 17
    end
  end
end
