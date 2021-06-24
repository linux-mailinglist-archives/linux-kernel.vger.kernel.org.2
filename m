Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826793B398D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 00:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhFXWw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 18:52:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232908AbhFXWwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 18:52:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E870F613AD;
        Thu, 24 Jun 2021 22:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624575001;
        bh=g2B8hrmFul6ifZ0UpMp8TtuzYtUGgNYkA4J7r0w/K00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KAgdchjX/TbFLrYvQCMWLU60VGdlkEbic0sIqDNJ12pJua+vj9623LFfF19pJJhtX
         1cRVeslBYOE0ouf2l0FPOJMT0ifZlpvXEqPXxq9PvhfZf+pV8JuY8W3afEfAIDIclW
         1iTCPW/ZJvKzdfSkosMdeJ44AwkK+vaAVvrIBis9YdsrRTzx16zMYdfRvx0kVlyk/r
         W4OptIEYZBbSNx5cYygdZMvyhwQN0d8fS1MtT0IoArcaV1VEgsOlaIZucxDRHSd2PB
         oSaXvVMNz0+gradf8CDZWiYEZBoDUg5KpcV/0/ITAB7gAdY2paLzFa6zIqFckR2Uor
         xI3gVGdHGMOqw==
Received: by pali.im (Postfix)
        id A5EBF8A3; Fri, 25 Jun 2021 00:50:00 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/10] arm64: dts: marvell: armada-37xx: add device node for UART clock and use it
Date:   Fri, 25 Jun 2021 00:49:08 +0200
Message-Id: <20210624224909.6350-10-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624224909.6350-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change defines DT node for UART clock "marvell,armada-3700-uart-clock"
and use this UART clock as a base clock for all UART devices.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts    |  4 ++++
 .../boot/dts/marvell/armada-3720-espressobin.dtsi |  4 ++++
 .../boot/dts/marvell/armada-3720-turris-mox.dts   |  4 ++++
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts  |  4 ++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi      | 15 +++++++++++++--
 5 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 3e5789f37206..accf014a6a1e 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -191,6 +191,10 @@
 	};
 };
 
+&uartclk {
+	status = "okay";
+};
+
 /*
  * Exported on the micro USB connector CON30(V2.0)/CON32(V1.4) through
  * an FTDI (also on CON24(V2.0)/CON26(V1.4)).
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index 5fc613d24151..d03c7cdfbfb3 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -117,6 +117,10 @@
 	};
 };
 
+&uartclk {
+	status = "okay";
+};
+
 /* Exported on the micro USB connector J5 through an FTDI */
 &uart0 {
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 52070dd0b7ee..62d56951f5d6 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -167,6 +167,10 @@
 	status = "disabled";
 };
 
+&uartclk {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index 95d46e8d081c..c8217440b8dd 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -183,6 +183,10 @@
 	phy-names = "usb2-utmi-otg-phy";
 };
 
+&uartclk {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 20dd9d9e9d58..d9bdd374cf45 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -132,10 +132,21 @@
 				reg = <0x11500 0x40>;
 			};
 
+			uartclk: uartclk@12000 {
+				compatible = "marvell,armada-3700-uart-clock";
+				reg = <0x12010 0x4>, <0x12210 0x4>;
+				clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
+					<&tbg 3>, <&xtalclk>;
+				clock-names = "TBG-A-P", "TBG-B-P", "TBG-A-S",
+					"TBG-B-S", "xtal";
+				#clock-cells = <1>;
+				status = "disabled";
+			};
+
 			uart0: serial@12000 {
 				compatible = "marvell,armada-3700-uart";
 				reg = <0x12000 0x18>;
-				clocks = <&xtalclk>;
+				clocks = <&uartclk 0>;
 				interrupts =
 				<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
@@ -147,7 +158,7 @@
 			uart1: serial@12200 {
 				compatible = "marvell,armada-3700-uart-ext";
 				reg = <0x12200 0x30>;
-				clocks = <&xtalclk>;
+				clocks = <&uartclk 1>;
 				interrupts =
 				<GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
 				<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
-- 
2.20.1

