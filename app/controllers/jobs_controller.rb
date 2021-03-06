class JobsController < ApplicationController
  before_action :authenticate_user!, on: [:new, :create, :update, :destroy]
  def index
    @jobs = case params[:order]
            when 'by_lower_bound'
              Job.published.order('wage_lower_bound DESC')
            when 'by_upper_bound'
              Job.published.order('wage_upper_bound DESC')
            else
              Job.published.order('created_at DESC')
            end
    # @jobs = Job.where(:is_hidden => false).order('created_at DESC')
  end

  def new
    @job = Job.new
  end

  def edit
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      flash[:notice] = "Job发布成功"
      redirect_to jobs_path
    else
      flash[:alert] = "Job发布失败"
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      flash[:notice] = "Job更新成功"
      redirect_to jobs_path
    else
      flash[:alert] = "Job更新失败"
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.delete
    flash[:notice] = "Job删除成功"
    redirect_to jobs_path
  end


  protected

  def job_params
    params.require(:job).permit(:title, :description)
  end
end
