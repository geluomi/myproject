(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("melpa" . "http://melpa.org/packages/"))
)
(package-initialize)

(defun install-if-missing (pkgs)
  (when pkgs
    (unless (package-installed-p (car pkgs) nil)
      (package-install (car pkgs)))
    (install-if-missing (cdr pkgs))))

(unless package-archive-contents
   (package-refresh-contents))

(install-if-missing
  '( yasnippet auto-complete racket-mode
   ))
;;;;;;;;;;;;;;;;;;;;

;; Scheme的配置-王垠 

;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/elpa")
(setq scheme-program-name "/usr/bin/racket")         ;; 如果用 Petite 就改成 "petite"


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
;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-snow)
;;暂时不用背景主题扩展
(menu-bar-mode 0)
(autoload 'scheme-smart-complete "scheme-complete-0.8.11" nil t)
(eval-after-load 'scheme
  '(define-key scheme-mode-map "\t" 'scheme-smart-complete))
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
;;;;;;;;;;;;;;;;;;
;;;;;helm的配置;;;
;;;;;;;;;;;;;;;;;;
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)
;(load-theme 'zenburn t)
;;用第三方的颜色主题会合很多插件的颜色高亮显示冲突

(setq geiser-active-implementations '(racket))
(add-hook 'geiser-mode-hook
(lambda ()
(paredit-mode 1)
(define-key geiser-mode-map (kbd "<f5>") 'geiser-eval-last-sexp)
(define-key geiser-mode-map (kbd "<f6>") 'geiser-eval-region)
)
)

