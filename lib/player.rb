class Player < Sprite
  attr_reader :offset

  LEFT_LIMIT, RIGHT_LIMIT = 260, 380
  UP_LIMIT, DOWN_LIMIT = 200, 280

  def initialize
    super
    self.x, self.y = 50, 60
    self.image = Image.new(10, 50, C_WHITE)
    @alive = true
    @clockwise = 1
    init_offset
  end

  def update
    init_offset
    return unless @alive
    @collided = false
    self.angle += 1 * @clockwise
    self.x += Input.x * 3
    self.y += Input.y * 3

    scroll
  end

  def shot(other)
    case other.role
    when :wall
      @alive = false
      self.image = Image.new(10, 50, C_RED)
    when :spring
      @clockwise *= -1
      self.x -= Input.x * 5
      self.y -= Input.y * 5
      self.angle += 2 * @clockwise
    end

    @collided = true
  end

  def init_offset
    @offset = {x: 0, y: 0}
  end

  def scroll
    if self.x < LEFT_LIMIT
      @offset[:x] = LEFT_LIMIT - self.x
      self.x = LEFT_LIMIT
    elsif self.x > RIGHT_LIMIT
      @offset[:x] = RIGHT_LIMIT - self.x
      self.x = RIGHT_LIMIT
    end

    if self.y < UP_LIMIT
      @offset[:y] = UP_LIMIT - self.y
      self.y = UP_LIMIT
    elsif self.y > DOWN_LIMIT
      @offset[:y] = DOWN_LIMIT - self.y
      self.y = DOWN_LIMIT
    end
  end
end
