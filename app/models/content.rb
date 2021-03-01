class Content < ApplicationRecord
  belongs_to :user

  validates :title, :description, presence: true, uniqueness: {case_sensitive: true}

  has_many :tag_contents, dependent: :destroy
  has_many :tags, through: :tag_contents
end
