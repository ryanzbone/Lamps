class Lamp

  @@count = 0

  attr_reader :id, :price, :color
  attr_accessor :quantity

  def initialize(name, price, color)
    @name = name
    @price = price
	@quantity = rand(10) + 7
	@color = color
    @id = @@count
    @@count += 1
  end

  def to_s
    @name.to_s.capitalize
  end
end
