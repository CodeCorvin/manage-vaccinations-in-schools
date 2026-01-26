# frozen_string_literal: true

class AddParentRemovalStatusToCohortImports < ActiveRecord::Migration[8.1]
  def change
    add_column :cohort_imports,
               :parent_removal_status,
               :integer,
               default: nil,
               null: true
  end
end
