json.array! @page.records do |user|
  json.partial! "autocompletable/users/user", user: user
end
