class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    conversation = Conversation.find_by(id: message_params[:conversation_id])

    if message.save
      serializer = MessageSerializer.new(message)
      serialized_data = ActiveModelSerializer::Adapter::Json.new(serializer).serializable_hash
      MessageChannel.broadcast_to conversation, serialized_data
      head :ok
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :conversation_id)
  end
end
