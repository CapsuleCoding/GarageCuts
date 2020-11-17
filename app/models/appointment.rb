class Appointment < ApplicationRecord
    belongs_to :barber
    belongs_to :client
  
    validates :starting_date_and_time, :ending_date_and_time, presence: true
    validate :barber_conflict, :client_conflict, if: :starts_before_it_ends?
    validate :ends_after_it_starts
  
    def barber_conflict
      starting = self.starting_date_and_time
      ending = self.ending_date_and_time
      conflict = barber.appointments.any? do |appointment|
        other_start = appointment.starting_date_and_time
        other_end = appointment.ending_date_and_time
        other_start < ending && ending < other_end || other_start < starting && starting < other_end
      end
      if conflict
        errors.add[:barber, "Conflicting Appointment Present"]
      end
    end
  
    def client_conflict
      starting = self.starting_date_and_time
      ending = self.ending_date_and_time
      conflict = client.appointments.any? do |appointment|
        other_start = appointment.starting_date_and_time
        other_end = appointment.ending_date_and_time
        other_start < ending && ending < other_end || other_start < starting && starting < other_end
      end
      if conflict
        errors.add[:client, "Conflicting Appointment Present"]
      end
    end
  
    def ends_after_it_starts
      if !starts_before_it_ends?
        errors.add(:starting_date_and_time, "must be before the ending date and time")
      end
    end
  
    def starts_before_it_ends?
      starting_date_and_time < ending_date_and_time
    end
  
    def barber_name
      self.barber.name
    end
  
    def client_name
      self.client.name
    end
  
    def self.by_barber(barber)
      where(barber_id: barber.id)
    end
  
    def self.upcoming
      where("starting_date_and_time > ?", Time.now)
    end
  
    def self.past
      where("ending_date_and_time < ?", Time.now)
    end
  
    def self.most_recent
      order(starting_date_and_time: :desc)
    end
  
    def self.longest_ago
      order(starting_date_and_time: :asc)
    end
  end
  