;;显示行列号
(global-linum-mode t)

(setq backup-directory-alist '(("." . "~/.emacs_backups")));;设置备份文件的路径
(setq backup-by-copying t);;备份设置方法，直接拷贝

;;允许emacs和外部其他程序的粘贴
(setq x-select-enable-clipboard t)

;;默认使用utf-8编码
(prefer-coding-system 'utf-8)
