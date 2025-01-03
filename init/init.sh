#!/bash/bin

dir=$(dirname "$(realpath "$0")") # /init
p_dir=$(dirname "$dir")

# 配置文件路径
CONFIG_FILE_PATH="$p_dir/.config"

# 检查配置文件是否存在
if [ ! -f "$CONFIG_FILE_PATH" ]; then
    echo "配置文件不存在，请确保 $CONFIG_FILE_PATH 文件无误"
    exit 1
fi

# 读取配置文件
source "$CONFIG_FILE_PATH"

sudo apt update

## 共享文件相关
sudo apt install virtualbox-guest-utils
# 在virtualbox中用于共享文件的传输，如果没有这个工具即使设置了共享文件，也不会生效！！！
# 设置好共享文件后可以选择自动挂载使其生效，也可以手动执行下面的命令：
# sudo mount -t vboxsf share_name /mount_path_in_linux
sudo usermod -aG vboxsf $USERNAME
# 共享文件属于vboxsf组，为便于访问将用户加入到这该组

## 网络相关
sudo apt install isc-dhcp-client isc-dhcp-client-ddns
# 用于进行dhcp刷新，系统开机后有些网卡的ip地址可能不会自动配置，通过下面的命令可以出发dhcp
# sudo dhclient -r enp0s8   # 清除原有的ip地址
# sudo dhclient enp0s8      # 配置新的ip地址

sudo apt install net-tools inetutils-traceroute
# net-tools 带有route命令，可以配置和查看路由信息
# inetutils-traceroute 带有traceroute，可以查看网络请求路径

sudo apt install network-manager
# 提供 nmcli命令用于查看dhcp
