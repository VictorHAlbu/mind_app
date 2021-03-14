class ContentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_content, only: [:show, :edit, :update, :destroy]
    
    def index
       @contents = current_user.contents
       tag_names = params[:tags]
       if tag_names.present?
           @contents = @contents.joins(:tags).where(tags: {name: tag_names}).distinct 
       end
    end

    def show; end

    def new
        @content = Content.new
    end

    def create
        @content = current_user.contents.build(content_params)

        if @content.save
            associate_tags!
            redirect_to contents_path, notice: 'Conteudo foi criado com sucesso'
        else
            render :new
        end
    end

    def update
        if @content.update(content_params)
            associate_tags!
            redirect_to contents_path, notice: 'Conteudo foi atualizado com sucesso'
        else
            render :edit
        end    
    end

    def destroy
        @content.destroy
        redirect_to contents_path, notice: 'Conteudo foi excluído com sucesso'
    end

    def edit; end

    private
    def set_content
        @content = Content.find(params[:id])
    end
    #metodo tags params lista de tags permite um array de tags e a tag se ela tiver em branco
    def tags_params
        params.require(:content).permit(tags: [])[:tags].reject(&:blank?)
        #retorna todas as tags que o osuario enviou via front e elimina as vazias
    end

    def content_params
        params.require(:content).permit(:title, :description)
    end

    def associate_tags!
        tags = tags_params.map do |tag_name|
            current_user.tags.where(name: tag_name).first_or_initialize
        end
        @content.tags = tags
    end
    
end