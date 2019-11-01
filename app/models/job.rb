# == Schema Information
#
# Table name: jobs
#
#  id               :integer          not null, primary key
#  title            :string
#  description      :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  wage_upper_bound :integer
#  wage_lower_bound :integer
#  contact_email    :string
#  is_hidden        :boolean          default("0")
#

class Job < ApplicationRecord
  validates :title, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 0}
  validates :wage_upper_bound, numericality: { greater_than: :wage_lower_bound}

  has_many :resumes


  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

  scope :published, -> { where(is_hidden: false) }
  scope :publish, ->{ order("created_at DESC")}
end
