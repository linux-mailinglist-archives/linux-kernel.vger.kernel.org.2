Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E483ECEC6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 08:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhHPGri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 02:47:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:55193 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbhHPGrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629096412; x=1660632412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PiqvCX1MQm/EGD8KRuh49+Z+0O1Y0bW1x+51DVd1FEI=;
  b=r7jauG3n9agPc2PRYsf5R5YDOWWYAMGz4LbNReluVDK7mC6NbT2sZrRB
   ehbDD1PYUEoq9j1YoXVb5JQ2az//z3n8VzoL2hVLCDzmSUfDcD2NE4AlU
   39MBbKxo9pEbXglJ5UNdAbv40kA9nWTHFWR3rFiT931ChLFcXyDWDhVKe
   ai04UC7Z46C8D34O3xSrehxmmh9NDfgUELzqaTKiyBcHQlWV2HH+jYSrV
   HEM5H2TBGSAFHZ30qGca9KpelPFI/hNIQH9vA+kmaVX1MnE0+eRv9L9B6
   Txjbbi/4qqNbpyyKXTKNClsVaR5PNXqQpvVgXsiQADkBXmClCi6J+r7ZC
   Q==;
IronPort-SDR: QNzyo2JBIAJtU7vFpsfzv+UW6kY2xf9e6qDeYB7Z+mNccIqhAPjlz3ir7n3LCV4uEmrLzNv6sK
 Hm5e+6hZ1LG2neXQmrqLYn7RELbJ24Yz/3F3vdSkIApzHhUzzPVE/biyjJVQEimJiw4Bc6vv65
 4/3kCWi34OT5xzZAJIm9kYE5MnCYhZcfqlFQBQn6nGfvaciggwpfzvmlg+lEQ528Wo3JqfP1pk
 gt54QtbOGZDocjY6xbo661F/b5O/pb/LiihUxCUm20Vw4NKYET+djh9fWokfr3rsU8D0zvCr9I
 gbBpuGbD9AX8N2M17RxmJfHp
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="132919610"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2021 23:46:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 15 Aug 2021 23:46:51 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 15 Aug 2021 23:46:47 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Owen Kirby <osk@exegin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 7/7] ARM: dts: at91: add Exegin Q5xR5 board
Date:   Mon, 16 Aug 2021 09:44:16 +0300
Message-ID: <20210816064416.1630674-8-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
References: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Owen Kirby <osk@exegin.com>

Add Exegin Q5xR5. The base device tree is from OpenWrt tree and with
the addition of this patch there will be no need to maintain it
separatelly in OpenWrt.

[osk: original author of patch in OpenWrt]
Signed-off-by: Owen Kirby <osk@exegin.com>
[claudiu.beznea: use "&<label> {" syntax, sorted nodes in alphabetical
 order, adapted flash to new support in kernel 5.14, use proper
 compatibles according to kernel 5.14, use macros instead of
 hardcoded numbers for pinctrl phandles and for all pinctrl references,
 add pinctrl-names, pinctrl-X where necessaray]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/Makefile       |   1 +
 arch/arm/boot/dts/at91-q5xr5.dts | 200 +++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-q5xr5.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 249216d4a145..07be55262516 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -41,6 +41,7 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
 	at91-kizboxmini-base.dtb \
 	at91-kizboxmini-mb.dtb \
 	at91-kizboxmini-rd.dtb \
+	at91-q5xr5.dtb \
 	at91-smartkiz.dtb \
 	at91-wb45n.dtb \
 	at91sam9g15ek.dtb \
diff --git a/arch/arm/boot/dts/at91-q5xr5.dts b/arch/arm/boot/dts/at91-q5xr5.dts
new file mode 100644
index 000000000000..4866f1c6ccf9
--- /dev/null
+++ b/arch/arm/boot/dts/at91-q5xr5.dts
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Device Tree file for Exegin Q5xR5 board
+ *
+ * Copyright (C) 2014 Owen Kirby <osk@exegin.com>
+ */
+
+/dts-v1/;
+#include "at91sam9g20.dtsi"
+
+/ {
+	model = "Exegin Q5x (rev5)";
+	compatible = "exegin,q5xr5", "atmel,at91sam9g20", "atmel,at91sam9";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 rootfstype=squashfs,jffs2";
+	};
+
+	memory {
+		reg = <0x20000000 0x0>;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		main_clock: clock@0 {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <18432000>;
+		};
+
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <18432000>;
+		};
+	};
+};
+
+&dbgu {
+	status = "okay";
+};
+
+&ebi {
+	status = "okay";
+
+	flash: flash@0 {
+		compatible = "cfi-flash";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0 0x1000000 0x800000>;
+		bank-width = <2>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			kernel@0 {
+				label = "kernel";
+				reg = <0x0 0x200000>;
+			};
+
+			rootfs@200000 {
+				label = "rootfs";
+				reg = <0x200000 0x600000>;
+			};
+		};
+	};
+};
+
+&macb0 {
+	phy-mode = "mii";
+	status = "okay";
+};
+
+&pinctrl {
+	board {
+		pinctrl_pck0_as_mck: pck0_as_mck {
+			atmel,pins = <AT91_PIOC 1 AT91_PERIPH_B AT91_PINCTRL_NONE>;
+		};
+	};
+
+	spi0 {
+		pinctrl_spi0: spi0-0 {
+			atmel,pins =
+				<AT91_PIOA 0 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOA 1 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOA 2 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_spi0_npcs0: spi0_npcs0 {
+			atmel,pins = <AT91_PIOA 3 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_spi0_npcs1: spi0_npcs1 {
+			atmel,pins = <AT91_PIOC 11 AT91_PERIPH_B AT91_PINCTRL_NONE>;
+		};
+	};
+
+	spi1 {
+		pinctrl_spi1: spi1-0 {
+			atmel,pins =
+				<AT91_PIOB 0 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOB 1 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOB 2 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_spi1_npcs0: spi1_npcs0 {
+			atmel,pins = <AT91_PIOB 3 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_spi1_npcs1: spi1_npcs1 {
+			atmel,pins = <AT91_PIOC 5 AT91_PERIPH_B AT91_PINCTRL_NONE>;
+		};
+	};
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi0 &pinctrl_spi0_npcs0 &pinctrl_spi0_npcs1>;
+	cs-gpios = <&pioA 3 GPIO_ACTIVE_HIGH>, <&pioC 11 GPIO_ACTIVE_LOW>, <0>, <0>;
+	status = "okay";
+
+	m25p80@0 {
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		at91boot@0 {
+			label = "at91boot";
+			reg = <0x0 0x4000>;
+		};
+
+		uenv@4000 {
+			label = "uboot-env";
+			reg = <0x4000 0x4000>;
+		};
+
+		uboot@8000 {
+			label = "uboot";
+			reg = <0x8000 0x3E000>;
+		};
+	};
+
+	spidev@1 {
+		compatible = "spidev";
+		spi-max-frequency = <2000000>;
+		reg = <1>;
+	};
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1 &pinctrl_spi1_npcs0 &pinctrl_spi1_npcs1>;
+	cs-gpios = <&pioB 3 GPIO_ACTIVE_HIGH>, <&pioC 5 GPIO_ACTIVE_LOW>, <0>, <0>;
+	status = "okay";
+
+	spidev@0 {
+		compatible = "spidev";
+		spi-max-frequency = <2000000>;
+		reg = <0>;
+	};
+
+	spidev@1 {
+		compatible = "spidev";
+		spi-max-frequency = <2000000>;
+		reg = <1>;
+	};
+};
+
+&usart0 {
+	pinctrl-0 =
+		<&pinctrl_usart0
+		 &pinctrl_usart0_rts
+		 &pinctrl_usart0_cts
+		 &pinctrl_usart0_dtr_dsr
+		 &pinctrl_usart0_dcd
+		 &pinctrl_usart0_ri>;
+	status = "okay";
+};
+
+&usb0 {
+	num-ports = <2>;
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
+
-- 
2.25.1

