class ConversationsController < ApplicationController
  def index
    render json: Conversation.all
  end
end
