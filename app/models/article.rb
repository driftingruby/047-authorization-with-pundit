# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string
#  user_id    :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  published  :boolean          default(FALSE)
#

class Article < ApplicationRecord
  belongs_to :user
end
