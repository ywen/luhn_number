module LuhnNumber
  class Output
    attr_reader :input
    def initialize(input)
      @input = input
    end

    def result
      modifer = Validator.new(input).valid? ? "" : "not "
      "#{input} is #{modifer}valid"
    end
  end

  class Validator
    attr_reader :number_str

    def initialize(number_str)
      @number_str = number_str
    end

    def valid?
      return false unless all_digit?
      result = DoubleEverySecondDigit.new(number_part).result
      sum = SumAllIndividualDigitsWithCheckDigit.new(check_digit, result).result
      sum % 10 == 0
    end

    private

    def all_digit?
      !number_array_str.detect{|ele| ele > "9" || ele < "0" }
    end

    def number_array_str
      @number_array_str ||= number_str.split("")
    end

    def number_array
      @number_array ||= number_array_str.map(&:to_i)
    end

    def number_part
      number_array[0..number_array.size-2]
    end

    def check_digit
      number_array.last
    end
  end

  class SumAllIndividualDigitsWithCheckDigit
    attr_reader :check_digit, :other_digits
    def initialize(check_digit, other_digits)
      @check_digit, @other_digits = check_digit, other_digits
    end

    def result
      other_digits.inject(0) {|sum, digit| sum+= digit} + check_digit
    end
  end

  class DoubleEverySecondDigit
    attr_reader :number_array
    def initialize(number_array)
      @number_array = number_array
    end

    def result
      (number_array.size-1).step(0, -2).each do |index|
        double = number_array[index] * 2
        if double >= 10
          number_array[index] = double.to_s.split("").inject(0) {|sum, digit| sum += digit.to_i }
        else
          number_array[index] = double
        end
      end
      number_array
    end
  end
end
