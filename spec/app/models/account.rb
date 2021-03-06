class Account
  include Mongoid::Document

  field :_id, type: String, overwrite: true, default: ->{ name.try(:parameterize) }

  field :number, type: String
  field :balance, type: String
  field :nickname, type: String
  field :name, type: String
  field :balanced, type: Mongoid::Boolean, default: ->{ balance? ? true : false }

  field :overridden, type: String

  embeds_many :memberships
  belongs_to :creator, class_name: "User", foreign_key: :creator_id
  belongs_to :person
  has_many :alerts, autosave: false
  has_and_belongs_to_many :agents
  has_one :comment, validate: false

  validates_presence_of :name
  validates_presence_of :nickname, on: :upsert
  validates_length_of :name, maximum: 10, on: :create

  def overridden
    self[:overridden] = "not recommended"
  end
end
