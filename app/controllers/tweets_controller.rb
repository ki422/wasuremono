class TweetsController < ApplicationController
  before_action :authenticate_user!
  after_action :kakuninn, only:[:index]
    
    def index
      
      if params[:search] == nil
        @tweets= Tweet.all
      elsif params[:search] == ''
        @tweets= Tweet.all
      else
        @tweets = Tweet.where("name LIKE ? ",'%' + params[:search] + '%')
      end
      @tweets = @tweets.order(created_at: :desc)
    end
    

    def new
        @tweet = Tweet.new
      end
    
      def create
        tweet = Tweet.new(tweet_params)
        tweet.user_id = current_user.id
        if tweet.save!
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
      end
      
      def show
        @tweet = Tweet.find(params[:id])
      end
     
      def edit
        @tweet = Tweet.find(params[:id])
      end
     
      def update
        tweet = Tweet.find(params[:id])
        if tweet.update(tweet_params)
          redirect_to :action => "show", :id => tweet.id
        else
          redirect_to :action => "new"
        end
      end
      
      def destroy
        tweet = Tweet.find(params[:id])
        tweet.destroy
        redirect_to action: :index
      end
      
      private
      def tweet_params
        params.require(:tweet).permit(:name, :place, :memory, :overall, :image)
      end
      
    
      def kakuninn
        user = current_user
        time = Time.now
        jtime = Time.at(time, in: "+09:00")
        user.update!(
        remind_date: jtime
        )
      end
  
end

