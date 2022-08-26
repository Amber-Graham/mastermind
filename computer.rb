module Computer
  include Game
  class Computer
    def make_guess(turns, all_combinations)
      turns == 11 ? %w[yellow yellow blue blue] : all_combinations.sample
    end
  end
end