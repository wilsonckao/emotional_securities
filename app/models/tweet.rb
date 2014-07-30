class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short #c_at
  field :text, type: String
  field :tweet_id, type: Integer
  field :sentiment, type: Float
  field :tweeted_at, type: DateTime
  field :company, type: String


  def avg
    self.inject{ |sum, n| sum + n.sentiment }/self.length
  end

  def self.running10(company)
     moving_avg = []
     ordered_sentiments = Tweet.where(company: company).order{:tweeted_at}.pluck(:sentiment)

     p ordered_sentiments.length.times {|i| moving_avg << ordered_sentiments[i...i+10].inject(:+)/10 unless ordered_sentiments[i+10] == nil}

     p moving_avg
  end

end

