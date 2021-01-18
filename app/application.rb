class Application 
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            query_item = req.path.split("/")[2]
            found = Item.all.find{|item| item.name == query_item}
            if found
                resp.write(found.price)
            else
                resp.status = 400
                resp.write("Item not found")
            end
            resp.finish
        else
            resp.status = 404
            resp.write("Route not found")
            resp.finish
        end
    end
end