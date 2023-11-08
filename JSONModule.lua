local json = require("json")

local module = {}

local function findData(JsonFilePath)
    local file = io.open(JsonFilePath,"r")

    if file then
        local directoryPath = JsonFilePath:match("(.*/*)")
        if directoryPath then
            return file
        else
            return false
        end
    else
        return false
    end
end

function module.returnJson(JsonFilePath)
    local file = findData(JsonFilePath)
    if file then
        local jsonContent = file:read("*a")
        local Content = json.decode(jsonContent)
        file:close()
        return Content
    else
        return false
    end
end

function module.insertDataIntoJson(JsonFilePath, arrayData)
    local file = findData(JsonFilePath)
    if file then
        local jsonContent = file:read("*a")
        file:close()

        local Content = json.decode(jsonContent)

        for i,v in pairs(arrayData) do
            Content[i] = v
        end

        local updatedContent = json.encode(Content)
        file = io.open(JsonFilePath, "w")

        if file then
            file:write(updatedContent)
            file:close()
        else
            print("Failed to insert data.")
        end
    else
        print("Failed to return data.")
    end
end

return module
