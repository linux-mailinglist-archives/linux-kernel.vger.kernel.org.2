Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54DD39DE01
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhFGNsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:48:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47634 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhFGNsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:48:02 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 157Dk5Kw068074;
        Mon, 7 Jun 2021 08:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623073565;
        bh=9dGfQaWDsHiDoiQDDpPKv07yVhkuZ6gXKAnZZHp17yQ=;
        h=From:To:CC:Subject:Date;
        b=gFHjzMNZmISIdvakz+70mFeTq0dAOZsI4zHp/2orreYqYH2bNMrTl79EYj3qVBl8U
         10UO6b6fSElzsZjpFJ7Ruuo8Jtp94fkkYsKOsAb+jyhcwJB9OfT15jqIDsmEU2Zll+
         Y5LA/2x/16AXt0qgeUkSF40e+4D5PsXmv/rdDNaI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 157Dk55c013957
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jun 2021 08:46:05 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 08:46:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 7 Jun 2021 08:46:04 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 157Dk1F6050749;
        Mon, 7 Jun 2021 08:46:02 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: dts: ti: Drop reg-io-width/reg-shift from UART nodes
Date:   Mon, 7 Jun 2021 19:15:58 +0530
Message-ID: <20210607134558.23704-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8250_omap compatible UART IPs on all SoCs have registers aligned at 4
byte address boundary and constant byte addressability. Thus there is no
need for reg-io-width or reg-shift DT properties.  These properties are
not used by 8250_omap driver nor documented as part of binding document.
Therefore drop them.

This is in preparation to move omap-serial.txt to YAML format.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      | 14 -------------
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi       |  4 ----
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  6 ------
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  2 --
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |  2 --
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 20 -------------------
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |  4 ----
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 20 -------------------
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  4 ----
 9 files changed, 76 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index ca59d1f711f8..f1c42ef05e52 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -189,8 +189,6 @@ phy_gmii_sel: phy@4044 {
 	main_uart0: serial@2800000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -202,8 +200,6 @@ main_uart0: serial@2800000 {
 	main_uart1: serial@2810000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x02810000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -215,8 +211,6 @@ main_uart1: serial@2810000 {
 	main_uart2: serial@2820000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x02820000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -228,8 +222,6 @@ main_uart2: serial@2820000 {
 	main_uart3: serial@2830000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x02830000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -241,8 +233,6 @@ main_uart3: serial@2830000 {
 	main_uart4: serial@2840000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x02840000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -254,8 +244,6 @@ main_uart4: serial@2840000 {
 	main_uart5: serial@2850000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x02850000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -267,8 +255,6 @@ main_uart5: serial@2850000 {
 	main_uart6: serial@2860000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x02860000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
index deb19ae5e168..20274df5f216 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
@@ -9,8 +9,6 @@ &cbass_mcu {
 	mcu_uart0: serial@4a00000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x04a00000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -22,8 +20,6 @@ mcu_uart0: serial@4a00000 {
 	mcu_uart1: serial@4a10000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x04a10000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 6cd3131eb9ff..05964943a4a4 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -84,8 +84,6 @@ serdes1: serdes@910000 {
 	main_uart0: serial@2800000 {
 		compatible = "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -95,8 +93,6 @@ main_uart0: serial@2800000 {
 	main_uart1: serial@2810000 {
 		compatible = "ti,am654-uart";
 		reg = <0x00 0x02810000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		power-domains = <&k3_pds 147 TI_SCI_PD_EXCLUSIVE>;
@@ -105,8 +101,6 @@ main_uart1: serial@2810000 {
 	main_uart2: serial@2820000 {
 		compatible = "ti,am654-uart";
 		reg = <0x00 0x02820000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		power-domains = <&k3_pds 148 TI_SCI_PD_EXCLUSIVE>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index f5b8ef2f5f77..c93ff1520a0e 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -23,8 +23,6 @@ phy_gmii_sel: phy@4040 {
 	mcu_uart0: serial@40a00000 {
 		compatible = "ti,am654-uart";
 			reg = <0x00 0x40a00000 0x00 0x100>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
 			interrupts = <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <96000000>;
 			current-speed = <115200>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index 7cb864b4d74a..9d21cdf6fce8 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -50,8 +50,6 @@ wkup_pmx0: pinctrl@4301c000 {
 	wkup_uart0: serial@42300000 {
 		compatible = "ti,am654-uart";
 		reg = <0x42300000 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 19fea8adbcff..5a2f75a455c5 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -301,8 +301,6 @@ main_pmx0: pinctrl@11c000 {
 	main_uart0: serial@2800000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -314,8 +312,6 @@ main_uart0: serial@2800000 {
 	main_uart1: serial@2810000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02810000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -327,8 +323,6 @@ main_uart1: serial@2810000 {
 	main_uart2: serial@2820000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02820000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -340,8 +334,6 @@ main_uart2: serial@2820000 {
 	main_uart3: serial@2830000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02830000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -353,8 +345,6 @@ main_uart3: serial@2830000 {
 	main_uart4: serial@2840000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02840000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -366,8 +356,6 @@ main_uart4: serial@2840000 {
 	main_uart5: serial@2850000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02850000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -379,8 +367,6 @@ main_uart5: serial@2850000 {
 	main_uart6: serial@2860000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02860000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -392,8 +378,6 @@ main_uart6: serial@2860000 {
 	main_uart7: serial@2870000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02870000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -405,8 +389,6 @@ main_uart7: serial@2870000 {
 	main_uart8: serial@2880000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02880000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -418,8 +400,6 @@ main_uart8: serial@2880000 {
 	main_uart9: serial@2890000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02890000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 5663fe3ea466..5f069b55f449 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -73,8 +73,6 @@ mcu_ram: sram@41c00000 {
 	wkup_uart0: serial@42300000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x42300000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -86,8 +84,6 @@ wkup_uart0: serial@42300000 {
 	mcu_uart0: serial@40a00000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x40a00000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 846 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <96000000>;
 		current-speed = <115200>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 3bcafe4c1742..8a0e29636074 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -775,8 +775,6 @@ pcie3_ep: pcie-ep@2930000 {
 	main_uart0: serial@2800000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -788,8 +786,6 @@ main_uart0: serial@2800000 {
 	main_uart1: serial@2810000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02810000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -801,8 +797,6 @@ main_uart1: serial@2810000 {
 	main_uart2: serial@2820000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02820000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -814,8 +808,6 @@ main_uart2: serial@2820000 {
 	main_uart3: serial@2830000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02830000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -827,8 +819,6 @@ main_uart3: serial@2830000 {
 	main_uart4: serial@2840000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02840000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -840,8 +830,6 @@ main_uart4: serial@2840000 {
 	main_uart5: serial@2850000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02850000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -853,8 +841,6 @@ main_uart5: serial@2850000 {
 	main_uart6: serial@2860000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02860000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -866,8 +852,6 @@ main_uart6: serial@2860000 {
 	main_uart7: serial@2870000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02870000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -879,8 +863,6 @@ main_uart7: serial@2870000 {
 	main_uart8: serial@2880000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02880000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -892,8 +874,6 @@ main_uart8: serial@2880000 {
 	main_uart9: serial@2890000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02890000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 5e825e4d0306..d2dceda72fe9 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -73,8 +73,6 @@ mcu_ram: sram@41c00000 {
 	wkup_uart0: serial@42300000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x42300000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
@@ -86,8 +84,6 @@ wkup_uart0: serial@42300000 {
 	mcu_uart0: serial@40a00000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x40a00000 0x00 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 846 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <96000000>;
 		current-speed = <115200>;
-- 
2.31.1

