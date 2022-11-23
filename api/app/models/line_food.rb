# 仮注文のモデル
class LineFood < ApplicationRecord
  belongs_to :food
  belongs_to :restaurant
  belongs_to :order, optional: true

  validates :count, numericality: { greater_than: 0 }

  scope :active, -> { where(active: true) }
  scope :other_restaurant, -> (picked_restaurant_id) { where.not(restaurant_id: picked_restaurant_id) }

  def total_amount
    food.price * count
  end

  def self.exists_active_line_food_in_other_restaurant?(other_restaurant_id)
    self.active.other_restaurant(other_restaurant_id).exists?
  end
end
