# **Go开发相关工具配置**

### **Go SDK配置**

#### 

#### **Go SDK版本**

​                ● Go 1.18.x [Vulnerabilities](https://security.snyk.io/package/linux/ubuntu:20.04/golang-1.18) 存在24个漏洞

​                ● Go 1.19.x [Vulnerabilities](https://security.snyk.io/package/linux/ubuntu:22.10/golang-1.19) 存在9个漏洞

​                ● Go 1.20.x [Vulnerabilities](https://security.snyk.io/package/linux/ubuntu:23.04/golang-1.20) 存在3个漏洞

建议尽快统一切换到最新 [**Go 1.21.0**](https://go.dev/dl/)



#### **Go SDK环境变量**



```
go env -w GOINSECURE='git.ouryun.cn,192.168.20.12'
go env -w GONOPROXY='git.ouryun.cn,192.168.20.12'
go env -w GONOSUMDB='git.ouryun.cn,192.168.20.12'
go env -w GOPRIVATE='git.ouryun.cn,192.168.20.12'
go env -w GOPROXY='https://goproxy.cn|https://goproxy.io|direct'
```





并且在GoLand中进行如下相同的配置

![img](https://wdcdn.qpic.cn/MTY4ODg1NzIwOTUxNjQxNw_217263_8Nt3tAH-A05FW8dz_1690795095?w=1138&h=456&type=image/png)



### **goimports -> gci**

自动格式化代码并重新整理组织导入包, 包路径按照 std,3rd,1st 规则进行分组排序, 示例如下:

![img](https://wdcdn.qpic.cn/MTY4ODg1NzIwOTUxNjQxNw_671159_AYtI2jh_yuvNfj_U_1692071531?w=494&h=475&type=image/png)



##### **安装gci**



```
go install github.com/daixiang0/gci@latest
```





##### **在GoLand/VSCode等开发环境中配置保存文件时自动格式化**

增加如下参数，将导入自研包排序到最末尾



```
# Program
gci

# Arguments
write -s standard -s default -s "prefix(git.ouryun.cn)" $FilePath$
```





![img](https://wdcdn.qpic.cn/MTY4ODg1NzIwOTUxNjQxNw_91340_vNxPPHJQLG_Gimn0_1691745631?w=1212&h=699&type=image/png)

亦可在命令行直接执行命令格式化指定文件



```
gci write -s standard -s default -s 'prefix(git.ouryun.cn)' xxx.go
```







### **golangci-lint**

##### **安装golangci-lint**



```
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```





##### **在开发工具中配置**

![img](https://wdcdn.qpic.cn/MTY4ODg1NzIwOTUxNjQxNw_423362_YIhlh0lfY3ADAk6O_1690788047?w=746&h=532&type=image/png)

亦可在命令行执行命令对当前项目代码进行静态检查



```
golangci-lint run --enable-all
```







### **单元测试UT**

#### **GoLand中自动生成测试模板**

打开待测源文件,选中期望测试的函数/方法(或者在空白处)点击右键菜单选择Generate

![img](https://wdcdn.qpic.cn/MTY4ODg1NzIwOTUxNjQxNw_507705_rK2-HIyQjUSCULt3_1692154191?w=732&h=525&type=image/png)

为选择的函数/方法/整个文件/整个包生成单元测试模板

![img](https://wdcdn.qpic.cn/MTY4ODg1NzIwOTUxNjQxNw_552520_BGkzHC1juUZGkBGF_1692154311?w=636&h=380&type=image/png)

在生成的单元测试模板中的TODO处添加对应的测试用例

![img](https://wdcdn.qpic.cn/MTY4ODg1NzIwOTUxNjQxNw_895795_tw0JCTlrkoZZGWk4_1692154408?w=253&h=30&type=image/png)

填入待测试的用例内容后即可点击运行进行单元测试

![img](https://wdcdn.qpic.cn/MTY4ODg1NzIwOTUxNjQxNw_32348_XoOfFf_uoQZQphWh_1692154518?w=755&h=757&type=image/png)

执行命令单独运行指定的测试



```
go test -run ^TestIPv4Uint32ToString$
```





#### 

#### **基准测试**

在_test.go测试文件中点击右键,选择Generate后再选择Benchmark或Table Benchmark

![img](https://wdcdn.qpic.cn/MTY4ODg1NzIwOTUxNjQxNw_957933_pIwVlA75yA38TjTh_1692154942?w=340&h=358&type=image/png)

补齐待测函数/方法名称与调用的内容后即可点击运行进行基准测试

![img](https://wdcdn.qpic.cn/MTY4ODg1NzIwOTUxNjQxNw_712432_sbd1viyT6dIxkAcc_1692154982?w=512&h=126&type=image/png)

执行命令单独运行指定的测试



```
go test -run ^$ -bench ^BenchmarkIPv4Uint32ToString$ .
```