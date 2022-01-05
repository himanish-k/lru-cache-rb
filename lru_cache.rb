class LruCache

    MAX = 5

    def initialize
        @lru
        @mru
        @cache = {}
    end

    def get(key)
        puts 'cache is empty' if @cache.size == 0
    end

    def set(key, value)
        new_node = Node.new(value)
        if (@cache.size == 0)
            @cache[key] = new_node
            @lru = key
            @mru = key
        end

        print_cache_state
    end

    private

    def print_cache_state
        puts "cache state: #{@cache}"
        puts "lru: #{@lru}"
        puts "mru: #{@mru}"
    end

    class Node
        attr_accessor :value, :next

        def initialize(value)
            @value = value
        end
    end
end

cache = LruCache.new
cache.get 'first'
cache.set('first', 'himanish')