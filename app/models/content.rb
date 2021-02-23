class Content < ApplicationRecord
  belongs_to :user

  validates :title, :description, presence: true, uniqueness: {case_sensitive: true}
end
