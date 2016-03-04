(req-package helm-config
  :diminish (helm-mode . "")
  :ensure helm
  :init
  (progn
    (setq helm-ff-auto-update-initial-value)

    (setq helm-M-x-fuzzy-match t
          helm-apropos-fuzzy-match t
          helm-file-cache-fuzzy-match t
          helm-imenu-fuzzy-match t
          helm-lisp-fuzzy-completion t
          helm-recentf-fuzzy-match t
          helm-semantic-fuzzy-match t
          helm-buffers-fuzzy-matching t)

    (bind-key* "M-x" 'helm-M-x)
    (bind-key* "C-x C-f" 'helm-find-files))
  :config
  (progn
    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
    (define-key helm-map (kbd "C-z")  'helm-select-action)
    (helm-mode 1) ))
