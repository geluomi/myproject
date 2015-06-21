(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			  ("marmalade" . "https://marmalade-repo.org/packages/")
			   ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)



;;Setup load-path,autoloads and your lisp system
;;Not needed if you install SLIME via MELPA
(add-to-list 'load-path "/usr/share/common-lisp/source/slime")
(require 'slime-autoloads)
(setq inferior-lisp-program "/usr/bin/sbcl")

;;;;;;;;;;;;;;;;;;;;

;; Scheme的配置-王垠 

;;;;;;;;;;;;;;;;;;;;

;;Enable the paredit-mode
(autoload 'paredit-mode "~/.emacs.d/paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)
;;;Add hooks on scheme-mode and emacs-lisp-mode
(add-hook 'scheme-mode-hook
  (lambda ()
    (paredit-mode 1)))
(add-hook 'emacs-lisp-mode-hook
  (lambda ()
    (paredit-mode 1)))
;;End
;;Show the parenthesis
(show-paren-mode 1)
;;End
;;Configure the line number
(global-linum-mode 0)
;; 彩虹括号高亮的配置;;
(autoload 'rainbow-delimiters-mode "~/.emacs.d/rainbow-delimiters"
  "Minor mode for paren-coloring editing Lisp code."
  t)
;;;Add hooks on scheme-mode and emacs-lisp-mode
(add-hook 'scheme-mode-hook
  (lambda ()
    (rainbow-delimiters-mode 1)))
(add-hook 'emacs-lisp-mode-hook
  (lambda ()
    (rainbow-delimiters-mode 1)))
(add-to-list 'load-path "~/.emacs.d/")
(require 'color-theme)
(color-theme-initialize)
;;(color-theme-charcoal-black)
;;暂时不用背景主题扩展
(menu-bar-mode 0)
(autoload 'scheme-smart-complete "scheme-complete-0.8.11" nil t)
(eval-after-load 'scheme
  '(define-key scheme-mode-map "\t" 'scheme-smart-complete))

(add-to-list 'load-path "~/.emacs.d/elpa")
;;;;;;;;;;;;;;;;;
;;yasnippet配置;;
;;;;;;;;;;;;;;;;;
(require 'yasnippet)
(setq yas/prompt-functions 
   '(yas/dropdown-prompt yas/x-prompt yas/completing-prompt yas/ido-prompt yas/no-prompt))
(yas/global-mode 1)
(yas/minor-mode-on) ; 以minor mode打开，这样才能配合主mode使用


(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/ac-dict")
(ac-config-default)
