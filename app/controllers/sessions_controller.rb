class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    client_id = ENV["GITHUB_CLIENT"]
    client_secret = ENV["GITHUB_SECRET"]
    code = params[:code]
    service = GithubService.new.authenticate!(client_id, client_secret, code)
    session[:username] = service.get_username

    redirect_to '/'
  end
end
