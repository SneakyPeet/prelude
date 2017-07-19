(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ag indium csv-mode markdown-mode dockerfile-mode clj-refactor parinfer all-the-icons nyan-mode yaml-mode clojure-mode vkill exec-path-from-shell zop-to-char zenburn-theme which-key volatile-highlights undo-tree smartrep smartparens smart-mode-line operate-on-number move-text magit projectile ov imenu-anywhere guru-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region epl editorconfig easy-kill diminish diff-hl discover-my-major dash crux browse-kill-ring beacon anzu ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(prelude-require-packages '(nyan-mode neotree all-the-icons parinfer clj-refactor indium ag))

(toggle-frame-maximized)
(scroll-bar-mode -1)
(nyan-mode)

;; pretty symbols

(global-prettify-symbols-mode 1)
(setq prettify-symbols-unprettify-at-point 'right-edge)

(defvar sneakypeet/clojure-prettify-alist '())

;; (add-hook 'clojure-mode-hook
;;           (lambda ()
;;             (push '("fn" . 995) prettify-symbols-alist)))

;; key bindings

(global-set-key (kbd "s-;") 'avy-goto-char)
(global-set-key (kbd "C-'") 'avy-goto-char-2)
(global-set-key (kbd "M-g f") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
(global-set-key (kbd "M-p") 'ace-window)


;; JS2-mode
(setq js2-basic-offset 2)
(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))

(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)
(js2-mode-hide-warnings-and-errors)

;;NeoTree
(setq neo-theme (if (display-graphic-p) 'icons 'nerd))
(setq neo-smart-open t)
(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (projectile-project-root))
        (file-name (buffer-file-name)))
    (neotree-toggle)
    (if project-dir
        (if (neo-global--window-exists-p)
            (progn
              (neotree-dir project-dir)
              (neotree-find file-name)))
      (message "Could not find git project root."))))
(global-set-key [f8] 'neotree-project-dir)

;;parinfer
(global-set-key (kbd "C-`") 'parinfer-toggle-mode)
(setq parinfer-extensions '(defaults pretty-parens smart-yank smart-tab))
(add-hook 'clojure-mode-hook #'parinfer-mode)
(add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
(add-hook 'common-lisp-mode-hook #'parinfer-mode)
(add-hook 'scheme-mode-hook #'parinfer-mode)
(add-hook 'lisp-mode-hook #'parinfer-mode)

;;clj-refactor
(defun sneaky-clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import statements
    ;; This choice of keybinding leaves cider-macroexpand-1 unbound
    (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook #'sneaky-clojure-mode-hook)

;;figwheel
(setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")


;;indium
(add-hook 'js-mode-hook #'indium-interaction-mode)

;; ag

(setq ag-highlight-search t)
