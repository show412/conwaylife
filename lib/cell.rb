class Cell

  attr_accessor(:state, :pending, :neighbors)
  def initialize(state)
    @state = state
    @pending = ' '
    @neighbors = []
  end
  def res
    @pending = "."
  end
  def murder
    @pending = " "
  end
end
