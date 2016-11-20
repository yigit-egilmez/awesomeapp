class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    render json: "Hello World 2"
  end
end
