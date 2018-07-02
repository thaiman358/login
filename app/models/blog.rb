# データベースとの連携用のモデルファイル
class Blog < ApplicationRecord
    has_many :users
    validates :title, length: { in: 1..140 }
    validates :content, length: { in: 1..140 }
end