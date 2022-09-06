class CreateRestaurantServers < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurant_servers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
