# frozen_string_literal: true

class Vehicle < ApplicationRecord
  validates :vehicle_name, :brand, :year, :description, presence: true
  before_save :sold_state

  scope :by_name, ->(vehicle_name) { where(vehicle_name: vehicle_name) }
  scope :by_brand, ->(brand) { where(brand: brand) }

  private

  def sold_state
    self.sold = false if sold.nil?
  end
  
end
