Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2E442D66B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 11:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhJNJwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:52:12 -0400
Received: from mo-csw-fb1116.securemx.jp ([210.130.202.175]:39934 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhJNJwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:52:11 -0400
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1116) id 19E9WYR0028952; Thu, 14 Oct 2021 18:32:34 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 19E9WRfl003817; Thu, 14 Oct 2021 18:32:27 +0900
X-Iguazu-Qid: 2wGrDIThyhDNqVKqwL
X-Iguazu-QSIG: v=2; s=0; t=1634203946; q=2wGrDIThyhDNqVKqwL; m=4zehAYeNbRATCaZ3OAhMbmPJgaQhQQLSHRHh0DU1PCU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1113) id 19E9WQBA015844
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Oct 2021 18:32:26 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 0DB8B10007B;
        Thu, 14 Oct 2021 18:32:26 +0900 (JST)
Received: from enc01.toshiba.co.jp (localhost.localdomain [127.0.0.1])
        by enc01.toshiba.co.jp  with ESMTP id 19E9WPK3024619;
        Thu, 14 Oct 2021 18:32:25 +0900
Received: from enc01.toshiba.co.jp.mid_24808785 (localhost.localdomain [127.0.0.1])
        by enc01.toshiba.co.jp  with ESMTP id 19E9RMH8021261;
        Thu, 14 Oct 2021 18:27:22 +0900
X-SA-MID: 24808785
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>, nobuhiro1.iwamatsu@toshiba.co.jp
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: visconti: Add DTS for the VisROBO board
Date:   Thu, 14 Oct 2021 18:27:03 +0900
X-TSB-HOP: ON
Message-Id: <20211014092703.15251-4-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211014092703.15251-1-yuji2.ishikawa@toshiba.co.jp>
References: <20211014092703.15251-1-yuji2.ishikawa@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This board consists of two boards:
the SoM board (VRC SoM) with the SoC on board, and the board for I/O (VRB).

The functions of each board supported by this update are as follows:
  - VRC SoM
    - WDT
    - GPIO
    - SDCard (SPI-MMC mode)
    - I2C x1
  - VRB board
    - VRC SoM
    - UART x2
    - Ethernet phy

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
---
 arch/arm64/boot/dts/toshiba/Makefile          |  1 +
 .../boot/dts/toshiba/tmpv7708-visrobo-vrb.dts | 61 +++++++++++++++++++
 .../dts/toshiba/tmpv7708-visrobo-vrc.dtsi     | 44 +++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 arch/arm64/boot/dts/toshiba/tmpv7708-visrobo-vrb.dts
 create mode 100644 arch/arm64/boot/dts/toshiba/tmpv7708-visrobo-vrc.dtsi

diff --git a/arch/arm64/boot/dts/toshiba/Makefile b/arch/arm64/boot/dts/toshiba/Makefile
index 8cd460d5b68e..7ccb4664bb37 100644
--- a/arch/arm64/boot/dts/toshiba/Makefile
+++ b/arch/arm64/boot/dts/toshiba/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_VISCONTI) += tmpv7708-rm-mbrc.dtb
+dtb-$(CONFIG_ARCH_VISCONTI) += tmpv7708-visrobo-vrb.dtb
diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708-visrobo-vrb.dts b/arch/arm64/boot/dts/toshiba/tmpv7708-visrobo-vrb.dts
new file mode 100644
index 000000000000..d0817463706e
--- /dev/null
+++ b/arch/arm64/boot/dts/toshiba/tmpv7708-visrobo-vrb.dts
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree File for TMPV7708 VisROBO VRB board
+ *
+ * (C) Copyright 2020, 2021, Toshiba Corporation.
+ * (C) Copyright 2020, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+ */
+
+/dts-v1/;
+
+#include "tmpv7708-visrobo-vrc.dtsi"
+
+/ {
+	model = "Toshiba TMPV7708 VisROBO (VRB) board";
+	compatible = "toshiba,tmpv7708-visrobo-vrb", "toshiba,tmpv7708";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	/* 768MB memory */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x30000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+	clocks = <&uart_clk>;
+	clock-names = "apb_pclk";
+};
+
+&uart1 {
+	status = "okay";
+	clocks = <&uart_clk>;
+	clock-names = "apb_pclk";
+};
+
+&piether {
+	status = "okay";
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	clocks = <&clk300mhz>, <&clk125mhz>;
+	clock-names = "stmmaceth", "phy_ref_clk";
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy0: ethernet-phy@1 {
+			device_type = "ethernet-phy";
+			reg = <0x1>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708-visrobo-vrc.dtsi b/arch/arm64/boot/dts/toshiba/tmpv7708-visrobo-vrc.dtsi
new file mode 100644
index 000000000000..f0a93db6dde6
--- /dev/null
+++ b/arch/arm64/boot/dts/toshiba/tmpv7708-visrobo-vrc.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree File for TMPV7708 VisROBO VRC SoM
+ *
+ * (C) Copyright 2020, 2021, Toshiba Corporation.
+ * (C) Copyright 2020, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+ */
+
+/dts-v1/;
+
+#include "tmpv7708.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+&wdt {
+	status = "okay";
+	clocks = <&wdt_clk>;
+};
+
+&gpio {
+	status = "okay";
+};
+
+&spi0_pins {
+	groups = "spi0_grp", "spi0_cs0_grp";
+};
+
+&spi0 {
+	status = "okay";
+	clocks = <&clk300mhz>, <&clk150mhz>;
+	clock-names = "sspclk", "apb_pclk";
+
+	mmc-slot@0 {
+		compatible = "mmc-spi-slot";
+		reg = <0>;
+		gpios = <&gpio 15 GPIO_ACTIVE_LOW>;
+		voltage-ranges = <3200 3400>;
+		spi-max-frequency = <12000000>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+	clocks = <&clk150mhz>;
+};
-- 
2.17.1


