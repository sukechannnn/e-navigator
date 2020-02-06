# frozen_string_literal: true

class User < ApplicationRecord
  has_many :interviews
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum gender: { female: 1, male: 2, other: 3 }
  enum role: { member: 1, interviewer: 2 }

  def self.interviewers
    all.where(role: :interviewer)
  end
end
