class Barber < ApplicationRecord
    has_many :appointments
    has_many :clients, through: :appointments
  
    validates :name, :phone_number, :email, :skills, presence: true
  end
  