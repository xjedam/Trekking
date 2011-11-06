class CreateTrails < ActiveRecord::Migration
  def down
    drop_table :trails
  end

  def change
    create_table :trails do |t|
      t.string :name
      t.string :locations
      t.timestamps
    end
  end
end
