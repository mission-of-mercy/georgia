class AddSentToSupportRequests < ActiveRecord::Migration
  def change
    add_column :support_requests, :sent, :boolean, default: false, nil: false
  end
end
