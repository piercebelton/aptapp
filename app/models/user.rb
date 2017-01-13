class User < ApplicationRecord
  has_many :apartments
  devise :database_authenticatable, :registerable, :omniauthable, :recoverable, :rememberable, :trackable, :validatable,  :omniauth_providers => [:twitter]
  after_create :assign_role

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  def assign_role
    add_role(:default)
  end



  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #   user.email = auth.info.email
  #   user.password = Devise.friendly_token[0,20]
  #   user.name = auth.info.name   # assuming the user model has a name
  #   user.image = auth.info.image # assuming the user model has an image
  #   # If you are using confirmable and the provider(s) you use validate emails,
  #   # uncomment the line below to skip the confirmation emails.
  #   # user.skip_confirmation!
  #   end
  # end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.uid + "@twitter.com"
      user.password = Devise.friendly_token[0,20]
    end
  end

end
