# e-Navigator で作って欲しいアプリケーションの説明

## セットアップ

### 事前にインストールしておいて欲しいもの
以下は事前にインストールしてあるものとします。
これらのインストールに関しては基本的に質問を受け付けません。

- ruby (version 2.6.5)
- Bundler
- PostgreSQL

### セットアップの手順

セットアップの手順は以下の通りです。
ここからの部分で分からないことがあれば、気軽に質問してください！

Github上でforkして、これから作るRailsアプリケーションの雛形をコピーします。
画面の右上にあるforkボタンを押すことで、自分のアカウントにこのアプリケーションをコピーしてくることができます。

![fork_button](https://github.com/feedforce/e-navigator/wiki/images/fork_button.jpg)

forkしたらローカルにcloneしておいてください。

次に、`$ bin/setup`を実行します。

最後に、`$ bundle exec rails s`してから、`http://localhost:3000`にアクセスしてください。

いつもの画面が表示されればセットアップは完了です。

![youre_on_rails](https://github.com/feedforce/e-navigator/wiki/images/youre_on_rails.png)

## 作って欲しいもの

面談の日程を調整するためのアプリケーションを作っていただきます。
そして、ここで作ったアプリケーションは、あなたの面談日程を調整するために実際に使います。
せっかく作ったアプリケーションが使われないのはもったいないですよね。
自分で作って自分で使って、ぜひ技術書をゲットしちゃってください！

### サンプルアプリ
実装の参考になるように、こんな感じのものを作って欲しいというサンプル用のアプリケーションを用意しました。
サンプルアプリを触ってみてイメージを掴んだ上で中身を実装してみてください！

- [サンプルアプリはこちらです](https://e-navigator.herokuapp.com/)

### 詳細な説明
必要な機能の一覧は以下の通りです。

- 前編
  - ユーザー登録、ログイン機能
  - 登録したユーザーのプロフィール編集機能
- 後編
  - 自分の面談日程の表示・登録・編集・削除機能
  - 面接官が面談日程を承認 or 拒否するための機能
  - 面談日程を知らせるためのメール送信機能

以下で詳しく説明します。

## 前編

### ユーザー登録、ログイン機能
ユーザーを新規登録できるようにし、その登録したユーザーでログインできるようにしてください。
ログインに必要な項目は以下のとおりです。

- メール
- パスワード

Railsチュートリアルではこのユーザー登録・ログイン機能の実装にほとんどの章を割いていますが、[devise](https://github.com/plataformatec/devise)というgemを使えば簡単に実装することができます。
また、他にも認証機能を実装できるgemはいくつかあります。
gemは何を使っても大丈夫ですが、ここの部分はメインの機能ではないのでなるべく簡単に実装してください。

### 登録したユーザーのプロフィール編集機能
以下のプロフィールを登録・編集できるようにしてください。

- 名前
  - 文字列で作りましょう
- 生年月日
  - 生年月日を登録しておけば年齢は計算できますね
- 性別
  - enumを使うと良いですね
- 学校名
  - 文字列で大丈夫です

### 前半終了！
ここまでできたら前半は完了です！

**レビューと今後のアドバイスをしますので、プルリクエストを作り、Herokuに途中までのアプリケーションをデプロイしてLINE等で教えてください！**

Herokuにデプロイする際のアプリ名は`e-navigator-{あなたのGithubのID}`としてください。例えばGithubのIDが`feedforce`であれば、以下のようになります。

```
$ heroku create e-navigator-feedforce
```

また、fork した際のプルリクエストの作り方が分からない場合は、下記のQiita記事が参考になると思います。

- [【GitHub】Pull Requestの手順](https://qiita.com/Commander-Aipa/items/d61d21988a36a4d0e58b)

プルリクエストを作る際には、以下の画像を参考にして Base Repository を自分のGithubアカウントのmasterに切り替えてください。

![base_repository](https://github.com/feedforce/e-navigator/wiki/images/base_repository.jpeg)

## 後編
後編はちょっと長いので、章立てにしてあります。
後編の全てを１つのプルリクエストにすると非常に長いので、各章または各節で個別にプルリクエストを作ってください。それでも長いと感じたら、自分のタイミングでプルリクエストを作って頂いても大丈夫です。作って頂いたプルリクエスト単位でレビューとアドバイスをします。
また、ここからは実装方法についても気軽に相談してください。後編は試行錯誤が必要になると思います。一緒に進めていきましょう！

### 第１章　自分の面談日程の表示・登録・編集・削除機能
まずは自分の面接を表示・登録・編集・削除できるようにしていきましょう！

#### 第１節　面接日程を表示・登録できるようにする
面接日程を登録するためにはその情報をDBに保存する必要があります。
そのために、まずはモデルを作りましょう。モデル名は何でも良いですが、ここでは`Interview`モデルとします。`Interview`モデルは`User`モデルに対して１対多でリレーションを貼ってください。

`Interview`モデルの中身は、面接日程と、面接の可否が判断できるものを保存できるようにしてください。

`Interview`モデルを作ったら、次はそれを表示できるようにしましょう。あるユーザーに対して１対多で紐付いているので、ルーティングもそれに従ってください。`InterviewsController#index`で面接日程の一覧が表示できるようにしましょう。

**⚠ 説明が分からない場合は、ぜひサンプルアプリを見ながら読んでみてください。**

一覧で表示できるようになっても、まだデータを登録していないので表示する内容がありません。そこで、面接日程を登録できるようにしていきます。`InterviewsController#new`で面接日程を登録するための画面を表示し、`InterviewsController#create`で面接日程を登録できるようにしましょう！

#### 第２節　面接日程を編集・削除できるようにする
面接日程の表示・登録ができるようになったら、次は編集と削除をできるようにします。

`InterviewsController#edit`で面接日程を編集するためのページを表示します。そして、`InterviewsController#update`で面接日程の編集を反映できるようにします。
最後に、`InterviewsController#destroy`で一度保存した面接日程を削除できるようにしましょう。

面接日程のCRUD操作(表示・登録・編集・削除)ができるようになったら次に進みましょう！

### 第２章　面接官が面談日程を承認 or 拒否するための機能
次は面接日程の可否を判断する面接官のための機能です。改めて新しいアカウントで登録し、つづきを実装していきましょう！

#### 第１節　自分以外のユーザーの一覧をトップページに表示する

まずは、自分以外の全てのユーザーの一覧をトップページに表示してください。そこに名前やメールアドレスなどのユーザー情報も表示しておきましょう。ここに、他の人の面接一覧を表示するページへのリンクを追加します。(もちろん自分以外のユーザーの面接日程が必要です。あらかじめアカウントを2つ以上登録しておきましょう)

#### 第２節　面接官用の面接日程一覧ページを作る
自分の面接日程は登録や編集ができる必要がありましたが、面接官が面接日程を見る際には「面接はこの日に決定！」という風に、面接日程を指定できる必要があります。そうすると、同じ面接日程の一覧ページでも表示したい内容が異なりますね。

そこで、自分以外の面接日程の一覧を`InterviewsController#index`で表示した際には、どの面接日程で面接を行うのかを選択できるようにしたいです。(ここは説明が難しいのでサンプルアプリを見てみてください)

表示内容を出し分けるにはパーシャルを使うと良いです。また、コントローラーを分けてしまうという手もあります。やりやすい方法で実装してみてください。

#### 第３節　面談日程を承認or拒否できるようにする
面接日程を選択したら、その日が面接日であることを保存してください。また、他の日が面接日程でないことも同様に保存できるようにしてください。

### 第３章　面談日程を知らせるためのメール送信機能
面接日程を登録する場合も、それを承認する場合も、登録したことや承認したことを知らせる必要があります。ここではメールを使ってリマインドができるようにしましょう！

- ユーザーを指定して申請をすると、指定したユーザーに希望する面談日程を承認を依頼するメール
- 承認が押された際に、両者に面接日が決ったことを伝えるメール

以上２つのメールを最低限送信出来るようにしてください。

メールの送信はActionMailerとGmailを使うことで無料で実装することができます(ここでは送信だけで大丈夫です)。メールの文面は、面接官に送信する場合と自分に送信する場合とで分けてください。

また、メールの設定に使うメールアドレスやパスワードは、 **必ず環境変数に入れるようにしGithubに上げないようにしてください。**
環境変数の使い方は [こちらの記事](http://morizyun.github.io/ruby/library-dotenv.html) が参考になります。

### 後編終了！
ここまで来たら完成です。お疲れ様でした！
最後にまたHerokuにアプリをデプロイして、LINE等で教えてください。レビュー後に作ったアプリケーションを使って、実際に弊社の人事と面接日程を決めていただきます！


# Herokuにデプロイする方法
Herokuにデプロイする方法を簡単に書いておきます。

### Herokuにアカウントを作る
Herokuのアカウントを持っていない方は、まずはアカウントを作成してください。

https://www.heroku.com/

### Herokuをセットアップする
Heroku CLI がインストールされているかどうかを確認してください。

```
$ heroku version
```

上記のコマンドを打ってバージョンが表示されない方は Homebrew でインストールしてください。

```
$ brew install heroku/brew/heroku
```

Heroku CLIがインストールできたら、`heroku`コマンドでログインしてSSHキーを登録してください。

```
$ heroku login
$ heroku keys:add
```

ログインできたら、Herokuのサーバーにアプリケーションの実行場所を作りましょう。
アプリ名は`e-navigator-{あなたのGithubのID}`としてください。例えばGithubのIDが`feedforce`であれば、以下のようになります。

```
$ heroku create e-navigator-feedforce
```

### Herokuにデプロイする
いよいよHerokuに登録したアプリケーションをデプロイしましょう。
masterブランチの場合は以下のようにします。

```
$ git push heroku master
```

masterブランチ以外をデプロイしたい場合は以下のようにしてデプロイしてください。

```
$ git push heroku ブランチ名:master
```

正しくデプロイできたか確認してみましょう。

```
$ heroku open
```

正しくアクセスできれば完了です。

## このアプリを作る際に考慮しなくていいこと
以下のことは考慮しなくて大丈夫です。
もしも自分からやってきてくれた分にはきちんと見ますが、出来ていないからといってレビューなどに影響することはありません。

- 見た目(デザイン)
- 新機能の追加
- テスト(弊社ではRailsを使った開発の際には必ずテストを書きますが、ここでは必須ではありません。)

---

これまでのことでもし分からないことがあれば、LINE等で気軽に聞いてください。
