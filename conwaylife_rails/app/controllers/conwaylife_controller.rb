class ConwaylifeController < ApplicationController
	def index
		respond_to do |format|
      format.html do
      	render "index"
      end
    end
	end
end
