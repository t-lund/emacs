(require 'whitespace)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(load-library "hideshow")
(global-set-key (kbd "C-l") nil)
(global-set-key (kbd "C-l l") 'goto-line)
(global-set-key (kbd "C-l w") 'whitespace-mode)
(global-set-key (kbd "C-l +") 'hs-show-block)
(global-set-key (kbd "C-l -") 'hs-hide-block)
(global-set-key (kbd "C-l s") 'hs-show-all)
(global-set-key (kbd "C-l h") 'hs-hide-all)

(add-hook 'python-mode-hook 'hs-minor-mode)
(add-hook 'python-mode-hook 'flycheck-mode)

(defun cpp-highlight-if-0/1 ()
  "Modify the face of text in between #if 0 ... #endif."
  (interactive)
  (setq cpp-known-face '(foreground-color . "red"))
  (setq cpp-unknown-face 'default)
  (setq cpp-face-type 'dark)
  (setq cpp-known-writable 't)
  (setq cpp-unknown-writable 't)
  (setq cpp-edit-list
        '((#("1" 0 1
             (fontified nil))
           nil
           (foreground-color . "red")
           both nil)
          (#("0" 0 1
             (fontified nil))
           (foreground-color . "red")
           nil
           both nil)))
  (cpp-highlight-buffer t))

(defun jpk/c-mode-hook ()
  (cpp-highlight-if-0/1)
  (add-hook 'after-save-hook 'cpp-highlight-if-0/1 'append 'local)
  )

(add-hook 'c-mode-common-hook 'jpk/c-mode-hook)
