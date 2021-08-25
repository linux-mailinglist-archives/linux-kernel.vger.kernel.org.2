Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75973F6CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 03:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbhHYBMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 21:12:35 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:54236 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235458AbhHYBMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 21:12:34 -0400
X-UUID: 1605f5eed508401b9a21010efc32b99e-20210825
X-UUID: 1605f5eed508401b9a21010efc32b99e-20210825
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2129154962; Wed, 25 Aug 2021 09:11:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 25 Aug 2021 09:11:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 25 Aug 2021 09:11:43 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v1 3/5] arm64: dts: mediatek: Correct SPI clock of MT8192
Date:   Wed, 25 Aug 2021 09:11:18 +0800
Message-ID: <20210825011120.30481-4-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210825011120.30481-1-chun-jie.chen@mediatek.com>
References: <20210825011120.30481-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update uart0 ~ 7 clocks to the real ones.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 48 ++++++++++++------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 31d135e18784..d1c85d3e152b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -355,9 +355,9 @@
 			#size-cells = <0>;
 			reg = <0 0x1100a000 0 0x1000>;
 			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>,
-				 <&clk26m>,
-				 <&clk26m>;
+			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_INFRA_SPI0>;
 			clock-names = "parent-clk", "sel-clk", "spi-clk";
 			status = "disabled";
 		};
@@ -369,9 +369,9 @@
 			#size-cells = <0>;
 			reg = <0 0x11010000 0 0x1000>;
 			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>,
-				 <&clk26m>,
-				 <&clk26m>;
+			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_INFRA_SPI1>;
 			clock-names = "parent-clk", "sel-clk", "spi-clk";
 			status = "disabled";
 		};
@@ -383,9 +383,9 @@
 			#size-cells = <0>;
 			reg = <0 0x11012000 0 0x1000>;
 			interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>,
-				 <&clk26m>,
-				 <&clk26m>;
+			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_INFRA_SPI2>;
 			clock-names = "parent-clk", "sel-clk", "spi-clk";
 			status = "disabled";
 		};
@@ -397,9 +397,9 @@
 			#size-cells = <0>;
 			reg = <0 0x11013000 0 0x1000>;
 			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>,
-				 <&clk26m>,
-				 <&clk26m>;
+			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_INFRA_SPI3>;
 			clock-names = "parent-clk", "sel-clk", "spi-clk";
 			status = "disabled";
 		};
@@ -411,9 +411,9 @@
 			#size-cells = <0>;
 			reg = <0 0x11018000 0 0x1000>;
 			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>,
-				 <&clk26m>,
-				 <&clk26m>;
+			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_INFRA_SPI4>;
 			clock-names = "parent-clk", "sel-clk", "spi-clk";
 			status = "disabled";
 		};
@@ -425,9 +425,9 @@
 			#size-cells = <0>;
 			reg = <0 0x11019000 0 0x1000>;
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>,
-				 <&clk26m>,
-				 <&clk26m>;
+			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_INFRA_SPI5>;
 			clock-names = "parent-clk", "sel-clk", "spi-clk";
 			status = "disabled";
 		};
@@ -439,9 +439,9 @@
 			#size-cells = <0>;
 			reg = <0 0x1101d000 0 0x1000>;
 			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>,
-				 <&clk26m>,
-				 <&clk26m>;
+			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_INFRA_SPI6>;
 			clock-names = "parent-clk", "sel-clk", "spi-clk";
 			status = "disabled";
 		};
@@ -453,9 +453,9 @@
 			#size-cells = <0>;
 			reg = <0 0x1101e000 0 0x1000>;
 			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>,
-				 <&clk26m>,
-				 <&clk26m>;
+			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_INFRA_SPI7>;
 			clock-names = "parent-clk", "sel-clk", "spi-clk";
 			status = "disabled";
 		};
-- 
2.18.0

