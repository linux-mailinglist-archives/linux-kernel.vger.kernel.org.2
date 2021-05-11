Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A6337AF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhEKTti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:49:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34426 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhEKTth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:49:37 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14BJmNqg073029;
        Tue, 11 May 2021 14:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620762503;
        bh=hzvT5WuMiuQH1Vq1OyjpWEdZemybAFC+dULLzT8TK+0=;
        h=From:To:CC:Subject:Date;
        b=DOCgDjfP0U+445UQM1q1uy96lDviDZFl4w690lnILs5h16Vq5RJANgilUTF9fSRyI
         JEg1R4j6xOvDU8+BIA6uevb4JrsNSLPVnis9cWy0Gsb/2pIajle+xq7unnTqlVZtz8
         l4D2aqM51uLRJKBExidLzOmBnjitUGtw1/Kypb+U=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14BJmMKE031884
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 May 2021 14:48:22 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 11
 May 2021 14:48:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 11 May 2021 14:48:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14BJmMTr067209;
        Tue, 11 May 2021 14:48:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <kristo@kernel.org>, <lokeshvutla@ti.com>
CC:     <grygorii.strashko@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2] arm64: dts: ti: k3*: Introduce reg definition for interrupt routers
Date:   Tue, 11 May 2021 14:48:21 -0500
Message-ID: <20210511194821.13919-1-nm@ti.com>
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

Reviewed-by: Tero Kristo <kristo@kernel.org>
Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Changes since v1:
* updates to register to be consistent (use 0x%08x formatting).

V1: https://lore.kernel.org/linux-arm-kernel/20210510145508.8994-1-nm@ti.com/
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
index b2bcbf23eefd..5075a2143641 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -373,8 +373,9 @@ main_spi4: spi@20140000 {
 		clocks = <&k3_clks 145 0>;
 	};
 
-	main_gpio_intr: interrupt-controller0 {
+	main_gpio_intr: interrupt-controller@a00000 {
 		compatible = "ti,sci-intr";
+		reg = <0x00 0x00a00000 0x00 0x800>;
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
index cb340d1b401f..cbdb6331de11 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -433,8 +433,9 @@ usb1_phy: phy@4110000 {
 		#phy-cells = <0>;
 	};
 
-	intr_main_gpio: interrupt-controller0 {
+	intr_main_gpio: interrupt-controller@a00000 {
 		compatible = "ti,sci-intr";
+		reg = <0x0 0x00a00000 0x0 0x400>;
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
index f86c493a44f1..7a6c2054c5ed 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -68,8 +68,9 @@ gic_its: msi-controller@1820000 {
 		};
 	};
 
-	main_gpio_intr: interrupt-controller0 {
+	main_gpio_intr: interrupt-controller@a00000 {
 		compatible = "ti,sci-intr";
+		reg = <0x00 0x00a00000 0x00 0x800>;
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
index c2aa45a3ac79..d5e41f665794 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -76,8 +76,9 @@ gic_its: msi-controller@1820000 {
 		};
 	};
 
-	main_gpio_intr: interrupt-controller0 {
+	main_gpio_intr: interrupt-controller@a00000 {
 		compatible = "ti,sci-intr";
+		reg = <0x00 0x00a00000 0x00 0x800>;
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

