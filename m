Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B039245AF6B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 23:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbhKWWwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 17:52:50 -0500
Received: from soltyk.jannau.net ([144.76.91.90]:58854 "EHLO soltyk.jannau.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240026AbhKWWwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:52:41 -0500
Received: from coburn.home.jannau.net (p579ad520.dip0.t-ipconnect.de [87.154.213.32])
        by soltyk.jannau.net (Postfix) with ESMTPSA id DE370261B57;
        Tue, 23 Nov 2021 23:49:31 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] arm64: dts: apple: t8103: Add i2c nodes
Date:   Tue, 23 Nov 2021 23:49:24 +0100
Message-Id: <20211123224926.7722-4-j@jannau.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123224926.7722-1-j@jannau.net>
References: <20211123224926.7722-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple M1 has at least 5 i2c controllers. i2c0, i2c1 and i2c3 are used
on all M1 Mac devices. The 2020 Mac Mini uses i2c2 and the 13-inch
MacBook Pro uses i2c2 and i2c4.

Signed-off-by: Janne Grunau <j@jannau.net>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Acked-by: Hector Martin <marcan@marcan.st>
---
 - fixed node order by address in t8103.dtsi
 - removed clock-names property from i2c nodes
 - added Reviewed-by and Acked-by tags

 arch/arm64/boot/dts/apple/t8103-j274.dts |  4 ++
 arch/arm64/boot/dts/apple/t8103-j293.dts |  8 +++
 arch/arm64/boot/dts/apple/t8103.dtsi     | 87 ++++++++++++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103-j274.dts b/arch/arm64/boot/dts/apple/t8103-j274.dts
index 9e01ef70039d..2cd429efba5b 100644
--- a/arch/arm64/boot/dts/apple/t8103-j274.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j274.dts
@@ -39,3 +39,7 @@ ethernet0: ethernet@0,0 {
 		local-mac-address = [00 10 18 00 00 00];
 	};
 };
+
+&i2c2 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8103-j293.dts b/arch/arm64/boot/dts/apple/t8103-j293.dts
index 466035f00b69..49cdf4b560a3 100644
--- a/arch/arm64/boot/dts/apple/t8103-j293.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j293.dts
@@ -31,3 +31,11 @@ &pcie0_dart_2 {
 
 /delete-node/ &port01;
 /delete-node/ &port02;
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index c320c8baeb41..c62d9082c6a3 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -111,6 +111,68 @@ soc {
 		ranges;
 		nonposted-mmio;
 
+		i2c0: i2c@235010000 {
+			compatible = "apple,t8103-i2c", "apple,i2c";
+			reg = <0x2 0x35010000 0x0 0x4000>;
+			clocks = <&clk24>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 627 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c0_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+		};
+
+		i2c1: i2c@235014000 {
+			compatible = "apple,t8103-i2c", "apple,i2c";
+			reg = <0x2 0x35014000 0x0 0x4000>;
+			clocks = <&clk24>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 628 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c1_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+		};
+
+		i2c2: i2c@235018000 {
+			compatible = "apple,t8103-i2c", "apple,i2c";
+			reg = <0x2 0x35018000 0x0 0x4000>;
+			clocks = <&clk24>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 629 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c2_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			status = "disabled"; /* not used in all devices */
+		};
+
+		i2c3: i2c@23501c000 {
+			compatible = "apple,t8103-i2c", "apple,i2c";
+			reg = <0x2 0x3501c000 0x0 0x4000>;
+			clocks = <&clk24>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 630 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c3_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+		};
+
+		i2c4: i2c@235020000 {
+			compatible = "apple,t8103-i2c", "apple,i2c";
+			reg = <0x2 0x35020000 0x0 0x4000>;
+			clocks = <&clk24>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 631 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c4_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			status = "disabled"; /* only used in J293 */
+		};
+
 		serial0: serial@235200000 {
 			compatible = "apple,s5l-uart";
 			reg = <0x2 0x35200000 0x0 0x1000>;
@@ -153,6 +215,31 @@ pinctrl_ap: pinctrl@23c100000 {
 				     <AIC_IRQ 195 IRQ_TYPE_LEVEL_HIGH>,
 				     <AIC_IRQ 196 IRQ_TYPE_LEVEL_HIGH>;
 
+			i2c0_pins: i2c0-pins {
+				pinmux = <APPLE_PINMUX(192, 1)>,
+					 <APPLE_PINMUX(188, 1)>;
+			};
+
+			i2c1_pins: i2c1-pins {
+				pinmux = <APPLE_PINMUX(201, 1)>,
+					 <APPLE_PINMUX(199, 1)>;
+			};
+
+			i2c2_pins: i2c2-pins {
+				pinmux = <APPLE_PINMUX(163, 1)>,
+					 <APPLE_PINMUX(162, 1)>;
+			};
+
+			i2c3_pins: i2c3-pins {
+				pinmux = <APPLE_PINMUX(73, 1)>,
+					 <APPLE_PINMUX(72, 1)>;
+			};
+
+			i2c4_pins: i2c4-pins {
+				pinmux = <APPLE_PINMUX(135, 1)>,
+					 <APPLE_PINMUX(134, 1)>;
+			};
+
 			pcie_pins: pcie-pins {
 				pinmux = <APPLE_PINMUX(150, 1)>,
 					 <APPLE_PINMUX(151, 1)>,
-- 
2.34.0

