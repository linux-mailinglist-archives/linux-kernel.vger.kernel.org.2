Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F23A3A87A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhFORe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:34:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34885 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229728AbhFORex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:34:53 -0400
X-UUID: 0187e62bc676475d959a10ce8ba042a7-20210616
X-UUID: 0187e62bc676475d959a10ce8ba042a7-20210616
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2133741345; Wed, 16 Jun 2021 01:32:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 01:32:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 01:32:43 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <seiya.wang@mediatek.com>, <wenst@google.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 09/27] arm64: dts: mt8195: add spi controller
Date:   Wed, 16 Jun 2021 01:32:15 +0800
Message-ID: <20210615173233.26682-9-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210615173233.26682-1-tinghan.shen@mediatek.com>
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leilk Liu <leilk.liu@mediatek.com>

add spi controller node into mt8195 SoC

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 106 +++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 9b002bb6d344..80a272703879 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -818,6 +818,112 @@
 			#clock-cells = <1>;
 		};
 
+		spi0: spi@1100a000 {
+			compatible = "mediatek,mt8195-spi",
+				     "mediatek,mt6765-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x1100a000 0 0x100>;
+			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg_ao CLK_INFRA_AO_SPI0>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi1: spi@11010000 {
+			compatible = "mediatek,mt8195-spi",
+				     "mediatek,mt6765-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11010000 0 0x100>;
+			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg_ao CLK_INFRA_AO_SPI1>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi2: spi@11012000 {
+			compatible = "mediatek,mt8195-spi",
+				     "mediatek,mt6765-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11012000 0 0x100>;
+			interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg_ao CLK_INFRA_AO_SPI2>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi3: spi@11013000 {
+			compatible = "mediatek,mt8195-spi",
+				     "mediatek,mt6765-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11013000 0 0x100>;
+			interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg_ao CLK_INFRA_AO_SPI3>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi4: spi@11018000 {
+			compatible = "mediatek,mt8195-spi",
+				     "mediatek,mt6765-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11018000 0 0x100>;
+			interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg_ao CLK_INFRA_AO_SPI4>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spi5: spi@11019000 {
+			compatible = "mediatek,mt8195-spi",
+				     "mediatek,mt6765-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11019000 0 0x100>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg_ao CLK_INFRA_AO_SPI5>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		spis0: spi@1101d000 {
+			compatible = "mediatek,mt8195-spi-slave";
+			reg = <0 0x1101d000 0 0x100>;
+			interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_SPIS0>;
+			clock-names = "spi";
+			assigned-clocks = <&topckgen CLK_TOP_SPIS_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D6>;
+			status = "disabled";
+		};
+
+		spis1: spi@1101e000 {
+			compatible = "mediatek,mt8195-spi-slave";
+			reg = <0 0x1101e000 0 0x100>;
+			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_SPIS1>;
+			clock-names = "spi";
+			assigned-clocks = <&topckgen CLK_TOP_SPIS_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D6>;
+			status = "disabled";
+		};
+
 		mmc0: mmc@11230000 {
 			compatible = "mediatek,mt8195-mmc", "mediatek,mt8192-mmc";
 			reg = <0 0x11230000 0 0x10000>,
-- 
2.18.0

