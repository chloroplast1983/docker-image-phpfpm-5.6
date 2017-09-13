# docker-image-phpfpm-5.6

---

### 版本 

#### 1.2

* 添加默认时区
* 开启opcode
* 修改上传文件最大为5M
* 修改内存上限从128MB改为512MB

#### 1.3

* 修改内存上限为默认值为`256`, 因为不需要跑在`cli`下默认放小
* 修改`pm.max_children`,估算方式为:`pm.max_children = (MAX_MEMORY - 500MB) / 20MB` = 5000(按照5G计算)/20(估算约20MB) = 250, 最后定下来为`100`.
* 修改`pm.start_servers`,php-fpm启动起始进程数为`40`
* 修改`pm.min_spare_servers`,php-fpm的最小空闲进程数为`20`
* 修改`pm.max_spare_servers`,php-fpm的最大空闲进程数为`60`
* 添加错误日志配置文件:
	* `display_errors = off`,不显示错误信息(不输出到页面或屏幕上)
	* `error_reporting = E_ALL`,输出所有错误
	* `log_errors = on`,记录错误信息(保存到日志文件中,但是我们这里是输出到标准错误输出上)