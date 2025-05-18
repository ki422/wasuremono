class UsersController < ApplicationController
    def show
        @user = User.find(params[:id]) 
      
      
          if params[:search] == nil
            @tweets= Tweet.all
          elsif params[:search] == ''
            @tweets= Tweet.all
          else
            @tweets = Tweet.where("name LIKE ? ",'%' + params[:search] + '%')
          end
          @tweets = @tweets.order(created_at: :desc)
      
    end
    
end
