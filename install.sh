#!/bin/bash
# ===============================================
# desuVPN - Futuristic Overlay for givps
# โดเมน: domudesu.duckdns.org
# เมนูสวยทับบน givps (ไม่ติดตั้ง 3x-ui ซ้ำ)
# ===============================================

clear
echo -e "\033[38;5;165m"
echo "   ███████╗███████╗███████╗██╗   ██╗██╗   ██╗██████╗ ███╗   ██╗"
echo "   ██╔════╝██╔════╝██╔════╝██║   ██║██║   ██║██╔══██╗████╗  ██║"
echo "   ███████╗█████╗  ███████╗██║   ██║██║   ██║██║  ██║██╔██╗ ██║"
echo "   ╚════██║██╔══╝  ╚════██║╚██╗ ██╔╝██║   ██║██║  ██║██║╚██╗██║"
echo "   ███████║███████╗███████║ ╚████╔╝ ╚██████╔╝██████╔╝██║ ╚████║"
echo "   ╚══════╝╚══════╝╚══════╝  ╚═══╝   ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝"
echo -e "\033[38;5;201m                  desuVPN  •  FUTURISTIC OVERLAY\033[0m"
echo -e "\033[38;5;93m               สำหรับ givps + domudesu.duckdns.org\033[0m"
echo ""
echo -e "\033[38;5;165m                  กำลังติดตั้งเมนูสวย...\033[0m\n"

if [[ $EUID -ne 0 ]]; then
   echo -e "\033[31mกรุณารันด้วย root\033[0m"
   exit 1
fi

DOMAIN="domudesu.duckdns.org"

# ตรวจสอบ givps + 3x-ui
echo -e "\033[38;5;165mตรวจสอบ givps และ 3x-ui...\033[0m"
if ! command -v x-ui &> /dev/null && ! command -v xui &> /dev/null; then
    echo -e "\033[33m⚠️  ไม่พบ 3x-ui (givps) กรุณาตรวจสอบว่าติดตั้ง givps สำเร็จหรือไม่\033[0m"
fi

cat << 'EOF' > /usr/local/bin/desuvpn
#!/bin/bash
clear
DOMAIN="domudesu.duckdns.org"

while true; do
    echo -e "\033[0;40m\033[38;5;165m"
    echo "   ███████╗███████╗███████╗██╗   ██╗██╗   ██╗██████╗ ███╗   ██╗"
    echo "   ██╔════╝██╔════╝██╔════╝██║   ██║██║   ██║██╔══██╗████╗  ██║"
    echo "   ███████╗█████╗  ███████╗██║   ██║██║   ██║██║  ██║██╔██╗ ██║"
    echo "   ╚════██║██╔══╝  ╚════██║╚██╗ ██╔╝██║   ██║██║  ██║██║╚██╗██║"
    echo "   ███████║███████╗███████║ ╚████╔╝ ╚██████╔╝██████╔╝██║ ╚████║"
    echo "   ╚══════╝╚══════╝╚══════╝  ╚═══╝   ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝"
    echo -e "\033[38;5;201m                  desuVPN  •  FUTURISTIC OVERLAY\033[0m"
    echo -e "\033[38;5;93m               givps + $DOMAIN\033[0m"
    echo ""
    echo -e "\033[38;5;165m══════════════════════════════════════════════════════════════\033[0m"
    echo -e "\033[38;5;165m  [1]  เปิด 3x-ui Panel (จาก givps)"
    echo -e "\033[38;5;165m [21]  ตั้งค่า DuckDNS + SSL ($DOMAIN)"
    echo -e "\033[38;5;165m [19]  สร้าง Inbound Trojan"
    echo -e "\033[38;5;165m [20]  สร้าง Inbound VMess"
    echo -e "\033[38;5;165m  [3]  สร้าง VLESS Reality"
    echo -e "\033[38;5;165m  [7]  รีสตาร์ท 3x-ui"
    echo -e "\033[38;5;165m [16]  อัพเดท desuVPN"
    echo -e "\033[38;5;165m  [0]  ออก"
    echo -e "\033[38;5;165m══════════════════════════════════════════════════════════════\033[0m"
    echo -e "\033[38;5;201mเลือกหมายเลข → \033[0m"
    read -r choice

    case $choice in
        1|3) 
            if command -v x-ui &> /dev/null; then x-ui; else echo -e "\033[31mไม่พบคำสั่ง x-ui\033[0m"; fi ;;
        7) systemctl restart x-ui 2>/dev/null || echo -e "\033[33mรีสตาร์ทไม่สำเร็จ\033[0m" ;;
        21)
            echo -e "\033[38;5;165m=== DuckDNS + SSL สำหรับ $DOMAIN ===\033[0m"
            echo "ไปที่ https://www.duckdns.org → อัพเดท IP VPS"
            read -p "อัพเดทแล้ว? (y/n): " ok
            if [[ "$ok" == "y" ]]; then
                curl https://get.acme.sh | sh -s email=your-email@gmail.com > /dev/null 2>&1
                ~/.acme.sh/acme.sh --issue -d $DOMAIN --standalone --force
                echo -e "\033[38;5;51mSSL สำเร็จ → ไปตั้งใน 3x-ui Panel Settings\033[0m"
            fi
            ;;
        19|20|3)
            echo -e "\033[38;5;165mเปิด 3x-ui เพื่อสร้าง Inbound...\033[0m"
            x-ui 2>/dev/null || echo -e "\033[31mไม่พบ x-ui\033[0m"
            echo -e "\033[38;5;51mแนะนำใส่ SNI = $DOMAIN\033[0m"
            ;;
        16)
            echo -e "\033[38;5;165mอัพเดท desuVPN...\033[0m"
            curl -sSL https://raw.githubusercontent.com/SHINIGAMI2002/desuVPN/main/install.sh | bash
            ;;
        0) echo -e "\033[38;5;201mขอบคุณที่ใช้ desuVPN ❤️\033[0m"; exit 0 ;;
        *) echo -e "\033[31mเลือกไม่ถูกต้อง!\033[0m" ;;
    esac
    echo -e "\nกด Enter เพื่อกลับเมนู..."
    read -r
done
EOF

chmod +x /usr/local/bin/desuvpn
echo 'alias desuvpn="/usr/local/bin/desuvpn"' >> /root/.bashrc

echo -e "\033[38;5;165m"
echo "══════════════════════════════════════════════════════════════"
echo "✅ desuVPN Overlay สำเร็จ (เสริม givps)"
echo "🔥 พิมพ์: desuvpn เพื่อเปิดเมนู Futuristic"
echo "══════════════════════════════════════════════════════════════"
echo -e "\033[0m"
