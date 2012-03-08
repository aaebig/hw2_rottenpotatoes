class CreateRatings < ActiveRecord::Migration
  def up
    create_table 'ratings' do |t|
      t.string 'rating'
      t.timestamps
    end
  end

  def down
    drop_table 'ratings'
  end
end
