Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5298B39A356
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhFCOg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:36:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47334 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhFCOg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:36:26 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 153EYagC016258;
        Thu, 3 Jun 2021 09:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622730876;
        bh=k8/fjF6Bxv4vsa9d0B9zE6LGyp/RWLo7r73WBVsmyRo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fuKz8T5SVxOVt50hI5HC0nRK+cc+I4y1tTrdhE+ATiJa+RDuBSwCeLHBz4wRlFNPh
         +OantdwddJG83R6a5X0POlSYEmpoWR7bFQfqxnw9va6fDZYgAPya8hhjIGlgSPpxV0
         KC4gPvauHI5rSf1EK+AusZyN0NtzSLH5N9+DLakc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 153EYabk068736
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jun 2021 09:34:36 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 09:34:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 3 Jun 2021 09:34:35 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 153EYRDJ011740;
        Thu, 3 Jun 2021 09:34:32 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 1/4] arm64: dts: ti: k3-j721e-main: Fix external refclk input to SERDES
Date:   Thu, 3 Jun 2021 20:04:24 +0530
Message-ID: <20210603143427.28735-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603143427.28735-1-kishon@ti.com>
References: <20210603143427.28735-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the external refclk inputs to the SERDES from
dummy_cmn_refclk/dummy_cmn_refclk1 to cmn_refclk/cmn_refclk1
respectively. Also move the external refclk DT nodes outside the
cbass_main DT node. Since in j721e common processor board, only the
cmn_refclk1 is connected to 100MHz clock, fix the clock frequency.

Fixes: afd094ebe69f ("arm64: dts: ti: k3-j721e-main: Add WIZ and SERDES PHY nodes")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     |  4 ++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 58 ++++++++++---------
 2 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 60764366e22b..86f7ab511ee8 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -635,6 +635,10 @@
 	status = "disabled";
 };
 
+&cmn_refclk1 {
+	clock-frequency = <100000000>;
+};
+
 &serdes0 {
 	serdes0_pcie_link: link@0 {
 		reg = <0>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index c2aa45a3ac79..674bfc60f076 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -8,6 +8,20 @@
 #include <dt-bindings/mux/mux.h>
 #include <dt-bindings/mux/ti-serdes.h>
 
+/ {
+	cmn_refclk: clock-cmnrefclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
+	cmn_refclk1: clock-cmnrefclk1 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+};
+
 &cbass_main {
 	msmc_ram: sram@70000000 {
 		compatible = "mmio-sram";
@@ -336,24 +350,12 @@
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
-	dummy_cmn_refclk: dummy-cmn-refclk {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <100000000>;
-	};
-
-	dummy_cmn_refclk1: dummy-cmn-refclk1 {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <100000000>;
-	};
-
 	serdes_wiz0: wiz@5000000 {
 		compatible = "ti,j721e-wiz-16g";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 292 5>, <&k3_clks 292 11>, <&dummy_cmn_refclk>;
+		clocks = <&k3_clks 292 5>, <&k3_clks 292 11>, <&cmn_refclk>;
 		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
 		assigned-clocks = <&k3_clks 292 11>, <&k3_clks 292 0>;
 		assigned-clock-parents = <&k3_clks 292 15>, <&k3_clks 292 4>;
@@ -362,21 +364,21 @@
 		ranges = <0x5000000 0x0 0x5000000 0x10000>;
 
 		wiz0_pll0_refclk: pll0-refclk {
-			clocks = <&k3_clks 292 11>, <&dummy_cmn_refclk>;
+			clocks = <&k3_clks 292 11>, <&cmn_refclk>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz0_pll0_refclk>;
 			assigned-clock-parents = <&k3_clks 292 11>;
 		};
 
 		wiz0_pll1_refclk: pll1-refclk {
-			clocks = <&k3_clks 292 0>, <&dummy_cmn_refclk1>;
+			clocks = <&k3_clks 292 0>, <&cmn_refclk1>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz0_pll1_refclk>;
 			assigned-clock-parents = <&k3_clks 292 0>;
 		};
 
 		wiz0_refclk_dig: refclk-dig {
-			clocks = <&k3_clks 292 11>, <&k3_clks 292 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
+			clocks = <&k3_clks 292 11>, <&k3_clks 292 0>, <&cmn_refclk>, <&cmn_refclk1>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz0_refclk_dig>;
 			assigned-clock-parents = <&k3_clks 292 11>;
@@ -410,7 +412,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		power-domains = <&k3_pds 293 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 293 5>, <&k3_clks 293 13>, <&dummy_cmn_refclk>;
+		clocks = <&k3_clks 293 5>, <&k3_clks 293 13>, <&cmn_refclk>;
 		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
 		assigned-clocks = <&k3_clks 293 13>, <&k3_clks 293 0>;
 		assigned-clock-parents = <&k3_clks 293 17>, <&k3_clks 293 4>;
@@ -419,21 +421,21 @@
 		ranges = <0x5010000 0x0 0x5010000 0x10000>;
 
 		wiz1_pll0_refclk: pll0-refclk {
-			clocks = <&k3_clks 293 13>, <&dummy_cmn_refclk>;
+			clocks = <&k3_clks 293 13>, <&cmn_refclk>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz1_pll0_refclk>;
 			assigned-clock-parents = <&k3_clks 293 13>;
 		};
 
 		wiz1_pll1_refclk: pll1-refclk {
-			clocks = <&k3_clks 293 0>, <&dummy_cmn_refclk1>;
+			clocks = <&k3_clks 293 0>, <&cmn_refclk1>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz1_pll1_refclk>;
 			assigned-clock-parents = <&k3_clks 293 0>;
 		};
 
 		wiz1_refclk_dig: refclk-dig {
-			clocks = <&k3_clks 293 13>, <&k3_clks 293 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
+			clocks = <&k3_clks 293 13>, <&k3_clks 293 0>, <&cmn_refclk>, <&cmn_refclk1>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz1_refclk_dig>;
 			assigned-clock-parents = <&k3_clks 293 13>;
@@ -467,7 +469,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		power-domains = <&k3_pds 294 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 294 5>, <&k3_clks 294 11>, <&dummy_cmn_refclk>;
+		clocks = <&k3_clks 294 5>, <&k3_clks 294 11>, <&cmn_refclk>;
 		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
 		assigned-clocks = <&k3_clks 294 11>, <&k3_clks 294 0>;
 		assigned-clock-parents = <&k3_clks 294 15>, <&k3_clks 294 4>;
@@ -476,21 +478,21 @@
 		ranges = <0x5020000 0x0 0x5020000 0x10000>;
 
 		wiz2_pll0_refclk: pll0-refclk {
-			clocks = <&k3_clks 294 11>, <&dummy_cmn_refclk>;
+			clocks = <&k3_clks 294 11>, <&cmn_refclk>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz2_pll0_refclk>;
 			assigned-clock-parents = <&k3_clks 294 11>;
 		};
 
 		wiz2_pll1_refclk: pll1-refclk {
-			clocks = <&k3_clks 294 0>, <&dummy_cmn_refclk1>;
+			clocks = <&k3_clks 294 0>, <&cmn_refclk1>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz2_pll1_refclk>;
 			assigned-clock-parents = <&k3_clks 294 0>;
 		};
 
 		wiz2_refclk_dig: refclk-dig {
-			clocks = <&k3_clks 294 11>, <&k3_clks 294 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
+			clocks = <&k3_clks 294 11>, <&k3_clks 294 0>, <&cmn_refclk>, <&cmn_refclk1>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz2_refclk_dig>;
 			assigned-clock-parents = <&k3_clks 294 11>;
@@ -524,7 +526,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		power-domains = <&k3_pds 295 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 295 5>, <&k3_clks 295 9>, <&dummy_cmn_refclk>;
+		clocks = <&k3_clks 295 5>, <&k3_clks 295 9>, <&cmn_refclk>;
 		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
 		assigned-clocks = <&k3_clks 295 9>, <&k3_clks 295 0>;
 		assigned-clock-parents = <&k3_clks 295 13>, <&k3_clks 295 4>;
@@ -533,21 +535,21 @@
 		ranges = <0x5030000 0x0 0x5030000 0x10000>;
 
 		wiz3_pll0_refclk: pll0-refclk {
-			clocks = <&k3_clks 295 9>, <&dummy_cmn_refclk>;
+			clocks = <&k3_clks 295 9>, <&cmn_refclk>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz3_pll0_refclk>;
 			assigned-clock-parents = <&k3_clks 295 9>;
 		};
 
 		wiz3_pll1_refclk: pll1-refclk {
-			clocks = <&k3_clks 295 0>, <&dummy_cmn_refclk1>;
+			clocks = <&k3_clks 295 0>, <&cmn_refclk1>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz3_pll1_refclk>;
 			assigned-clock-parents = <&k3_clks 295 0>;
 		};
 
 		wiz3_refclk_dig: refclk-dig {
-			clocks = <&k3_clks 295 9>, <&k3_clks 295 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
+			clocks = <&k3_clks 295 9>, <&k3_clks 295 0>, <&cmn_refclk>, <&cmn_refclk1>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz3_refclk_dig>;
 			assigned-clock-parents = <&k3_clks 295 9>;
-- 
2.17.1

