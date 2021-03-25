class BooksController < ApplicationController

  def index #初期表示画面

    # 画面表示用モデル
    @books = Book.all

    # 新規登録用モデル
    @book = Book.new
  end


  def show #詳細画面
    # 1件レコードを取得
    @book = Book.find(params[:id])
  end


  def edit #編集画面
    # 1件レコードを取得
    @book = Book.find(params[:id])
  end


  def create #新規登録イベント

    # 画面の入力パラメータをモデルに設定
    @book = Book.new(list_params)

    # 登録(insert)
    if @book.save then

      # 登録メッセージを設定
      flash[:notice] = 'Book was successfully created.'

      # 詳細画面(show)へ遷移
      redirect_to book_path(@book.id)

    # 更新が失敗した場合
    else

      # 再描画する際にActionを踏まないので必要
      @books = Book.all

      # 初期画面(indes)を再描画
      render "books/index"
    end
  end


  def update #更新イベント

    @book = Book.find(params[:id])

    # 更新(update)
    if @book.update(list_params) then

      # 更新メッセージを設定
      flash[:notice] = 'Book was successfully updated.'

      # 詳細画面(show)へ遷移
      redirect_to book_path(@book.id)

    # 更新が失敗した場合
    else

      # エラーメッセージを設定
      #flash[:error] = @book.errors.full_messages

      # 更新しようとした情報を設定
      #flash[:book] = @book

      # 編集画面(edit)を再描画
      render "books/edit"

    end
  end


  def destroy #削除イベント

    book = Book.find(params[:id])

    # 削除(delete)
    book.destroy

    # 初期画面(index)へ遷移
    redirect_to books_path
  end


  private
  # ストロングパラメータ
  def list_params
    params.require(:book).permit(:title, :body)
  end

end
