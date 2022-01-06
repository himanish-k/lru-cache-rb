class LruCache

    MAX = 5

    def initialize
        @lru
        @mru
        @cache = {}
    end

    def get(key)
        puts 'cache is empty' if @cache.size == 0

        puts @cache[key]
    end

    def set(key, value)
        new_node = Node.new(value)
        if (@cache.size == 0)
            @cache[key] = new_node
            @lru = key
            @mru = key
        elsif @cache[key] # if key already exists
            prev_key = @cache[key].prev
            next_key = @cache[key].next

            if key == @mru
                new_node.prev = prev_key
            else
                if key == @lru
                    @cache[next_key].prev = nil
                    @lru = next_key
                else
                    @cache[prev_key].next = next_key
                    @cache[next_key].prev = prev_key
                end

                new_node.prev = @mru
                @cache[@mru].next = key
                @mru = key
            end

            @cache[key] = new_node
        else
            @cache[key] = new_node
            new_node.prev = @mru
            @cache[@mru].next = key
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
        attr_accessor :value, :next, :prev

        def initialize(value)
            @value = value
        end
    end
end

cache = LruCache.new
cache.get 'first'
cache.set('first', 'red')
cache.set('second', 'red')
cache.set('third', 'red')
cache.set('second', 'blue')
cache.set('first', 'blue')
cache.set('first', 'green')
