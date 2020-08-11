class ItemsController < ApplicationController
  before_action :move_to_login, only: [:new, :create, :edit]
  before_action :item_information, only: [:show, :edit]

  def index
    @items = Item.all.order("created_at DESC")
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
  end

  def edit
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :item_description, :category_id, :item_condition_id, :shipping_fee_id, :shipping_place_id, :shipping_days_id, :price).merge(user_id: current_user.id)
  end

  def move_to_login
    unless user_signed_in?
      flash[:alert] = 'ログイン、または新規登録をしましょう！'
      redirect_to new_user_session_path
    end
  end

  def item_information
    @item = Item.find(params[:id])
  end

end
