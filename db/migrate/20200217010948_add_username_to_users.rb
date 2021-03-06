class AddUsernameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_name, :string, null: false
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name_kana, :string, null: false
    add_column :users, :first_name_kana, :string, null: false
    add_column :users, :nickname, :string, null: false, unique: true
    add_column :users, :tel, :string, null: false
    add_column :users, :zip_code, :integer, null: false
    add_column :users, :address, :string, null: false
    add_column :users, :birth_year, :integer, null: false
    add_column :users, :birth_month, :integer, null: false
    add_column :users, :birth_day, :integer, null: false
    add_reference :users, :prefecture, null: false, foreign_key: true 
  end
end
