;;; packages.el --- copy-and-paste layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: stackerzzq <foo_stacker@yeah.net>
;; URL: https://github.com/stackerzzq/spacemacs.d
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `copy-and-paste-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `copy-and-paste/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `copy-and-paste/pre-init-PACKAGE' and/or
;;   `copy-and-paste/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst copy-and-paste-packages
  '(copy-to-clipboard
    paste-from-clipboard)
  "The list of Lisp packages required by the copy-and-paste layer.")

(defun copy-and-paste/init-copy-to-clipboard ()
  "Copies selection to x-clipboard."
  (use-package copy-to-clipboard
    ;; :bind ("M-m o c" 'copy-to-clipboard)
    :init
    (if (display-graphic-p)
        (progn
          (message "Yanked region to x-clipboard!")
          (call-interactively 'clipboard-kill-ring-save)
          )
      (if (region-active-p)
          (progn
            (shell-command-on-region (region-beginning) (region-end) "pbcopy")
            (message "Yanked region to clipboard!")
            (deactivate-mark))
        (message "No region active; can't yank to clipboard!")))
    )
  )

(defun copy-and-paste/init-paste-from-clipboard ()
  "Pastes from x-clipboard."
  (use-package paste-from-clipboard
    ;; :bind ("M-m o c" 'paste-from-clipboard)
    :init
    (if (display-graphic-p)
        (progn
          (clipboard-yank)
          (message "graphics active")
          )
      (insert (shell-command-to-string "pbpaste"))
      )
    )
  )

;; (defun copy-to-clipboard ()
;;   "Copies selection to x-clipboard."
;;   (interactive)
;;   (if (display-graphic-p)
;;       (progn
;;         (message "Yanked region to x-clipboard!")
;;         (call-interactively 'clipboard-kill-ring-save)
;;         )
;;     (if (region-active-p)
;;         (progn
;;           (shell-command-on-region (region-beginning) (region-end) "pbcopy")
;;           (message "Yanked region to clipboard!")
;;           (deactivate-mark))
;;       (message "No region active; can't yank to clipboard!")))
;;   )

;; (defun paste-from-clipboard ()
;;   "Pastes from x-clipboard."
;;   (interactive)
;;   (if (display-graphic-p)
;;       (progn
;;         (clipboard-yank)
;;         (message "graphics active")
;;         )
;;     (insert (shell-command-to-string "pbpaste"))
;;     )
;;   )
;; (evil-leader/set-key "o c" 'copy-to-clipboard)
;; (evil-leader/set-key "o v" 'paste-from-clipboard)
;; packages.el ends here
