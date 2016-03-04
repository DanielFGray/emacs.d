(req-package evil
  :require (helm-config)
  :ensure evil
  :init
  (progn
    (setq evil-default-cursor t)
    (evil-mode 1)
    (setq evil-motion-state-modes
      (append evil-emacs-state-modes evil-motion-state-modes))
   )
  :config
  (progn
    (bind-key "[escape]" 'keyboard-escape-quit evil-normal-state-map)
    (bind-key "[escape]" 'keyboard-escape-quit evil-visual-state-map)
    (bind-key "<escape>" 'keyboard-escape-quit)
   ))

(req-package surround
  :require evil
  :init (global-surround-mode 1))

(use-package evil-leader ; why doesn't this work with req-package??
  ;; :require evil
  :ensure evil-leader
  :init (global-evil-leader-mode t)
  :config
  (progn
    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
     "b" 'helm-mini
     "f" 'helm-find-files
     ";" 'helm-M-x
     "/" 'helm-do-grep-ag)))

(req-package evil-snipe
  :require evil
  :ensure evil-snipe
  :init (evil-snipe-override-mode 1)
  :config
  (progn
    (setq evil-snipe-scope 'whole-buffer
          evil-snipe-repeat-scope 'whole-buffer
          evil-snipe-override-evil-repeat-keys t)))

(req-package evil-commentary
  :require evil
  :ensure evil-commentary
  :init (evil-commentary-mode 1))

(req-package undo-tree
  :diminish ""
  :init
  (progn
    (setq undo-tree-auto-save-history t)
    (global-undo-tree-mode)))
