Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831253A87C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhFORfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:35:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35324 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231238AbhFORe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:34:56 -0400
X-UUID: fe010a276f864cdf8738f7f02467bf6e-20210616
X-UUID: fe010a276f864cdf8738f7f02467bf6e-20210616
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1654132548; Wed, 16 Jun 2021 01:32:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 01:32:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 01:32:45 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <seiya.wang@mediatek.com>, <wenst@google.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
Subject: [PATCH 19/27] arm64: dts: mt8195: add dp_intf node
Date:   Wed, 16 Jun 2021 01:32:25 +0800
Message-ID: <20210615173233.26682-19-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210615173233.26682-1-tinghan.shen@mediatek.com>
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason-JH Lin <jason-jh.lin@mediatek.com>

add dp_intf cnode

Signed-off-by: Jason-JH Lin <jason-jh.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 31 ++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 0399aa8cf994..560a0583ca0b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -2003,6 +2003,29 @@
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
 		};
 
+		dp_intf0: dp_intf0@1c015000 {
+			status = "disabled";
+			compatible = "mediatek,mt8195-dpintf";
+			reg = <0 0x1c015000 0 0x1000>;
+			interrupts = <GIC_SPI 657 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&vdosys0  CLK_VDO0_DP_INTF0>,
+				<&vdosys0 CLK_VDO0_DP_INTF0_DP_INTF>,
+				<&topckgen CLK_TOP_EDP_SEL>,
+				<&topckgen CLK_TOP_TVDPLL1_D2>,
+				<&topckgen CLK_TOP_TVDPLL1_D4>,
+				<&topckgen CLK_TOP_TVDPLL1_D8>,
+				<&topckgen CLK_TOP_TVDPLL1_D16>,
+				<&topckgen CLK_TOP_TVDPLL1>;
+			clock-names = "hf_fmm_ck",
+				      "hf_fdp_ck",
+				      "MUX_DP",
+				      "TVDPLL_D2",
+				      "TVDPLL_D4",
+				      "TVDPLL_D8",
+				      "TVDPLL_D16",
+				      "DPI_CK";
+		};
+
 		smi_common0: smi@1c01b000 {
 			compatible = "mediatek,mt8195-smi-common";
 			mediatek,common-id = <0>;
@@ -2113,6 +2136,14 @@
 			ddc-i2c-bus = <&hdmiddc0>;
 			status = "disabled";
 		};
+
+		edp_tx: edp_tx@1c500000 {
+			status = "disabled";
+			compatible = "mediatek,mt8195-dp_tx";
+			reg = <0 0x1c500000 0 0x8000>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_EPD_TX>;
+			interrupts = <GIC_SPI 676 IRQ_TYPE_LEVEL_HIGH 0>;
+		};
 	};
 
 	hdmiddc0: ddc_i2c {
-- 
2.18.0

