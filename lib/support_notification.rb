class SupportNotification
  @queue = "support"

  def self.perform(station, requested_at)
    # Ignore old support requests
    return unless requested_at >= 10.minutes.ago

    Twilio::Sms.message('2033090935', '2038042317', station)

    puts station
  end
end
