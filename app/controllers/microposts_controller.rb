class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
   
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to :action => 'show'
    else
      render 'static_pages/home'
    end
  end

  def new
    @micropost = current_user.microposts.build if logged_in?
  end
  
  def show
    if params[:search]
      @microposts = Micropost.search(params[:search]).order("created_at DESC")
    else
      @microposts = Micropost.all.order('created_at DESC')
    end
    # @microposts = Micropost.all.order('created_at DESC')
  end
  
  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  
  private
    def micropost_params
      params.require(:micropost).permit(:content, :title, :picture)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
    
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
