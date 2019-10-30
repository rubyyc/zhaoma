class ApplicationController < ActionController::Base
  def require_is_admin
    if !current_user.admin?
      flash[:alert] = "暂无权限"
      redirect_to root_path
    end
  end
end
