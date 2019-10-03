# Your Ruby code here
class TaxRateCalculation
  BASIC_SALES_TAX_RATE = 0.1
  IMPORTED_SALES_TAX_RATE = 0.05
  USER_INPUT_YES = /^(yes|y)$/i
  
  def get_product_details_display_total_amount
    products = []
    loop do
	  product = Product.new      
      if product.get_product_details_from_user
        product.total_tax_rate = total_tax_calc(product.imported, product.exempted)
        products.push(product)
      else
        puts 'Invalid User Input'
      end
      print 'Do you want to add more items to your list(y/n): '
      break unless gets.chomp =~ USER_INPUT_YES
    end
	sum = 0
    products.each do |product|
      puts product.display_product_details
      sum += product.total_price
    end
    puts "Grand Total = #{sum}"
  end
  
  private

  def exempt?(exempt)
    exempt =~ USER_INPUT_YES
  end

  def imported?(imported)
    imported =~ USER_INPUT_YES
  end

  def total_tax_calc(imported, exempted)
    tax = 0
    tax += BASIC_SALES_TAX_RATE unless exempt?(exempted)
    tax += IMPORTED_SALES_TAX_RATE if imported?(imported)
    tax
  end
end

class Product
  INPUT_YES_NO = /(?i)^(?:Yes|No)$/  
  attr_accessor :name, :price, :total_tax_rate, :imported, :exempted
  
  def get_product_details_from_user
    print 'Name of the product: '
    self.name = gets.chomp
    return false if name.empty?
    print 'Imported?(yes/no) '
    self.imported = gets.chomp
    return false unless imported =~ INPUT_YES_NO
    print 'Exempted from sales tax?(yes/no) '
    self.exempted = gets.chomp
    return false unless exempted =~ INPUT_YES_NO
    print 'Price: '
    self.price = gets.chomp.to_i
    return false unless price > 0    
    true
  end
  
  def total_price
    price + total_tax_rate * price
  end
  
  def display_product_details
    "#{name}\t#{price}\t#{total_tax_rate * 100}\t#{total_price}"
  end
end


tax_rate_calculation = TaxRateCalculation.new
tax_rate_calculation.get_product_details_display_total_amount