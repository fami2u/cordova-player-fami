##README
### 下载说明
* 下载插件源代码

* 下载fami-plugin-lists用于集成插件 git clone git@github.com:fami2u/fami-plugin-lists.git

* 以上两个目录平级

* cd fami-plugin-lists

* 查看当前安装的插件 cordova plugin list

* 删除插件 cordova plugin remove com.fami2u.plugin.

* 安装插件 cordova-plugin- 使用命令 cordova plugin add ../

* 重新编译插件 cordova build android||ios

### 调用说明
> IOS部分

此插件目前只能实现视频的播放，例：启动页视频。在需要的地方调用video.play(params)方法。

- 参数说明：

	
		var params = {
		                                                                                                 	type:"local",
		                                                  	strUrl: "IMG_0377.MOV"
	                                                  
	          };
	       
type:要播放视频是本地（local）还是网络视频(network)。

strUrl:如果是网络视频的话传网址，如果是本地视频的话请先将视频文件拖		到项目中，此处填写视频全名。

#####更多插件请点击：[fami2u](https://github.com/fami2u)
#####关于我们：[FAMI](http://fami2u.com)