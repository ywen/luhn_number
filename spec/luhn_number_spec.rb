require "spec_helper"

module LuhnNumber
  describe Output do
    subject { Output.new "12345678" }

    describe "#result" do
      let(:validator) { double :validator, valid?: true }

      before(:each) do
        Validator.stub(:new).and_return validator
      end

      context "when the number is valid" do
        it "returns valid string" do
          validator.stub(:valid?).and_return true
          expect(subject.result).to eq( "12345678 is valid" )
        end
      end

      context "when the number is not valid" do
        it "returns invalid string" do
          validator.stub(:valid?).and_return false
          expect(subject.result).to eq( "12345678 is not valid" )
        end
      end
    end
  end

  describe Validator do
    subject { Validator.new number }

    describe "#valid?" do
      context "when the input is not all digit" do
        let(:number) { "000000a000" }
        it "returns false" do
          expect(subject).not_to be_valid
        end
      end

      context "when the number is valid" do
        let(:number) { "79927398713" }

        it "returns true" do
          expect(subject).to be_valid
        end
      end

      context "when the number is invalid" do
        let(:number) { "79927398712" }

        it "returns false" do
          expect(subject).not_to be_valid
        end
      end
    end
  end

  describe DoubleEverySecondDigit do
    subject { described_class.new number }

    let(:number) { [ 7, 9, 9, 2, 7, 3, 9, 8, 7, 1 ] }

    describe "#result" do
      it "returns an array with calculated result" do
        expect(subject.result).to eq([7, 9, 9, 4, 7, 6, 9, 7, 7, 2])
      end
    end
  end

  describe SumAllIndividualDigitsWithCheckDigit do
    subject { described_class.new 3, number }

    let(:number) { [7, 9, 9, 4, 7, 6, 9, 7, 7, 2] }

    describe "#result" do
      it "returns an array with calculated result" do
        expect(subject.result).to eq(70)
      end
    end
  end

end
