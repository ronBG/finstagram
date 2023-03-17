get '/' do
  username = "sharky_j"
  avatar_url = "https://live.staticflickr.com/65535/52358606250_01c667c5da_w.jpg"
  photo_url = "https://live.staticflickr.com/65535/52358421508_786aa10e2c_c.jpg"
  time_ago_in_minutes = 15
  like_count = 0
  comment_count = 1
  comments = [
    "sharky_j: Out for the long weekend... too embarrassed to show y'all the beach bod!"
  ]
  
  if time_ago_in_minutes >= 60
    "#{time_ago_in_minutes / 60} hours ago"
  else
    "#{time_ago_in_minutes} minutes ago"
  end
end