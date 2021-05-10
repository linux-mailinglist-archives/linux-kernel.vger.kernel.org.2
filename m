Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349743791A9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbhEJO5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:57:15 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52066 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbhEJOzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:55:48 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14AEsapV054850;
        Mon, 10 May 2021 09:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620658476;
        bh=bGjnX6HohEZiHw/QVhGzR4FG7geX74SqjuYW6MnBxVw=;
        h=From:To:CC:Subject:Date;
        b=HQITo+MebdxNoFSZyaXRbm/Y0Bvez86NYKxmTac0JultDAPEkROAxUKlRml17S59K
         wZhMDNMEWmgLXWEVni1mBsJiEZy76/ACaidhWx9AbW+gZnChKEcRjnhBHqWiyT8Pnp
         PHlmTWLx/TQLgy3Y/M80KBjp52i7PpAm+5BVmNKI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14AEsak1087903
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 May 2021 09:54:36 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 10
 May 2021 09:54:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 10 May 2021 09:54:36 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14AEsa09029744;
        Mon, 10 May 2021 09:54:36 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <kristo@kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
CC:     <lokeshvutla@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am65|j721e|am64: Map the dma / navigator subsystem via explicit ranges
Date:   Mon, 10 May 2021 09:54:29 -0500
Message-ID: <20210510145429.8752-1-nm@ti.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using empty ranges property, lets map explicitly the address
range that is mapped onto the dma / navigator subsystems (navss/dmss).

This is also exposed via the dtbs_check with dt-schema newer than
2021.03 version by throwing out following:
arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml: bus@100000: main-navss:
{'type': 'object'} is not allowed for
{'compatible': ['simple-mfd'], '#address-cells': [[2]], .....

This has already been correctly done for J7200, however was missed for
other k3 SoCs. Fix that oversight.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

if possible, I'd like to pick this fixup for 5.13 window..

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi        | 4 ++--
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi        | 4 ++--
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi         | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index a49e41021573..bb19db04a746 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -42,12 +42,12 @@ gic_its: msi-controller@1820000 {
 		};
 	};
 
-	dmss: dmss {
+	dmss: bus@48000000 {
 		compatible = "simple-mfd";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		dma-ranges;
-		ranges;
+		ranges = <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>;
 
 		ti,sci-dev-id = <25>;
 
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 037f9776c4c8..fea8260d33a8 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -445,11 +445,11 @@ intr_main_gpio: interrupt-controller@a00000 {
 		ti,interrupt-ranges = <0 392 32>;
 	};
 
-	main-navss {
+	main_navss: bus@30800000 {
 		compatible = "simple-mfd";
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges;
+		ranges = <0x0 0x30800000 0x0 0x30800000 0x0 0xbc00000>;
 		dma-coherent;
 		dma-ranges;
 
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 0388c02c2203..f5b8ef2f5f77 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -116,11 +116,11 @@ adc {
 		};
 	};
 
-	mcu-navss {
+	mcu_navss: bus@28380000 {
 		compatible = "simple-mfd";
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges;
+		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
 		dma-coherent;
 		dma-ranges;
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 512371e36a30..b2d25af872e2 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -88,11 +88,11 @@ main_gpio_intr: interrupt-controller@a00000 {
 		ti,interrupt-ranges = <8 392 56>;
 	};
 
-	main-navss {
+	main_navss: bus@30000000 {
 		compatible = "simple-mfd";
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges;
+		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
 		dma-coherent;
 		dma-ranges;
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index ad12a5c9f209..172629fa3c7c 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -250,11 +250,11 @@ adc {
 		};
 	};
 
-	mcu-navss {
+	mcu_navss: bus@28380000 {
 		compatible = "simple-mfd";
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges;
+		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
 		dma-coherent;
 		dma-ranges;
 
-- 
2.31.0

