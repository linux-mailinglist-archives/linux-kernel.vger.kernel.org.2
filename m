Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9D1382416
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 08:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhEQGTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 02:19:37 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55320 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbhEQGTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 02:19:33 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14H6IFIk040848;
        Mon, 17 May 2021 01:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621232295;
        bh=XuxsaWlsn0FoApoJBuq8628FdCGtrxuXK+ZrkC349qA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=C7NH4izgX0GeMj90ywAYtNupSo60S7JryAxomXRJLwn8sUN1KcGqYt057m1qaM5mv
         SAMQQ1zspyDjRZrGaphK6DOmSo7Iq9cy5dyYmjjqpWrcIR46nKkEKZugQUYIVnoKVU
         YSSJODBUvzWaKBxi78ho+Jogmlr0PaWMAe9E2ZIQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14H6IFWN097157
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 May 2021 01:18:15 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 17
 May 2021 01:18:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 17 May 2021 01:18:14 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14H6Hpl2003911;
        Mon, 17 May 2021 01:18:10 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, <a-govindraju@ti.com>
Subject: [PATCH v2 2/6] arm64: dts: ti: k3-am64-main: Add SERDES DT node
Date:   Mon, 17 May 2021 11:47:35 +0530
Message-ID: <20210517061739.5762-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517061739.5762-1-kishon@ti.com>
References: <20210517061739.5762-1-kishon@ti.com>
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
index b2bcbf23eefd..d4b0ddcc22ed 100644
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
+		serdes_ln_ctrl: mux {
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

