Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE13A44D2F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhKKINr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhKKINq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:13:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9885C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:10:57 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1ml5AV-0007nx-Qf; Thu, 11 Nov 2021 09:10:47 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1ml5AU-002z3q-4t; Thu, 11 Nov 2021 09:10:46 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v1] ARM: at91: add Microchip EVB-KSZ9477 board
Date:   Thu, 11 Nov 2021 09:10:45 +0100
Message-Id: <20211111081045.711323-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add KSZ9477 managed switch evaluation kit with SAMA5D36 MPU:
https://www.microchip.com/en-us/development-tool/evb-ksz9477

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../arm/boot/dts/at91-sama5d3_ksz9477_evb.dts | 209 ++++++++++++++++++
 2 files changed, 210 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e0934180724..ff0557b9dfc7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -59,6 +59,7 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-sama5d2_icp.dtb \
 	at91-sama5d2_ptc_ek.dtb \
 	at91-sama5d2_xplained.dtb \
+	at91-sama5d3_ksz9477_evb.dtb \
 	at91-sama5d3_xplained.dtb \
 	at91-dvk_som60.dtb \
 	at91-gatwick.dtb \
diff --git a/arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dts b/arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dts
new file mode 100644
index 000000000000..443e8b022897
--- /dev/null
+++ b/arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dts
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2021 Oleksij Rempel <kernel@pengutronix.de>, Pengutronix
+ */
+/dts-v1/;
+#include "sama5d36.dtsi"
+
+/ {
+	model = "EVB-KSZ9477";
+	compatible = "microchip,sama5d3-ksz9477-evb", "atmel,sama5d36",
+		     "atmel,sama5d3", "atmel,sama5";
+
+	chosen {
+		stdout-path = &dbgu;
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_vcc_mmc0: regulator-mmc0 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mcc0_vcc>;
+		regulator-name = "mmc0-vcc";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		gpio = <&pioE 2 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&dbgu {
+	status = "okay";
+};
+
+&ebi {
+	pinctrl-0 = <&pinctrl_ebi_nand_addr>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-0 = <&pinctrl_i2c0_pu>;
+	status = "okay";
+};
+
+&macb0 {
+	phy-mode = "rgmii";
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&main_xtal {
+	clock-frequency = <12000000>;
+};
+
+&mmc0 {
+	pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0 &pinctrl_mmc0_dat1_3
+		     &pinctrl_mmc0_dat4_7 &pinctrl_mmc0_cd>;
+	status = "okay";
+
+	slot@0 {
+		reg = <0>;
+		bus-width = <8>;
+		cd-gpios = <&pioE 0 GPIO_ACTIVE_LOW>;
+		disable-wp;
+		vmmc-supply = <&reg_vcc_mmc0>;
+		vqmmc-supply = <&reg_3v3>;
+	};
+};
+
+&nand_controller {
+	status = "okay";
+
+	nand@3 {
+		reg = <0x3 0x0 0x2>;
+		atmel,rb = <0>;
+		nand-bus-width = <8>;
+		nand-ecc-mode = "hw";
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+		nand-on-flash-bbt;
+		label = "atmel_nand";
+	};
+};
+
+&slow_xtal {
+	clock-frequency = <32768>;
+};
+
+&spi0 {
+	cs-gpios = <&pioD 13 GPIO_ACTIVE_LOW>, <0>, <0>,
+		   <&pioD 16 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-0 = <&pinctrl_spi_ksz>;
+	cs-gpios = <&pioC 25 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	switch@0 {
+		compatible = "microchip,ksz9477";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		spi-cpha;
+		spi-cpol;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				label = "lan1";
+			};
+
+			port@1 {
+				reg = <1>;
+				label = "lan2";
+			};
+
+			port@2 {
+				reg = <2>;
+				label = "lan3";
+			};
+
+			port@3 {
+				reg = <3>;
+				label = "lan4";
+			};
+
+			port@4 {
+				reg = <4>;
+				label = "lan5";
+			};
+
+			port@5 {
+				reg = <5>;
+				label = "cpu";
+				ethernet = <&macb0>;
+				phy-mode = "rgmii-txid";
+
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+	};
+};
+
+&usb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usba_vbus>;
+	atmel,vbus-gpio = <&pioE 9 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&pinctrl {
+	board {
+		pinctrl_i2c0_pu: i2c0-pu {
+			atmel,pins =
+				<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
+				<AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
+		};
+
+		pinctrl_mmc0_cd: mmc0-cd {
+			atmel,pins = <AT91_PIOE 0 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_mcc0_vcc: mmc0-vcc {
+			atmel,pins = <AT91_PIOE 2 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_spi_ksz: spi-ksz {
+			atmel,pins =
+				<
+				/* SPI1_MISO */
+				AT91_PIOC 22 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+				/* SPI1_MOSI */
+				AT91_PIOC 23 AT91_PERIPH_A AT91_PINCTRL_NONE
+				/* SPI1_SPCK */
+				AT91_PIOC 24 AT91_PERIPH_A AT91_PINCTRL_NONE
+
+				/* SPI CS */
+				AT91_PIOC 25 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				/* switch IRQ */
+				AT91_PIOB 28 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH
+				/* switch PME_N, SoC IN */
+				AT91_PIOC 30 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP
+				/* switch RST */
+				AT91_PIOC 31 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH
+				>;
+		};
+
+		pinctrl_usba_vbus: usba-vbus {
+			atmel,pins =
+				<AT91_PIOE 9 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
+		};
+	};
+};
-- 
2.30.2

