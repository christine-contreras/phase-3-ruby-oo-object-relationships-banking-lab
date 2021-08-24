class Transfer
  # your code here
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender, @receiver, @amount = sender, receiver, amount
    @status = "pending"
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    if self.check_transaction?
      self.sender.balance -= self.amount
      self.receiver.balance += self.amount
      self.status = "complete"
    else 
      self.rejected
    end

  end

  def reverse_transfer
    if self.check_reverse?
      self.sender.balance += self.amount
      self.receiver.balance -= self.amount
      self.status = "reversed"
    else
      self.rejected
    end

  end

  def check_transaction?
    self.valid? &&
    self.sender.balance > self.amount &&
    self.status == "pending"
  end

  def check_reverse?
    self.valid? &&
    self.receiver.balance > self.amount &&
    self.status == "complete"
  end

  def rejected
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end

  

end
