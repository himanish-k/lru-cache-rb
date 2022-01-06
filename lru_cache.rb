class LruCache

    MAX = 5

    def initialize
        @lru
        @mru
        @cache = {}
    end

    def get(key)
        node = @cache[key.to_sym]
        
        node.nil? ? nil : node.value 
    end

    def set(key, value)
        key = key.to_sym
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
            if @cache.size == MAX
                lru_next_key = @cache[@lru].next
                @cache.delete(@lru)
                @cache[lru_next_key].prev = nil
                @lru = lru_next_key
            end

            @cache[key] = new_node
            new_node.prev = @mru
            @cache[@mru].next = key
            @mru = key
        end
    end

    def print
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
cache.set('first', 'red')
cache.print
cache.set('second', 'red')
cache.print
cache.set('third', 'red')
cache.print
cache.set('second', 'blue')
cache.print
cache.set('first', 'blue')
cache.print
cache.set('first', 'green')
cache.print
cache.set('fourth', 'green')
cache.print
cache.set('fifth', 'green')
cache.print
cache.set('sixth', 'green')
cache.print
puts "sixth: #{cache.get('sixth')}"
puts "seventh: #{cache.get('seventh')}"