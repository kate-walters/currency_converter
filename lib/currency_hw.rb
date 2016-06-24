class DifferentCurrencyCodeError < StandardError
  def message
    "Currency types are not consistent, cannot be added or subtracted."
  end
end

class NaN < StandardError
  def message
    "This is not a number."
  end
end

class Currency
  attr_reader :code, :amount
  def initialize(code, amount)
    @code = code
    @amount = amount
  end

  def ==(other)
    return false unless other.is_a?(Currency)
    @amount == other.amount
  end

  def !=(other)
    return false until other.is_a?(Currency)
    @amount != other.amount
  end

  def +(other)
    raise  DifferentCurrencyCodeError unless other.is_a?(Currency)
    final_amount = @amount + other.amount
    Currency.new(@code, final_amount)
  end

  def -(other)
    raise DifferentCurrencyCodeError unless other.is_a?(Currency)
    final_amount = @amount - other.amount
    if final_amount < 0
      STDERR.puts ("WARNING : Amount was going to be #{final_amount}. Cannot have negative Currency.")
    else
      Currency.new(@code, final_amount)
    end

    def *(other)
      raise NaN unless other.is_a?(Fixnum) || other.is_a?(Float)
      final_amount = @amount * other
      Currency.new(@code, final_amount)
    end
  end
end


class CurrencyConverter
  attr_reader :codes
  def initialize(codes)
    @codes = codes
  end

  def currency_converter
    CurrencyConverter.new( { USD: 1.0, EUR: 0.88, JPY: 106.58 } )
  end

  def convert(currency, convert_to_code)
    Currency.new(@codes, currency_converter)
  end

  #currency_converter.convert( CurrencyConverter.new(1, :USD), :JPY) == CurrencyConverter.new(106.58, :JPY)

end
