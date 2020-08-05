## 部署步骤
#### 1. 拉取部署仓库
```
git clone git@github.com:jmc6666/easy_qa.git
```
#### 2. 启动服务
```
docker-compose up -d
```

## 说明
#### 1. 端口
- `10008`： WEB页面
- `554`: rtsp

#### 2. 挂载
- `/root/video`: 默认挂载目录

#### 3. 网络
- `host`: 服务为host网络

#### 4. 使用
- 将视频放入默认挂载目录即可

#### 5. 相关链接
- [EasyDarwin](https://github.com/EasyDarwin/EasyDarwin)
