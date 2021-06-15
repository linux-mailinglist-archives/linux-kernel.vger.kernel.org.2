Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6613A87CB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhFORfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:35:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34890 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230507AbhFORe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:34:57 -0400
X-UUID: 5ff78f30d68143489c675450805a90a8-20210616
X-UUID: 5ff78f30d68143489c675450805a90a8-20210616
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 892757725; Wed, 16 Jun 2021 01:32:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
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
        Jason-JH Lin <jason-jh.lin@mediatek.com>
Subject: [PATCH 24/27] arm64: dts: mt8195: add gce setting for disply node
Date:   Wed, 16 Jun 2021 01:32:30 +0800
Message-ID: <20210615173233.26682-24-tinghan.shen@mediatek.com>
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

add gce setting for disply node

Signed-off-by: Jason-JH Lin <jason-jh.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 51edb8ee35a8..e273833a49f8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -2245,6 +2245,7 @@
 			reg-names = "vdosys0_config";
 			iommus = <&iommu_vdo M4U_PORT_L0_DISP_RDMA0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+			mboxes = <&gce1 0 0 CMDQ_THR_PRIO_4>;
 		};
 
 		mutex: disp_mutex0@1c016000 {
@@ -2255,6 +2256,7 @@
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
 			clock-names = "vdo0_mutex";
 			interrupts = <GIC_SPI 658 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-events = <CMDQ_EVENT_VDO0_DISP_STREAM_DONE_0>;
 		};
 
 		ovl0: disp_ovl@1c000000 {
@@ -2264,6 +2266,7 @@
 			clocks = <&vdosys0 CLK_VDO0_DISP_OVL0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
 			iommus = <&iommu_vdo M4U_PORT_L0_DISP_OVL0_RDMA0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1c00XXXX 0x0000 0x1000>;
 		};
 
 		rdma0: disp_rdma@1c002000 {
@@ -2273,6 +2276,7 @@
 			clocks = <&vdosys0 CLK_VDO0_DISP_RDMA0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
 			iommus = <&iommu_vdo M4U_PORT_L0_DISP_RDMA0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1c00XXXX 0x2000 0x1000>;
 		};
 
 		color0: disp_color@1c003000 {
@@ -2281,6 +2285,7 @@
 			interrupts = <GIC_SPI 639 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&vdosys0 CLK_VDO0_DISP_COLOR0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1c00XXXX 0x3000 0x1000>;
 		};
 
 		ccorr0: disp_ccorr@1c004000 {
@@ -2289,6 +2294,7 @@
 			interrupts = <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&vdosys0 CLK_VDO0_DISP_CCORR0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1c00XXXX 0x4000 0x1000>;
 		};
 
 		aal0: disp_aal@1c005000 {
@@ -2297,6 +2303,7 @@
 			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&vdosys0 CLK_VDO0_DISP_AAL0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1c00XXXX 0x5000 0x1000>;
 		};
 
 		gamma0: disp_gamma@1c006000 {
@@ -2305,6 +2312,7 @@
 			interrupts = <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&vdosys0 CLK_VDO0_DISP_GAMMA0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1c00XXXX 0x6000 0x1000>;
 		};
 
 		dither0: disp_dither@1c007000 {
@@ -2313,6 +2321,7 @@
 			interrupts = <GIC_SPI 643 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&vdosys0 CLK_VDO0_DISP_DITHER0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1c00XXXX 0x7000 0x1000>;
 		};
 
 		merge0: disp_vpp_merge0@1c014000 {
@@ -2321,6 +2330,7 @@
 			interrupts = <GIC_SPI 656 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&vdosys0 CLK_VDO0_VPP_MERGE0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1c01XXXX 0x4000 0x1000>;
 		};
 
 		dsc0: disp_dsc_wrap@1c009000 {
@@ -2329,6 +2339,7 @@
 			interrupts = <GIC_SPI 645 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&vdosys0 CLK_VDO0_DSC_WRAP0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1c00XXXX 0x9000 0x1000>;
 		};
 
 		dp_intf0: dp_intf0@1c015000 {
-- 
2.18.0

