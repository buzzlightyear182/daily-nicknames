class Nickname < ActiveRecord::Migration
  def change
  	create_table :nicknames do |t|
      t.string :nickname
      t.integer :user_id
      t.timestamps
    end

    remove_column :users, :daily_nickname
  end
end
