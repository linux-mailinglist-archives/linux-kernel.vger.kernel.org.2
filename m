Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CCD3A87AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhFORfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:35:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34890 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230500AbhFORex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:34:53 -0400
X-UUID: a70f86e2f3ad466e8e22238fe7ee09cb-20210616
X-UUID: a70f86e2f3ad466e8e22238fe7ee09cb-20210616
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 655523478; Wed, 16 Jun 2021 01:32:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
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
        Wenbin Mei <wenbin.mei@mediatek.com>
Subject: [PATCH 12/27] arm64: dts: mt8195: fix mmc driver
Date:   Wed, 16 Jun 2021 01:32:18 +0800
Message-ID: <20210615173233.26682-12-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210615173233.26682-1-tinghan.shen@mediatek.com>
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenbin Mei <wenbin.mei@mediatek.com>

fix mmc driver with proper clock for mt8195 SoC.

Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 539f405a4f3d..327ff1b856d2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -926,22 +926,32 @@
 		};
 
 		mmc0: mmc@11230000 {
-			compatible = "mediatek,mt8195-mmc", "mediatek,mt8192-mmc";
+			compatible = "mediatek,mt8195-mmc",
+				     "mediatek,mt8192-mmc",
+				     "mediatek,mt8183-mmc";
 			reg = <0 0x11230000 0 0x10000>,
 			      <0 0x11f50000 0 0x1000>;
 			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>, <&clk26m>;
+			clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>,
+				 <&infracfg_ao CLK_INFRA_AO_MSDC0>,
+				 <&infracfg_ao CLK_INFRA_AO_MSDC0_SRC>;
 			clock-names = "source", "hclk", "source_cg";
 			status = "disabled";
 		};
 
 		mmc1: mmc@11240000 {
-			compatible = "mediatek,mt8195-mmc", "mediatek,mt8192-mmc";
+			compatible = "mediatek,mt8195-mmc",
+				     "mediatek,mt8192-mmc",
+				     "mediatek,mt8183-mmc";
 			reg = <0 0x11240000 0 0x1000>,
 			      <0 0x11c70000 0 0x1000>;
 			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>, <&clk26m>;
+			clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>,
+				 <&infracfg_ao CLK_INFRA_AO_MSDC1>,
+				 <&infracfg_ao CLK_INFRA_AO_MSDC1_SRC>;
 			clock-names = "source", "hclk", "source_cg";
+			assigned-clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
 			status = "disabled";
 		};
 
-- 
2.18.0

