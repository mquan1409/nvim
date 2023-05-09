vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<leader>ap", "\"+p")
vim.keymap.set("v", "<leader>ay", "\"+y")
vim.keymap.set("n", "<Space>h", "<C-w>h")
vim.keymap.set("n", "<Space>l", "<C-w>l")
vim.keymap.set("i", "ll", "<Right>")
vim.keymap.set("i", "hh", "<Left>")
vim.keymap.set("i", "(", "()<Left>")
vim.keymap.set("i", "[", "[]<Left>")
vim.keymap.set("i", "{", "{}<Left>")
vim.keymap.set("i", "\'", "\'\'<Left>")
vim.keymap.set("i", "\"", "\"\"<Left>")
vim.keymap.set("n", "<C-d>", "<C-d>zz_")
vim.keymap.set("n", "<C-u>", "<C-u>zz_")
