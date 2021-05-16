Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AB5382001
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 18:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhEPQg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 12:36:57 -0400
Received: from mail-m17638.qiye.163.com ([59.111.176.38]:38108 "EHLO
        mail-m17638.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhEPQgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 12:36:55 -0400
Received: from localhost.localdomain (unknown [58.199.17.113])
        by mail-m17638.qiye.163.com (Hmail) with ESMTPA id CEBBE1C0459;
        Mon, 17 May 2021 00:35:35 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     maxime@cerno.tech
Cc:     amadeus@jmu.edu.cn, devicetree@vger.kernel.org,
        jernej.skrabec@siol.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        lkft-triage@lists.linaro.org, naresh.kamboju@linaro.org,
        regressions@lists.linux.dev, robh+dt@kernel.org, wens@csie.org
Subject: [PATCH v2 1/2] arm64: dts: allwinner: h5: Add NanoPi R1S H5 support
Date:   Mon, 17 May 2021 00:35:22 +0800
Message-Id: <20210516163523.9484-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210516163523.9484-1-amadeus@jmu.edu.cn>
References: <20210511081823.mmcrliomwtetcirx@gilmour>
 <20210516163523.9484-1-amadeus@jmu.edu.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQxodTFYaGkoZS0IZQ00ZTh1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MiI6Sjo5CD8INzYhGAs2Awwq
        EEIKC0xVSlVKTUlKSkNJQkhNT0pLVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
        VUpCQlVKTFVKSkhZV1kIAVlBTEpOTjcG
X-HM-Tid: 0a7976087429d993kuwscebbe1c0459
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NanoPi R1S H5 is a open source board made by FriendlyElec.
It has the following features:

- Allwinner H5, Quad-core Cortex-A53
- 512MB DDR3 RAM
- 10/100/1000M Ethernet x 2
- RTL8189ETV WiFi 802.11b/g/n
- USB 2.0 host port (A)
- MicroSD Slot
- Serial Debug Port
- 5V 2A DC power-supply

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts | 195 ++++++++++++++++++
 2 files changed, 196 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 41ce680e5f8d..a96d9d2d8dd8 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -25,6 +25,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-libretech-all-h3-it.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-libretech-all-h5-cc.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo-plus2.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-r1s-h5.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
new file mode 100644
index 000000000000..55bcdf8d1a07
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2021 Chukun Pan <amadeus@jmu.edu.cn>
+ *
+ * Based on sun50i-h5-nanopi-neo-plus2.dts, which is:
+ *   Copyright (C) 2017 Antony Antony <antony@phenome.org>
+ *   Copyright (C) 2016 ARM Ltd.
+ */
+
+/dts-v1/;
+#include "sun50i-h5.dtsi"
+#include "sun50i-h5-cpu-opp.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "FriendlyARM NanoPi R1S H5";
+	compatible = "friendlyarm,nanopi-r1s-h5", "allwinner,sun50i-h5";
+
+	aliases {
+		ethernet0 = &emac;
+		ethernet1 = &rtl8189etv;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			function = LED_FUNCTION_LAN;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&pio 0 9 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-1 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-2 {
+			function = LED_FUNCTION_WAN;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&pio 6 11 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	r-gpio-keys {
+		compatible = "gpio-keys";
+
+		reset {
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_vcc3v3: vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_usb0_vbus: usb0-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb0-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL2 */
+		status = "okay";
+	};
+
+	vdd_cpux: gpio-regulator {
+		compatible = "regulator-gpio";
+		regulator-name = "vdd-cpux";
+		regulator-type = "voltage";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-ramp-delay = <50>; /* 4ms */
+		gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0x1>;
+		states = <1100000 0x0>, <1300000 0x1>;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_cpux>;
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_rgmii_pins>;
+	phy-supply = <&reg_gmac_3v3>;
+	phy-handle = <&ext_rgmii_phy>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&external_mdio {
+	ext_rgmii_phy: ethernet-phy@7 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <7>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	eeprom@51 {
+		compatible = "microchip,24c02";
+		reg = <0x51>;
+		pagesize = <16>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	status = "okay";
+};
+
+&mmc1 {
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	rtl8189etv: sdio_wifi@1 {
+		reg = <1>;
+	};
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pa_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	/* USB Type-A port's VBUS is always on */
+	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
+	usb0_vbus-supply = <&reg_usb0_vbus>;
+	status = "okay";
+};
-- 
2.17.1

