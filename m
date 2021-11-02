Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F744426F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 07:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhKBGDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 02:03:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38374 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230015AbhKBGDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 02:03:37 -0400
X-UUID: 98581cd3af4d47a3b52b4bcfe8ef3736-20211102
X-UUID: 98581cd3af4d47a3b52b4bcfe8ef3736-20211102
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 849701908; Tue, 02 Nov 2021 14:01:00 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 2 Nov 2021 14:00:59 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs10n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 2 Nov 2021 14:00:58 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] arm64: dts: mediatek: Add USB xHCI controller for mt8195
Date:   Tue, 2 Nov 2021 14:00:49 +0800
Message-ID: <20211102060049.1843-3-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211102060049.1843-1-chunfeng.yun@mediatek.com>
References: <20211102060049.1843-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all four USB xHCI controllers for MT8195

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 79 ++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index a59c0e9d1fc2..263eebfd2ea1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt8195-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/power/mt8195-power.h>
 
 / {
@@ -823,6 +824,26 @@
 			status = "disabled";
 		};
 
+		xhci0: usb@11200000 {
+			compatible = "mediatek,mt8195-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11200000 0 0x1000>, <0 0x11203e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
+			assigned-clocks = <&topckgen CLK_TOP_USB_TOP>,
+					  <&topckgen CLK_TOP_SSUSB_XHCI>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
+						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB>,
+				 <&infracfg_ao CLK_INFRA_AO_SSUSB_XHCI>,
+				 <&topckgen CLK_TOP_SSUSB_REF>,
+				 <&apmixedsys CLK_APMIXED_USB1PLL>;
+			clock-names = "sys_ck", "xhci_ck", "ref_ck", "mcu_ck";
+			mediatek,syscon-wakeup = <&pericfg 0x400 103>;
+			wakeup-source;
+			status = "disabled";
+		};
+
 		mmc0: mmc@11230000 {
 			compatible = "mediatek,mt8195-mmc", "mediatek,mt8192-mmc";
 			reg = <0 0x11230000 0 0x10000>,
@@ -843,6 +864,64 @@
 			status = "disabled";
 		};
 
+		xhci1: usb@11290000 {
+			compatible = "mediatek,mt8195-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11290000 0 0x1000>, <0 0x11293e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port1 PHY_TYPE_USB2>;
+			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_1P>,
+					  <&topckgen CLK_TOP_SSUSB_XHCI_1P>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
+						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_1P_BUS>,
+				 <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>,
+				 <&topckgen CLK_TOP_SSUSB_P1_REF>,
+				 <&apmixedsys CLK_APMIXED_USB1PLL>;
+			clock-names = "sys_ck", "xhci_ck", "ref_ck", "mcu_ck";
+			mediatek,syscon-wakeup = <&pericfg 0x400 104>;
+			wakeup-source;
+			status = "disabled";
+		};
+
+		xhci2: usb@112a0000 {
+			compatible = "mediatek,mt8195-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x112a0000 0 0x1000>, <0 0x112a3e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port2 PHY_TYPE_USB2>;
+			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_2P>,
+					  <&topckgen CLK_TOP_SSUSB_XHCI_2P>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
+						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_2P_BUS>,
+				 <&pericfg_ao CLK_PERI_AO_SSUSB_2P_XHCI>,
+				 <&topckgen CLK_TOP_SSUSB_P2_REF>;
+			clock-names = "sys_ck", "xhci_ck", "ref_ck";
+			mediatek,syscon-wakeup = <&pericfg 0x400 105>;
+			status = "disabled";
+		};
+
+		xhci3: usb@112b0000 {
+			compatible = "mediatek,mt8195-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x112b0000 0 0x1000>, <0 0x112b3e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&u2port3 PHY_TYPE_USB2>;
+			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_3P>,
+					  <&topckgen CLK_TOP_SSUSB_XHCI_3P>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
+						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_3P_BUS>,
+				 <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>,
+				 <&topckgen CLK_TOP_SSUSB_P3_REF>;
+			clock-names = "sys_ck", "xhci_ck", "ref_ck";
+			mediatek,syscon-wakeup = <&pericfg 0x400 106>;
+			wakeup-source;
+			usb2-lpm-disable;
+			status = "disabled";
+		};
+
 		nor_flash: nor@1132c000 {
 			compatible = "mediatek,mt8195-nor", "mediatek,mt8173-nor";
 			reg = <0 0x1132c000 0 0x1000>;
-- 
2.18.0

