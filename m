Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B7F341707
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbhCSIBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:01:15 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39484 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbhCSIA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:00:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12J80m35004889;
        Fri, 19 Mar 2021 03:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616140848;
        bh=d2o8y9nEwZ1XcT4SBOFhIbV7d8JryLY1PSTGqSDPDGE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JhjX4Wo90RVtd1YfWLrIapmd+rXPWFy+RFYEGwdk1L6qI/vnewBTOVRPGYvs2A+hF
         S6lZpUQps7zyAxn3zXAP9hoetDOHjaUTbIgfNTSn9aZ5MMrQnvkrvBiOo2/PFLiEyC
         xbX38BzFNoSDzOq6lswHtprTnUXS6b6EFYeum21c=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12J80m17003025
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Mar 2021 03:00:48 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 19
 Mar 2021 03:00:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 19 Mar 2021 03:00:48 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12J80eJr086082;
        Fri, 19 Mar 2021 03:00:45 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am64: Add SERDES DT node
Date:   Fri, 19 Mar 2021 13:30:37 +0530
Message-ID: <20210319080038.10521-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210319080038.10521-1-a-govindraju@ti.com>
References: <20210319080038.10521-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

Add SERDES DT node for the single one lane SERDES present in
AM64.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 52 ++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index a03b66456062..5a62a96c048c 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -5,6 +5,17 @@
  * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <dt-bindings/phy/phy-cadence-torrent.h>
+#include <dt-bindings/phy/phy-ti.h>
+
+/ {
+	serdes_refclk: serdes-refclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <100000000>;
+	};
+};
+
 &cbass_main {
 	oc_sram: sram@70000000 {
 		compatible = "mmio-sram";
@@ -184,6 +195,12 @@
 			reg = <0x4044 0x8>;
 			#phy-cells = <1>;
 		};
+
+		serdes_ln_ctrl: mux {
+			compatible = "mmio-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x4080 0x3>; /* SERDES0 lane0 select */
+		};
 	};
 
 	main_uart0: serial@2800000 {
@@ -477,6 +494,41 @@
 		};
 	};
 
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
+		assigned-clocks = <&k3_clks 162 1>;
+		assigned-clock-parents = <&k3_clks 162 5>;
+
+		serdes0: serdes@f000000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x0f000000 0x00010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz0 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz0 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 162 1>,
+						 <&k3_clks 162 1>,
+						 <&k3_clks 162 1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+		};
+	};
+
 	cpts@39000000 {
 		compatible = "ti,j721e-cpts";
 		reg = <0x0 0x39000000 0x0 0x400>;
-- 
2.17.1

