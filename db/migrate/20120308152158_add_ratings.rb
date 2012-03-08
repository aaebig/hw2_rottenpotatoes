class AddRatings < ActiveRecord::Migration
  ADD_RATINGS = [
    {:rating => 'G'},
    {:rating => 'PG'},
    {:rating => 'PG-13'},
    {:rating => 'R'}
  ]
  def up
    ADD_RATINGS.each do |rating|
      Rating.create!(rating)
    end
  end

  def down
    ADD_RATINGS.each do |rating|
      Rating.find_by_rating(rating[:rating]).destroy
    end
  end
end
