require "rspec"

require_relative "account"

describe Account do

  let(:wrong_acct_number) {"qwerty"}
  let(:acct_number)       {"1234567890"}
  let(:account)           {Account.new(acct_number)}

  describe "#initialize" do
    it "create a new account with right acct_number" do
      expect(account.acct_number).to eq("******7890")
      expect(account.transactions).to eq([0]) #expect transaction is nil
    end

    it "create a new account with wrong acct_number" do
      expect{ Account.new(wrong_acct_number)}.to raise_error(InvalidAccountNumberError)
    end
  end

  describe "#transactions" do
    it "gets an array of transactions" do
      expect( account.deposit!(100) ).to eq(100)
      expect( account.withdraw!(20) ).to eq(80)
      expect( account.transactions ).to eq([0, 100, -20])
    end
  end

  describe "#balance" do
    it "has a balance of zero" do
      expect( account.balance ).to eq(0)
    end

    it "has a net value balance" do
      account.deposit!(100)
      account.withdraw!(50)
      expect( account.balance ).to eq(50)
    end
  end

  describe "#account_number" do
    it "has commented out all numbers except last 4 digits" do
      expect( account.acct_number).to eq("******7890")
    end
  end

  describe "deposit!" do
    it "deposit into balance" do
      expect( account.deposit!(100) ).not_to be_nil
      expect( account.deposit!(50) ).to eq(150)
    end

    it "raise error if deposit is negative value" do
      expect{ account.deposit!(-10) }.to raise_error(NegativeDepositError)
    end
  end

  describe "#withdraw!" do
    it "withdraw from balance" do
      expect( account.deposit!(100) ).to eq(100)
      expect( account.withdraw!(50) ).to eq(50)
    end

    it "raise error if overdraft" do
      expect{ account.withdraw!(1000)}.to raise_error(OverdraftError)
    end
  end
end