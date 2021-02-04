Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4052D30FEB7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBDUoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:44:55 -0500
Received: from marcansoft.com ([212.63.210.85]:33362 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhBDUmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:42:09 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id EBE1D4286C;
        Thu,  4 Feb 2021 20:41:05 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Hector Martin <marcan@marcan.st>, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1) devicetree
Date:   Fri,  5 Feb 2021 05:39:51 +0900
Message-Id: <20210204203951.52105-19-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204203951.52105-1-marcan@marcan.st>
References: <20210204203951.52105-1-marcan@marcan.st>
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
 arch/arm64/boot/dts/apple/apple-j274.dts | 143 +++++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/Makefile
 create mode 100644 arch/arm64/boot/dts/apple/apple-j274.dts

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a54ee5747d3..5481b5bc2ef7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1635,6 +1635,7 @@ C:	irc://chat.freenode.net/asahi-dev
 T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/AAPL.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/AAPL,aic.yaml
+F:	arch/arm64/boot/dts/AAPL/
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
index 000000000000..238a1bcee066
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/apple-j274.dts
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021 Hector Martin <marcan@marcan.st>
+ */
+
+/dts-v1/;
+#include <dt-bindings/interrupt-controller/apple-aic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "Apple Mac Mini M1 2020";
+	compatible = "AAPL,j274", "AAPL,m1", "AAPL,arm-platform";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bootargs = "earlycon";
+		stdout-path = "serial0:1500000";
+
+		framebuffer0: framebuffer@0 {
+			compatible = "AAPL,simple-framebuffer", "simple-framebuffer";
+			reg = <0 0 0 0>; // To be filled by loader
+			// Format properties will be added by loader
+			status = "disabled";
+		};
+	};
+
+	memory@800000000 {
+		device_type = "memory";
+		reg = <0 0 0 0>; // To be filled by loader
+	};
+
+	aliases {
+		serial0 = &serial0;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "AAPL,icestorm";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; // To be filled by loader
+		};
+		cpu1: cpu@1 {
+			compatible = "AAPL,icestorm";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; // To be filled by loader
+		};
+		cpu2: cpu@2 {
+			compatible = "AAPL,icestorm";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; // To be filled by loader
+		};
+		cpu3: cpu@3 {
+			compatible = "AAPL,icestorm";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; // To be filled by loader
+		};
+		cpu4: cpu@10100 {
+			compatible = "AAPL,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10100>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; // To be filled by loader
+		};
+		cpu5: cpu@10101 {
+			compatible = "AAPL,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10101>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; // To be filled by loader
+		};
+		cpu6: cpu@10102 {
+			compatible = "AAPL,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10102>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; // To be filled by loader
+		};
+		cpu7: cpu@10103 {
+			compatible = "AAPL,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10103>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; // To be filled by loader
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ 0 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_FIQ 0 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_FIQ 1 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_FIQ 0 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	clk24: clk24 {
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
+		ranges;
+
+		aic: interrupt-controller@23b100000 {
+			compatible = "AAPL,m1-aic", "AAPL,aic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x2 0x3b100000 0x0 0x8000>;
+		};
+
+		serial0: serial@235200000 {
+			compatible = "AAPL,s5l-uart";
+			reg = <0x2 0x35200000 0x0 0x1000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 605 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk24>, <&clk24>;
+			clock-names = "uart", "clk_uart_baud0";
+		};
+
+	};
+};
-- 
2.30.0

