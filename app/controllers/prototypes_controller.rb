class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:edit, :show,:update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :move_to_index, only: [:edit,:update, :destroy]


  def index
    @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    binding.pry
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to action: :index
    else
      @prototype = Prototype.new(prototype_params)
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments
  end


  def edit
   
  end

  def update
   
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
      params.require(:prototype).permit(:title, :catch_copy,:concept,:image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end



  def move_to_index
    redirect_to root_path unless current_user == @prototype.user
  end



end
