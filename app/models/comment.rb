# == Schema Information
# Schema version: 20120427185014
#
# Table name: comments
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)     
#  email       :string(255)     
#  message     :text            
#  proposal_id :integer(4)      
#  created_at  :datetime        
#  updated_at  :datetime        
#

class Comment < ActiveRecord::Base
  attr_accessible :name, :email, :message

  belongs_to :proposal

  validates_presence_of :email, :message, :proposal_id

  # Make sure there's a legitimate proposal attached?!
  validates_presence_of :proposal, :message => "must be present"

  scope :listable, lambda { order("created_at desc").where("created_at IS NOT NULL") }
end
