class Nickname < ActiveRecord::Base

	belongs_to :user

  validates :nickname, presence: true
  validates :user_id, presence: true
  validate :nickname_has_to_be_unique_daily
  validate :nickname_has_to_be_unique_per_user

  scope :current,
  	-> {where(created_at: Date.today.beginning_of_day..Date.today.end_of_day)}

  scope :of_user,
	  -> (user_id) { where(user_id: user_id) }

	def nickname_has_to_be_unique_daily
		if Nickname.current.where(nickname: nickname).length > 1
			errors.add(:nickname, "There is already an existing nickname")
		end

		# if Nickname.current.pluck("nickname").include? nickname
		# 	errors.add(:nickname, "Error message")
		# end
	end

	def nickname_has_to_be_unique_per_user
		if Nickname.of_user(user_id).where(nickname: nickname).length > 1
			errors.add(:nickname, "The nickname has to be unique")
		end
	end

end
