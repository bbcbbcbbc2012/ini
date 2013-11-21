;;显示行列号
(global-linum-mode t)

(setq backup-directory-alist '(("." . "~/.emacs_backups")));;设置备份文件的路径
(setq backup-by-copying t);;备份设置方法，直接拷贝

;;允许emacs和外部其他程序的粘贴
(setq x-select-enable-clipboard t)

;;默认使用utf-8编码
(prefer-coding-system 'utf-8)

;;高亮当前行
;;(global-hl-line-mode t)

;;size of file
(size-indication-mode t)

;;tool-bar-mode
;;scroll-bar-mode
(if (display-graphic-p)
    (tool-bar-mode 0)
    ;;(scroll-bar-mode 0)
  )


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


;; for erlang
(setq load-path (cons "/opt/local/lib/erlang/lib/tools-2.6.11/emacs" load-path))
(setq erlang-root-dir "/opt/local/lib/erlang")
(setq exec-path (cons "/opt/local/lib/erlang/bin" exec-path))
(require 'erlang-start)

;;  my c cpp style;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconst my-c-indentation
  '((c-tab-always-indent . t)
    (c-comment-only-line-offset . 0)
    (c-hanging-braces-alist . ((substatement-open after)
			     (brace-list-open)))
    (c-cleanup-list . (comment-close-slash
		       compact-empty-funcall))
    (c-offsets-alist . ((substatement-open . 0)
			(innamespace . 0)
			(case-label . +)
			(access-label . -)
			(inline-open . 0)
			(block-open . 0)))
;;(c-echo-syntactic-information-p t)
  (setq comment-start "/*"
	comment-end "*/")
  (setq indent-tabs-mode nil))
"my c coding style")

(c-add-style "my-c-indentation" my-c-indentation)

;;define own hook
(defun my-c-common-hook-style()
  (c-set-style "my-c-indentation")
  (company-mode)
  (setq indent-tabs-mode nil)
  (setq global-hl-line-mode t)
  (setq tab-width 4)
  (setq c-basic-offset 4))

;(add-hook 'c++-mode-hook 'MyCppHook)
;(add-hook 'c-mode-hook 'MyCppHook)
(add-hook 'c-mode-common-hook 'my-c-common-hook-style)
;;;;;;end;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;cc mode config;;;;;;
(defun my-make-CR-do-indent ()
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))
(add-hook 'c-initialization-hook 'my-make-CR-do-indent)

;;;;cc mode config end;;;;



;; 刷新功能，重新打开当前文件，用于文件在外部被修改了的情况
(global-set-key (kbd "<f5>") 'kid-reopen-file)
(defun kid-reopen-file ()
  "reopen current buffer"
  (interactive)
  (if (null (buffer-file-name (current-buffer)))
      (message "buffer not attached to a file.")
    (let ((file-name (buffer-file-name (current-buffer)))
          (current-point (point)))
      (kill-buffer (current-buffer))
      (find-file file-name)
      (if (<= current-point (point-max))
          (goto-char current-point)))))


;; org-mode 自动换行
(add-hook 'org-mode-hook(lambda() (setq truncate-lines nil)))
