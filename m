Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05631391A29
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhEZObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:31:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41292 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhEZObI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:31:08 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QETX2Q053294;
        Wed, 26 May 2021 09:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622039373;
        bh=C1a2y5DJkmFCYf7GvjDFRnHGPDWOiGzQEeqY/3tWJCQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Qj0Yo185lEKo2CZnhWg3qC14POYoGB47vCty9AZuTvJ7HNBVmRQo4pRTHYRyGhlAC
         Z5R6N7jaIeqdgKjOPMiYsbkRNRGeVxICXY4+gX7lNTOqXSJHUTLxbfKTiacSpD5Rr2
         QG54aVlvJNJypT7/30tr7CgNd74NY4j3rg6qG+5k=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QETXig018548
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 09:29:33 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 09:29:33 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 09:29:33 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QETMca030380;
        Wed, 26 May 2021 09:29:29 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 1/5] arm64: dts: ti: k3-am64-main: Add SERDES DT node
Date:   Wed, 26 May 2021 19:59:17 +0530
Message-ID: <20210526142921.12127-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210526142921.12127-1-kishon@ti.com>
References: <20210526142921.12127-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64 has one SERDES 10G instance. Add SERDES DT node for it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 56 ++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index b2bcbf23eefd..a67f10406a8e 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -5,6 +5,17 @@
  * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <dt-bindings/phy/phy-cadence.h>
+#include <dt-bindings/phy/phy-ti.h>
+
+/ {
+	serdes_refclk: clock {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+};
+
 &cbass_main {
 	oc_sram: sram@70000000 {
 		compatible = "mmio-sram";
@@ -18,6 +29,20 @@
 		};
 	};
 
+	main_conf: syscon@43000000 {
+		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
+		reg = <0x0 0x43000000 0x0 0x20000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x43000000 0x20000>;
+
+		serdes_ln_ctrl: mux-controller {
+			compatible = "mmio-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x4080 0x3>; /* SERDES0 lane0 select */
+		};
+	};
+
 	gic500: interrupt-controller@1800000 {
 		compatible = "arm,gic-v3";
 		#address-cells = <2>;
@@ -672,4 +697,35 @@
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
 	};
+
+	serdes_wiz0: wiz@f000000 {
+		compatible = "ti,am64-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 162 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 162 0>, <&k3_clks 162 1>, <&serdes_refclk>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+		num-lanes = <1>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+		ranges = <0x0f000000 0x0 0x0f000000 0x00010000>;
+
+		assigned-clocks = <&k3_clks 162 1>;
+		assigned-clock-parents = <&k3_clks 162 5>;
+
+		serdes0: serdes@f000000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x0f000000 0x00010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz0 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>, <&serdes_wiz0 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>, <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>, <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 162 1>, <&k3_clks 162 1>, <&k3_clks 162 1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+		};
+	};
 };
-- 
2.17.1

