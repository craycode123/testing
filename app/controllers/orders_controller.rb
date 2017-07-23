class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    # "order"=>{"onigiri"=>["cheese", "kimchi", "mayo tuna"]}, "qua1"=>"2", "qua2"=>"", "qua3"=>"", "qua4"=>""
    onigiri = []
    params[:order][:onigiri].each_with_index do |o, i|
      a = 'qua' + i.to_s
      a = params[a.to_sym]
      if a == ""
        a = 0
      end
      onigiri << o << a
    end
    params[:order][:onigiri] = onigiri
    order = Order.new(order_params)
    price = 0
    onigiri.each_with_index do |x, i|
      if x == "cheese" || x == "kimchi"
        price += 6.90 * onigiri[i + 1].to_i
      elsif x == "mayo tuna" || x == "honey mustard"
        price += 7.90 * onigiri[i + 1].to_i
      end
    end
    order.total = price
    if order.save
      redirect_to orders_path
    else
      redirect_to root_path
    end
  end

  def update
    order = Order.find(params[:id])
    order.update(status: "Done")
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit({:onigiri => []})
  end
end
