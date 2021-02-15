Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D21D31B92F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhBOM1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhBOMUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:20:24 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362AEC061788;
        Mon, 15 Feb 2021 04:19:44 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8D72A4258F;
        Mon, 15 Feb 2021 12:19:38 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/25] arm64: apple: Add initial Mac Mini 2020 (M1) devicetree
Date:   Mon, 15 Feb 2021 21:17:13 +0900
Message-Id: <20210215121713.57687-26-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215121713.57687-1-marcan@marcan.st>
References: <20210215121713.57687-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This currently supports:

* SMP (via spin-tables)
* AIC IRQs
* Serial (with earlycon)
* Framebuffer

A number of properties are dynamic, and based on system firmware
decisions that vary from version to version. These are expected
to be filled in by the loader.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 MAINTAINERS                              |   1 +
 arch/arm64/boot/dts/Makefile             |   1 +
 arch/arm64/boot/dts/apple/Makefile       |   2 +
 arch/arm64/boot/dts/apple/apple-j274.dts |  41 ++++++++
 arch/arm64/boot/dts/apple/apple-m1.dtsi  | 124 +++++++++++++++++++++++
 5 files changed, 169 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/Makefile
 create mode 100644 arch/arm64/boot/dts/apple/apple-j274.dts
 create mode 100644 arch/arm64/boot/dts/apple/apple-m1.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index a8f258fbb5f1..87db1c947f45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1635,6 +1635,7 @@ C:	irc://chat.freenode.net/asahi-dev
 T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+F:	arch/arm64/boot/dts/apple/
 F:	arch/arm64/include/asm/sysreg_apple.h
 F:	drivers/irqchip/irq-apple-aic.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 9b1170658d60..64f055d94948 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -6,6 +6,7 @@ subdir-y += amazon
 subdir-y += amd
 subdir-y += amlogic
 subdir-y += apm
+subdir-y += apple
 subdir-y += arm
 subdir-y += bitmain
 subdir-y += broadcom
diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
new file mode 100644
index 000000000000..ec03c474efd4
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_APPLE) += apple-j274.dtb
diff --git a/arch/arm64/boot/dts/apple/apple-j274.dts b/arch/arm64/boot/dts/apple/apple-j274.dts
new file mode 100644
index 000000000000..9a1be91a2cf0
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/apple-j274.dts
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "apple-m1.dtsi"
+
+/ {
+	compatible = "apple,j274", "apple,m1", "apple,arm-platform";
+	model = "Apple Mac Mini M1 2020";
+
+	aliases {
+		serial0 = &serial0;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "serial0:1500000";
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
+		reg = <0 0 0 0>; /* To be filled by loader */
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/apple-m1.dtsi b/arch/arm64/boot/dts/apple/apple-m1.dtsi
new file mode 100644
index 000000000000..45c87771b057
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/apple-m1.dtsi
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <dt-bindings/interrupt-controller/apple-aic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible = "apple,m1", "apple,arm-platform";
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "apple,icestorm";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+		cpu1: cpu@1 {
+			compatible = "apple,icestorm";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+		cpu2: cpu@2 {
+			compatible = "apple,icestorm";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+		cpu3: cpu@3 {
+			compatible = "apple,icestorm";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+		cpu4: cpu@10100 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10100>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+		cpu5: cpu@10101 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10101>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+		cpu6: cpu@10102 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10102>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+		cpu7: cpu@10103 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10103>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&aic>;
+		interrupt-names = "hyp-phys", "hyp-virt", "phys", "virt";
+		interrupts = <AIC_FIQ AIC_TMR_HV_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_HV_VIRT IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	clk24: clock-24m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "clk24";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges;
+		nonposted-mmio;
+
+		aic: interrupt-controller@23b100000 {
+			compatible = "apple,m1-aic", "apple,aic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x2 0x3b100000 0x0 0x8000>;
+		};
+
+		serial0: serial@235200000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x2 0x35200000 0x0 0x1000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 605 IRQ_TYPE_LEVEL_HIGH>;
+			/*
+			 * TODO: figure out the clocking properly, there may
+			 * be a third selectable clock.
+			 */
+			clocks = <&clk24>, <&clk24>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+	};
+};
-- 
2.30.0

