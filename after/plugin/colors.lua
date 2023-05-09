function ColorBackground(input_color)
    if input_color == nil then
        vim.api.nvim_command('augroup CursorLineInsertMode')
        vim.api.nvim_command('autocmd!')
        vim.api.nvim_command('autocmd InsertEnter * highlight CursorLine guibg=#31363C') vim.api.nvim_command('autocmd InsertLeave * highlight CursorLine guibg=none') vim.api.nvim_command('augroup END')
        vim.api.nvim_command('autocmd InsertLeave * highlight CursorLine guibg=none')
    end
    if input_color == 'dawn' then
        vim.api.nvim_command('augroup CursorLineInsertMode')
        vim.api.nvim_command('autocmd!')
        vim.api.nvim_command('autocmd InsertEnter * highlight CursorLine guibg=#AAE5DD')
        vim.api.nvim_command('autocmd InsertLeave * highlight CursorLine guibg=none')
        vim.api.nvim_command('augroup END')
    end
    require('rose-pine').setup({
        --- @usage 'auto'|'main'|'moon'|'dawn'
        variant = input_color or 'auto',
        --- @usage 'main'|'moon'|'dawn'
        dark_variant = input_color or 'main',
        bold_vert_split = false,
        dim_nc_background = false,
        disable_background = false,
        disable_float_background = false,
        disable_italics = false,

        --- @usage string hex value or named color from rosepinetheme.com/palette
        groups = {
            background = 'base',
            panel = 'surface',
            border = 'highlight_med',
            comment = 'muted',
            link = 'iris',
            punctuation = 'subtle',

            error = 'love',
            hint = 'iris',
            info = 'foam',
            warn = 'gold',

            headings = {
                h1 = 'iris',
                h2 = 'foam',
                h3 = 'rose',
                h4 = 'gold',
                h5 = 'pine',
                h6 = 'foam',
            }
            -- or set all headings at once
            -- headings = 'subtle'
        },

        -- Change specific vim highlight groups
        -- https://github.com/rose-pine/neovim/wiki/Recipes
        highlight_groups = {
            ColorColumn = { bg = 'rose' },

            -- Blend colours against the "base" background
            CursorLine = { bg = 'foam', blend = 10 },
            StatusLine = { fg = 'love', bg = 'love', blend = 10 },
        }
    })

    -- set colorscheme after options
    vim.cmd('colorscheme rose-pine')
end

if tonumber(os.date("%H", timestamp)) > 6 and tonumber(os.date("%H", timestamp)) < 21 then
    ColorBackground('dawn')
else
    ColorBackground()
end
