Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C193237C402
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 17:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhELP05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 11:26:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35636 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbhELPNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:13:42 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14CFCN6i009319;
        Wed, 12 May 2021 10:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620832343;
        bh=LpTK6DFH2lvJPtQPVOb4sIrdXQ+nw3aMVasQIioh4gU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=w3rppMRQcxmThqUfrbPvHRBbujtDrNjTP/JRV1ssbhlGYUkHsn34Lr9Hq3q0x2Ng7
         NGhGkEDERW5mSkZs2ZCuGHnUzgCH4hjqIQZbKBx4mfqOhPn3wwhUCwc/UWzjn75hwg
         fMBmIohKgFXtcarvzy/fWyXUtIwU3AqtmTxlGNJs=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14CFCNJ2040738
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 May 2021 10:12:23 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 12
 May 2021 10:12:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 12 May 2021 10:12:23 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14CFCAIo005491;
        Wed, 12 May 2021 10:12:19 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 2/4] arm64: dts: ti: k3-j721e-main: Add #clock-cells property to serdes DT node
Date:   Wed, 12 May 2021 20:42:07 +0530
Message-ID: <20210512151209.27560-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512151209.27560-1-kishon@ti.com>
References: <20210512151209.27560-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add #clock-cells property to serdes DT node since the serdes is also now
modeled as a clock provider and include the input clocks "pll0_refclk"
and "pll1_refclk" which are parents to the clocks modeled by serdes.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 002a0c1520ee..cccd9fc966bb 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -400,10 +400,11 @@
 			reg = <0x5000000 0x10000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#clock-cells = <1>;
 			resets = <&serdes_wiz0 0>;
 			reset-names = "sierra_reset";
-			clocks = <&wiz0_cmn_refclk_dig_div>, <&wiz0_cmn_refclk1_dig_div>;
-			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
+			clocks = <&wiz0_cmn_refclk_dig_div>, <&wiz0_cmn_refclk1_dig_div>, <&wiz0_pll0_refclk>, <&wiz0_pll1_refclk>;
+			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div", "pll0_refclk", "pll1_refclk";
 		};
 	};
 
@@ -457,10 +458,11 @@
 			reg = <0x5010000 0x10000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#clock-cells = <1>;
 			resets = <&serdes_wiz1 0>;
 			reset-names = "sierra_reset";
-			clocks = <&wiz1_cmn_refclk_dig_div>, <&wiz1_cmn_refclk1_dig_div>;
-			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
+			clocks = <&wiz1_cmn_refclk_dig_div>, <&wiz1_cmn_refclk1_dig_div>, <&wiz1_pll0_refclk>, <&wiz1_pll1_refclk>;
+			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div", "pll0_refclk", "pll1_refclk";
 		};
 	};
 
@@ -514,10 +516,11 @@
 			reg = <0x5020000 0x10000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#clock-cells = <1>;
 			resets = <&serdes_wiz2 0>;
 			reset-names = "sierra_reset";
-			clocks = <&wiz2_cmn_refclk_dig_div>, <&wiz2_cmn_refclk1_dig_div>;
-			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
+			clocks = <&wiz2_cmn_refclk_dig_div>, <&wiz2_cmn_refclk1_dig_div>, <&wiz2_pll0_refclk>, <&wiz2_pll1_refclk>;
+			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div", "pll0_refclk", "pll1_refclk";
 		};
 	};
 
@@ -571,10 +574,11 @@
 			reg = <0x5030000 0x10000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#clock-cells = <1>;
 			resets = <&serdes_wiz3 0>;
 			reset-names = "sierra_reset";
-			clocks = <&wiz3_cmn_refclk_dig_div>, <&wiz3_cmn_refclk1_dig_div>;
-			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
+			clocks = <&wiz3_cmn_refclk_dig_div>, <&wiz3_cmn_refclk1_dig_div>, <&wiz3_pll0_refclk>, <&wiz3_pll1_refclk>;
+			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div", "pll0_refclk", "pll1_refclk";
 		};
 	};
 
-- 
2.17.1

