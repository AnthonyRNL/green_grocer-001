require 'pry'
def consolidate_cart(cart:[])
  # code here
  consolidated = {}
  cart.each do |x|
    x.each do |k,v|
      if consolidated[k]
        consolidated[k][:count] += 1
      else
        consolidated[k] = {
          :price => v[:price],
          :clearance => v[:clearance],
          :count => v[:count] || 1
        }
      end
    end
  end
  # consolidated.each do |x,y|
  #   y[:price] *= y[:count]
  # end
  consolidated
end

def apply_coupons(cart:[], coupons:[])
  # code here

      # binding.pry
    if coupons.length > 0
      coupons.each do |x|
        if cart[x[:item]] && cart[x[:item]][:count] >= x[:num]
          if cart[x[:item]][:count] - x[:num] <= 0
            cart[x[:item]][:count] = 0
          else
            cart[x[:item]][:count] -= x[:num]
          end
          if cart["#{x[:item]} W/COUPON"]
            cart["#{x[:item]} W/COUPON"][:count] += 1
          else
            cart["#{x[:item]} W/COUPON"] = {
              :price => x[:cost],
              :clearance => cart[x[:item]][:clearance],
              :count => 1
            }
          end
        end
      end
    end
  cart
end

def apply_clearance(cart:[])
  cart.each do |k,v|
    if v[:clearance]
      v[:price] -= v[:price] * 0.2
    end
  end
  cart
end

def checkout(cart: [], coupons: [])
  # code here
  price = 0
  consol = consolidate_cart(cart: cart)
  cartCP = apply_coupons(cart: consol, coupons: coupons)
  # binding.pry
  cartCL = apply_clearance(cart: cartCP)
  # binding.pry
  cartCL.each do |k,v|

    # binding.pry
   price += v[:price] * v[:count]
  end
    # binding.pry
  if price > 100
    price -= price * 0.1
  end
  price
end
