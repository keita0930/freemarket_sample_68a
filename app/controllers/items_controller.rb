class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :show]
  def new
    @item = Item.new
    @item.images.new
    @parents = Category.where(ancestry: nil)
  end

  def create
    @item = Item.new(item_params)
    @parents = Category.where(ancestry: nil)
    unless @item.save
      render :new
    end
  end
  
  def get_category_children
    @category_children = Category.find_by(id: "#{params[:parent_id]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find_by(id: "#{params[:child_id]}").children
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @parents = Category.where(ancestry:nil)
    @children = Category.where(ancestry:@item.category.root.id)
    @grandchildren = Category.where(ancestry:"#{@item.category.root.id}/#{@item.category.parent.id}")
  end

  def update
    @item = Item.find(params[:id])
    @parents = Category.where(ancestry:nil)
    @children = Category.where(ancestry:@item.category.root.id)
    @grandchildren = Category.where(ancestry:"#{@item.category.root.id}/#{@item.category.parent.id}")
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    unless item.destroy
      render :show
    end
    
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :description, :shipping_method_id, :brand_id, :condition_id, :size_id, :category_id, :prefecture_id, :delivery_date_id, :shipping_fee_id, :method ,images_attributes: [:src, :_destroy, :id]).merge(user_id: current_user.id)
  end
end

