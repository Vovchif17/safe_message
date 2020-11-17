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
    return 'You already requested this message' if object.viewed?

    if object.authenticate(instance_options[:password])
      object.decrypted_message
    else
      object.text
    end
  end
end
