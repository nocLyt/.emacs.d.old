;; Package 设置.  M-x list-package 更新
(require 'package)
(package-initialize)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; 装载插件 ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(package-initialize)

(elpy-enable)
; (语法提示设置)默认是rope,改成jedi更好用了. 
(setq elpy-rpc-backend "jedi") 

; ; 配置 YASnippet
; (require 'yasnippet)
; (yas-global-mode 1)

; ; 配置 Auto-complete
(require 'auto-complete-config)
(ac-config-default)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; 主题设置 ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 设置启动主题 凑合着用了. 好像是自带的，没用到 color-theme
(add-to-list 'load-path "C:\\Users\\tianyi.lyt\\AppData\\Roaming\\.emacs.d\\elpa\\color-theme-6.6.0")
(require 'color-theme)
(color-theme-initialize)



; 一个简单的黄底的主题
(color-theme-aalto-light)

;; 设置高亮
; (require 'highlight-indentation)
; (set-face-background 'highlight-indentation-face "#e3e3d3")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; 字体设置 ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; from http://zhuoqiang.me/torture-emacs.html#id1
;; 中英文采用不同的字体
;; 通过编码来设置字体，有编码(kana han symbol cjk-misc bopomofo)

;; 低端的方法

;; Setting English Font
(set-face-attribute 'default nil :font "Consolas 14")
;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset (font-spec :family "Microsoft Yahei"
                                       :size 16)))

;; 高端的方法--函数声明

;; 判断字体是否存在
(defun qiang-font-existsp (font)
  (if (null (x-list-fonts font))
      nil
    t))

;; 产生带上字体大小信息的字体描述文本
(defun qiang-make-font-string (font-name font-size)
  (if (and (stringp font-size)
           (equal ":" (string (elt font-size 0))))
      (format "%s%s" font-name font-size)
    (format "%s %s" font-name font-size)))

;; 自动设置字体函数
(defun qiang-set-font (english-fonts
                       english-font-size
                       chinese-fonts
                       &optional chinese-font-size)

  "english-font-size could be set to \":pixelsize=18\" or a integer.
If set/leave chinese-font-size to nil, it will follow english-font-size"
  (require 'cl) ; for find if
  (let ((en-font (qiang-make-font-string
                  (find-if #'qiang-font-existsp english-fonts)
                  english-font-size))
        (zh-font (font-spec :family (find-if #'qiang-font-existsp chinese-fonts)
                            :size chinese-font-size)))

    ;; Set the default English font
    ;;
    ;; The following 2 method cannot make the font settig work in new frames.
    ;; (set-default-font "Consolas:pixelsize=18")
    ;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=18"))
    ;; We have to use set-face-attribute
    (message "Set English Font to %s" en-font)
    (set-face-attribute 'default nil :font en-font)

    ;; Set Chinese font
    ;; Do not use 'unicode charset, it will cause the English font setting invalid
    (message "Set Chinese Font to %s" zh-font)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset zh-font))))

;; 高端的方法--设置字体
(qiang-set-font
 '("Consolas" "Monaco" "DejaVu Sans Mono" "Monospace" "Courier New") ":pixelsize=18"
 '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; 界面设置 ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 隐藏启动画面
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)


;; 设置utf-8编码。 应该设置：在非Windows下，设置utf-8编码
; (prefer-coding-system 'utf-8)
; (setq coding-system-for-read 'utf-8)
; (setq coding-system-for-write 'utf-8)

;; 鼠标滚轮控制字体大小
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)


;; 设置行号
(global-linum-mode 1)

;; 以 y/n 代表 yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; 在标题栏提示你目前在什么位置 ??
(setq frame-title-format "noclyt@%b")

;; 显示列号
(setq column-number-mode t)
(setq line-number-mode t)

;; 每行的列宽，有用吗？。。
(setq default-fill-column 80)

;; 显示括号匹配
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;; 去掉工具栏
(tool-bar-mode -1)
;; 光标接近鼠标时，自动移动鼠标
; (mouse-avoidance-mode 'animate)

;; 支持中键粘贴
(setq mouse-yank-at-point t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; 键位绑定 ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; FXX 功能键
;; F1 打开帮助
(global-set-key [f1] 'info)
;; F2 撤销
(global-set-key [f2] 'undo)
;; F3 反撤销  ???
(global-set-key [f3] 'redo)
;; F4 关闭当前Buffer
(global-set-key [f4] 'kill-this-buffer)
;; F5 打开一个终端. 可以绑定: eshell, shell, terminal-emulator
(global-set-key [f5] 'shell)


;; 多窗口切换-> C-o
(global-set-key [(control o)] 'other-window)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; 功能函数 ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 注释功能增强
;; 以前光标在某一行中时 alt-; 没法注释/反注释一行
;; 现在可以了。
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and
we are not at the end of the line, then comment current line.
Replaces default behaviour of comment-dwim,
when it inserts comment at the end of the line. "

  (interactive "*P")
  (comment-normalize-vars)

  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-set-key "\M-;" 'qiang-comment-dwim-line)



;; 无选中时, M-w复制当前整行; M-k从光标复制到行尾的
;; !!! 注意 M-w 不能用 !!
;; Smart copy, if no region active, it simply copy the current whole line
;; from http://zhuoqiang.me/torture-emacs.html
;; PS : 可以根据需求添加删除配置的 mode
;; Smart copy, if no region active, it simply copy the current whole line
(defadvice kill-line (before check-position activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode python-mode
                                c-mode c++-mode objc-mode js-mode
                                latex-mode plain-tex-mode))
      (if (and (eolp) (not (bolp)))
          (progn (forward-char 1)
                 (just-one-space 0)
                 (backward-char 1)))))

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end))
                 (message "Copied line")
                 (list (line-beginning-position)
                       (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;; Copy line from point to the end, exclude the line break
(defun qiang-copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (point)
                  (line-end-position))
  ;; (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(global-set-key (kbd "M-k") 'qiang-copy-line)


;; 拷贝代码自动格式化
;; 你可以加入或删除一些 mode 名称来定制上面的配置。
(dolist (command '(yank yank-pop))
  (eval
   `(defadvice, command (after indent-region activate)
      (and (not current-prefix-arg)
           (member major-mode
                   '(emacs-lisp-mode lisp-mode clojure-mode scheme-mode
                                     haskell-mode ruby-mode rspec-mode
                                     python-mode c-mode c++-mode objc-mode
                                     latex-mode js-mode plain-tex-mode))
           (let ((mark-even-if-inactive transient-mark-mode))
             (indent-region (region-beginning) (region-end) nil))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(python-indent-guess-indent-offset t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
