require 'minitest/autorun'
require 'minitest/pride'
require './lib/house'

class HouseTest < Minitest::Test
  def test_it_exists
    house = House.new("$400000", "123 sugar lane")

    assert_instance_of House, house
  end

  def test_it_has_a_price
    house = House.new("$400000", "123 sugar lane")

    assert_equal 400000, house.price
  end

  def test_it_has_an_address
    house = House.new("$400000", "123 sugar lane")

    assert_equal "123 sugar lane", house.address
  end

  def test_it_starts_without_rooms
    house = House.new("$400000", "123 sugar lane")

    assert_equal [], house.rooms
  end
end
