#!/bin/bash
# ===============================================
# desuVPN - Futuristic Dark Mode VPN Installer
# โดเมน: domudesu.duckdns.org
# สีดำสนิท + ม่วงนีออน | เมนูภาษาไทย
# ===============================================

clear
echo -e "\033[38;5;165m"
echo "   ██████╗ ███████╗███████╗██╗   ██╗██╗   ██╗██████╗ ███╗   ██╗"
echo "   ██╔══██╗██╔════╝██╔════╝██║   ██║██║   ██║██╔══██╗████╗  ██║"
echo "   ██║  ██║█████╗  ███████╗██║   ██║██║   ██║██║  ██║██╔██╗ ██║"
echo "   ██║  ██║██╔══╝  ╚════██║╚██╗ ██╔╝██║   ██║██║  ██║██║╚██╗██║"
echo "   ██████╔╝███████╗███████║ ╚████╔╝ ╚██████╔╝██████╔╝██║ ╚████║"
echo "   ╚═════╝ ╚══════╝╚══════╝  ╚═══╝   ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝"
echo "                  desuVPN - Futuristic Dark Mode"
echo -e "\033[0m"
echo -e "\033[38;5;165m                  กำลังติดตั้งระบบใหม่...\033[0m\n"

if [[ $EUID -ne 0 ]]; then
   echo -e "\033[31mกรุณารันด้วย root (sudo bash install.sh)\033[0m"
   exit 1
fi

apt-get update -y && apt-get install -y curl wget git unzip jq uuid-runtime socat

DOMAIN="domudesu.duckdns.org"

echo -e "\033[38;5;165mกำลังติดตั้ง 3x-ui...\033[0m"
bash <(curl -Ls https://raw.githubusercontent.com/MHSanaei/3x-ui/master/install.sh) > /dev/null 2>&1

cat << 'EOF' > /usr/local/bin/desuvpn
#!/bin/bash
clear
DOMAIN="domudesu.duckdns.org"

while true; do
    echo -e "\033[0;40m\033[38;5;165m"
    echo "   ██████╗ ███████╗███████╗██╗   ██╗██╗   ██╗██████╗ ███╗   ██╗"
    echo "   ██╔══██╗██╔════╝██╔════╝██║   ██║██║   ██║██╔══██╗████╗  ██║"
    echo "   ██║  ██║█████╗  ███████╗██║   ██║██║   ██║██║  ██║██╔██╗ ██║"
    echo "   ██║  ██║██╔══╝  ╚════██║╚██╗ ██╔╝██║   ██║██║  ██║██║╚██╗██║"
    echo "   ██████╔╝███████╗███████║ ╚████╔╝ ╚██████╔╝██████╔╝██║ ╚████║"
    echo "   ╚═════╝ ╚══════╝╚══════╝  ╚═══╝   ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝"
    echo -e "\033[38;5;165m                  desuVPN - Futuristic Dark Mode"
    echo -e "\033[38;5;51m               โดเมนหลัก: $DOMAIN\033[0m"
    echo ""
    echo -e "\033[38;5;165m══════════════════════════════════════════════════════════════\033[0m"
    echo -e "\033[38;5;165m  1.\033[0m เปิด 3x-ui Panel"
    echo -e "\033[38;5;165m 21.\033[0m ตั้งค่า DuckDNS + SSL อัตโนมัติ ($DOMAIN)"
    echo -e "\033[38;5;165m 19.\033[0m สร้าง Inbound Trojan"
    echo -e "\033[38;5;165m 20.\033[0m สร้าง Inbound VMess"
    echo -e "\033[38;5;165m  3.\033[0m สร้าง VLESS Reality"
    echo -e "\033[38;5;165m  7.\033[0m รีสตาร์ท 3x-ui"
    echo -e "\033[38;5;165m 16.\033[0m อัพเดท desuVPN"
    echo -e "\033[38;5;165m  0.\033[0m ออก"
    echo -e "\033[38;5;165m══════════════════════════════════════════════════════════════\033[0m"
    echo -e "\033[38;5;165mเลือกหมายเลข : \033[0m"
    read -r choice

    case $choice in
        1|3) x-ui ;;
        7) systemctl restart x-ui ;;
        21)
            echo -e "\033[38;5;165m=== ตั้งค่า DuckDNS + SSL สำหรับ $DOMAIN ===\033[0m"
            echo -e "1. ไปที่ https://www.duckdns.org"
            echo -e "   ล็อกอิน → อัพเดท IP เป็น IP ของ VPS นี้"
            read -p "อัพเดท IP แล้วหรือยัง? (y/n): " confirmed
            if [[ "$confirmed" == "y" ]]; then
                echo -e "\033[38;5;165mกำลังขอ SSL...\033[0m"
                curl https://get.acme.sh | sh -s email=your-email@gmail.com > /dev/null 2>&1
                ~/.acme.sh/acme.sh --issue -d $DOMAIN --standalone --force
                echo -e "\033[38;5;51m✅ ขอ SSL สำเร็จแล้ว!\033[0m"
                echo -e "Certificate และ Key อยู่ใน ~/.acme.sh/$DOMAIN"
                echo -e "ไปตั้งค่าใน 3x-ui → Panel Settings"
            else
                echo -e "\033[33mกรุณาอัพเดท IP ที่ DuckDNS ก่อน แล้วลองใหม่\033[0m"
            fi
            ;;
        19|20|3)
            echo -e "\033[38;5;165mเปิด 3x-ui เพื่อสร้าง Inbound...\033[0m"
            x-ui
            echo -e "\033[38;5;51mหลังสร้างเสร็จ แนะนำใส่ SNI / Host = $DOMAIN\033[0m"
            ;;
        16)
            echo -e "\033[38;5;165mกำลังอัพเดท desuVPN เวอร์ชันล่าสุด...\033[0m"
            curl -sSL https://raw.githubusercontent.com/SHINIGAMI2002/desuVPN/main/install.sh | bash
            ;;
        0) 
            echo -e "\033[38;5;165mขอบคุณที่ใช้ desuVPN ❤️ ออกจากระบบ...\033[0m"
            exit 0 
            ;;
        *) echo -e "\033[31mเลือกไม่ถูกต้อง!\033[0m" ;;
    esac
    echo -e "\n\033[38;5;165mกด Enter เพื่อกลับเมนู...\033[0m"
    read -r
done
EOF

chmod +x /usr/local/bin/desuvpn
echo 'alias desuvpn="/usr/local/bin/desuvpn"' >> /root/.bashrc

echo -e "\033[38;5;165m"
echo "══════════════════════════════════════════════════════════════"
echo "✅ desuVPN ติดตั้งสำเร็จเรียบร้อย!"
echo "🔥 พิมพ์คำสั่ง: desuvpn เพื่อเปิดเมนู Futuristic Dark Mode"
echo "🌐 3x-ui Panel: http://$(curl -s ifconfig.me):54321"
echo "   Username: admin | Password: admin (เปลี่ยนทันที)"
echo "══════════════════════════════════════════════════════════════"
echo -e "\033[0m"
EOF

chmod +x /root/install.sh

echo -e "\033[38;5;165mไฟล์ install.sh พร้อมใช้งานแล้วครับ\033[0m"
