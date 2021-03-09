Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AEE33260E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhCINFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:05:45 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33116 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhCINFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:05:31 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 129D5MlX005805;
        Tue, 9 Mar 2021 07:05:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615295122;
        bh=sLreBZxnznNU+Oc1Psygdp8lJTN5HrrEsPiC4ihQsN4=;
        h=From:To:CC:Subject:Date;
        b=V3EnFEfHsqAH2DjqLU6Y7Wgjg4aWQ64WAT6TKy65Xsf/vqxSCp0VpfE5Wruk5J8Fs
         TsvEfJ4x1efbQibVzm2ilYiUBw2EnvDUcLXi79gRArjLn/jxFBp9Jprv1kk1P0PE6O
         QaN1w1nd4vb+iQs+NkU6f64XtUds6OIIg0PYIz+A=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 129D5MGB131044
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 07:05:22 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 9 Mar
 2021 07:05:22 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 9 Mar 2021 07:05:22 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 129D5I5w094746;
        Tue, 9 Mar 2021 07:05:19 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am64-main: Add OSPI node
Date:   Tue, 9 Mar 2021 18:35:13 +0530
Message-ID: <20210309130514.11740-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64 SoC has a single Octal SPI (OSPI) instance under Flash SubSystem
(FSS).  Add DT entry for the same.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 5f85950daef7..bcec4fa444b5 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -402,4 +402,29 @@ sdhci1: mmc@fa00000 {
 		ti,otap-del-sel-ddr50 = <0x9>;
 		ti,clkbuf-sel = <0x7>;
 	};
+
+	fss: bus@fc00000 {
+		compatible = "simple-bus";
+		reg = <0x00 0x0fc00000 0x00 0x70000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ospi0: spi@fc40000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x00 0x0fc40000 0x00 0x100>,
+			      <0x05 0x00000000 0x01 0x00000000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			clocks = <&k3_clks 75 6>;
+			assigned-clocks = <&k3_clks 75 6>;
+			assigned-clock-parents = <&k3_clks 75 7>;
+			assigned-clock-rates = <166666666>;
+			power-domains = <&k3_pds 75 TI_SCI_PD_EXCLUSIVE>;
+		};
+	};
 };
-- 
2.30.1

