PromoplatformPadrino::App.controllers :actions do
  
  get :index do
    @actions = Action.where(confirmed: true).group(:user_id).sum(:points) 
    
    @ranking = @actions.sort_by { |k,v| v }.reverse
    
    
    render 'actions/index'
  end
  
  post :create do
    activity_id = params[:action][:activity_id].to_i
    activity = Activity.find(activity_id)
    
    action = Action.new
    
    action.user_id = session[:current_user].id
    action.activity_id = activity_id
    action.confirmed = false
    action.points = activity.points
    
    if action.save
      flash[:notice] = 'Zapisano na aktywność'
      
      message = Message.new
      message.who = session[:current_user].id
      message.content = "zapisał(a) się na "
      message.what = activity.id
      
      message.save
      
      redirect back
    end
  end
  
  post :update do
    activity_id = params[:action][:activity_id].to_i
    
    @action = Action.where(activity_id: activity_id, user_id: session[:current_user].id).first
    
    @action.confirmed = true
    @action.confirmation = params[:action][:confirmation]
    
    if @action.save
      
#      potwierdzenia aktywności śmiecą czat
#      message = Message.new
#      message.who = session[:current_user].id
#      message.content = "potwierdził(a) swoją aktywność w "
#      message.what = activity_id
#      
#      message.save
      
      redirect back
    end
  end
  
end
