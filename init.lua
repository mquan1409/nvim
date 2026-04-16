-- ========================
--
-- Basic Settings
-- ========================
vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"

-- ========================
-- Install lazy.nvim
-- ========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ========================
-- Plugins
-- ========================
require("lazy").setup({

  -- Theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  },

  -- Treesitter (syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
     build = ":TSUpdate",
  },

  -- Telescope (fuzzy finder)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
  },

  -- Auto-complete
  {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      completion = {
        autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-a>"] = cmp.mapping.complete(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
      },
    })
  end,
},
})

-- ========================
-- Theme setup
-- ========================
vim.cmd.colorscheme("tokyonight")

local tokyo_colors = require("tokyonight.colors").setup()

vim.api.nvim_set_hl(0, "LineNr", { fg = tokyo_colors.dark3 })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = tokyo_colors.dark3 })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = tokyo_colors.dark3 })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = tokyo_colors.orange, bold = true })

-- ========================
-- Keymaps
-- ========================
local insert_pairs = {
  ["("] = "()<Left>",
  ["["] = "[]<Left>",
  ["{"] = "{}<Left>",
  ['"'] = '""<Left>',
  ["'"] = "''<Left>",
  ["`"] = "``<Left>",
}

for open_char, pair in pairs(insert_pairs) do
  vim.keymap.set("i", open_char, pair)
end

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")

-- ========================
-- LSP setup
-- ========================
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,
})

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--header-insertion=iwyu",
    "--query-driver=/usr/bin/g++,/usr/bin/c++,/usr/bin/gcc,/usr/bin/cc",
  },
})

vim.lsp.enable("clangd")

vim.lsp.enable("pyright")
vim.lsp.enable("bashls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("clangd")

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- ========================
-- Telescope setup
-- ========================

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", function()
  builtin.find_files({hidden = false})
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep text" })
vim.keymap.set("n", "<leader>fw", function()
  builtin.grep_string({ search = vim.fn.expand("<cword>") })
end, { desc = "Search current word" })
