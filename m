Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB433821EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 01:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhEPXHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 19:07:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:43998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231887AbhEPXHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 19:07:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D5ABB1D0;
        Sun, 16 May 2021 23:06:20 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org
Subject: [PATCH 3/9] arm64: dts: rockchip: Prepare Rockchip RK1808
Date:   Mon, 17 May 2021 01:05:45 +0200
Message-Id: <20210516230551.12469-4-afaerber@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516230551.12469-1-afaerber@suse.de>
References: <20210516230551.12469-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an initial Device Tree for Rockchip RK1808 SoC.
Based on shipping TB-RK1808M0 DTB.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm64/boot/dts/rockchip/rk1808.dtsi | 203 +++++++++++++++++++++++
 1 file changed, 203 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk1808.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk1808.dtsi b/arch/arm64/boot/dts/rockchip/rk1808.dtsi
new file mode 100644
index 000000000000..af2b51afda7d
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk1808.dtsi
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2021 Andreas Färber
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible = "rockchip,rk1808";
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+		serial7 = &uart7;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP>;
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			CPU_SLEEP: cpu-sleep {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x10000>;
+				entry-latency-us = <120>;
+				exit-latency-us = <250>;
+				min-residency-us = <900>;
+			};
+		};
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a35-pmu";
+		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+		arm,no-tick-in-suspend;
+	};
+
+	xin24m: xin24m {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		#clock-cells = <0>;
+		clock-output-names = "xin24m";
+	};
+
+	firmware {
+		psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+
+		tee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		system_sram: sram@fec00000 {
+			compatible = "mmio-sram";
+			reg = <0xfec00000 0x200000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xfec00000 0x200000>;
+		};
+
+		gic: interrupt-controller@ff100000 {
+			compatible = "arm,gic-v3";
+			reg = <0xff100000 0x10000>, /* GICD */
+			      <0xff140000 0xc0000>, /* GICR */
+			      <0xff300000 0x10000>, /* GICC */
+			      <0xff310000 0x10000>, /* GICH */
+			      <0xff320000 0x10000>; /* GICV */
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			gic_its: msi-controller@ff120000 {
+				compatible = "arm,gic-v3-its";
+				reg = <0xff120000 0x20000>;
+				msi-controller;
+				#msi-cells = <1>;
+			};
+		};
+
+		uart0: serial@ff430000 {
+			compatible = "rockchip,rk1808-uart", "snps,dw-apb-uart";
+			reg = <0xff430000 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart1: serial@ff540000 {
+			compatible = "rockchip,rk1808-uart", "snps,dw-apb-uart";
+			reg = <0xff540000 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart2: serial@ff550000 {
+			compatible = "rockchip,rk1808-uart", "snps,dw-apb-uart";
+			reg = <0xff550000 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart3: serial@ff560000 {
+			compatible = "rockchip,rk1808-uart", "snps,dw-apb-uart";
+			reg = <0xff560000 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart4: serial@ff570000 {
+			compatible = "rockchip,rk1808-uart", "snps,dw-apb-uart";
+			reg = <0xff570000 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart5: serial@ff5a0000 {
+			compatible = "rockchip,rk1808-uart", "snps,dw-apb-uart";
+			reg = <0xff5a0000 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart6: serial@ff5b0000 {
+			compatible = "rockchip,rk1808-uart", "snps,dw-apb-uart";
+			reg = <0xff5b0000 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		uart7: serial@ff5c0000 {
+			compatible = "rockchip,rk1808-uart", "snps,dw-apb-uart";
+			reg = <0xff5c0000 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.31.1

