Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15E73A87C6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhFORf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:35:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35307 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231186AbhFORez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:34:55 -0400
X-UUID: 2ba9a969a76c4ec594749d2d43112c68-20210616
X-UUID: 2ba9a969a76c4ec594749d2d43112c68-20210616
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 918936174; Wed, 16 Jun 2021 01:32:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 01:32:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 01:32:44 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <seiya.wang@mediatek.com>, <wenst@google.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: [PATCH 14/27] arm64: dts: mt8195: add usb support
Date:   Wed, 16 Jun 2021 01:32:20 +0800
Message-ID: <20210615173233.26682-14-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210615173233.26682-1-tinghan.shen@mediatek.com>
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianping Fang <tianping.fang@mediatek.com>

Add usb support for mt8195 SoC.

Signed-off-by: Tianping Fang <tianping.fang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 110 ++++++++++++++++++++---
 1 file changed, 100 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 1a281551d011..41d9f167701f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -957,6 +957,28 @@
 			status = "disabled";
 		};
 
+		xhci: xhci@11200000 {
+			compatible = "mediatek,mt8195-xhci",
+				     "mediatek,mtk-xhci";
+			reg = <0 0x11200000 0 0x1000>,
+			      <0 0x11203e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port0 PHY_TYPE_USB2>,
+			       <&u3port0 PHY_TYPE_USB3>;
+			assigned-clocks = <&topckgen CLK_TOP_USB_SEL>,
+					  <&topckgen CLK_TOP_SSUSB_XHCI_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
+						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB>,
+				 <&infracfg_ao CLK_INFRA_AO_SSUSB_XHCI>,
+				 <&topckgen CLK_TOP_SSUSB_REF>;
+			clock-names = "sys_ck", "xhci_ck", "ref_ck";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			status = "disabled";
+		};
+
 		mmc0: mmc@11230000 {
 			compatible = "mediatek,mt8195-mmc",
 				     "mediatek,mt8192-mmc",
@@ -987,6 +1009,70 @@
 			status = "disabled";
 		};
 
+		xhci1: xhci1@11290000 {
+			compatible = "mediatek,mt8195-xhci",
+				     "mediatek,mtk-xhci";
+			reg = <0 0x11290000 0 0x1000>,
+			      <0 0x11293e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port1 PHY_TYPE_USB2>;
+			assigned-clocks = <&topckgen CLK_TOP_USB_1P_SEL>,
+					  <&topckgen CLK_TOP_SSUSB_XHCI_1P_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
+						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_1P_BUS>,
+				 <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>,
+				 <&topckgen CLK_TOP_SSUSB_P1_REF>;
+			clock-names = "sys_ck", "xhci_ck", "ref_ck";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			status = "disabled";
+		};
+
+		xhci2: xhci2@112a0000 {
+			compatible = "mediatek,mt8195-xhci",
+				     "mediatek,mtk-xhci";
+			reg = <0 0x112a0000 0 0x1000>,
+			      <0 0x112a3e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port2 PHY_TYPE_USB2>;
+			assigned-clocks = <&topckgen CLK_TOP_USB_2P_SEL>,
+					  <&topckgen CLK_TOP_SSUSB_XHCI_2P_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
+						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_2P_BUS>,
+				 <&pericfg_ao CLK_PERI_AO_SSUSB_2P_XHCI>,
+				 <&topckgen CLK_TOP_SSUSB_P2_REF>;
+			clock-names = "sys_ck", "xhci_ck", "ref_ck";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			status = "disabled";
+		};
+
+		xhci3: xhci3@112b0000 {
+			compatible = "mediatek,mt8195-xhci",
+				     "mediatek,mtk-xhci";
+			reg = <0 0x112b0000 0 0x1000>,
+			      <0 0x112b3e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port3 PHY_TYPE_USB2>;
+			assigned-clocks = <&topckgen CLK_TOP_USB_3P_SEL>,
+					  <&topckgen CLK_TOP_SSUSB_XHCI_3P_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
+						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_3P_BUS>,
+				 <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>,
+				 <&topckgen CLK_TOP_SSUSB_P3_REF>;
+			clock-names = "sys_ck", "xhci_ck", "ref_ck";
+			usb2-lpm-disable;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			status = "disabled";
+		};
+
 		pcie0: pcie@112f0000 {
 			device_type = "pci";
 			compatible = "mediatek,mt8195-pcie";
@@ -1080,7 +1166,7 @@
 
 			u2port2: usb-phy@0 {
 				reg = <0x0 0x700>;
-				clocks = <&clk26m>;
+				clocks = <&topckgen CLK_TOP_SSUSB_PHY_P2_REF>;
 				clock-names = "ref";
 				#phy-cells = <1>;
 			};
@@ -1095,7 +1181,7 @@
 
 			u2port3: usb-phy@0 {
 				reg = <0x0 0x700>;
-				clocks = <&clk26m>;
+				clocks = <&topckgen CLK_TOP_SSUSB_PHY_P3_REF>;
 				clock-names = "ref";
 				#phy-cells = <1>;
 			};
@@ -1244,15 +1330,17 @@
 
 			u2port1: usb-phy@0 {
 				reg = <0x0 0x700>;
-				clocks = <&clk26m>;
-				clock-names = "ref";
+				clocks = <&topckgen CLK_TOP_SSUSB_PHY_P1_REF>,
+					 <&apmixedsys CLK_APMIXED_USB1PLL>;
+				clock-names = "ref", "da_ref";
 				#phy-cells = <1>;
 			};
 
 			u3port1: usb-phy@700 {
 				reg = <0x700 0x700>;
-				clocks = <&clk26m>;
-				clock-names = "ref";
+				clocks = <&apmixedsys CLK_APMIXED_PLL_SSUSB26M>,
+					 <&topckgen CLK_TOP_SSUSB_PHY_P1_REF>;
+				clock-names = "ref", "da_ref";
 				#phy-cells = <1>;
 			};
 		};
@@ -1266,15 +1354,17 @@
 
 			u2port0: usb-phy@0 {
 				reg = <0x0 0x700>;
-				clocks = <&clk26m>;
-				clock-names = "ref";
+				clocks = <&topckgen CLK_TOP_SSUSB_PHY_REF>,
+					 <&apmixedsys CLK_APMIXED_USB1PLL>;
+				clock-names = "ref", "da_ref";
 				#phy-cells = <1>;
 			};
 
 			u3port0: usb-phy@700 {
 				reg = <0x700 0x700>;
-				clocks = <&clk26m>;
-				clock-names = "ref";
+				clocks = <&apmixedsys CLK_APMIXED_PLL_SSUSB26M>,
+					 <&topckgen CLK_TOP_SSUSB_PHY_REF>;
+				clock-names = "ref", "da_ref";
 				#phy-cells = <1>;
 			};
 		};
-- 
2.18.0

