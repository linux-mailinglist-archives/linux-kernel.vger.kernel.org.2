Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C93C3A87D0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFORgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:36:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35307 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231289AbhFORe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:34:59 -0400
X-UUID: 558b68876c8e450e9b7d3a41ff547240-20210616
X-UUID: 558b68876c8e450e9b7d3a41ff547240-20210616
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 789805714; Wed, 16 Jun 2021 01:32:47 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 01:32:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 01:32:46 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <seiya.wang@mediatek.com>, <wenst@google.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH 22/27] arm64: dts: mt8195: add edp nodes
Date:   Wed, 16 Jun 2021 01:32:28 +0800
Message-ID: <20210615173233.26682-22-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210615173233.26682-1-tinghan.shen@mediatek.com>
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jitao Shi <jitao.shi@mediatek.com>

add edp nodes for mt8195

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 59 +++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 256818c4c0bf..d7d2c2a8f461 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -23,6 +23,8 @@
 
 	aliases {
 		dpi1 = &disp_dpi1;
+		dp-intf0 = &dp_intf0;
+		dp-intf1 = &dp_intf1;
 	};
 
 	clocks {
@@ -1155,6 +1157,29 @@
 			status = "disabled";
 		};
 
+		disp_pwm0: disp_pwm0@1100e000 {
+			compatible = "mediatek,mt8183-disp-pwm";
+			reg = <0 0x1100e000 0 0x1000>;
+			interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_LOW 0>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+			#pwm-cells = <2>;
+			clocks = <&topckgen CLK_TOP_DISP_PWM0_SEL>,
+					<&infracfg_ao CLK_INFRA_AO_DISP_PWM>;
+			clock-names = "main", "mm";
+			status = "disabled";
+		};
+
+		disp_pwm1: disp_pwm1@1100f000 {
+			compatible = "mediatek,mt8183-disp-pwm";
+			reg = <0 0x1100f000 0 0x1000>;
+			interrupts = <GIC_SPI 793 IRQ_TYPE_LEVEL_HIGH 0>;
+			#pwm-cells = <2>;
+			clocks = <&topckgen CLK_TOP_DISP_PWM1_SEL>,
+				<&infracfg_ao CLK_INFRA_AO_DISP_PWM1>;
+			clock-names = "main", "mm";
+			status = "disabled";
+		};
+
 		spi1: spi@11010000 {
 			compatible = "mediatek,mt8195-spi",
 				     "mediatek,mt6765-spi";
@@ -2397,6 +2422,30 @@
 			status = "disabled";
 		};
 
+		dp_intf1: dp_intf1@1c113000 {
+			compatible = "mediatek,mt8195-dp-intf";
+			reg = <0 0x1c113000 0 0x1000>;
+			interrupts = <GIC_SPI 513 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
+			clocks = <&vdosys1 CLK_VDO1_DP_INTF0_MM>,
+				 <&vdosys1 CLK_VDO1_DPINTF>,
+				 <&topckgen CLK_TOP_DP_SEL>,
+				 <&topckgen CLK_TOP_TVDPLL2_D2>,
+				 <&topckgen CLK_TOP_TVDPLL2_D4>,
+				 <&topckgen CLK_TOP_TVDPLL2_D8>,
+				 <&topckgen CLK_TOP_TVDPLL2_D16>,
+				 <&topckgen CLK_TOP_TVDPLL2>;
+			clock-names = "hf_fmm_ck",
+				      "hf_fdp_ck",
+				      "MUX_DP",
+				      "TVDPLL_D2",
+				      "TVDPLL_D4",
+				      "TVDPLL_D8",
+				      "TVDPLL_D16",
+				      "DPI_CK";
+			status = "disabled";
+		};
+
 		hdmi0: hdmi@1c300000 {
 			compatible = "mediatek,mt8195-hdmi";
 			reg = <0 0x1c300000 0 0x1000>;
@@ -2421,11 +2470,19 @@
 
 		edp_tx: edp_tx@1c500000 {
 			status = "disabled";
-			compatible = "mediatek,mt8195-dp_tx";
+			compatible = "mediatek,mt8195-edp_tx";
 			reg = <0 0x1c500000 0 0x8000>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_EPD_TX>;
 			interrupts = <GIC_SPI 676 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
+
+		dp_tx: dp_tx@1c600000 {
+			compatible = "mediatek,mt8195-dp_tx";
+			reg = <0 0x1c600000 0 0x8000>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_DP_TX>;
+			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
 	};
 
 	hdmiddc0: ddc_i2c {
-- 
2.18.0

