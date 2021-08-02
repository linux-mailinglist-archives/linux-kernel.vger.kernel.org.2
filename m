Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765823DD092
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhHBGbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:31:44 -0400
Received: from smtpbg127.qq.com ([109.244.180.96]:32151 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232329AbhHBGbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:31:38 -0400
X-QQ-mid: bizesmtp41t1627885387tsg72wqe
Received: from localhost.localdomain (unknown [113.89.245.207])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 02 Aug 2021 14:23:06 +0800 (CST)
X-QQ-SSF: 01100000002000206000B00A0000000
X-QQ-FEAT: HLwgFh8nePqoY9AsNVuAPiK/hEP+KHLgUQ2KoXT1MKtTjQmsmmSr49uIC06Hn
        Acfb5QGuqPU4LkBLdX9cPs5NTwS3npQSwpqWyWpg+FsAIRCsMUifBnUijvN172q3LbgHKyu
        CheZLE5lwpB3qdHM6AGBkQ801KIW2BbAhdcY5ifBsfaDXiQMI9AmQAogI0UfNuKn2Owdhud
        XjD940YJwSTwkhy0ApPShSoT75HpY9O3nNMhhkT7wa0rjnAwl9WwJOCSWZRjcEpke0nGLPi
        vsWErkZn6df9GNqjBRyRNYYE6OiXKRoSVsMLTlf9LA9/rcu94MNgdJDU07yBqVbE7FSqCV2
        k36yRK1AMn9OsbLplaQl/Dk2ZiEYXRxn5vccQqQ
X-QQ-GoodBg: 0
From:   Icenowy Zheng <icenowy@sipeed.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@sipeed.com>
Subject: [PATCH 15/17] arm64: allwinner: dts: add DTSI file for R329 SoC
Date:   Mon,  2 Aug 2021 14:22:10 +0800
Message-Id: <20210802062212.73220-16-icenowy@sipeed.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210802062212.73220-1-icenowy@sipeed.com>
References: <20210802062212.73220-1-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:sipeed.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner R329 is a new SoC focused on smart audio devices.

Add a DTSI file for it.

Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
---
 .../arm64/boot/dts/allwinner/sun50i-r329.dtsi | 244 ++++++++++++++++++
 1 file changed, 244 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-r329.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-r329.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-r329.dtsi
new file mode 100644
index 000000000000..bfefa2b734b0
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-r329.dtsi
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2021 Sipeed
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/sun50i-r329-ccu.h>
+#include <dt-bindings/reset/sun50i-r329-ccu.h>
+#include <dt-bindings/clock/sun50i-r329-r-ccu.h>
+#include <dt-bindings/reset/sun50i-r329-r-ccu.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <1>;
+			enable-method = "psci";
+		};
+	};
+
+	osc24M: osc24M_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "osc24M";
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		arm,no-tick-in-suspend;
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		pio: pinctrl@2000400 {
+			compatible = "allwinner,sun50i-r329-pinctrl";
+			reg = <0x02000400 0x400>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_APB1>, <&osc24M>, <&rtc 0>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+
+			uart0_pb_pins: uart0-pb-pins {
+				pins = "PB4", "PB5";
+				function = "uart0";
+			};
+
+			mmc0_pf_pins: mmc0-pf-pins {
+				pins = "PF0", "PF1", "PF2",
+				       "PF3", "PF4", "PF5";
+				function = "mmc0";
+			};
+
+			mmc1_clk_pg0: mmc1-clk-pg0 {
+				pins = "PG0";
+				function = "mmc1_clk";
+			};
+
+			mmc1_cmd_pg1: mmc1-clk-pg1 {
+				pins = "PG1";
+				function = "mmc1_cmd";
+			};
+
+			mmc1_d0_pg2: mmc1-clk-pg2 {
+				pins = "PG2";
+				function = "mmc1_d0";
+			};
+
+			mmc1_d1_pg3: mmc1-clk-pg3 {
+				pins = "PG3";
+				function = "mmc1_d1";
+			};
+
+			mmc1_d2_pg4: mmc1-clk-pg4 {
+				pins = "PG4";
+				function = "mmc1_d2";
+			};
+
+			mmc1_d3_pg5: mmc1-clk-pg5 {
+				pins = "PG5";
+				function = "mmc1_d3";
+			};
+		};
+
+		ccu: clock@2001000 {
+			compatible = "allwinner,sun50i-r329-ccu";
+			reg = <0x02001000 0x1000>;
+			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>;
+			clock-names = "hosc", "losc", "iosc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		uart0: serial@2500000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x02500000 0x400>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
+			status = "disabled";
+		};
+
+		uart1: serial@2500400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x02500400 0x400>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART1>;
+			resets = <&ccu RST_BUS_UART1>;
+			status = "disabled";
+		};
+
+		uart2: serial@2500800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x02500800 0x400>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART2>;
+			resets = <&ccu RST_BUS_UART2>;
+			status = "disabled";
+		};
+
+		uart3: serial@2500c00 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x02500c00 0x400>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART3>;
+			resets = <&ccu RST_BUS_UART3>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@3021000 {
+			compatible = "arm,gic-400";
+			reg = <0x03021000 0x1000>,
+			      <0x03022000 0x2000>,
+			      <0x03024000 0x2000>,
+			      <0x03026000 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		mmc0: mmc@4020000 {
+			compatible = "allwinner,sun50i-r329-mmc";
+			reg = <0x04020000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC0>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <150000000>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc1: mmc@4021000 {
+			compatible = "allwinner,sun50i-r329-mmc";
+			reg = <0x04021000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC1>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <150000000>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		r_ccu: clock@7010000 {
+			compatible = "allwinner,sun50i-r329-r-ccu";
+			reg = <0x07010000 0x10000>;
+			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>;
+			clock-names = "hosc", "losc", "iosc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		r_pio: pinctrl@7022000 {
+			compatible = "allwinner,sun50i-r329-r-pinctrl";
+			reg = <0x07022000 0x400>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_R_APB1>, <&osc24M>, <&rtc 0>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		rtc: rtc@7090000 {
+			compatible = "allwinner,sun50i-r329-rtc";
+			reg = <0x07090000 0x400>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			clock-output-names = "osc32k", "osc32k-out", "iosc";
+			#clock-cells = <1>;
+		};
+	};
+};
-- 
2.30.2

