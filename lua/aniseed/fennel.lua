local _0_0
do
  local name_0_ = "aniseed.fennel"
  local module_0_
  do
    local x_0_ = package.loaded[name_0_]
    if ("table" == type(x_0_)) then
      module_0_ = x_0_
    else
      module_0_ = require("aniseed.deps.fennel")
    end
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = ((module_0_)["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = ((module_0_)["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local autoload = (require("aniseed.autoload")).autoload
local function _1_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _1_()
    return {autoload("aniseed.deps.fennel"), autoload("aniseed.nvim")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {autoload = {fennel = "aniseed.deps.fennel", nvim = "aniseed.nvim"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local fennel = _local_0_[1]
local nvim = _local_0_[2]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "aniseed.fennel"
do local _ = ({nil, _0_0, nil, {{}, nil, nil, nil}})[2] end
local add_path
do
  local v_0_
  do
    local v_0_0
    local function add_path0(path)
      fennel.path = (fennel.path .. ";" .. path)
      return nil
    end
    v_0_0 = add_path0
    _0_0["add-path"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["add-path"] = v_0_
  add_path = v_0_
end
local sync_rtp
do
  local v_0_
  do
    local v_0_0
    local function sync_rtp0()
      local fnl_suffix = "/fnl/?.fnl"
      local rtp = nvim.o.runtimepath
      local fnl_path = (rtp:gsub(",", (fnl_suffix .. ";")) .. fnl_suffix)
      local lua_path = fnl_path:gsub("/fnl/", "/lua/")
      fennel["path"] = (fnl_path .. ";" .. lua_path)
      return nil
    end
    v_0_0 = sync_rtp0
    _0_0["sync-rtp"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["sync-rtp"] = v_0_
  sync_rtp = v_0_
end
return sync_rtp()
