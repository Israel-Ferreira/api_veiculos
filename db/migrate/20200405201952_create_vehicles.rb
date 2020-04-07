class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.string :vehicle_name
      t.string :brand
      t.integer :year
      t.string :description
      t.boolean :sold

      t.timestamps
    end
  end
end
