Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B654240C540
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbhIOM2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:28:55 -0400
Received: from goliath.siemens.de ([192.35.17.28]:35928 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbhIOM2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:28:46 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 18FCREqp012240
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 14:27:15 +0200
Received: from md1f2u6c.ad001.siemens.net ([167.87.79.72])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 18FCRAr7006124;
        Wed, 15 Sep 2021 14:27:14 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH v4 5/6] arm64: dts: ti: iot2050: Prepare for adding 2nd-generation boards
Date:   Wed, 15 Sep 2021 14:27:09 +0200
Message-Id: <87408a5d2d56e6d7dd840e9cec1c8f9da97754be.1631708830.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631708830.git.jan.kiszka@siemens.com>
References: <cover.1631708830.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

The current IOT2050 devices are Product Generation 1 (PG1), using SR1.0
AM65x silicon. Upcoming PG2 devices will use SR2.x SoCs and will
therefore need separate device trees. Prepare for that by factoring out
common bits that will be shared across both generations.

At this chance, drop a link to the product homepage to in the top-level
dts files. Also fix a typo in my email address in some headers.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../dts/ti/k3-am65-iot2050-common-pg1.dtsi    | 46 +++++++++++++++
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 35 +-----------
 ...ts => k3-am6528-iot2050-basic-common.dtsi} | 12 +---
 .../boot/dts/ti/k3-am6528-iot2050-basic.dts   | 56 +++----------------
 ...=> k3-am6548-iot2050-advanced-common.dtsi} |  8 +--
 .../dts/ti/k3-am6548-iot2050-advanced.dts     | 50 +++--------------
 6 files changed, 67 insertions(+), 140 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
 copy arch/arm64/boot/dts/ti/{k3-am6528-iot2050-basic.dts => k3-am6528-iot2050-basic-common.dtsi} (80%)
 copy arch/arm64/boot/dts/ti/{k3-am6548-iot2050-advanced.dts => k3-am6548-iot2050-advanced-common.dtsi} (85%)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
new file mode 100644
index 000000000000..51f902fa35a7
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Siemens AG, 2021
+ *
+ * Authors:
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ *
+ * Common bits of the IOT2050 Basic and Advanced variants, PG1
+ */
+
+&dss {
+	assigned-clocks = <&k3_clks 67 2>;
+	assigned-clock-parents = <&k3_clks 67 5>;
+};
+
+&serdes0 {
+	status = "disabled";
+};
+
+&sdhci1 {
+	no-1-8-v;
+};
+
+&tx_pru0_0 {
+	status = "disabled";
+};
+
+&tx_pru0_1 {
+	status = "disabled";
+};
+
+&tx_pru1_0 {
+	status = "disabled";
+};
+
+&tx_pru1_1 {
+	status = "disabled";
+};
+
+&tx_pru2_0 {
+	status = "disabled";
+};
+
+&tx_pru2_1 {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index b29537088289..65da226847f4 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -4,13 +4,11 @@
  *
  * Authors:
  *   Le Jin <le.jin@siemens.com>
- *   Jan Kiszka <jan.kiszk@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
  *
- * Common bits of the IOT2050 Basic and Advanced variants
+ * Common bits of the IOT2050 Basic and Advanced variants, PG1 and PG2
  */
 
-/dts-v1/;
-
 #include "k3-am654.dtsi"
 #include <dt-bindings/phy/phy.h>
 
@@ -557,7 +555,6 @@ &sdhci1 {
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
-	no-1-8-v;
 };
 
 &usb0 {
@@ -631,10 +628,6 @@ dpi_out: endpoint {
 	};
 };
 
-&serdes0 {
-	status = "disabled";
-};
-
 &pcie0_rc {
 	status = "disabled";
 };
@@ -738,27 +731,3 @@ &icssg1_mdio {
 &icssg2_mdio {
 	status = "disabled";
 };
-
-&tx_pru0_0 {
-	status = "disabled";
-};
-
-&tx_pru0_1 {
-	status = "disabled";
-};
-
-&tx_pru1_0 {
-	status = "disabled";
-};
-
-&tx_pru1_1 {
-	status = "disabled";
-};
-
-&tx_pru2_0 {
-	status = "disabled";
-};
-
-&tx_pru2_1 {
-	status = "disabled";
-};
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
similarity index 80%
copy from arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
copy to arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
index 94bb5dd39122..4a9bf7d7c07d 100644
--- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
@@ -4,20 +4,14 @@
  *
  * Authors:
  *   Le Jin <le.jin@siemens.com>
- *   Jan Kiszka <jan.kiszk@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
  *
- * AM6528-based (dual-core) IOT2050 Basic variant
- * 1 GB RAM, no eMMC, main_uart0 on connector X30
+ * Common bits of the IOT2050 Basic variant, PG1 and PG2
  */
 
-/dts-v1/;
-
 #include "k3-am65-iot2050-common.dtsi"
 
 / {
-	compatible = "siemens,iot2050-basic", "ti,am654";
-	model = "SIMATIC IOT2050 Basic";
-
 	memory@80000000 {
 		device_type = "memory";
 		/* 1G RAM */
@@ -61,6 +55,6 @@ &main_uart0 {
 };
 
 &mcu_r5fss0 {
-	/* lock-step mode not supported on this board */
+	/* lock-step mode not supported on Basic boards */
 	ti,cluster-mode = <0>;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
index 94bb5dd39122..87928ff28214 100644
--- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
@@ -4,63 +4,21 @@
  *
  * Authors:
  *   Le Jin <le.jin@siemens.com>
- *   Jan Kiszka <jan.kiszk@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
  *
- * AM6528-based (dual-core) IOT2050 Basic variant
+ * AM6528-based (dual-core) IOT2050 Basic variant, Product Generation 1
  * 1 GB RAM, no eMMC, main_uart0 on connector X30
+ *
+ * Product homepage:
+ * https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
  */
 
 /dts-v1/;
 
-#include "k3-am65-iot2050-common.dtsi"
+#include "k3-am6528-iot2050-basic-common.dtsi"
+#include "k3-am65-iot2050-common-pg1.dtsi"
 
 / {
 	compatible = "siemens,iot2050-basic", "ti,am654";
 	model = "SIMATIC IOT2050 Basic";
-
-	memory@80000000 {
-		device_type = "memory";
-		/* 1G RAM */
-		reg = <0x00000000 0x80000000 0x00000000 0x40000000>;
-	};
-
-	cpus {
-		cpu-map {
-			/delete-node/ cluster1;
-		};
-		/delete-node/ cpu@100;
-		/delete-node/ cpu@101;
-	};
-
-	/delete-node/ l2-cache1;
-};
-
-/* eMMC */
-&sdhci0 {
-	status = "disabled";
-};
-
-&main_pmx0 {
-	main_uart0_pins_default: main-uart0-pins-default {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x01e4, PIN_INPUT,  0)  /* (AF11) UART0_RXD */
-			AM65X_IOPAD(0x01e8, PIN_OUTPUT, 0)  /* (AE11) UART0_TXD */
-			AM65X_IOPAD(0x01ec, PIN_INPUT,  0)  /* (AG11) UART0_CTSn */
-			AM65X_IOPAD(0x01f0, PIN_OUTPUT, 0)  /* (AD11) UART0_RTSn */
-			AM65X_IOPAD(0x0188, PIN_INPUT,  1)  /* (D25) UART0_DCDn */
-			AM65X_IOPAD(0x018c, PIN_INPUT,  1)  /* (B26) UART0_DSRn */
-			AM65X_IOPAD(0x0190, PIN_OUTPUT, 1)  /* (A24) UART0_DTRn */
-			AM65X_IOPAD(0x0194, PIN_INPUT,  1)  /* (E24) UART0_RIN */
-		>;
-	};
-};
-
-&main_uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart0_pins_default>;
-};
-
-&mcu_r5fss0 {
-	/* lock-step mode not supported on this board */
-	ti,cluster-mode = <0>;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
similarity index 85%
copy from arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
copy to arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
index ec9617c13cdb..d25e8b26187f 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
@@ -4,10 +4,9 @@
  *
  * Authors:
  *   Le Jin <le.jin@siemens.com>
- *   Jan Kiszka <jan.kiszk@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
  *
- * AM6548-based (quad-core) IOT2050 Advanced variant
- * 2 GB RAM, 16 GB eMMC, USB-serial converter on connector X30
+ * Common bits of the IOT2050 Advanced variant, PG1 and PG2
  */
 
 /dts-v1/;
@@ -15,9 +14,6 @@
 #include "k3-am65-iot2050-common.dtsi"
 
 / {
-	compatible = "siemens,iot2050-advanced", "ti,am654";
-	model = "SIMATIC IOT2050 Advanced";
-
 	memory@80000000 {
 		device_type = "memory";
 		/* 2G RAM */
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
index ec9617c13cdb..077f165bdc68 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
@@ -4,57 +4,21 @@
  *
  * Authors:
  *   Le Jin <le.jin@siemens.com>
- *   Jan Kiszka <jan.kiszk@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
  *
- * AM6548-based (quad-core) IOT2050 Advanced variant
+ * AM6548-based (quad-core) IOT2050 Advanced variant, Product Generation 1
  * 2 GB RAM, 16 GB eMMC, USB-serial converter on connector X30
+ *
+ * Product homepage:
+ * https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
  */
 
 /dts-v1/;
 
-#include "k3-am65-iot2050-common.dtsi"
+#include "k3-am6548-iot2050-advanced-common.dtsi"
+#include "k3-am65-iot2050-common-pg1.dtsi"
 
 / {
 	compatible = "siemens,iot2050-advanced", "ti,am654";
 	model = "SIMATIC IOT2050 Advanced";
-
-	memory@80000000 {
-		device_type = "memory";
-		/* 2G RAM */
-		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
-	};
-};
-
-&main_pmx0 {
-	main_mmc0_pins_default: main-mmc0-pins-default {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x01a8, PIN_INPUT_PULLDOWN, 0)  /* (B25) MMC0_CLK */
-			AM65X_IOPAD(0x01ac, PIN_INPUT_PULLUP,   0)  /* (B27) MMC0_CMD */
-			AM65X_IOPAD(0x01a4, PIN_INPUT_PULLUP,   0)  /* (A26) MMC0_DAT0 */
-			AM65X_IOPAD(0x01a0, PIN_INPUT_PULLUP,   0)  /* (E25) MMC0_DAT1 */
-			AM65X_IOPAD(0x019c, PIN_INPUT_PULLUP,   0)  /* (C26) MMC0_DAT2 */
-			AM65X_IOPAD(0x0198, PIN_INPUT_PULLUP,   0)  /* (A25) MMC0_DAT3 */
-			AM65X_IOPAD(0x0194, PIN_INPUT_PULLUP,   0)  /* (E24) MMC0_DAT4 */
-			AM65X_IOPAD(0x0190, PIN_INPUT_PULLUP,   0)  /* (A24) MMC0_DAT5 */
-			AM65X_IOPAD(0x018c, PIN_INPUT_PULLUP,   0)  /* (B26) MMC0_DAT6 */
-			AM65X_IOPAD(0x0188, PIN_INPUT_PULLUP,   0)  /* (D25) MMC0_DAT7 */
-			AM65X_IOPAD(0x01b8, PIN_OUTPUT_PULLUP,  7)  /* (B23) MMC0_SDWP */
-			AM65X_IOPAD(0x01b4, PIN_INPUT_PULLUP,   0)  /* (A23) MMC0_SDCD */
-			AM65X_IOPAD(0x01b0, PIN_INPUT,          0)  /* (C25) MMC0_DS */
-		>;
-	};
-};
-
-/* eMMC */
-&sdhci0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mmc0_pins_default>;
-	bus-width = <8>;
-	non-removable;
-	ti,driver-strength-ohm = <50>;
-	disable-wp;
-};
-
-&main_uart0 {
-	status = "disabled";
 };
-- 
2.31.1

