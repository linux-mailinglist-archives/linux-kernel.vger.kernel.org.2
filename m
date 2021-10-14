Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF5A42D44D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhJNH6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:58:47 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:47556 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230167AbhJNH6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:58:40 -0400
X-UUID: 5e000e99e5e5444fa746dd55cf9f36fb-20211014
X-UUID: 5e000e99e5e5444fa746dd55cf9f36fb-20211014
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 368425434; Thu, 14 Oct 2021 15:56:32 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 14 Oct 2021 15:56:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 Oct
 2021 15:56:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Oct 2021 15:56:31 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        "Weiyi Lu" <weiyi.lu@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     John Crispin <john@phrozen.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        "Sam Shih" <sam.shih@mediatek.com>
Subject: [PATCH v4 4/5] arm64: dts: mediatek: add clock support for mt7986a
Date:   Thu, 14 Oct 2021 15:56:19 +0800
Message-ID: <20211014075620.17563-5-sam.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211014075620.17563-1-sam.shih@mediatek.com>
References: <20211014075620.17563-1-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock controller nodes, include 40M clock source, topckgen,
infracfg, apmixedsys and ethernet subsystem.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 68 +++++++++++++++++++++--
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 75912bcf6c9c..a8cf0eb79688 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/mt7986-clk.h>
 
 / {
 	compatible = "mediatek,mt7986a";
@@ -13,10 +14,11 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	system_clk: dummy40m {
+	clk40m: oscillator@0 {
 		compatible = "fixed-clock";
 		clock-frequency = <40000000>;
 		#clock-cells = <0>;
+		clock-output-names = "clkxtal";
 	};
 
 	cpus {
@@ -99,6 +101,18 @@ gic: interrupt-controller@c000000 {
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		infracfg: infracfg@10001000 {
+			compatible = "mediatek,mt7986-infracfg", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		topckgen: topckgen@1001b000 {
+			compatible = "mediatek,mt7986-topckgen", "syscon";
+			reg = <0 0x1001B000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		watchdog: watchdog@1001c000 {
 			compatible = "mediatek,mt7986-wdt",
 				     "mediatek,mt6589-wdt";
@@ -108,11 +122,31 @@ watchdog: watchdog@1001c000 {
 			status = "disabled";
 		};
 
+		apmixedsys: apmixedsys@1001e000 {
+			compatible = "mediatek,mt7986-apmixedsys";
+			reg = <0 0x1001E000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		sgmiisys0: syscon@10060000 {
+			compatible = "mediatek,mt7986-sgmiisys_0",
+				     "syscon";
+			reg = <0 0x10060000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		sgmiisys1: syscon@10070000 {
+			compatible = "mediatek,mt7986-sgmiisys_1",
+				     "syscon";
+			reg = <0 0x10070000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		trng: trng@1020f000 {
 			compatible = "mediatek,mt7986-rng",
 				     "mediatek,mt7623-rng";
 			reg = <0 0x1020f000 0 0x100>;
-			clocks = <&system_clk>;
+			clocks = <&infracfg CLK_INFRA_TRNG_CK>;
 			clock-names = "rng";
 			status = "disabled";
 		};
@@ -122,7 +156,13 @@ uart0: serial@11002000 {
 				     "mediatek,mt6577-uart";
 			reg = <0 0x11002000 0 0x400>;
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&system_clk>;
+			clocks = <&infracfg CLK_INFRA_UART0_SEL>,
+				 <&infracfg CLK_INFRA_UART0_CK>;
+			clock-names = "baud", "bus";
+			assigned-clocks = <&topckgen CLK_TOP_UART_SEL>,
+					  <&infracfg CLK_INFRA_UART0_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_XTAL>,
+						 <&topckgen CLK_TOP_UART_SEL>;
 			status = "disabled";
 		};
 
@@ -131,7 +171,11 @@ uart1: serial@11003000 {
 				     "mediatek,mt6577-uart";
 			reg = <0 0x11003000 0 0x400>;
 			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&system_clk>;
+			clocks = <&infracfg CLK_INFRA_UART1_SEL>,
+				 <&infracfg CLK_INFRA_UART1_CK>;
+			clock-names = "baud", "bus";
+			assigned-clocks = <&infracfg CLK_INFRA_UART1_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_F26M_SEL>;
 			status = "disabled";
 		};
 
@@ -140,10 +184,24 @@ uart2: serial@11004000 {
 				     "mediatek,mt6577-uart";
 			reg = <0 0x11004000 0 0x400>;
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&system_clk>;
+			clocks = <&infracfg CLK_INFRA_UART2_SEL>,
+				 <&infracfg CLK_INFRA_UART2_CK>;
+			clock-names = "baud", "bus";
+			assigned-clocks = <&infracfg CLK_INFRA_UART2_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_F26M_SEL>;
 			status = "disabled";
 		};
 
+		ethsys: syscon@15000000 {
+			 #address-cells = <1>;
+			 #size-cells = <1>;
+			 compatible = "mediatek,mt7986-ethsys",
+				      "syscon";
+			 reg = <0 0x15000000 0 0x1000>;
+			 #clock-cells = <1>;
+			 #reset-cells = <1>;
+		};
+
 	};
 
 };
-- 
2.29.2

