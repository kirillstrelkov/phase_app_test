# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :question
      t.text :answer

      t.timestamps
    end
  end
end
