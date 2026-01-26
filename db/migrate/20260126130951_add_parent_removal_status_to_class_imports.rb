# frozen_string_literal: true

class AddParentRemovalStatusToClassImports < ActiveRecord::Migration[8.1]
  def change
    add_column :class_imports,
               :parent_removal_status,
               :integer,
               default: nil,
               null: true
  end
end
