class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :title, presence: true, length: { maximum: 140 }
  mount_uploader :picture, PictureUploader
  validate  :picture_size
  
  def self.search(search)
    # Title is for the above case, the OP incorrectly had 'name'
    where("title LIKE ?", "%#{search}%")
  end
  
  private
    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
