class PlaysController < ApplicationController
  def index
    @plays = Play.all
  end
  
  def show
    @play = Play.find(params[:id])
  end

  def new
    @play = Play.new
  end

  def create
    @play = Play.new(play_params)
    
    if @play.save 
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @play = Play.find(params[:id])
  end

  def update
    @play = Play.find(params[:id])

    if @play.update(play_params)
      redirect_to play_path(@play)
    else
      render 'edit'
    end
  end

  def destroy
    @play = Play.find(params[:id])
    @play.destroy
    redirect_to root_path
  end

  private

  def play_params
    params.require(:play).permit(:title, :description, :director)
  end
end
