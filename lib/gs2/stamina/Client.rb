require 'gs2/core/AbstractClient.rb'

module Gs2 module Stamina
  
  # GS2-Stamina クライアント
  #
  # @author Game Server Services, Inc.
  class Client < Gs2::Core::AbstractClient
  
    @@ENDPOINT = 'stamina'
  
    # コンストラクタ
    # 
    # @param region [String] リージョン名
    # @param gs2_client_id [String] GSIクライアントID
    # @param gs2_client_secret [String] GSIクライアントシークレット
    def initialize(region, gs2_client_id, gs2_client_secret)
      super(region, gs2_client_id, gs2_client_secret)
    end
    
    # デバッグ用。通常利用する必要はありません。
    def self.ENDPOINT(v = nil)
      if v
        @@ENDPOINT = v
      else
        return @@ENDPOINT
      end
    end

    # スタミナプールリストを取得
    # 
    # @param pageToken [String] ページトークン
    # @param limit [Integer] 取得件数
    # @return [Array]
    #   * items
    #     [Array]
    #       * staminaPoolId => スタミナプールID
    #       * ownerId => オーナーID
    #       * name => スタミナプール名
    #       * description => 説明文
    #       * serviceClass => サービスクラス
    #       * increaseInterval => スタミナの更新速度
    #       * createAt => 作成日時
    #   * nextPageToken => 次ページトークン
    def describe_stamina_pool(pageToken = nil, limit = nil)
      query = {}
      if pageToken; query['pageToken'] = pageToken; end
      if limit; query['limit'] = limit; end
      return get(
            'Gs2Stamina', 
            'DescribeStaminaPool', 
            @@ENDPOINT, 
            '/staminaPool',
            query);
    end
    
    # スタミナプールを作成<br>
    # <br>
    # GS2-Staminaを利用するには、まずスタミナプールを作成する必要があります。<br>
    # スタミナプールには複数のユーザのスタミナ値を格納することができます。<br>
    # <br>
    # スタミナプールの設定として、スタミナ値の回復速度を秒単位で指定できます。<br>
    # この設定値を利用して、スタミナ値の回復処理を行いつつユーザごとに最新のスタミナ値を取得することができます。<br>
    # 
    # @param request [Array]
    #   * name => スタミナプール名
    #   * description => 説明文
    #   * serviceClass => サービスクラス
    #   * increaseInterval => スタミナの更新速度
    # @return [Array]
    #   * item
    #     * staminaPoolId => スタミナプールID
    #     * ownerId => オーナーID
    #     * name => スタミナプール名
    #     * description => 説明文
    #     * serviceClass => サービスクラス
    #     * increaseInterval => スタミナの更新速度
    #     * createAt => 作成日時
    def create_stamina_pool(request)
      if not request; raise ArgumentError.new(); end
      body = {}
      if request.has_key?('name'); body['name'] = request['name']; end
      if request.has_key?('description'); body['description'] = request['description']; end
      if request.has_key?('serviceClass'); body['serviceClass'] = request['serviceClass']; end
      if request.has_key?('increaseInterval'); body['increaseInterval'] = request['increaseInterval']; end
      query = {}
      return post(
            'Gs2Stamina', 
            'CreateStaminaPool', 
            @@ENDPOINT, 
            '/staminaPool',
            body,
            query);
    end
  
    # サービスクラスリストを取得
    # 
    # @return [Array] サービスクラス
    def describeServiceClass()
      query = {}
      result = get(
          'Gs2Stamina',
          'DescribeServiceClass',
          @@ENDPOINT,
          '/staminaPool/serviceClass',
          query);
      return result['items'];
    end
    
    # スタミナプールを取得
    # 
    # @param request [Array]
    #   * staminaPoolName => スタミナプール名
    # @return [Array]
    #   * item
    #     * staminaPoolId => スタミナプールID
    #     * ownerId => オーナーID
    #     * name => スタミナプール名
    #     * description => 説明文
    #     * serviceClass => サービスクラス
    #     * increaseInterval => スタミナの更新速度
    #     * createAt => 作成日時
    def get_stamina_pool(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('staminaPoolName'); raise ArgumentError.new(); end
      if not request['staminaPoolName']; raise ArgumentError.new(); end
      query = {}
      return get(
          'Gs2Stamina',
          'GetStaminaPool',
          @@ENDPOINT,
          '/staminaPool/' + request['staminaPoolName'],
          query);
    end
  
    # スタミナプールの状態を取得
    # 
    # @param request [Array]
    #   * staminaPoolName => スタミナプール名
    # @return [Array]
    #   * status => 状態
    def get_stamina_pool_status(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('staminaPoolName'); raise ArgumentError.new(); end
      if not request['staminaPoolName']; raise ArgumentError.new(); end
      query = {}
      return get(
          'Gs2Stamina',
          'GetStaminaPoolStatus',
          @@ENDPOINT,
          '/staminaPool/' + request['staminaPoolName'] + '/status',
          query);
    end
    
    # スタミナプールを更新
    # 
    # @param request [Array]
    #   * staminaPoolName => スタミナプール名
    #   * description => 説明文
    #   * serviceClass => サービスクラス
    #   * increaseInterval => スタミナの更新速度
    # @return [Array]
    #   * item
    #     * staminaPoolId => スタミナプールID
    #     * ownerId => オーナーID
    #     * name => スタミナプール名
    #     * description => 説明文
    #     * serviceClass => サービスクラス
    #     * increaseInterval => スタミナの更新速度
    #     * createAt => 作成日時
    def update_stamina_pool(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('staminaPoolName'); raise ArgumentError.new(); end
      if not request['staminaPoolName']; raise ArgumentError.new(); end
      body = {}
      if request.has_key?('description'); body['description'] = request['description']; end
      if request.has_key?('serviceClass'); body['serviceClass'] = request['serviceClass']; end
      if request.has_key?('increaseInterval'); body['increaseInterval'] = request['increaseInterval']; end
      query = {}
      return put(
          'Gs2Stamina',
          'UpdateStaminaPool',
          @@ENDPOINT,
          '/staminaPool/' + request['staminaPoolName'],
          body,
          query);
    end
    
    # スタミナプールを削除
    # 
    # @param request [Array]
    #   * staminaPoolName => スタミナプール名
    def delete_stamina_pool(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('staminaPoolName'); raise ArgumentError.new(); end
      if not request['staminaPoolName']; raise ArgumentError.new(); end
      query = {}
      return delete(
            'Gs2Stamina', 
            'DeleteStaminaPool', 
            @@ENDPOINT, 
            '/staminaPool/' + request['staminaPoolName'],
            query);
    end
  
    # スタミナ値を取得<br>
    # <br>
    # 指定したユーザの最新のスタミナ値を取得します。<br>
    # 回復処理などが行われた状態の値が応答されますので、そのままゲームで利用いただけます。<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * staminaPoolName => スタミナプール名
    #   * maxValue => スタミナ値の最大値
    #   * accessToken => アクセストークン
    # @return [Array]
    #   * item
    #     * userId => ユーザID
    #     * value => スタミナ値
    #     * overflow => 最大値を超えているスタミナ値
    #     * lastUpdateAt => 更新日時
    #   * nextIncreaseTimestamp => 次回スタミナ値が回復するタイムスタンプ(unixepoch)
    def get_stamina(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('staminaPoolName'); raise ArgumentError.new(); end
      if not request['staminaPoolName']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      query = {}
      if request.has_key?('maxValue'); query['maxValue'] = request['maxValue']; end
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return get(
          'Gs2Stamina',
          'GetStamina',
          @@ENDPOINT,
          '/staminaPool/' + request['staminaPoolName'] + '/stamina',
          query,
          header);
    end
  
    # スタミナ値を増減させる<br>
    # <br>
    # 同一ユーザに対するスタミナ値の増減処理が衝突した場合は、後でリクエストを出した側の処理が失敗します。<br>
    # そのため、同時に複数のデバイスを利用してゲームを遊んでいる際に、一斉にクエストを開始することで1回分のスタミナ消費で2回ゲームが遊べてしまう。<br>
    # というような不正行為を防ぐことが出来るようになっています。<br>
    # <br>
    # クエストに失敗した時に消費したスタミナ値を戻してあげる際や、スタミナ値の回復アイテムを利用した際などに<br>
    # スタミナ値を増やす操作を行うことになりますが、その際に overflow に true を指定することで、スタミナ値の最大値を超える回復を行えます。<br>
    # スタミナ値の上限を超えた部分は overflow フィールドに格納され、優先してそちらが消費されます。<br>
    # <br>
    # accessToken には {http://static.docs.gs2.io/ruby/auth/Gs2/Auth/Client.html#login-instance_method Gs2::Auth::Client::login()} でログインして取得したアクセストークンを指定してください。<br>
    # 
    # @param request [Array]
    #   * staminaPoolName => スタミナプール名
    #   * variation => スタミナ値の増減量
    #   * maxValue => スタミナ値の最大値
    #   * overflow => スタミナ値の最大値を超えることを許容するか
    #   * accessToken => アクセストークン
    # @return [Array]
    #   * item
    #     * userId => ユーザID
    #     * value => スタミナ値
    #     * overflow => 最大値を超えているスタミナ値
    #     * lastUpdateAt => 更新日時
    def change_stamina(request)
      if not request; raise ArgumentError.new(); end
      if not request.has_key?('staminaPoolName'); raise ArgumentError.new(); end
      if not request['staminaPoolName']; raise ArgumentError.new(); end
      if not request.has_key?('accessToken'); raise ArgumentError.new(); end
      if not request['accessToken']; raise ArgumentError.new(); end
      body = {}
      if request.has_key?('variation'); body['variation'] = request['variation']; end
      if request.has_key?('maxValue'); body['maxValue'] = request['maxValue']; end
      if request.has_key?('overflow'); body['overflow'] = request['overflow']; end
      query = {}
      header = {
        'X-GS2-ACCESS-TOKEN' => request['accessToken']
      }
      return post(
          'Gs2Stamina', 
          'ChangeStamina', 
          @@ENDPOINT, 
          '/staminaPool/' + request['staminaPoolName'] + '/stamina',
          body,
          query,
          header);
    end
  end
end end