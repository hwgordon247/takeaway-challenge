require_relative 'menu.rb'
require_relative 'text.rb'

class Operator

  def initialize(menu = Menu.new, text = Text.new)
    @menu = menu
    @text = text
    @current_text = ''
    @price = 0
  end

  def check_new_messages
    @current_text = @text.new_message
  end

  def action
    send(@menu.food) if request_menu?
    sort_order(@current_text) unless request_menu?
  end

  def request_menu?
    @current_text.include? 'menu'
  end

  def send(message)
    @text.text(message)
  end

  def sort_order(order)
    item_quantity = []
    @order_information = {}
    items = order.split(",")
    items.each {|x|
      item_quantity << x.split(" ")
    }
    item_quantity.each {|x|
      if x.length == 1
        @order_information[x[0].to_sym] = 1
      else
        @order_information[x[0].to_sym] = x[1].to_i
      end
    }
    @price = @menu.create_receipt(@order_information)
    confirmation_message
    @order_information
  end

  def confirmation_message
    message = "Thank you for placing your order of:\n"
    @order_information.each {|food,quantity|
      message = message + "#{quantity}x #{food}\n"
    }
    message = message + "Total cost: £#{@price}"
    send(message)
    message
  end





end
