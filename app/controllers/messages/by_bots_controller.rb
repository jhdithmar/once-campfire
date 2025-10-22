class Messages::ByBotsController < MessagesController
  allow_bot_access only: :create

  def create
    super
    head :created, location: message_url(@message)
  end

  private
    def message_params
      if params[:attachment]
        params.permit(:attachment)
      else
        reading(request.body) { |body| { body: request.content_type == "application/x-www-form-urlencoded" ? CGI.unescape(body) : body } }
      end
    end

    def reading(io)
      io.rewind
      yield io.read.force_encoding("UTF-8")
    ensure
      io.rewind
    end
end
