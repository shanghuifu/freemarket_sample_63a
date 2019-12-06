class ItemsController < ApplicationController
  before_action :redirect_to_login_page, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all #.order(created_at: "desc").limit(10)
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item_images = @item.images.limit(10)
  end

  def edit
    @images = @item.images
  end

  def update
    if current_user.id == @item.user_id && @item.update(item_params)
      render :show
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @item.user_id && @item.destroy
      render :index
    else
      render :edit
    end
  end


  private
  def redirect_to_login_page
    redirect_to new_user_session_path unless user_signed_in?
  end
  
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :name,
      :text,
      :price,
      :condition,
      :shipping_from,
      :shipping_date,
      :shipping_fee,
      images: []
    ).merge(user_id: current_user.id)
  end
end

