# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  password_digest :string
#  text            :string
#  uuid            :string
#  viewed          :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class MessageSerializer < ActiveModel::Serializer
  attribute :text do

    if object.viewed?
    'You already requested this message'
    elsif object.authenticate(instance_options[:password])
      object.update!(viewed: true, password:instance_options[:password])
      object.decrypted_message
    else
      object.text
    end
  end
end
