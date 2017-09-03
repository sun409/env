(require 'package) ;; You might already have this line
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize) ;; You might already have this line

;;==============================================================================
;;==============================================================================
;;==============================================================================

(show-paren-mode)

(global-set-key [f5] 'hl-line-mode)

(global-set-key [(meta g)] 'goto-line)
(global-set-key [home]     'smart-beginning-of-line)
(global-set-key [select]   'end-of-line)

(global-set-key (kbd "M-<SPC>") 'set-mark-command)

(global-set-key (kbd "C-z")   'nil)
(global-set-key (kbd "C-SPC") 'nil)


;; always end a file with a newline
(setq require-final-newline 'query)

(fset 'yes-or-no-p 'y-or-n-p)

;;==============================================================================
;;==============================================================================
;;==============================================================================

;; buffer control
(require 'bs)
(global-set-key (kbd "C-x C-b") 'bs-show)
(setq bs--show-all t)

;; Uniquify each buffer by adding directory prefix
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-min-dir-content 2)

;;==============================================================================
;;==============================================================================
;;==============================================================================

(require 'sr-speedbar)
(global-set-key (kbd "<C-f3>") 'sr-speedbar-toggle)

;;==============================================================================
;;==============================================================================
;;==============================================================================

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

;;==============================================================================
;;==============================================================================
;;==============================================================================

;; delete trailing whitespaces before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;==============================================================================
;;==============================================================================
;;==============================================================================

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

;;==============================================================================
;;==============================================================================
;;==============================================================================

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

;; auto detect indent by space or tab, 4 or 8
(require 'dtrt-indent)
(dtrt-indent-mode 1)

(defun toggle-tab-between-8-4()
    (interactive)
    (setq tab-width (if (= tab-width 8) 4 8))
    (redraw-display))

(global-set-key [f8] 'toggle-tab-between-8-4)

(global-set-key [f9] 'helm-gtags-dwim)
(global-set-key (kbd "<C-f9>") 'helm-gtags-pop-stack)
(global-set-key (kbd "M-<up>")  'helm-gtags-previous-history)
(global-set-key (kbd "M-<down>")  'helm-gtags-next-history)

;;==============================================================================
;;==============================================================================
;;==============================================================================

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

;; default to unified diffs
(setq diff-switches "-u")

;;==============================================================================
;;==============================================================================
;;==============================================================================

;; start a shell
(eshell)
(rename-buffer "1shell")

;;==============================================================================
;;==============================================================================
;;==============================================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (sr-speedbar google-c-style icicles dtrt-indent async-await popup-complete helm-gtags))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
