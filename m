Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA48359E7F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhDIMVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:21:04 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:49334 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhDIMVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:21:02 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4FGy001dChz1qtQF;
        Fri,  9 Apr 2021 14:20:48 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4FGy000Rvxz1qqwp;
        Fri,  9 Apr 2021 14:20:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 3xAlLEhjTm45; Fri,  9 Apr 2021 14:20:46 +0200 (CEST)
X-Auth-Info: oxxYY0cPQTVwwLJEyDhi89sOk4LP78poTozY3fuYeBs=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri,  9 Apr 2021 14:20:46 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 2/2] ARM: dts: imx28: Add DTS description of imx28 based XEA board
Date:   Fri,  9 Apr 2021 14:20:36 +0200
Message-Id: <20210409122036.31628-1-lukma@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DTS definition of the imx278 based XEA board.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v2:
- Fix 'memory' node and remove regulators subnode
- Rename 'flash0: s25fl256s0@0' to flash@0
- Add proper compatible for XEA board
---
 arch/arm/boot/dts/Makefile       |   3 +-
 arch/arm/boot/dts/imx28-lwe.dtsi | 174 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx28-xea.dts  |  99 ++++++++++++++++++
 3 files changed, 275 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx28-lwe.dtsi
 create mode 100644 arch/arm/boot/dts/imx28-xea.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8e5d4ab4e75e..d2398a090e4d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -721,7 +721,8 @@ dtb-$(CONFIG_ARCH_MXS) += \
 	imx28-m28evk.dtb \
 	imx28-sps1.dtb \
 	imx28-ts4600.dtb \
-	imx28-tx28.dtb
+	imx28-tx28.dtb \
+	imx28-xea.dtb
 dtb-$(CONFIG_ARCH_NOMADIK) += \
 	ste-nomadik-s8815.dtb \
 	ste-nomadik-nhk15.dtb
diff --git a/arch/arm/boot/dts/imx28-lwe.dtsi b/arch/arm/boot/dts/imx28-lwe.dtsi
new file mode 100644
index 000000000000..2d14a8ae91f8
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-lwe.dtsi
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2021
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+/dts-v1/;
+#include "imx28.dtsi"
+
+/ {
+	aliases {
+		spi2 = &ssp3;
+	};
+
+	chosen {
+		bootargs = "root=/dev/mmcblk0p2 rootfstype=ext4 ro rootwait console=ttyAMA0,115200 panic=1";
+	};
+
+	memory@0x40000000 {
+		reg = <0x40000000 0x08000000>;
+	};
+
+	reg_3v3: regulator-reg-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_usb_5v: regulator-reg-usb-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+	};
+
+	reg_fec_3v3: regulator-reg-fec-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "fec-phy";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+};
+
+&duart {
+	pinctrl-names = "default";
+	pinctrl-0 = <&duart_pins_a>;
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+};
+
+&saif0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&saif0_pins_a>;
+	#sound-dai-cells = <0>;
+	assigned-clocks = <&clks 53>;
+	assigned-clock-rates = <12000000>;
+	status = "okay";
+};
+
+&saif1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&saif1_pins_a>;
+	fsl,saif-master = <&saif0>;
+	#sound-dai-cells = <0>;
+	status = "okay";
+};
+
+&spi3_pins_a {
+	fsl,pinmux-ids = <
+		MX28_PAD_AUART2_RX__SSP3_D4
+		MX28_PAD_AUART2_TX__SSP3_D5
+		MX28_PAD_SSP3_SCK__SSP3_SCK
+		MX28_PAD_SSP3_MOSI__SSP3_CMD
+		MX28_PAD_SSP3_MISO__SSP3_D0
+		MX28_PAD_SSP3_SS0__SSP3_D3
+		MX28_PAD_AUART2_TX__GPIO_3_9
+	>;
+};
+
+&ssp3 {
+	compatible = "fsl,imx28-spi";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi3_pins_a>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <40000000>;
+		reg = <0>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "u-boot";
+				reg = <0 0x80000>;
+				read-only;
+			};
+
+			partition@80000 {
+				label = "env0";
+				reg = <0x80000 0x10000>;
+			};
+
+			partition@90000 {
+				label = "env1";
+				reg = <0x90000 0x10000>;
+			};
+
+			partition@100000 {
+				label = "kernel";
+				reg = <0x100000 0x400000>;
+			};
+
+			partition@500000 {
+				label = "swupdate";
+				reg = <0x500000 0x800000>;
+			};
+		};
+	};
+};
+
+&ssp2 {
+	compatible = "fsl,imx28-spi";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins_a>;
+	status = "okay";
+};
+
+&ssp0 {
+	compatible = "fsl,imx28-mmc";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_8bit_pins_a>;
+	bus-width = <8>;
+	vmmc-supply = <&reg_3v3>;
+	non-removable;
+	status = "okay";
+};
+
+&usb0 {
+	vbus-supply = <&reg_usb_5v>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins_b>, <&usb0_id_pins_a>;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy0 {
+	status = "okay";
+};
+
+&usb1 {
+	vbus-supply = <&reg_usb_5v>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb1_pins_b>;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx28-xea.dts b/arch/arm/boot/dts/imx28-xea.dts
new file mode 100644
index 000000000000..a400c108f66a
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-xea.dts
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2021
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+/dts-v1/;
+#include "imx28-lwe.dtsi"
+
+/ {
+	compatible = "lwn,imx28-xea", "fsl,imx28";
+};
+
+&can0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&can1_pins_a>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_b>;
+	status = "okay";
+};
+
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hog_pins_a &hog_pins_tiva>;
+
+	hog_pins_a: hog@0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			MX28_PAD_GPMI_D00__GPIO_0_0
+			MX28_PAD_GPMI_D02__GPIO_0_2
+			MX28_PAD_GPMI_D05__GPIO_0_5
+			MX28_PAD_GPMI_CE1N__GPIO_0_17
+			MX28_PAD_GPMI_RDY0__GPIO_0_20
+			MX28_PAD_GPMI_RDY1__GPIO_0_21
+			MX28_PAD_GPMI_RDY2__GPIO_0_22
+			MX28_PAD_GPMI_RDN__GPIO_0_24
+			MX28_PAD_GPMI_CLE__GPIO_0_27
+			MX28_PAD_LCD_VSYNC__GPIO_1_28
+			MX28_PAD_SSP1_SCK__GPIO_2_12
+			MX28_PAD_SSP1_CMD__GPIO_2_13
+			MX28_PAD_SSP2_SS1__GPIO_2_20
+			MX28_PAD_SSP2_SS2__GPIO_2_21
+			MX28_PAD_LCD_D00__GPIO_1_0
+			MX28_PAD_LCD_D01__GPIO_1_1
+			MX28_PAD_LCD_D02__GPIO_1_2
+			MX28_PAD_LCD_D03__GPIO_1_3
+			MX28_PAD_LCD_D04__GPIO_1_4
+			MX28_PAD_LCD_D05__GPIO_1_5
+			MX28_PAD_LCD_D06__GPIO_1_6
+		>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+	};
+
+	hog_pins_tiva: hog@1 {
+		reg = <1>;
+		fsl,pinmux-ids = <
+			MX28_PAD_GPMI_RDY3__GPIO_0_23
+			MX28_PAD_GPMI_WRN__GPIO_0_25
+		>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+	};
+
+	hog_pins_coding: hog@2 {
+		reg = <2>;
+		fsl,pinmux-ids = <
+			MX28_PAD_GPMI_D01__GPIO_0_1
+			MX28_PAD_GPMI_D03__GPIO_0_3
+			MX28_PAD_GPMI_D04__GPIO_0_4
+			MX28_PAD_GPMI_D06__GPIO_0_6
+			MX28_PAD_GPMI_D07__GPIO_0_7
+		>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+	};
+};
+
+&reg_fec_3v3 {
+	gpio = <&gpio0 0 0>;
+};
+
+&reg_usb_5v {
+	gpio = <&gpio0 2 0>;
+};
+
+&spi2_pins_a {
+	fsl,pinmux-ids = <
+		MX28_PAD_SSP2_SCK__SSP2_SCK
+		MX28_PAD_SSP2_MOSI__SSP2_CMD
+		MX28_PAD_SSP2_MISO__SSP2_D0
+		MX28_PAD_SSP2_SS0__GPIO_2_19
+	>;
+};
-- 
2.20.1

