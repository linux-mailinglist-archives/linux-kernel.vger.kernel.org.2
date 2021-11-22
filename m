Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EF4458E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 13:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbhKVMfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 07:35:52 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51078 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239265AbhKVMfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 07:35:50 -0500
X-UUID: 17390bb131534e349222c2ef6d60a5b2-20211122
X-UUID: 17390bb131534e349222c2ef6d60a5b2-20211122
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1935587781; Mon, 22 Nov 2021 20:32:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 22 Nov 2021 20:32:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Nov 2021 20:32:38 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     John Crispin <john@phrozen.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        "Sam Shih" <sam.shih@mediatek.com>
Subject: [PATCH v8 2/2] arm64: dts: mediatek: add basic mt7986 support
Date:   Mon, 22 Nov 2021 20:32:22 +0800
Message-ID: <20211122123222.8016-3-sam.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211122123222.8016-1-sam.shih@mediatek.com>
References: <20211122123222.8016-1-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic chip support for Mediatek mt7986, include
basic uart nodes, rng node and watchdog node.

Add cpu node, timer node, gic node, psci and reserved-memory node
for ARM Trusted Firmware.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>

---
v8: removed debug bootargs
v7: added memory node back to dts
v6: removed clock and pinctrl node, to separate basic part into a single
    patch series

Original thread:
https://lore.kernel.org/all/20211004124155.1404-1-sam.shih@mediatek.com/

v5: follow reviewr's comment: removed clock freqency node in timer due to
    we have set CNTFRQ_EL0 in ATF firmware, and also corrected GICD range
v4: added missing gic register bases, and fixed range of GICR
v3: used the stdout-path instead of console=ttyS0
v2: modified clock and uart node due to clock driver updated
---
 arch/arm64/boot/dts/mediatek/Makefile        |   1 +
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts |  37 +++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 148 +++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 4f68ebed2e31..e6c3a73b9e4a 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
new file mode 100644
index 000000000000..6911862390d7
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2021 MediaTek Inc.
+ * Author: Sam.Shih <sam.shih@mediatek.com>
+ */
+
+/dts-v1/;
+#include "mt7986a.dtsi"
+
+/ {
+	model = "MediaTek MT7986a RFB";
+	compatible = "mediatek,mt7986a-rfb";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		reg = <0 0x40000000 0 0x40000000>;
+	};
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
+&uart2 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
new file mode 100644
index 000000000000..77906839cc85
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2021 MediaTek Inc.
+ * Author: Sam.Shih <sam.shih@mediatek.com>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	system_clk: dummy40m {
+		compatible = "fixed-clock";
+		clock-frequency = <40000000>;
+		#clock-cells = <0>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			enable-method = "psci";
+			reg = <0x0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			enable-method = "psci";
+			reg = <0x1>;
+			#cooling-cells = <2>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			enable-method = "psci";
+			reg = <0x2>;
+			#cooling-cells = <2>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			enable-method = "psci";
+			compatible = "arm,cortex-a53";
+			reg = <0x3>;
+			#cooling-cells = <2>;
+		};
+	};
+
+	psci {
+		compatible  = "arm,psci-0.2";
+		method      = "smc";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		/* 192 KiB reserved for ARM Trusted Firmware (BL31) */
+		secmon_reserved: secmon@43000000 {
+			reg = <0 0x43000000 0 0x30000>;
+			no-map;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		gic: interrupt-controller@c000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			reg = <0 0x0c000000 0 0x10000>,  /* GICD */
+			      <0 0x0c080000 0 0x80000>,  /* GICR */
+			      <0 0x0c400000 0 0x2000>,   /* GICC */
+			      <0 0x0c410000 0 0x1000>,   /* GICH */
+			      <0 0x0c420000 0 0x2000>;   /* GICV */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		watchdog: watchdog@1001c000 {
+			compatible = "mediatek,mt7986-wdt",
+				     "mediatek,mt6589-wdt";
+			reg = <0 0x1001c000 0 0x1000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			#reset-cells = <1>;
+			status = "disabled";
+		};
+
+		trng: trng@1020f000 {
+			compatible = "mediatek,mt7986-rng",
+				     "mediatek,mt7623-rng";
+			reg = <0 0x1020f000 0 0x100>;
+			clocks = <&system_clk>;
+			clock-names = "rng";
+			status = "disabled";
+		};
+
+		uart0: serial@11002000 {
+			compatible = "mediatek,mt7986-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11002000 0 0x400>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&system_clk>;
+			status = "disabled";
+		};
+
+		uart1: serial@11003000 {
+			compatible = "mediatek,mt7986-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11003000 0 0x400>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&system_clk>;
+			status = "disabled";
+		};
+
+		uart2: serial@11004000 {
+			compatible = "mediatek,mt7986-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11004000 0 0x400>;
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&system_clk>;
+			status = "disabled";
+		};
+
+	};
+
+};
-- 
2.29.2

