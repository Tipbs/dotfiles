---@type MappingsTable
local M = {}

local git_add = function()
  local api = require "nvim-tree.api"
  local node = api.tree.get_node_under_cursor()
  local gs = node.git_status.file

  -- If the current node is a directory get children status
  if gs == nil then
    gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
      or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
  end

  -- If the file is untracked, unstaged or partially staged, we stage it
  if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
    vim.cmd("silent !git add " .. node.absolute_path)

  -- If the file is staged, we unstage
  elseif gs == "M " or gs == "A " then
    vim.cmd("silent !git restore --staged " .. node.absolute_path)
  end

  api.tree.reload()
end

M.disabled = {
  n = {
    ["<C-n>"] = { "" },
    ["<leader>e"] = { "" },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>" },
    ["<leader>ds"] = { "<cmd> DapContinue <CR>" },
    -- ["<leader>dc"] = {
    --   function()
    --     require("dap").continue()
    --   end,
    -- },
  },
}

M.dap_ui = {
  plugin = true,
  n = {
    ["<leader>dt"] = {
      function()
        require("dapui").toggle()
      end,
      "DapUiToogle",
    },
  },
}

-- M.dap_python = {
--   plugin = true,
--   n = {
--     ["<leader>dpr"] = {
--       function()
--         require("dap-python").test_method()
--       end,
--     },
--   },
-- }

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["ga"] = { git_add, "Git Add" },
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Focus nvimtree" },
    ["*"] = { "<cmd> keepjumps normal! mi*`i<CR>" },
    ["<C-b>"] = { "<cmd> noh <CR>" },

    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-j>"] = { ":m .+1<CR>==" },
    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-k>"] = { ":m .-2<CR>==" },

    -- Resize with arrows
    ["<C-Up>"] = { ":resize -2<CR>" },
    ["<C-Down>"] = { ":resize +2<CR>" },
    ["<C-Left>"] = { ":vertical resize -2<CR>" },
    ["<C-Right>"] = { ":vertical resize +2<CR>" },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
  },
  v = {
    ["<A-j>"] = { ":m '>+1<CR>gv-gv" },
    ["<A-k>"] = { ":m '<-2<CR>gv-gv" },
    [">"] = { ">gv", "indent" },
  },
  i = {
    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-j>"] = { "<Esc>:m .+1<CR>==gi" },
    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-k>"] = { "<Esc>:m .-2<CR>==gi" },
  },
}

-- more keybinds!

return M
