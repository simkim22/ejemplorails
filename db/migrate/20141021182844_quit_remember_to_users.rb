class QuitRememberToUsers < ActiveRecord::Migration
  def change
    remove_index  :users, :remember_token
    remove_column :users, :remember_token
  end
end
