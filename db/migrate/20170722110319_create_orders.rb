class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :onigiri, array: true, default: []
      t.integer :quantity, array: true, default: []
      t.decimal :total
      t.string :status, default: "Waiting"

      t.timestamps null: false
    end
  end
end
