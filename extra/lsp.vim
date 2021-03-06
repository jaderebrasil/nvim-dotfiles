set completeopt=menu,menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD :lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>K :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>hh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true


"inoremap <silent><expr> <C-Space> compe#complete()
"inoremap <silent><expr> <C-e>     compe#close('<C-e>')
"inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
"inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

highlight link CompeDocumentation NormalFloat

lua <<EOF
  -- Setup nvim-cmp.
	local cmp = require'cmp'
    local lspconfig = require'lspconfig'

	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
				-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
				-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},
		mapping = {
			['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
			['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
			['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
			['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
			['<C-e>'] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		},
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'vsnip' }, -- For vsnip users.
			-- { name = 'luasnip' }, -- For luasnip users.
			-- { name = 'ultisnips' }, -- For ultisnips users.
			-- { name = 'snippy' }, -- For snippy users.
		}, {
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

	-- Setup lspconfig.
	local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
	-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
	lspconfig['tsserver'].setup {
		capabilities = capabilities
	}

	lspconfig['pyright'].setup {
		capabilities = capabilities
	}

	lspconfig['texlab'].setup {
		capabilities = capabilities
	}

    -- hook to nvim-lspconfig
    require("grammar-guard").init()

--    local ltex_settings = function (lang) -- pt-BR or en
--        return {
--            enabled = { "latex", "tex", "bib", "markdown" },
--            language = lang,
--            diagnosticSeverity = "information",
--            checkFrequency="save",
--            setenceCacheSize = 5000,
--            additionalRules = {
--                enablePickyRules = true,
--                motherTongue = lang,
--            },
--            trace = { server = "verbose" },
--            dictionary = {},
--            disabledRules = {},
--            hiddenFalsePositives = {},
--        }
--    end
--
--    function GrammarGuardLanguage(lang)
--        -- setup LSP config
--        lspconfig['grammar_guard'].setup({
--            capabilities = capabilities,
--            cmd = { '/opt/ltex-ls-bin/bin/ltex-ls' },
--            settings = {
--                ltex = ltex_settings(lang),
--            }
--        })
--
--        vim.lsp.
--    end

    -- LSP Fuzzy
    -- map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    -- map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    -- map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
    -- map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    -- map('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
    -- map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
    -- map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
    -- map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
EOF
