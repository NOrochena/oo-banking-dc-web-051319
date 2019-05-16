class Transfer

  attr_accessor :sender, :receiver, :amount, :status, :last_transaction_amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if !(sender.balance - amount < 0)
      sender.balance -= self.amount
      receiver.balance += self.amount
      self.last_transaction_amount = self.amount
      self.amount = 0
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete"
      sender.balance += self.last_transaction_amount
      receiver.balance -= self.last_transaction_amount
      self.status = "reversed"
    end
  end
end
