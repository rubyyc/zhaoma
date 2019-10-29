class Admin::JobsController < ApplicationController
  before_action :authenticate_user!, on: [:new, :create, :update, :destroy]
  before_action :require_is_admin
  def index
    @jobs = Job.all
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
      redirect_to admin_jobs_path
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
      redirect_to admin_jobs_path
    else
      flash[:alert] = "Job更新失败"
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.delete
    flash[:notice] = "Job删除成功"
    redirect_to admin_jobs_path
  end


  protected

  def job_params
    params.require(:job).permit(:title, :description)
  end


end
