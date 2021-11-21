Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37A54585CD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 19:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbhKUSLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 13:11:10 -0500
Received: from soltyk.jannau.net ([144.76.91.90]:55046 "EHLO soltyk.jannau.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230454AbhKUSLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 13:11:07 -0500
Received: from coburn.home.jannau.net (p579ad520.dip0.t-ipconnect.de [87.154.213.32])
        by soltyk.jannau.net (Postfix) with ESMTPSA id E5951261B35;
        Sun, 21 Nov 2021 19:08:00 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: apple: Add missing M1 (t8103) devices
Date:   Sun, 21 Nov 2021 19:07:57 +0100
Message-Id: <20211121180758.29477-3-j@jannau.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211121180758.29477-1-j@jannau.net>
References: <20211121180758.29477-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for following Apple M1 devices:
 - MacBook Pro (13-inch, M1, 2020)
 - MacBook Air (M1, 2020)
 - iMac (24-inch 2021)

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/Makefile        |  4 ++
 arch/arm64/boot/dts/apple/t8103-j274.dts  | 29 +-------------
 arch/arm64/boot/dts/apple/t8103-j293.dts  | 33 +++++++++++++++
 arch/arm64/boot/dts/apple/t8103-j313.dts  | 33 +++++++++++++++
 arch/arm64/boot/dts/apple/t8103-j456.dts  | 41 +++++++++++++++++++
 arch/arm64/boot/dts/apple/t8103-j457.dts  | 47 ++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi | 49 +++++++++++++++++++++++
 7 files changed, 208 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j293.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j313.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j456.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j457.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index cbbd701ebf05..c0510c25ca6a 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -1,2 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j274.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8103-j293.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8103-j313.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8103-j456.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8103-j457.dtb
diff --git a/arch/arm64/boot/dts/apple/t8103-j274.dts b/arch/arm64/boot/dts/apple/t8103-j274.dts
index 02c36301e985..9e01ef70039d 100644
--- a/arch/arm64/boot/dts/apple/t8103-j274.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j274.dts
@@ -10,39 +10,15 @@
 /dts-v1/;
 
 #include "t8103.dtsi"
+#include "t8103-jxxx.dtsi"
 
 / {
 	compatible = "apple,j274", "apple,t8103", "apple,arm-platform";
 	model = "Apple Mac mini (M1, 2020)";
 
 	aliases {
-		serial0 = &serial0;
 		ethernet0 = &ethernet0;
 	};
-
-	chosen {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		stdout-path = "serial0";
-
-		framebuffer0: framebuffer@0 {
-			compatible = "apple,simple-framebuffer", "simple-framebuffer";
-			reg = <0 0 0 0>; /* To be filled by loader */
-			/* Format properties will be added by loader */
-			status = "disabled";
-		};
-	};
-
-	memory@800000000 {
-		device_type = "memory";
-		reg = <0x8 0 0x2 0>; /* To be filled by loader */
-	};
-};
-
-&serial0 {
-	status = "okay";
 };
 
 /*
@@ -50,9 +26,6 @@ &serial0 {
  * on-board devices and properties that are populated by the bootloader
  * (such as MAC addresses).
  */
-&port00 {
-	bus-range = <1 1>;
-};
 
 &port01 {
 	bus-range = <2 2>;
diff --git a/arch/arm64/boot/dts/apple/t8103-j293.dts b/arch/arm64/boot/dts/apple/t8103-j293.dts
new file mode 100644
index 000000000000..466035f00b69
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8103-j293.dts
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple MacBook Pro (13-inch, M1, 2020)
+ *
+ * target-type: J293
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8103.dtsi"
+#include "t8103-jxxx.dtsi"
+
+/ {
+	compatible = "apple,j293", "apple,t8103", "apple,arm-platform";
+	model = "Apple MacBook Pro (13-inch, M1, 2020)";
+};
+
+/*
+ * Remove unused PCIe ports and disable the associated DARTs.
+ */
+
+&pcie0_dart_1 {
+	status = "disabled";
+};
+
+&pcie0_dart_2 {
+	status = "disabled";
+};
+
+/delete-node/ &port01;
+/delete-node/ &port02;
diff --git a/arch/arm64/boot/dts/apple/t8103-j313.dts b/arch/arm64/boot/dts/apple/t8103-j313.dts
new file mode 100644
index 000000000000..b0ebb45bdb6f
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8103-j313.dts
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple MacBook Air (M1, 2020)
+ *
+ * target-type: J313
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8103.dtsi"
+#include "t8103-jxxx.dtsi"
+
+/ {
+	compatible = "apple,j313", "apple,t8103", "apple,arm-platform";
+	model = "Apple MacBook Air (M1, 2020)";
+};
+
+/*
+ * Remove unused PCIe ports and disable the associated DARTs.
+ */
+
+&pcie0_dart_1 {
+	status = "disabled";
+};
+
+&pcie0_dart_2 {
+	status = "disabled";
+};
+
+/delete-node/ &port01;
+/delete-node/ &port02;
diff --git a/arch/arm64/boot/dts/apple/t8103-j456.dts b/arch/arm64/boot/dts/apple/t8103-j456.dts
new file mode 100644
index 000000000000..7267e069355b
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8103-j456.dts
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iMac (24-inch, 4x USB-C, M1, 2020)
+ *
+ * target-type: J456
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8103.dtsi"
+#include "t8103-jxxx.dtsi"
+
+/ {
+	compatible = "apple,j456", "apple,t8103", "apple,arm-platform";
+	model = "Apple iMac (24-inch, 4x USB-C, M1, 2020)";
+
+	aliases {
+		ethernet0 = &ethernet0;
+	};
+};
+
+/*
+ * Force the bus number assignments so that we can declare some of the
+ * on-board devices and properties that are populated by the bootloader
+ * (such as MAC addresses).
+ */
+
+&port01 {
+	bus-range = <2 2>;
+};
+
+&port02 {
+	bus-range = <3 3>;
+	ethernet0: ethernet@0,0 {
+		reg = <0x30000 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-mac-address = [00 10 18 00 00 00];
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8103-j457.dts b/arch/arm64/boot/dts/apple/t8103-j457.dts
new file mode 100644
index 000000000000..d7c622931627
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8103-j457.dts
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iMac (24-inch, 2x USB-C, M1, 2020)
+ *
+ * target-type: J457
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8103.dtsi"
+#include "t8103-jxxx.dtsi"
+
+/ {
+	compatible = "apple,j457", "apple,t8103", "apple,arm-platform";
+	model = "Apple iMac (24-inch, 2x USB-C, M1, 2020)";
+
+	aliases {
+		ethernet0 = &ethernet0;
+	};
+};
+
+/*
+ * Force the bus number assignments so that we can declare some of the
+ * on-board devices and properties that are populated by the bootloader
+ * (such as MAC addresses).
+ */
+
+&port02 {
+	bus-range = <3 3>;
+	ethernet0: ethernet@0,0 {
+		reg = <0x30000 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-mac-address = [00 10 18 00 00 00];
+	};
+};
+
+/*
+ * Remove unused PCIe port and disable the associated DART.
+ */
+
+&pcie0_dart_1 {
+	status = "disabled";
+};
+
+/delete-node/ &port01;
diff --git a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
new file mode 100644
index 000000000000..53d22b434d76
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple M1 Mac mini, MacBook Air/Pro, iMac 24" (M1, 2020/2021)
+ *
+ * This file contains parts common to all Apple M1 devices using the t8103.
+ *
+ * target-type: J274, J293, J313, J456, J457
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/ {
+	aliases {
+		serial0 = &serial0;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "serial0";
+
+		framebuffer0: framebuffer@0 {
+			compatible = "apple,simple-framebuffer", "simple-framebuffer";
+			reg = <0 0 0 0>; /* To be filled by loader */
+			/* Format properties will be added by loader */
+			status = "disabled";
+		};
+	};
+
+	memory@800000000 {
+		device_type = "memory";
+		reg = <0x8 0 0x2 0>; /* To be filled by loader */
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
+
+/*
+ * Force the bus number assignments so that we can declare some of the
+ * on-board devices and properties that are populated by the bootloader
+ * (such as MAC addresses).
+ */
+&port00 {
+	bus-range = <1 1>;
+};
-- 
2.34.0

