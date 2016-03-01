(req-package evil
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

