class Tweet < ApplicationRecord
    belongs_to :user
    mount_uploader :image, ImageUploader

    after_create :renzoku_hantei
        #投稿を作成したのちにrenzoku_hanteiを実行する。
        
        #↓がrenzoku_hanteiの中身
    private
    def renzoku_hantei
        puts "始まったよー！！"
        user = self.user
        today = user.remind_date
        toukoubi = created_at.to_date
        last_date = user.last_tweeted_date
        return if last_date == today
        #user.last_tweeted_dateがremind_date(今日の日付)と同じならカウントしない。同日に複数投稿してる場合にこの後の処理を全部なしにする。
        puts "同日投稿判定を潜り抜けたよ！"
            if last_date == today - 1
            #user.last_tweeted_date（前回投稿した日）がremind_date(今日の日付)より1低かったら(:例16日に投稿、前回の投稿は15日)なら、
            new_kaisuu = user.kaisuu.to_i + 1
            puts "回数が増えたよ！"
            else
            puts "1回目だよ！"
            new_kaisuu = 1
            end
        # kaisuuカラムにニュー回数を代入、last_tweeted_date(前回投稿日)にtoukoubi（今回投稿した日）を代入。
        user.update!(
        kaisuu: new_kaisuu,
        last_tweeted_date: today
        )
    end
    
end
