#!/bin/bash

# 脚本名称：server_setup.sh

# 进入/tmp目录
cd /tmp

# 创建serveryanzheng目录
mkdir -p serveryanzheng

# 进入serveryanzheng目录
cd serveryanzheng

# 显示当前工作目录
echo "================================"
echo "   HTTP文件服务器设置工具"
echo "================================"
echo ""
echo "当前工作目录: $(pwd)"
echo ""

# 要求用户输入文件名
read -p "请输入文件名: " filename

# 检查文件名是否为空
if [ -z "$filename" ]; then
    echo "错误：文件名不能为空！"
    exit 1
fi

# 提示用户输入文件内容
echo ""
echo "请输入文件内容（输入完成后按Ctrl+D保存）："
echo "----------------------------------------"

# 创建文件并写入内容
cat > "$filename"

# 确认文件创建成功
if [ -f "$filename" ]; then
    echo ""
    echo "----------------------------------------"
    echo "✓ 文件 '$filename' 创建成功！"
    echo "文件路径: /tmp/serveryanzheng/$filename"
    echo ""
    
    # 获取服务器IP地址
    IP=$(hostname -I | awk '{print $1}')
    
    echo "正在启动HTTP服务器..."
    echo "================================"
    echo "服务器信息："
    echo "- 本地访问: http://localhost/$filename"
    echo "- 局域网访问: http://$IP/$filename"
    echo "- 服务目录: /tmp/serveryanzheng"
    echo "================================"
    echo ""
    echo "按 Ctrl+C 停止服务器"
    echo ""
    
    # 在serveryanzheng目录运行HTTP服务器
    sudo python3 -m http.server 80
else
    echo "错误：文件创建失败！"
    exit 1
fi
