(req-package evil
  :require (helm-config)
  :ensure evil
  :init
  (progn
    (setq evil-default-cursor t)
    (evil-mode 1)
    (setq evil-motion-state-modes
      (append evil-emacs-state-modes evil-motion-state-modes)))
  :config
  (progn
    ;; quit things with escape
    (define-key evil-visual-state-map (kbd "<escape>") 'keyboard-quit)
    (define-key minibuffer-local-map (kbd "<escape>") 'keyboard-escape-quit)
    (define-key minibuffer-local-ns-map (kbd "<escape>") 'keyboard-escape-quit)
    (define-key minibuffer-local-completion-map (kbd "<escape>") 'keyboard-escape-quit)
    (define-key minibuffer-local-must-match-map (kbd "<escape>") 'keyboard-escape-quit)
    (define-key minibuffer-local-isearch-map (kbd "<escape>") 'keyboard-escape-quit)
    (bind-key "[escape]" 'keyboard-escape-quit evil-normal-state-map)
    (bind-key "[escape]" 'keyboard-escape-quit evil-visual-state-map)
    (bind-key "<escape>" 'keyboard-escape-quit)

    ;; Switch gj and j, gk and k
    (define-key evil-normal-state-map "j" 'evil-next-visual-line)
    (define-key evil-normal-state-map "k" 'evil-previous-visual-line)
    (define-key evil-normal-state-map "gj" 'evil-next-line)
    (define-key evil-normal-state-map "gk" 'evil-previous-line)

    ;; this should probably be a separate file?
    ;; unimpaired-style bindings
    (define-key evil-normal-state-map (kbd "[ SPC")
      (lambda()
        (interactive)
        (evil-insert-newline-above)
        (forward-line)))
    (define-key evil-normal-state-map (kbd "] SPC")
      (lambda()
        (interactive)
        (evil-insert-newline-below)
        (forward-line -1)))

    (define-key evil-normal-state-map (kbd "[ p")
      (lambda()
        (interactive)
        (evil-insert-newline-above)
        (evil-paste-after 1)))
    (define-key evil-normal-state-map (kbd "] p")
      (lambda()
        (interactive)
        (evil-insert-newline-below)
        (evil-paste-after 1)))

    ;; vinegar-like dired browser
    (setq dired-listing-switches "-alhgoBF --group-directories-first")
    (progn
     (evil-define-key 'normal dired-mode-map "h" 'dired-up-directory)
     (evil-define-key 'normal dired-mode-map "l" 'dired-find-alternate-file)
     (evil-define-key 'normal dired-mode-map "o" 'dired-sort-toggle-or-edit)
     (evil-define-key 'normal dired-mode-map "v" 'dired-toggle-marks)
     (evil-define-key 'normal dired-mode-map "m" 'dired-mark)
     (evil-define-key 'normal dired-mode-map "u" 'dired-unmark)
     (evil-define-key 'normal dired-mode-map "U" 'dired-unmark-all-marks)
     (evil-define-key 'normal dired-mode-map "c" 'dired-create-directory)
     (evil-define-key 'normal dired-mode-map "n" 'evil-search-next)
     (evil-define-key 'normal dired-mode-map "N" 'evil-search-previous)
     (evil-define-key 'normal dired-mode-map "q" 'kill-this-buffer))
    (define-key evil-normal-state-map (kbd "-") ; open dired with `-`
      (lambda()
        (interactive)
        (dired default-directory)))
    (add-hook 'dired-mode-hook ; go up a directory with `-` in dired buffers
      (lambda()
        (define-key dired-mode-map (kbd "-")
          (lambda()
            (interactive)
            (find-alternate-file "..")))))
    (defadvice dired-advertised-find-file (around dired-subst-directory activate)
      "Replace current buffer if file is a directory."
      (interactive)
      (let ((orig (current-buffer))
            (filename (dired-get-filename)))
        ad-do-it
        (when (and (file-directory-p filename)
                   (not (eq (current-buffer) orig)))
                        (kill-buffer orig))))
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
