# This class can be helpful to customize error messages.

class MyError < StandardError
  def initialize(error)
    @error = error
  end

  def message
    [@error.message, 'Actual thrown error is:']
  end
end
