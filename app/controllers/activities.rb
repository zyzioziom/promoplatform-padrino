PromoplatformPadrino::App.controllers :activities do

  get :index do
    @activities = Activity.all
    
    render 'activities/index'
  end

  get :index, :with => :id do
    case params[:id]
      when 'leaflets'
        @activities = Activity.where(category: "leaflet").order(:date, :hour).group_by(&:date)
      
        unless @activities.nil?
          render 'activities/index'
        end
      
      when 'posters'
        @activities = Activity.where(category: "poster").order(:date, :hour).group_by(&:date)
        unless @activities.nil?
          render 'activities/index'
        end
      
      when 'stands'
        @activities = Activity.where(category: "stand").order(:date, :hour).group_by(&:date)
        unless @activities.nil?
          render 'activities/index'
        end
      
      when 'events'
        @activities = Activity.where(category: "event").order(:date, :hour).group_by(&:date)
        unless @activities.nil?
          render 'activities/index'
        end
      
      when 'others'
        @activities = Activity.where(category: "other").order(:date, :hour).group_by(&:date)
        unless @activities.nil?
          render 'activities/index'
        end
      
      else
        @activity = Activity.find_by_id(params[:id])
        @signed = Action.where(activity_id: params[:id])
        @current_user_signed = Action.where(activity_id: params[:id], account_id: session[:current_user]).first
      
        unless @activity.nil?
          render 'activities/show'
        end
      end
  end
  
end
