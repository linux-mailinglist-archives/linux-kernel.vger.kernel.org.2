Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70A832DB9C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 22:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbhCDVM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 16:12:29 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37674 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239104AbhCDVMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 16:12:13 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 124LBIig075167;
        Thu, 4 Mar 2021 15:11:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614892278;
        bh=LZ3j37WzdOm90vBaY7rBVvDN7IeME/G6VnchJ5Cn3E0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QVxEPCSK6vINtLIuybabij0fFf3iu+7TUCYWXhQLUUtnIleuBvNwFOzUnGI6xI9Jg
         jdQ99bYgb+xKjoLx/x7skI03ZVOjFB6dActjweffNN9uO5EWmNsBZfIOypIaiZSZYL
         tdO0uH0wLiBh2ojIsCbtS7ZO+5XiwQeHZS8Mh6HE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 124LBIBx016792
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Mar 2021 15:11:18 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 4 Mar
 2021 15:11:17 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 4 Mar 2021 15:11:17 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 124LBGpG108962;
        Thu, 4 Mar 2021 15:11:17 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
CC:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 1/4] arm64: dts: ti: k3-am64-main: Add CPSW DT node
Date:   Thu, 4 Mar 2021 23:10:35 +0200
Message-ID: <20210304211038.12511-2-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304211038.12511-1-grygorii.strashko@ti.com>
References: <20210304211038.12511-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vignesh Raghavendra <vigneshr@ti.com>

Add CPSW3g DT node with two external ports, MDIO and CPTS support. For
CPSW3g DMA channels the ASEL is set to 15 (AM642x per DMA channel coherency
feature), so that CPSW DMA channel participates in Coherency and thus avoid
need to cache maintenance for SKBs. This improves bidirectional TCP
performance by up to 100Mbps (on 1G link).

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 74 ++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am64.dtsi      |  2 +
 2 files changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 5f85950daef7..80443dbf272c 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -178,6 +178,12 @@
 			compatible = "ti,am654-chipid";
 			reg = <0x00000014 0x4>;
 		};
+
+		phy_gmii_sel: phy@4044 {
+			compatible = "ti,am654-phy-gmii-sel";
+			reg = <0x4044 0x8>;
+			#phy-cells = <1>;
+		};
 	};
 
 	main_uart0: serial@2800000 {
@@ -402,4 +408,72 @@
 		ti,otap-del-sel-ddr50 = <0x9>;
 		ti,clkbuf-sel = <0x7>;
 	};
+
+	cpsw3g: ethernet@8000000 {
+		compatible = "ti,am642-cpsw-nuss";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x0 0x8000000 0x0 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x0 0x0 0x0 0x8000000 0x0 0x200000>;
+		clocks = <&k3_clks 13 0>;
+		assigned-clocks = <&k3_clks 13 1>;
+		assigned-clock-parents = <&k3_clks 13 9>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 13 TI_SCI_PD_EXCLUSIVE>;
+
+		dmas = <&main_pktdma 0xC500 15>,
+		       <&main_pktdma 0xC501 15>,
+		       <&main_pktdma 0xC502 15>,
+		       <&main_pktdma 0xC503 15>,
+		       <&main_pktdma 0xC504 15>,
+		       <&main_pktdma 0xC505 15>,
+		       <&main_pktdma 0xC506 15>,
+		       <&main_pktdma 0xC507 15>,
+		       <&main_pktdma 0x4500 15>;
+		dma-names = "tx0", "tx1", "tx2", "tx3", "tx4", "tx5", "tx6",
+			    "tx7", "rx";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cpsw_port1: port@1 {
+				reg = <1>;
+				ti,mac-only;
+				label = "port1";
+				phys = <&phy_gmii_sel 1>;
+				mac-address = [00 00 de ad be ef];
+			};
+
+			cpsw_port2: port@2 {
+				reg = <2>;
+				ti,mac-only;
+				label = "port2";
+				phys = <&phy_gmii_sel 2>;
+				mac-address = [00 01 de ad be ef];
+			};
+		};
+
+		cpsw3g_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+			reg = <0x0 0xf00 0x0 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 13 0>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+		};
+
+		cpts@3d000 {
+			compatible = "ti,j721e-cpts";
+			reg = <0x0 0x3d000 0x0 0x400>;
+			clocks = <&k3_clks 13 1>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
index 0ae8c844c482..de6805b0c72c 100644
--- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
@@ -28,6 +28,8 @@
 		serial6 = &main_uart4;
 		serial7 = &main_uart5;
 		serial8 = &main_uart6;
+		ethernet0 = &cpsw_port1;
+		ethernet1 = &cpsw_port2;
 	};
 
 	chosen { };
-- 
2.17.1

