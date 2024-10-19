class Task < ApplicationRecord
  belongs_to :category
  enum status: { incomplete: 0, complete: 1 }

  validates :name, presence: true
  validates :status, presence: true
end
