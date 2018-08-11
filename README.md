# zsh-shell-autocomplete
A Simple ZSH Plugin, AutoComplete File Path, like Vim Plugin `ctrlp`



#### 基本说明

* 类似vim直接在编辑器中快速查找文件打开文件，如`ctrlp`
* 因vscode编辑器自带终端，能够快速切换打开shell，遂根据需求，基于`incr-0.2`完成此插件。无需在vscode侧边栏滚来滚去查找\打开文件。



#### 支持范围

* Linux && MacOS
* VSCode



#### 功能演示

![](./screen.gif)



#### 使用说明

1. 命令行使用`code`快速开启vscode:

   ```
   $ vi ~/.zshrc
   
   > # vscode使用命令行打开
   > export PATH=/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin:$PATH
   
   # 保存退出
   $ source ~/.zshrc
   
   # 命令行使用code打开当前目录
   $ code .
   ```

2. 拷贝zsh插件`autoc.zsh`

   ```
   # 建议拷贝至oh-my-zsh个人插件目录:~/.oh-my-zsh/custom/plugins
   $ mkdir autoc
   $ cp your/path/autoc.zsh autoc/autoc.zsh
   
   # 添加插件source
   $ vi ~/.zshrc
   > source ~/.oh-my-zsh/custom/plugins/autoc/autoc*.zsh
   
   # 配置生效
   $ souce ~/.zshrc
   ```

   

####  参考

* [incr-0.2](http://mimosa-pudica.net/zsh-incremental.html)



#### TODO

- 可以支持sublime & webstorm快速打开