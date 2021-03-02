class ContentsController < ApplicationController
    before_action :authenticate_user!

    def index
       @contents = current_user.contents
    end

    def show
        @content = Content.find(params[:id])
    end

    def new
        @content = Content.new
    end

    def create
        @content = current_user.contents.build(content_params)

        if @content.save
            redirect_to contents_path, notice: 'Conteudo foi criado com sucesso'
        else
            render :new
        end
    end

    def update
        @content = Content.find(params[:id])

        if @content.update(content_params)
            redirect_to contents_path, notice: 'Conteudo foi atualizado com sucesso'
        else
            render :edit
        end    
    end

    def edit
        @content = Content.find(params[:id])
    end

    private
    def content_params
        params.require(:content).permit(:title, :description)
    end
    
end