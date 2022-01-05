class LruCache

    def get(key)
        puts 'cache is empty'
    end

    def set(key, value)
        puts "added value '#{value}' for key #{key}"
    end
end

cache = LruCache.new
cache.get 'first'
cache.set 'first', 'First'