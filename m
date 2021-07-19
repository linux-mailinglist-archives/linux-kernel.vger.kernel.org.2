Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CA33CCFDE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhGSIV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:21:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53934 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbhGSIV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:21:57 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16J8s9RG068557;
        Mon, 19 Jul 2021 03:54:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626684849;
        bh=l3N55Ft0wxYr3NzQ84cS4L5dBBKww2riqu3Ph6sU2OM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bEpk6xQu9+gsEYEYu5N/QASGOTPFnPE4/AFK3/X3HNlRYWRGacDjgkKyJb7hhaavX
         BZ5RDlNooBWMG4dLa2p2i2UymFkGguEEja4elkt9yQQ5e9789hDKRzqlOu4xMrsmPU
         nXcQOb8qXPdSJvyERQULfia9T411ndXleiFtDlqU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16J8s9IZ120754
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Jul 2021 03:54:09 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 19
 Jul 2021 03:54:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 19 Jul 2021 03:54:08 -0500
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16J8s3hC047822;
        Mon, 19 Jul 2021 03:54:06 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Nishanth Menon <nm@ti.com>, <kristo@kernel.org>
CC:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 1/4] arm64: dts: ti: k3-am64-main: Add epwm nodes
Date:   Mon, 19 Jul 2021 14:23:59 +0530
Message-ID: <20210719085402.28569-2-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210719085402.28569-1-lokeshvutla@ti.com>
References: <20210719085402.28569-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT nodes for all epwm instances present in AM64 SoC.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 87 ++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 02c3fdf9cc46..9e762f64b631 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -217,6 +217,12 @@ phy_gmii_sel: phy@4044 {
 			reg = <0x4044 0x8>;
 			#phy-cells = <1>;
 		};
+
+		epwm_tbclk: clock@4140 {
+			compatible = "ti,am64-epwm-tbclk", "syscon";
+			reg = <0x4130 0x4>;
+			#clock-cells = <1>;
+		};
 	};
 
 	main_uart0: serial@2800000 {
@@ -859,4 +865,85 @@ pcie0_ep: pcie-ep@f102000 {
 		clock-names = "fck";
 		max-functions = /bits/ 8 <1>;
 	};
+
+	epwm0: pwm@23000000 {
+		compatible = "ti,am64-epwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x23000000 0x0 0x100>;
+		power-domains = <&k3_pds 86 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&epwm_tbclk 0>, <&k3_clks 86 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	epwm1: pwm@23010000 {
+		compatible = "ti,am64-epwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x23010000 0x0 0x100>;
+		power-domains = <&k3_pds 87 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&epwm_tbclk 1>, <&k3_clks 87 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	epwm2: pwm@23020000 {
+		compatible = "ti,am64-epwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x23020000 0x0 0x100>;
+		power-domains = <&k3_pds 88 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&epwm_tbclk 2>, <&k3_clks 88 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	epwm3: pwm@23030000 {
+		compatible = "ti,am64-epwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x23030000 0x0 0x100>;
+		power-domains = <&k3_pds 89 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&epwm_tbclk 3>, <&k3_clks 89 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	epwm4: pwm@23040000 {
+		compatible = "ti,am64-epwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x23040000 0x0 0x100>;
+		power-domains = <&k3_pds 90 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&epwm_tbclk 4>, <&k3_clks 90 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	epwm5: pwm@23050000 {
+		compatible = "ti,am64-epwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x23050000 0x0 0x100>;
+		power-domains = <&k3_pds 91 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&epwm_tbclk 5>, <&k3_clks 91 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	epwm6: pwm@23060000 {
+		compatible = "ti,am64-epwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x23060000 0x0 0x100>;
+		power-domains = <&k3_pds 92 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&epwm_tbclk 6>, <&k3_clks 92 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	epwm7: pwm@23070000 {
+		compatible = "ti,am64-epwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x23070000 0x0 0x100>;
+		power-domains = <&k3_pds 93 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&epwm_tbclk 7>, <&k3_clks 93 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	epwm8: pwm@23080000 {
+		compatible = "ti,am64-epwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x23080000 0x0 0x100>;
+		power-domains = <&k3_pds 94 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&epwm_tbclk 8>, <&k3_clks 94 0>;
+		clock-names = "tbclk", "fck";
+	};
 };
-- 
2.30.0

