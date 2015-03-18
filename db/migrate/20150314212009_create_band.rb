class CreateBand < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :user_name
      t.string :name
      t.integer :band_id
      t.boolean :message_sent, default: false
      
      t.timestamps
    end
  end
end
