class CreateTweets < ActiveRecord::Migration[7.1]
  def change
    create_table :tweets do |t|
      t.string :name
      t.string :place
      t.datetime :memory

      t.timestamps
    end
  end
end
