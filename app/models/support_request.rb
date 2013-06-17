class SupportRequest < ActiveRecord::Base
  after_create :send_sms

  belongs_to :user
  belongs_to :treatment_area

  scope :active, SupportRequest.where(resolved: false)

  def station_description
    description = []

    if treatment_area && treatment_area != TreatmentArea.radiology
      description << treatment_area.name
    end

    description << user.name if user

    description.compact.join(" ")
  end

  def to_hash
    {
      :ip_address           => ip_address,
      :station_description  => station_description
    }
  end

  private

  def send_sms
    Resque.enqueue(SupportNotification, station_description, created_at)
  rescue StandardError
    true
  end
end
