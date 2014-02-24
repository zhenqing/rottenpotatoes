class ApplicationController < ActionController::Base
	helper :movies
  protect_from_forgery
end
