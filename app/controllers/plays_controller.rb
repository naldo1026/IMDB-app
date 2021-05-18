class PlaysController < ApplicationController
  def index
    @plays = Play.all.order('created_at DESC')
  end
  
  def show
    @play = Play.find(params[:id])
  end

  def new
    @play = current_user.plays.build
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def create
    @play = current_user.plays.build(play_params)
    @play.category_id = params[:category_id]
    
    if @play.save 
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @play = Play.find(params[:id])
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def update
    @play = Play.find(params[:id])
    @play.category_id = params[:category_id]

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
    params.require(:play).permit(:title, :description, :director, :category_id)
  end
end
