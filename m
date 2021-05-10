Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF7C3791AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbhEJO6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:58:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38944 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbhEJO4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:56:18 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14AEtAgh063061;
        Mon, 10 May 2021 09:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620658510;
        bh=CMzlHwBbMIyTAJyRKkiMWI78DsMwDCkvJgkn6jGfgm8=;
        h=From:To:CC:Subject:Date;
        b=irSiQZtLyNw9jtHFnMv9FA0D0zHdTKfLMQaEr3PqZAdNZaB9aP0epuswCsXXzi/Tz
         qwj02A8vzoauneCjPUalvnX6d+yqu2023v4pPiUNLTGk7/cSMWu+j3trLQ85Job83r
         +DNke0tApAlxqsuX+FQUn2mC/c6cVCf3xglry5vg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14AEtAZn089137
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 May 2021 09:55:10 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 10
 May 2021 09:55:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 10 May 2021 09:55:09 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14AEt9kU125448;
        Mon, 10 May 2021 09:55:09 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <kristo@kernel.org>, <grygorii.strashko@ti.com>
CC:     <lokeshvutla@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] arm64: dts: ti: k3*: Introduce reg definition for interrupt routers
Date:   Mon, 10 May 2021 09:55:08 -0500
Message-ID: <20210510145508.8994-1-nm@ti.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt routers are memory mapped peripherals, that are organized
in our dts bus hierarchy to closely represents the actual hardware
behavior.

However, without explicitly calling out the reg property, using
2021.03+ dt-schema package, this exposes the following problem with
dtbs_check:

/arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml: bus@100000:
interrupt-controller0: {'type': 'object'} is not allowed for
{'compatible': ['ti,sci-intr'], .....

Even though we don't use interrupt router directly via memory mapped
registers and have to use it via the system controller, the hardware
block is memory mapped, so describe the base address in device tree.

This is a valid, comprehensive description of hardware and permitted
by the existing ti,sci-intr schema.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

if possible, I'd like to pick this fixup for 5.13 window..

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi        | 3 ++-
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi         | 3 ++-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi        | 6 ++++--
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi      | 3 ++-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi       | 6 ++++--
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 3 ++-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       | 6 ++++--
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 3 ++-
 8 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index b2bcbf23eefd..a49e41021573 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -373,8 +373,9 @@ main_spi4: spi@20140000 {
 		clocks = <&k3_clks 145 0>;
 	};
 
-	main_gpio_intr: interrupt-controller0 {
+	main_gpio_intr: interrupt-controller@a00000 {
 		compatible = "ti,sci-intr";
+		reg = <0x00 0xa00000 0x00 0x800>;
 		ti,intr-trigger-type = <1>;
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
index 99e94dee1bd4..deb19ae5e168 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
@@ -74,8 +74,9 @@ mcu_spi1: spi@4b10000 {
 		clocks = <&k3_clks 148 0>;
 	};
 
-	mcu_gpio_intr: interrupt-controller1 {
+	mcu_gpio_intr: interrupt-controller@4210000 {
 		compatible = "ti,sci-intr";
+		reg = <0x00 0x04210000 0x00 0x200>;
 		ti,intr-trigger-type = <1>;
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index cb340d1b401f..037f9776c4c8 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -433,8 +433,9 @@ usb1_phy: phy@4110000 {
 		#phy-cells = <0>;
 	};
 
-	intr_main_gpio: interrupt-controller0 {
+	intr_main_gpio: interrupt-controller@a00000 {
 		compatible = "ti,sci-intr";
+		reg = <0x0 0xa00000 0x0 0x400>;
 		ti,intr-trigger-type = <1>;
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
@@ -454,8 +455,9 @@ main-navss {
 
 		ti,sci-dev-id = <118>;
 
-		intr_main_navss: interrupt-controller1 {
+		intr_main_navss: interrupt-controller@310e0000 {
 			compatible = "ti,sci-intr";
+			reg = <0x0 0x310e0000 0x0 0x2000>;
 			ti,intr-trigger-type = <4>;
 			interrupt-controller;
 			interrupt-parent = <&gic500>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index ed42f13e7663..62a18b110c52 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -69,8 +69,9 @@ wkup_i2c0: i2c@42120000 {
 		power-domains = <&k3_pds 115 TI_SCI_PD_EXCLUSIVE>;
 	};
 
-	intr_wkup_gpio: interrupt-controller2 {
+	intr_wkup_gpio: interrupt-controller@42200000 {
 		compatible = "ti,sci-intr";
+		reg = <0x42200000 0x200>;
 		ti,intr-trigger-type = <1>;
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index f86c493a44f1..4403ac0fc8a7 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -68,8 +68,9 @@ gic_its: msi-controller@1820000 {
 		};
 	};
 
-	main_gpio_intr: interrupt-controller0 {
+	main_gpio_intr: interrupt-controller@a00000 {
 		compatible = "ti,sci-intr";
+		reg = <0x00 0xa00000 0x00 0x800>;
 		ti,intr-trigger-type = <1>;
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
@@ -86,8 +87,9 @@ main_navss: bus@30000000 {
 		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
 		ti,sci-dev-id = <199>;
 
-		main_navss_intr: interrupt-controller1 {
+		main_navss_intr: interrupt-controller@310e0000 {
 			compatible = "ti,sci-intr";
+			reg = <0x00 0x310e0000 0x00 0x4000>;
 			ti,intr-trigger-type = <4>;
 			interrupt-controller;
 			interrupt-parent = <&gic500>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 5e74e43822c3..825b9f1931b7 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -96,8 +96,9 @@ mcu_uart0: serial@40a00000 {
 		clock-names = "fclk";
 	};
 
-	wkup_gpio_intr: interrupt-controller2 {
+	wkup_gpio_intr: interrupt-controller@42200000 {
 		compatible = "ti,sci-intr";
+		reg = <0x00 0x42200000 0x00 0x400>;
 		ti,intr-trigger-type = <1>;
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index c2aa45a3ac79..512371e36a30 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -76,8 +76,9 @@ gic_its: msi-controller@1820000 {
 		};
 	};
 
-	main_gpio_intr: interrupt-controller0 {
+	main_gpio_intr: interrupt-controller@a00000 {
 		compatible = "ti,sci-intr";
+		reg = <0x00 0xa00000 0x00 0x800>;
 		ti,intr-trigger-type = <1>;
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
@@ -97,8 +98,9 @@ main-navss {
 
 		ti,sci-dev-id = <199>;
 
-		main_navss_intr: interrupt-controller1 {
+		main_navss_intr: interrupt-controller@310e0000 {
 			compatible = "ti,sci-intr";
+			reg = <0x0 0x310e0000 0x0 0x4000>;
 			ti,intr-trigger-type = <4>;
 			interrupt-controller;
 			interrupt-parent = <&gic500>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index d56e3475aee7..ad12a5c9f209 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -96,8 +96,9 @@ mcu_uart0: serial@40a00000 {
 		clock-names = "fclk";
 	};
 
-	wkup_gpio_intr: interrupt-controller2 {
+	wkup_gpio_intr: interrupt-controller@42200000 {
 		compatible = "ti,sci-intr";
+		reg = <0x00 0x42200000 0x00 0x400>;
 		ti,intr-trigger-type = <1>;
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
-- 
2.31.0

