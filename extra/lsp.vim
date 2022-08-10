set completeopt=menu,menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

highlight link CompeDocumentation NormalFloat

lua <<EOF
    -- Mappings
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    local opts = { noremap=true, silent=true }
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap=true, silent=true, buffer=bufnr }

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)

        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>hh', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<leader>f ', vim.lsp.buf.formatting, bufopts)
    end

    local lsp_flags = {
      -- This is the default in Nvim 0.7+
      debounce_text_changes = 150,
    }

    -- Add additional capabilities supported by nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  	local cmp = require'cmp'
    local lspconfig = require'lspconfig'

    -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
    local servers = { 'pylsp', 'texlab', 'pyright', 'tsserver' }
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
      }
    end

  	cmp.setup({
  		snippet = {
  			-- REQUIRED - you must specify a snippet engine
  			expand = function(args)
  				-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
  				require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
  				-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
  				-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  			end,
  		},
  		mapping = cmp.mapping.preset.insert({
  			['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  			['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  			['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  			['<C-y>'] = cmp.config.disable,
            ['<C-e>'] = cmp.mapping({
  				i = cmp.mapping.abort(),
  				c = cmp.mapping.close(),
  			}),
  			['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                else
                  fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
            end, { 'i', 's' }),
        }),
  		sources = cmp.config.sources({
  			{ name = 'nvim_lsp' },
  			-- { name = 'vsnip' }, -- For vsnip users.
  			{ name = 'luasnip' }, -- For luasnip users.
  			-- { name = 'ultisnips' }, -- For ultisnips users.
  			-- { name = 'snippy' }, -- For snippy users.
  		},
        {
  		    { name = 'buffer' },
  		})
  	})

  	-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  	cmp.setup.cmdline('/', {
  		sources = {
  			{ name = 'buffer' }
  		}
  	})

  	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  	cmp.setup.cmdline(':', {
  		sources = cmp.config.sources({
  			{ name = 'path' }
  		}, {
  			{ name = 'cmdline' }
  		})
  	})

    -- hook to nvim-lspconfig
    require("grammar-guard").init()
EOF
