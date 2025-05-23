-- local modname = minetest.get_current_modname()
-- local modpath = minetest.get_modpath(modname)

debug_callstack = {}

-- change/add print(..) or whatever else works
local function print_debug(msg)
  core.log("action", msg)
end

local DEFAULT_MAX_DEPTH = 10

-- get stacktrace as a string
local function get_stacktrace(maxDepth)
  local trace = ""
  if not maxDepth then maxDepth = DEFAULT_MAX_DEPTH end
  for i = 2, maxDepth + 1 do -- ignore 1 because that's this function
    local info = debug.getinfo(i)
    local name = info.name
    local source = info.source
    local line = info.linedefined
    if not name then break end
    trace = trace.."\n".."("..source..":"..line.."): "..name
  end
  return trace
end

function debug_callstack.get_override(original_func, function_name)
  local prev = original_func
  return function(...)
    local params = {...}
    print_debug(function_name.." called\n> params = "..(dump(params):gsub("\n", " ")).."\n> stacktrace = "..get_stacktrace())
    return prev(...)
  end
end


----------------------------------------------------------------
-- overrides (can be made from any other mod using this one)
----------------------------------------------------------------
-- Examples:
-- core.forceload_block = debug_callstack.get_override(core.forceload_block, "forceload_block")
-- core.is_protected = debug_callstack.get_override(core.is_protected, "is_protected")
