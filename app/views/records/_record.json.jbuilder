json.extract! record, :id, :text, :created_at, :updated_at
json.url record_url(record, format: :json)