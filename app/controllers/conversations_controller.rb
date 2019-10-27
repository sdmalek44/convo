class ConversationsController < ApplicationController
  def index
    render json: Conversation.all
  end

  def create
    conversation = Conversation.new(conversation_params)

    if conversation.save
      serialized_convo = ConversationSerializer.new(conversation)
      serialized_data = ActiveModelSerializers::Adapter::Json.new(serialized_convo).serializable_hash
      ActionCable.server.broadcast 'conversations_channel', serialized_data
      head :ok
    end
  end

  private

  def conversation_params
    params.require(:conversation).permit(:title)
  end
end
