Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D853ECEBD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 08:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhHPGrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 02:47:16 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:35787 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhHPGrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629096399; x=1660632399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=79Yc+nAUTJJl0MiSc6D7XMZAKdHncu3VELYubkLXPUE=;
  b=CiUZKyPhEhvQP96fEZmlGIzoZyUGbCC8BoVzrdXc0XUgt27Pl1k/j5e8
   OfBuM2VF/JNXOgcQEm22LJ1gUAf0Z/mV8Upj+uYacBgaHn4EsjDWO+2lY
   0XlhKTfEy0/heiST0Fjav0dAGNwJWaaCrHRiGseKKU2b8vBF8lpuGJLDG
   rhJLd3d4tHggpi0xec3RgOaDvd4FIX+rjQ/QRYFcCfl6SpTK2I3Z3wshW
   rUZVGSRvpSG1c6MgNosmU3PVKUxHDvZkLvFXaK61294Ae0Bdfe4Ak6rvV
   1sQkcJwC54viK1VCJ/d9rb3VKCGDL68IROPbxcGRNZe1WAC82kxK1JowA
   Q==;
IronPort-SDR: wfMiUrn8o/qZ+5RKkyB4BzznGOXBuFxzDwMgpaqY1t1tCRvMOQvZY7YiX+FXGuiCvoq/jxVo1z
 sf+r8j3HBQ3VoUd6EwCAM52c9slREuuGjDXdFWns7XDMyJWP7mWStqJuIsWJJbxiW5gOvbRALG
 FmQV1zDots/+5Y4XRN5e6jUwX68Er35/02KJyQybqbrC11K2TmkJMXBiGV71GViI6wVshhS3Mc
 rNbSl+cTtWOWaSpAcdL8PY/h5E8m0a1mqCjYbSjAv4+REWGi7VN3cq0vDsgnbd7hXQrHejCBwa
 KgFkrSAqJKcLcYHgttONGAnj
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="125900508"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2021 23:46:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 15 Aug 2021 23:46:38 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 15 Aug 2021 23:46:35 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Adam Porter <porter.adam@gmail.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 4/7] ARM: dts: at91: add CalAmp LMU5000 board
Date:   Mon, 16 Aug 2021 09:44:13 +0300
Message-ID: <20210816064416.1630674-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
References: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Porter <porter.adam@gmail.com>

Add CalAmp LMU5000 board. The base device tree is from OpenWrt tree and
with the addition of this patch there will be no need to maintain it
separatelly in OpenWrt.

[porter.adam: original author of patch in OpenWrt]
Signed-off-by: Adam Porter <porter.adam@gmail.com>
[claudiu.beznea: fixed compilation warnings, use &<lable> syntax,
 sorted nodes in alphabetical order, adapted flash to new support
 in kernel 5.14, use proper compatibles according to kernel 5.14,
 use macros instead of hard coded numbers for pinctrl phandles and
 for all pinctrl references, add pinctrl-names, pinctrl-X where
 necessary]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/at91-lmu5000.dts | 148 +++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-lmu5000.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 63b60f571035..249216d4a145 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -25,6 +25,7 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
 	usb_a9263.dtb \
 	at91-foxg20.dtb \
 	at91-kizbox.dtb \
+	at91-lmu5000.dtb \
 	at91sam9g20ek.dtb \
 	at91sam9g20ek_2mmc.dtb \
 	tny_a9g20.dtb \
diff --git a/arch/arm/boot/dts/at91-lmu5000.dts b/arch/arm/boot/dts/at91-lmu5000.dts
new file mode 100644
index 000000000000..6a52728cc98f
--- /dev/null
+++ b/arch/arm/boot/dts/at91-lmu5000.dts
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Device Tree file for CalAmp LMU5000 board
+ *
+ * Copyright (C) 2013 Adam Porter <porter.adam@gmail.com>
+ */
+
+/dts-v1/;
+#include "at91sam9g20.dtsi"
+
+/ {
+	model = "CalAmp LMU5000";
+	compatible = "calamp,lmu5000", "atmel,at91sam9g20", "atmel,at91sam9";
+
+	chosen {
+		bootargs = "mem=64M console=ttyS0,115200 rootfstype=jffs2";
+	};
+
+	memory {
+		reg = <0x20000000 0x4000000>;
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
+	nand_controller: nand-controller {
+		pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb>;
+		pinctrl-names = "default";
+		status = "okay";
+
+		nand@3 {
+			reg = <0x3 0x0 0x800000>;
+			rb-gpios = <&pioC 13 GPIO_ACTIVE_HIGH>;
+			cs-gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
+			nand-bus-width = <8>;
+			nand-ecc-mode = "soft";
+			nand-on-flash-bbt;
+			label = "atmel_nand";
+			status = "okay";
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				kernel@0 {
+					label = "kernel";
+					reg = <0x0 0x400000>;
+				};
+
+				rootfs@400000 {
+					label = "rootfs";
+					reg = <0x400000 0x3C00000>;
+				};
+
+				user1@4000000 {
+					label = "user1";
+					reg = <0x4000000 0x2000000>;
+				};
+
+				user2@6000000 {
+					label = "user2";
+					reg = <0x6000000 0x2000000>;
+				};
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
+	usb0 {
+		pinctrl_usb1_vbus_gpio: usb0_vbus_gpio {
+			atmel,pins = <AT91_PIOC 5 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+};
+
+&ssc0 {
+	status = "okay";
+	pinctrl-0 = <&pinctrl_ssc0_tx>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
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
+&usart2 {
+	status = "okay";
+};
+
+&usb0 {
+	num-ports = <2>;
+	status = "okay";
+};
+
+&usb1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb1_vbus_gpio>;
+	atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
+
-- 
2.25.1

