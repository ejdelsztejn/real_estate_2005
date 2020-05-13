require 'minitest/autorun'
require 'minitest/pride'
require './lib/room'

class HouseTest < Minitest::Test
  def test_it_exists
    house = House.new("$400000", "123 sugar lane")

    assert_instance_of House, house
  end
end
