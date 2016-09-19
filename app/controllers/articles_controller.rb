class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    # @articles = Article.all
    # @articles = Article.where(published: true)
    @articles = policy_scope(Article).reverse
  end

  def show
  end

  def new
    @article = current_user.articles.new
    authorize @article
  end

  def edit
  end

  def create
    @article = current_user.articles.create(article_params)
    authorize @article
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private
    def set_article
      @article = Article.find(params[:id])
      authorize @article
    end

    def article_params
      params.require(:article).permit(:title, :user_id, :content, :published)
    end
end
