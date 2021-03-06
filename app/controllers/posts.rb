get "/create_post" do
  erb :create_post
end

post "/create_post" do
  post = Post.create(title: params[:post][:title],
                     body: params[:post][:body],
                     author: params[:post][:author] )
  tag_arr = params[:post][:tag].split(", ")
              .map { |tag| Tag.find_or_create_by(tag: tag) }

  post.tags = tag_arr
  redirect to('/')
end

get "/post/:post_id" do
  @post = Post.find(params[:post_id])
  erb :single_post
end

get "/edit/:post_id" do
  @post = Post.find(params[:post_id])
  erb :edit_post
end

post "/edit/:post_id" do
  Post.update(params[:post_id],
              title:  params[:post][:title],
              body:   params[:post][:body],
              author: params[:post][:author])
  redirect to("/post/#{params[:post_id]}")
end

delete "/delete/:post_id" do
  Post.destroy(params[:post_id])
  redirect to("/")
end

