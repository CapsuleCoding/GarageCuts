class Client < ApplicationRecord
    belongs_to :user
    has_many :appointments
    has_many :barbers, through: :appointments
  
    validates :name, presence: true, uniqueness: { scope: :user_id }
    validates :phone_number, :email, presence: true
  end
  