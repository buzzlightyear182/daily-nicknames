class User < ActiveRecord::Base

	has_many :nicknames

  validates :name, presence: true

  def nickname
  	nicknames.current.first.nickname if nicknames.current.first
  end
end
