(setq visible-bell t)
; start package.el with emacs
(require 'package)
(require 'json)
; add MELPA to repository list
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
; initialize package.el
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))
;(package-refresh-contents)
(defvar myPackages
  '(better-defaults
    ido
    ein
    python-mode
    jedi
    elpy
    material-theme
    auto-complete
    flycheck
    yasnippet))

(mapc #'(lambda(package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)


;python-mode
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")
(setq py-python-command-args
      '("--gui=wx" "--pylab=wx" "-colors" "Linux"))
(setq python-shell-completion-native-enable nil)
(setq python-shell-prompt-detect-enabled nil)
(setq python-shell-prompt-detect-failure-warning nil)
;(setq py-force-py-shell-name-p t)
;(setq py-shell-switch-buffer-on-execute-p t)
;(setq py-split-windows-on-execute-p nil)
;(setq py-smart-indentation t)

;ido
(ido-mode t)

;colortheme package
;(require 'color-theme)
;(add-to-list 'custom-theme-load-path "~/Documents/emacs/")
;(color-theme-initialize)
;(load-theme 'blackboard t)


;Hide the startup message
(setq inhibit-startup-message t)
;Theme
(load-theme 'material t)
;Enable line number globally
(global-linum-mode t)
;Enable elpy for python
(elpy-enable)
(elpy-use-ipython)
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
(define-key global-map (kbd "C-c o") 'iedit-mode)
;Configure Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))



;start auto-complete with emacs
;(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)
(global-auto-composition-mode)
; start yasnippet with emacs
;(require 'yasnippiet)
(yas-global-mode 1)
; let's define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
(defun my:ac-c-header-init ()
(require 'auto-complete-c-headers)
(add-to-list 'ac-sources 'ac-source-c-headers)
(add-to-list 'achead:include-directories '"/usr/lib/gcc/i686-linux-gnu/4.6/include")
)
; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

; Fix iedit bug in Mac
(define-key global-map (kbd "C-c ;") 'iedit-mode)


; start google-c-style with emacs
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

; turn on Semantic
(semantic-mode 1)
; let's define a function which adds semantic as a suggestion backend to auto complete
; and hook this function to c-mode-common-hook
(defun my:add-semantic-to-autocomplete()
(add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
; turn on ede mode
(global-ede-mode 1)
; turn on automatic reparsing of open buffers in semantic
(global-semantic-idle-scheduler-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (elpy ein python-mode jedi color-theme yasnippet google-c-style flymake-google-cpplint auto-complete-c-headers)))
 '(python-shell-interpreter-interactive-arg ""))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
