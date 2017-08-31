;;==============================================================================
;; Modify ~/tools/share/emacs/24.3/etc/themes/misterioso-theme.el
;; to change background to "color-235"
;;==============================================================================




(add-to-list 'load-path "~/.emacs.d/lisp/")




(show-paren-mode)
(setq show-paren-style 'parenthesis)
(setq show-paren-delay 0)

;; Enable font lock mode
;;  except shell-mode and text-mode
(setq font-lock-maximum-decoration t)
(setq font-lock-global-modes '(not shell-mode text-mode))
(setq font-lock-verbose t)
(setq font-lock-maximum-size '((t . 1048576) (vm-mode . 5250000)))
(setq global-font-lock-mode t)

;; visual appealing
(load-theme 'misterioso t)
(set-background-color "black")
(set-face-background 'show-paren-match-face "Orange")





;; highlight current line globally
(global-hl-line-mode)
(make-variable-buffer-local 'global-hl-line-mode)
(add-hook 'eshell-mode-hook (lambda () (setq global-hl-line-mode nil)))
(global-set-key [f5] 'hl-line-mode)





(global-set-key [(meta g)] 'goto-line)
(global-set-key [home] 'smart-beginning-of-line)
(global-set-key [select] 'end-of-line)
(global-set-key "\C-z" nil)

(global-set-key (kbd "C-SPC") 'nil)
(global-set-key (kbd "M-<SPC>") 'set-mark-command)

(global-set-key "\C-xc" 'compile)





;; always end a file with a newline
(setq require-final-newline 'query)

(fset 'yes-or-no-p 'y-or-n-p)






;; global behaviour related
(menu-bar-mode 0)
;; (tool-bar-mode 0)
(display-time-mode 1)
;; (set-scroll-bar-mode 'right)
;; (set-scroll-bar-mode 'left)

(xterm-mouse-mode 1)

(setq line-number-mode t)
(setq column-number-mode t)

(setq system-time-locale "C")
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-interval 10)

(setq inhibit-startup-message t)
(setq gnus-inhibit-startup-message t)

;; default to unified diffs
(setq diff-switches "-u")

(ido-mode t)

(setq kill-ring-max 200)

(setq default-fill-column 200)

(auto-fill-mode -1)

(setq enable-recursive-minibuffers t)

;; (prefer-coding-system 'utf-8)
;; (setq coding-system-for-read 'utf-8)
;; (setq coding-system-for-write 'utf-8)

;; prevent scroll till 3 lines
(setq scroll-margin 3)
(setq scroll-margin 1)
(setq scroll-conservatively 10000)

(setq default-major-mode 'text-mode)
;; Autofill in all modes
(setq-default auto-fill-function 'do-auto-fill)

(add-hook 'text-mode-hook 'turn-on-auto-fill)

(setq backup-file-directory "~/.emacs.d/backup")
(setq backup-directory-alist
    `((".*" . ,backup-file-directory)))
(setq auto-save-file-name-transforms
    `((".*" ,backup-file-directory t)))
;; Auto delete files older than one week
(let ((week (* 60 60 24 7))
      (current (float-time (current-time))))
  (dolist (file (directory-files backup-file-directory t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (nth 5 (file-attributes file))))
                  week))
      (message "Deleting old backup files: %s" file)
      (delete-file file))))

;; editing convenience
(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.
Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive) ;; Use (interactive "^") in Emacs 23 to make shift-select work
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
	 (beginning-of-line))))

;; let C-k kill the whole line and the line-end char
;; (setq-default kill-whole-line t)

;; Duplicate line
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))
;; (global-set-key (kbd "C-d") 'duplicate-line)

;; delete trailing whitespaces before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)








(add-hook 'comint-output-filter-functions
	  'comint-watch-for-password-prompt)






;; buffer control
(require 'bs)
(global-set-key (kbd "C-x C-b") 'bs-show)
(setq bs--show-all t)

;; Uniquify each buffer by adding directory prefix
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-min-dir-content 2)





;; c-mode
(add-to-list 'auto-mode-alist '("\\.ext\\'" . c-mode))

(add-hook 'c-mode-common-hook
	  '(lambda()
	     (c-set-style "K&R")
	     (setq c-basic-offset 8)))

(require 'google-c-style)

(defun linux-c-mode()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq c-basic-offset 8))

(load "xcscope.el")
(setq cscope-do-not-update-database t)

;; auto detect indent by space or tab, 4 or 8
(require 'dtrt-indent)
(dtrt-indent-mode 1)

(defun toggle-tab-between-8-4()
  (interactive)
  (setq tab-width (if (= tab-width 8) 4 8))
  (redraw-display))

(global-set-key [f8] 'toggle-tab-between-8-4)





(add-to-list 'load-path "~/.emacs.d/icicles/")
(require 'icicles)
(icy-mode 1)





(require 'sr-speedbar)
(global-set-key (kbd "<C-f3>") 'sr-speedbar-toggle)
(add-hook 'speedbar-timer-hook
	  '(lambda ()
	     (save-excursion
	       (set-buffer speedbar-buffer)
	       (speedbar-expand-line))))







;; start a shell
(eshell)
(rename-buffer "1shell")





;;==============================================================================

;; (defun find-in-workspace(term)
;;   (interactive "sSearchInWorkspace: \n")
;;   (grep-find (concat "grep -rnH --include=\*.{c,cpp,h} --include=-e '" term "' /home/workspaces/*")))
(defun find-in-workspace(term)
  (interactive "sSearchInWorkspace: \n")
  (grep-find
   (concat "grep -rnH --include=\*.{c,cpp,h,S,inc} --exclude=cscope.\* --include=-e '"
	   term "' /home/timouyang/work/customer/software/HiSTBAndroidV500R001C00SPC032/device/hisilicon/bigfish/sdk/source/kernel/linux-3.4.y/*")))




;;==============================================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-time-mode t)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 125 :width normal)))))
