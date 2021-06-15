Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817D43A87B5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhFORfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:35:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35307 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230506AbhFORex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:34:53 -0400
X-UUID: 347347ff149d4800b730ae0427770430-20210616
X-UUID: 347347ff149d4800b730ae0427770430-20210616
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 687593839; Wed, 16 Jun 2021 01:32:45 +0800
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
        Jianjun Wang <jianjun.wang@mediatek.com>
Subject: [PATCH 11/27] arm64: dts: mt8195: add PCIe device node
Date:   Wed, 16 Jun 2021 01:32:17 +0800
Message-ID: <20210615173233.26682-11-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210615173233.26682-1-tinghan.shen@mediatek.com>
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianjun Wang <jianjun.wang@mediatek.com>

Add PCIe device node for mt8195.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 74 ++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index dd5644410fea..539f405a4f3d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/mt8195-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
 #include <dt-bindings/power/mt8195-power.h>
 #include <dt-bindings/reset/ti-syscon.h>
@@ -944,6 +945,79 @@
 			status = "disabled";
 		};
 
+		pcie0: pcie@112f0000 {
+			device_type = "pci";
+			compatible = "mediatek,mt8195-pcie";
+			reg = <0 0x112f0000 0 0x2000>;
+			reg-names = "pcie-mac";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			interrupts = <GIC_SPI 791 IRQ_TYPE_LEVEL_HIGH 0>;
+			bus-range = <0x00 0xff>;
+			ranges = <0x82000000 0 0x20000000
+				  0x0 0x20000000 0 0x4000000>;
+
+			status = "disabled";
+
+			clocks = <&infracfg_ao CLK_INFRA_AO_PCIE_PL_P_250M_P0>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_26M>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_96M>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_32K>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_PERI_26M>,
+				 <&pericfg_ao CLK_PERI_AO_PCIE_P0_MEM>;
+
+			phys = <&pciephy>;
+			phy-names = "pcie-phy";
+			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P0>;
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+					<0 0 0 2 &pcie_intc0 1>,
+					<0 0 0 3 &pcie_intc0 2>,
+					<0 0 0 4 &pcie_intc0 3>;
+			pcie_intc0: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		pcie1: pcie@112f8000 {
+			device_type = "pci";
+			compatible = "mediatek,mt8195-pcie";
+			reg = <0 0x112f8000 0 0x2000>;
+			reg-names = "pcie-mac";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			interrupts = <GIC_SPI 792 IRQ_TYPE_LEVEL_HIGH 0>;
+			bus-range = <0x00 0xff>;
+			ranges = <0x82000000 0 0x24000000
+				  0x0 0x24000000 0 0x4000000>;
+
+			status = "disabled";
+			clocks = <&infracfg_ao CLK_INFRA_AO_PCIE_PL_P_250M_P1>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_P1_TL_96M>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_P1_PERI_26M>,
+				 <&pericfg_ao CLK_PERI_AO_PCIE_P0_MEM>;
+
+			phys = <&u3port1 PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P1>;
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+					<0 0 0 2 &pcie_intc1 1>,
+					<0 0 0 3 &pcie_intc1 2>,
+					<0 0 0 4 &pcie_intc1 3>;
+			pcie_intc1: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
 		nor_flash: nor@1132c000 {
 			compatible = "mediatek,mt8195-nor", "mediatek,mt8173-nor";
 			reg = <0 0x1132c000 0 0x1000>;
-- 
2.18.0

