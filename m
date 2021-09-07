Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE85402CF7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344315AbhIGQje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:39:34 -0400
Received: from thoth.sbs.de ([192.35.17.2]:41715 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344014AbhIGQj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:39:26 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 187Gc5bJ012640
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Sep 2021 18:38:05 +0200
Received: from md1f2u6c.ad001.siemens.net ([167.87.245.242])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 187Gc3Gj021975;
        Tue, 7 Sep 2021 18:38:05 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH v2 4/4] arm64: dts: ti: iot2050: Add support for product generation 2 boards
Date:   Tue,  7 Sep 2021 18:38:02 +0200
Message-Id: <92c62afc6bb34d4704d65d4d0cbc0857d5814dfc.1631032682.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631032682.git.jan.kiszka@siemens.com>
References: <cover.1631032682.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This adds the devices trees for IOT2050 Product Generation 2 (PG2)
boards. We have Basic and an Advanced variants again, differing in
number of cores, RAM size, availability of eMMC and further details.
The major difference to PG1 is the used silicon revision (SR2.x on
PG2).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  2 +
 .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    | 51 +++++++++++++++++++
 .../dts/ti/k3-am6528-iot2050-basic-pg2.dts    | 24 +++++++++
 .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts | 29 +++++++++++
 4 files changed, 106 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index d56c742f5a10..41a4bc96e6bd 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -8,7 +8,9 @@
 
 dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
 
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board.dtb
 
diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
new file mode 100644
index 000000000000..2323628b0444
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Siemens AG, 2021
+ *
+ * Authors:
+ *   Chao Zeng <chao.zeng@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ *
+ * Common bits of the IOT2050 Basic and Advanced variants, PG2
+ */
+
+&main_pmx0 {
+	cp2102n_reset_pin_default: cp2102n_reset_pin_default {
+		pinctrl-single,pins = <
+			/* (AF12) GPIO1_24, used as cp2102 reset */
+			AM65X_IOPAD(0x01e0, PIN_OUTPUT, 7)
+		>;
+	};
+};
+
+&main_gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp2102n_reset_pin_default>;
+	gpio-line-names =
+		"", "", "", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "", "", "",
+		"", "", "", "", "CP2102N-RESET";
+};
+
+&dss {
+	/* Workaround needed to get DP clock of 154Mhz */
+	assigned-clocks = <&k3_clks 67 0>;
+};
+
+&serdes0 {
+	assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
+	assigned-clock-parents = <&k3_clks 153 7>, <&k3_clks 153 4>;
+};
+
+&dwc3_0 {
+	assigned-clock-parents = <&k3_clks 151 4>,  /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
+				 <&k3_clks 151 8>;  /* set PIPE3_TXB_CLK to WIZ8B2M4VSB */
+	phys = <&serdes0 PHY_TYPE_USB3 0>;
+	phy-names = "usb3-phy";
+};
+
+&usb0_phy {
+	maximum-speed = "super-speed";
+	snps,dis-u1-entry-quirk;
+	snps,dis-u2-entry-quirk;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
new file mode 100644
index 000000000000..c62549a4b436
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Siemens AG, 2018-2021
+ *
+ * Authors:
+ *   Le Jin <le.jin@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ *
+ * AM6528-based (dual-core) IOT2050 Basic variant, Product Generation 2
+ * 1 GB RAM, no eMMC, main_uart0 on connector X30
+ *
+ * Product homepage:
+ * https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
+ */
+
+/dts-v1/;
+
+#include "k3-am6528-iot2050-basic-common.dtsi"
+#include "k3-am65-iot2050-common-pg2.dtsi"
+
+/ {
+	compatible = "siemens,iot2050-basic-pg2", "ti,am654";
+	model = "SIMATIC IOT2050 Basic PG2";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
new file mode 100644
index 000000000000..f00dc86d01b9
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Siemens AG, 2018-2021
+ *
+ * Authors:
+ *   Le Jin <le.jin@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ *
+ * AM6548-based (quad-core) IOT2050 Advanced variant, Product Generation 2
+ * 2 GB RAM, 16 GB eMMC, USB-serial converter on connector X30
+ *
+ * Product homepage:
+ * https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
+ */
+
+/dts-v1/;
+
+#include "k3-am6548-iot2050-advanced-common.dtsi"
+#include "k3-am65-iot2050-common-pg2.dtsi"
+
+/ {
+	compatible = "siemens,iot2050-advanced-pg2", "ti,am654";
+	model = "SIMATIC IOT2050 Advanced PG2";
+};
+
+&mcu_r5fss0 {
+	/* lock-step mode not supported on this board */
+	ti,cluster-mode = <0>;
+};
-- 
2.31.1

