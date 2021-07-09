Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE733C2065
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 10:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhGIIEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 04:04:49 -0400
Received: from regular1.263xmail.com ([211.150.70.206]:50562 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhGIIEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 04:04:47 -0400
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id DA72B1B9B;
        Fri,  9 Jul 2021 16:01:55 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED2: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 1
Received: from localhost.localdomain (unknown [183.57.25.242])
        by smtp.263.net (postfix) whith ESMTP id P12349T139824269707008S1625817711146317_;
        Fri, 09 Jul 2021 16:01:54 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4ae106baf5e6455b5b8cf914d5fd869b>
X-RL-SENDER: djw@t-chip.com.cn
X-SENDER: djw@t-chip.com.cn
X-LOGIN-NAME: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-RCPT-COUNT: 16
X-SENDER-IP: 183.57.25.242
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   djw@t-chip.com.cn
To:     linux-rockchip@lists.infradead.org
Cc:     Wayne Chou <zxf@t-chip.com.cn>, Levin Du <djw@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
        David Bauer <mail@david-bauer.net>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Liang Chen <cl@rock-chips.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tianling Shen <cnsztl@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0 2/2] arm64: dts: rockchip: add support for Firefly ROC-RK3328-PC
Date:   Fri,  9 Jul 2021 16:01:26 +0800
Message-Id: <20210709080126.17045-3-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.23.0.37.g745f6812895b
In-Reply-To: <20210709080126.17045-1-djw@t-chip.com.cn>
References: <20210709080126.17045-1-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>

ROC-RK3328-PC is the board inside the portable Firefly Station M1
Geek PC. As a redesign after the ROC-RK3328-CC, it uses TypeC as
power input and OTG port, embedded with eMMC 5.1 storage and a
SDIO WiFi/BT chip (RTL8723DS).

- Rockchip RK3328 SoC
- 2/4GB LPDDR3 RAM
- 16/32/64/128GB eMMC 5.1
- TF card slot
- USB 3.0 Port x 1, USB 2.0 Port x 1, TypeC Port x 1 (Power/OTG)
- HDMI
- Gigabit Ethernet
- WiFi: RTL8723DS
- Audio: RK3328
- Key: Power, Reset, Recovery
- LED: POWER, USER
- IR

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../arm64/boot/dts/rockchip/rk3328-roc-pc.dts | 110 ++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 7fdb41de01ec..46652b6d7c4d 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock64.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock-pi-e.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-roc-cc.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-evb-act8846.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-geekbox.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-lion-haikou.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts
new file mode 100644
index 000000000000..0e3d04bba75b
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2021 T-Chip Intelligent Technology Co., Ltd
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+
+#include "rk3328-roc-cc.dts"
+
+/ {
+	model = "Firefly ROC-RK3328-PC";
+	compatible = "firefly,roc-rk3328-pc", "rockchip,rk3328";
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1750000>;
+
+		/* This button is unpopulated out of the factory. */
+		button-recovery {
+			label = "Recovery";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <10000>;
+		};
+	};
+
+	ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_LOW>;
+		linux,rc-map-name = "rc-khadas";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ir_int>;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_en>, <&wifi_host_wake>;
+		reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&codec {
+	mute-gpios = <&grf_gpio 0 GPIO_ACTIVE_LOW>;
+};
+
+&gpu {
+	mali-supply = <&vdd_logic>;
+};
+
+&pinctrl {
+	ir {
+		ir_int: ir-int {
+			rockchip,pins = <2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	wifi {
+		wifi_en: wifi-en {
+			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wifi_host_wake: wifi-host-wake {
+			rockchip,pins = <3 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none_4ma>;
+		};
+
+		bt_rst: bt-rst {
+			rockchip,pins = <1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_en: bt-en {
+			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sdmmcio {
+		sdio_per_pin: sdio-per-pin {
+			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+};
+
+&pmic_int_l {
+	rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
+};
+
+&rk805 {
+	interrupt-parent = <&gpio0>;
+	interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&saradc {
+	vref-supply = <&vcc_18>;
+	status = "okay";
+};
+
+&usb20_host_drv {
+	rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
+};
+
+&vcc_host1_5v {
+	gpio = <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
+};
+
+&vcc_sdio {
+	gpios = <&gpio0 RK_PD3 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio_per_pin>;
+};
-- 
2.23.0.37.g745f6812895b



