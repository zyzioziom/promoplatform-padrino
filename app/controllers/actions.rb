PromoplatformPadrino::App.controllers :actions do
  
  get :index do
    
    @ranking = Ranking.display
    
    
    render 'actions/index'
  end
  
  post :create do
    activity_id = params[:action][:activity_id].to_i
    activity = Activity.find(activity_id)
    
    action = Action.new
    
    action.user_id = current_user.id
    action.activity_id = activity_id
    action.confirmed = false
    action.points = activity.points
    
    if action.save
      
      message = Message.new
      message.user_id = current_user.id
      message.content = "zapisał(a) się na "
      message.activity_id = activity.id
      
      message.save!
      
      redirect back
    end
  end
  
  post :update do
    @theme_variables = Theme.current
    
    activity_id = params[:action][:activity_id].to_i
    
    action = Action.new.current(activity_id, current_user)
    
    action.confirmed = true
    action.confirmation = params[:action][:confirmation]
    
    if action.save
      flash[:success] = "#{@theme_variables.action_confirmed} #{10004.chr}"
      redirect back
    end
  end
  
end
