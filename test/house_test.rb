require 'minitest/autorun'
require 'minitest/pride'
require './lib/room'
require './lib/house'

class HouseTest < Minitest::Test
  def test_it_exists
    house = House.new("$400000", "123 sugar lane")

    assert_instance_of House, house
  end

  def test_it_has_a_price
    house = House.new("$400000", "123 sugar lane")

    assert_equal 400000, house.price

    house2 = House.new("$1000000", "45 sugar lane")

    assert_equal 1000000, house2.price
  end

  def test_it_has_an_address
    house = House.new("$400000", "123 sugar lane")

    assert_equal "123 sugar lane", house.address

    house2 = House.new("$1000000", "45 sugar lane")

    assert_equal "45 sugar lane", house2.address
  end

  def test_it_starts_without_rooms
    house = House.new("$400000", "123 sugar lane")

    assert_equal [], house.rooms
  end

  def test_it_can_add_rooms
    house = House.new("$400000", "123 sugar lane")

    assert_equal [], house.rooms

    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')

    house.add_room(room_1)
    house.add_room(room_2)

    assert_equal [room_1, room_2], house.rooms
  end

  def test_it_is_above_market_average_if_greater_than_500000
    house = House.new("$400000", "123 sugar lane")

    assert_equal false, house.above_market_average?

    house2 = House.new("$1000000", "45 sugar lane")

    assert_equal true, house2.above_market_average?
  end

  def test_it_can_return_number_of_rooms_by_category
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    assert_equal [room_1, room_2], house.rooms_from_category(:bedroom)
    assert_equal [room_4], house.rooms_from_category(:basement)
  end

  def test_it_can_return_house_area
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    assert_equal 1900, house.area

    house2 = House.new("$1000000", "45 sugar lane")
    room_5 = Room.new(:kitchen, 20, '45')
    room_6 = Room.new(:bedroom, 15, '20')
    room_7 = Room.new(:living_room, 30, '20')
    room_8 = Room.new(:basement, 40, '62')
    room_9 = Room.new(:bedroom, 10, '15')

    house2.add_room(room_5)
    house2.add_room(room_6)
    house2.add_room(room_7)
    house2.add_room(room_8)
    house2.add_room(room_9)

    assert_equal 4430, house2.area
  end

  def test_it_can_return_details
    house = House.new("$400000", "123 sugar lane")

    assert_equal 400000, house.details["price"]
    assert_equal "123 sugar lane", house.details["address"]
  end

  def test_it_can_return_price_per_square_foot
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_4)
    house.add_room(room_1)
    house.add_room(room_3)
    house.add_room(room_2)

    assert_equal 210.53, house.price_per_square_foot

    house2 = House.new("$1000000", "45 sugar lane")
    room_5 = Room.new(:kitchen, 20, '45')
    room_6 = Room.new(:bedroom, 15, '20')
    room_7 = Room.new(:living_room, 30, '20')
    room_8 = Room.new(:basement, 40, '62')
    room_9 = Room.new(:bedroom, 10, '15')

    house2.add_room(room_5)
    house2.add_room(room_6)
    house2.add_room(room_7)
    house2.add_room(room_8)
    house2.add_room(room_9)

    assert_equal 225.73, house2.price_per_square_foot
  end

  def test_it_can_sort_rooms_by_area
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_4)
    house.add_room(room_1)
    house.add_room(room_3)
    house.add_room(room_2)

    assert_equal [room_4, room_3, room_2, room_1], house.rooms_sorted_by_area

    house2 = House.new("$1000000", "45 sugar lane")
    room_5 = Room.new(:kitchen, 20, '45')
    room_6 = Room.new(:bedroom, 15, '20')
    room_7 = Room.new(:living_room, 30, '20')
    room_8 = Room.new(:basement, 40, '62')
    room_9 = Room.new(:bedroom, 10, '15')

    house2.add_room(room_5)
    house2.add_room(room_6)
    house2.add_room(room_7)
    house2.add_room(room_8)
    house2.add_room(room_9)

    assert_equal [room_8, room_5, room_7, room_6, room_9], house2.rooms_sorted_by_area
  end

  def test_it_can_sort_rooms_by_category
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_4)
    house.add_room(room_1)
    house.add_room(room_3)
    house.add_room(room_2)

    assert_equal [room_1, room_2], house.rooms_by_category[:bedroom]
    assert_equal [room_3], house.rooms_by_category[:living_room]
    assert_equal [room_4], house.rooms_by_category[:basement]
  end
end
