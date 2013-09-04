;;显示行列号
(global-linum-mode t)

(setq backup-directory-alist '(("." . "~/.emacs_backups")));;设置备份文件的路径
(setq backup-by-copying t);;备份设置方法，直接拷贝

;;允许emacs和外部其他程序的粘贴
(setq x-select-enable-clipboard t)

;;默认使用utf-8编码
(prefer-coding-system 'utf-8)

;;el-get
;(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;(unless (require 'el-get nil 'noerror)
;  (with-current-buffer
;      (url-retrieve-synchronously
;       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;    (let (el-get-master-branch)
;      (goto-char (point-max))
;      (eval-print-last-sexp))))

;(el-get 'sync)
;;el-get end

;;for clang auto-complete
(add-to-list 'load-path "~/.emacs.d/el-get/popup")
  ;;for auto-complete
(add-to-list 'load-path "~/.emacs.d/el-get/auto-complete/")  
(require 'auto-complete)  
(add-to-list 'ac-dictionary-directories "~/.emacs.d/el-get/auto-complete/ac-dict/")  
(add-to-list 'ac-user-dictionary-files "~/.emacs.d/el-get/auto-complete/dict/guotf.dict")  
(require 'auto-complete-config) 
  ;; auto-complete end

  ;; for auto-complete-clang
(add-to-list 'load-path "~/.emacs.d/auto-complete-clang-master")
(require 'auto-complete-clang)  
(setq ac-auto-start nil)  
(setq ac-quick-help-delay 0.5)  
;; (ac-set-trigger-key "TAB")  
;; (define-key ac-mode-map  [(control tab)] 'auto-complete)  
(define-key ac-mode-map  (kbd "M-/") 'auto-complete)  
(defun my-ac-config ()  
  (setq ac-clang-flags  
        (mapcar(lambda (item)(concat "-I" item))  
               (split-string  
                "  
 /usr/llvm-gcc-4.2/bin/../lib/gcc/i686-apple-darwin11/4.2.1/include
 /usr/include/c++/4.2.1
 /usr/include/c++/4.2.1/backward
 /Applications/Xcode.app/Contents/Developer/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin11/4.2.1/include
 /usr/include
 /System/Library/Frameworks
 /Library/Frameworks
")))  
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))  
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)  
  ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)  
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)  
  (add-hook 'css-mode-hook 'ac-css-mode-setup)  
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)  
  (global-auto-complete-mode t))  
(defun my-ac-cc-mode-setup ()  
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))  
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)  
;; ac-source-gtags  
(my-ac-config)  
;(ac-config-default)
  ;; auto-complete-clang end
;;end
