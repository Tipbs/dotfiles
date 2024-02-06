---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "tokyonight",
  -- theme_toggle = { "tokyonight", "one_light" },
 changed_themes = {
    tokyonight = {
       base_30 = {
        folder_bg = "#BD93F9",
       },
    },
  },
  hl_override = highlights.override,
  hl_add = highlights.add,
  statusline = {
    theme = "default",-- default/vscode/vscode_colored/minimal
     -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "round",
    -- modules arg here is the default table of modules
    overriden_modules = function(modules)
      -- set cursor position at the end
      modules[10] = (function()
        local left_sep = "%#St_pos_sep#" .."" .. "%#St_pos_icon#" .. " "
        local current_line = vim.fn.line(".", vim.g.statusline_winid)
        local current_col = vim.fn.col(".", vim.g.statusline_winid)
        local text = current_line .. "/" .. current_col

        return left_sep .. "%#St_pos_text#" .. " " .. text .. " "
      end)()
    end,
  },
  tabufline = {
    -- lazyload = true,
    overriden_modules = function(modules)
       table.remove(modules,4)
      -- or modules[1] = ""
    end,
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
