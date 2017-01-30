class Event < ApplicationRecord
  has_and_belongs_to_many :users

  def self.find_without_by_date_or_initialize_by(params)
    where(params.except(:date)).first_or_initialize(params)
  end
end
