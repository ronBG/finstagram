helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end
end

get '/' do
  @finstagram_posts = FinstagramPost.order(created_at: :desc)
  erb(:index)
end

get '/signup' do     
  @user = User.new   
  erb(:signup)  
end
 
get '/login' do    # when a GET request comes into /login
  erb(:login)      # render app/views/login.erb
end

post '/login' do
  username = params[:username]
  password = params[:password]

  user = User.find_by(username: username)  

  if user && user.password == password
    session[:user_id] = user.id
    redirect to('/')
  else
    @error_message = "Login failed."
    erb(:login)
  end
end 

get '/logout' do
  session[:user_id] = nil
  redirect to('/')
end

post '/signup' do
  email      = params[:email]
  avatar_url = params[:avatar_url]
  username   = params[:username]
  password   = params[:password]

  @user= User.new({email: email, avatar_url: avatar_url, username: username, password: password })
    
  if @user.save
    redirect to('/login')
  else
    erb(:signup)
  end    
end

#handle the HTTP GET fo the path '/finstagram_post/:id'
get '/finstagram_posts/new' do
  @finstagram_post = FinstagramPost.new
  erb(:"finstagram_posts/new")
end

get '/finstagram_posts/:id' do
  @finstagram_post = FinstagramPost.find(params[:id])   # find the finstagram post with the ID from the URL
  erb(:"finstagram_posts/show")               # render app/views/finstagram_posts/show.erb
end
 
post '/finstagram_posts' do
  photo_url = params[:photo_url]

  @finstagram_post = FinstagramPost.new({ photo_url: photo_url, user_id: current_user.id})

  # if @post validates, save
  if @finstagram_post.save
    redirect(to('/'))
  else
    # if it doesn't validate, print error messages ( by passing it to the neww.erb file)
    erb(:"finstagram_posts/new")
  end
end

post '/comments' do 
text = params[:text]
finstagram_post_id = params[:finstagram_post_id]
comment = Comment.new({ text: text, finstagram_post_id: finstagram_post_id, user_id: user_id })
comment.save
redirect(back)
end

post '/likes' do
  finstagram_post_id = params[:finstagram_post_id]

  like = Like.new({ finstagram_post_id: finstagram_post_id, user_id: current_user.id })
  like.save

  redirect(back)
end

delete '/likes/:id' do
  like = Like.find(params[:id])
  like.destroy
  redirect(back)
end