# Your Ruby code here
class TaxRateCalculation
  BASIC_SALES_TAX_RATE = 0.1
  IMPORTED_SALES_TAX_RATE = 0.05
  YES = /yes/i
  
  def calculate_total_amount
    product_array = []
    loop do
	  product = Product.new
      data_inputed = product.set_product_details
      if data_inputed == 1
        product.total_tax_rate = total_tax_calc(product.imported, product.exempted)
        product_array.push(product)
      else
        puts 'Invalid User Input'
      end
      print 'Do you want to add more items to your list(y/n): '
      check = gets.chomp
      if check != 'y'
        sum = 0
        product_array.each do |product|
          puts product.output
          sum += product.total_price
        end
        puts "Grand Total = #{sum}"
        break
      end
    end
  end
  
  private

  def exempt?(exempt)
    exempt =~ YES
  end

  def imported?(imported)
    imported =~ YES
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
  
  def set_product_details
    print 'Name of the product: '
    self.name = gets.chomp
    return 0 if name.empty?
    print 'Imported?(yes/no) '
    self.imported = gets.chomp
    return 0 unless imported =~ INPUT_YES_NO
    print 'Exempted from sales tax?(yes/no) '
    self.exempted = gets.chomp
    return 0 unless exempted =~ INPUT_YES_NO
    print 'Price: '
    self.price = gets.chomp.to_i
    return 0 unless price > 0    
    1
  end
  
  def total_price
    price + total_tax_rate * price
  end
  
  def output
    "#{name}\t#{price}\t#{total_tax_rate * 100}\t#{total_price}"
  end
end


tax_rate_calculation = TaxRateCalculation.new
tax_rate_calculation.calculate_total_amount