(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(global-font-lock-mode t nil (font-core))
 '(js2-mirror-mode nil)
 '(menu-bar-mode t)
 '(py-python-command "/opt/local/bin/python2.4")
 '(python-python-command "/opt/local/bin/python2.4")
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
'(global-font-lock-mode t nil (font-lock))

;(set-default-font "-apple-monaco-medium-r-normal--10-90-72-72-m-90-mac-roman")
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "White" :foreground "Black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "apple" :family "Monaco")))))

;(setq ns-antialias-text nil)

(setq mac-command-modifier 'control)

;(setq indent-tabs-mode nil)
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)
(setq make-backup-files nil)
;(setq global-font-lock-mode t)

(setq-default ispell-program-name "/opt/local/bin/aspell")

(add-to-list 'load-path "/Users/philipp/lib/emacs")
(autoload 'python-mode "python-mode" "Python editing mode." t)
(autoload 'js2-mode "js2" nil t)
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
;;(load "doctest-mode.el")
;;(load "nxml-mode/rng-auto.el")

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-to-list 'auto-mode-alist '("\\.pyx$" . python-mode))
(add-to-list 'auto-mode-alist '("\\.pxi$" . python-mode))

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsm$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))

(add-to-list 'auto-mode-alist '("\\.pt$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.zpt$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.cpt$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.kupu$" . html-mode))

(add-to-list 'auto-mode-alist '("\\.xml$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xul$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xsl$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.rng$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xhtml$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.zcml$" . nxml-mode))

;(add-to-list 'auto-mode-alist '("\\.pt$" . nxml-mode))
;(add-to-list 'auto-mode-alist '("\\.zpt$" . nxml-mode))
;(add-to-list 'auto-mode-alist '("\\.cpt$" . nxml-mode))

(add-to-list 'auto-mode-alist '("\\.egg$" . archive-mode))
(add-to-list 'auto-mode-alist '("\\.plot$" . gnuplot-mode))

;; load python-mode
;(require 'python-mode)

(pc-selection-mode)

;(add-hook 'nxml-mode-hook (lambda() (setq indent-tabs-mode nil)))

;;(load-file "~/physik/iktp/mathematica.el")
;;(setq mathematica-never-start-kernel-with-mode t)
;;(add-to-list 'auto-mode-alist '("\\.mod$" . mathematica-mode))
;;(add-to-list 'auto-mode-alist '("\\.gen$" . mathematica-mode))


; Chris McDonough made me do this:
(when (load "flymake" t) 
  (defun flymake-pyflakes-init () 
    (let* ((temp-file (flymake-init-create-temp-buffer-copy 
                       'flymake-create-temp-inplace)) 
           (local-file (file-relative-name 
                        temp-file 
                        (file-name-directory buffer-file-name)))) 
      (list "pyflakes" (list local-file)))) 

  (add-to-list 'flymake-allowed-file-name-masks 
               '("\\.py\\'" flymake-pyflakes-init))) 

;(add-hook 'find-file-hook 'flymake-find-file-hook)

;; -*- emacs-lisp -*-
;; Author: Rohan Nicholls
;; License: Gnu Public License
;;
;; Additional functionality that makes flymake error messages appear
;; in the minibuffer when point is on a line containing a flymake
;; error. This saves having to mouse over the error, which is a
;; keyboard user's annoyance


;;flymake-ler(file line type text &optional full-file)
(defun show-fly-err-at-point ()
  "If the cursor is sitting on a flymake error, display the message in the minibuffer"
  (interactive)
  (let ((line-no (line-number-at-pos)))
    (dolist (elem flymake-err-info)
      (if (eq (car elem) line-no)
          (let ((err (car (second elem))))
            (message "%s" (fly-pyflake-determine-message err)))))))

(defun fly-pyflake-determine-message (err)
  "pyflake is flakey if it has compile problems, this adjusts the message to display, so there is one ;)"
  (cond ((not (or (eq major-mode 'Python) (eq major-mode 'python-mode) t)))
        ((null (flymake-ler-file err))
         ;; normal message do your thing
         (flymake-ler-text err))
        (t ;; could not compile err
         (format "compile error, problem on line %s" (flymake-ler-line err)))))

(defadvice flymake-goto-next-error (after display-message activate compile)
"Display the error in the mini-buffer rather than having to mouse over it"
(show-fly-err-at-point))

(defadvice flymake-goto-prev-error (after display-message activate compile)
"Display the error in the mini-buffer rather than having to mouse over it"
(show-fly-err-at-point))

(defadvice flymake-mode (before post-command-stuff activate compile)
"Add functionality to the post command hook so that if the
cursor is sitting on a flymake error the error information is
displayed in the minibuffer (rather than having to mouse over
it)"
(set (make-local-variable 'post-command-hook)
(cons 'show-fly-err-at-point post-command-hook))) 



;; ======================================================================
;; Mac stuff
;; ======================================================================
;;(prefer-coding-system 'latin-1-unix)
;;(setq mac-keyboard-text-encoding kTextEncodingISOLatin1)
;;(set-language-environment 'German)
;;(set-buffer-file-coding-system 'utf-8-unix)
;;(set-clipboard-coding-system 'mac-roman-mac)
;;(set-keyboard-coding-system 'iso-latin-1)


(defun toggle-fullscreen()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(global-set-key [(meta return)] `toggle-fullscreen)


;; meta on messed up terminals
;;(global-set-key "\C-x\C-m" 'execute-extended-command)
;;(global-set-key "\C-c\C-m" 'execute-extended-command)
