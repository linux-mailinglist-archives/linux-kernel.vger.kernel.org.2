Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D1C3A87D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhFORg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:36:29 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34965 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231382AbhFORfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:35:04 -0400
X-UUID: a4788473769c439a8a93dcebc126d821-20210616
X-UUID: a4788473769c439a8a93dcebc126d821-20210616
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1811227526; Wed, 16 Jun 2021 01:32:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
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
        Nancy Lin <nancy.lin@mediatek.com>
Subject: [PATCH 25/27] arm64: dts: mt8195: add vdosys1 support for MT8195
Date:   Wed, 16 Jun 2021 01:32:31 +0800
Message-ID: <20210615173233.26682-25-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210615173233.26682-1-tinghan.shen@mediatek.com>
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nancy Lin <nancy.lin@mediatek.com>

add vdosys1 support for MT8195

Signed-off-by: Nancy Lin <nancy.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 178 +++++++++++++++++++++--
 1 file changed, 169 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index e273833a49f8..a98609989905 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -26,6 +26,7 @@
 		dpi1 = &disp_dpi1;
 		dp-intf0 = &dp_intf0;
 		dp-intf1 = &dp_intf1;
+		merge5 = &merge5;
 	};
 
 	clocks {
@@ -2241,22 +2242,27 @@
 
 		vdosys_config@1c01a000 {
 			compatible = "mediatek,mt8195-vdosys";
-			reg = <0 0x1c01a000 0 0x1000>;
-			reg-names = "vdosys0_config";
+			reg = <0 0x1c01a000 0 0x1000>,<0 0x1c100000 0 0x1000>;
+			reg-names = "vdosys0_config","vdosys1_config";
 			iommus = <&iommu_vdo M4U_PORT_L0_DISP_RDMA0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
-			mboxes = <&gce1 0 0 CMDQ_THR_PRIO_4>;
+			mboxes = <&gce1 0 0 CMDQ_THR_PRIO_4>,
+				 <&gce1 1 0 CMDQ_THR_PRIO_4>;
 		};
 
 		mutex: disp_mutex0@1c016000 {
 			compatible = "mediatek,mt8195-disp-mutex";
-			reg = <0 0x1c016000 0 0x1000>;
-			reg-names = "vdo0_mutex";
-			clocks = <&vdosys0 CLK_VDO0_DISP_MUTEX0>;
+			reg = <0 0x1c016000 0 0x1000>,
+			      <0 0x1c101000 0 0x1000>;
+			reg-names = "vdo0_mutex","vdo1_mutex";
+			clocks = <&vdosys0 CLK_VDO0_DISP_MUTEX0>,
+				 <&vdosys1 CLK_VDO1_DISP_MUTEX>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
-			clock-names = "vdo0_mutex";
-			interrupts = <GIC_SPI 658 IRQ_TYPE_LEVEL_HIGH 0>;
-			mediatek,gce-events = <CMDQ_EVENT_VDO0_DISP_STREAM_DONE_0>;
+			clock-names = "vdo0_mutex","sub_mutex";
+			interrupts = <GIC_SPI 658 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 494 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gce-events = <CMDQ_EVENT_VDO0_DISP_STREAM_DONE_0>,
+					       <CMDQ_EVENT_VDO1_STREAM_DONE_ENG_0>;
 		};
 
 		ovl0: disp_ovl@1c000000 {
@@ -2446,6 +2452,92 @@
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 		};
 
+		disp_pseudo_ovl0@1c104000 {
+			compatible = "mediatek,mt8195-disp-pseudo-ovl";
+			reg = <0 0x1c104000 0 0x1000>,
+			      <0 0x1c105000 0 0x1000>,
+			      <0 0x1c106000 0 0x1000>,
+			      <0 0x1c107000 0 0x1000>,
+			      <0 0x1c108000 0 0x1000>,
+			      <0 0x1c109000 0 0x1000>,
+			      <0 0x1c10A000 0 0x1000>,
+			      <0 0x1c10B000 0 0x1000>,
+			      <0 0x1c10C000 0 0x1000>,
+			      <0 0x1c10D000 0 0x1000>,
+			      <0 0x1c10E000 0 0x1000>,
+			      <0 0x1c10F000 0 0x1000>,
+			      <0 0x1c100000 0 0x1000>;
+			reg-names = "vdo1_mdp_rdma0","vdo1_mdp_rdma1","vdo1_mdp_rdma2",
+				    "vdo1_mdp_rdma3","vdo1_mdp_rdma4",
+				    "vdo1_mdp_rdma5","vdo1_mdp_rdma6",
+				    "vdo1_mdp_rdma7","vdo1_merge0",
+				    "vdo1_merge1","vdo1_merge2","vdo1_merge3","top";
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1c10XXXX 0x4000 0x1000>,
+						  <&gce1 SUBSYS_1c10XXXX 0x5000 0x1000>,
+						  <&gce1 SUBSYS_1c10XXXX 0x6000 0x1000>,
+						  <&gce1 SUBSYS_1c10XXXX 0x7000 0x1000>,
+						  <&gce1 SUBSYS_1c10XXXX 0x8000 0x1000>,
+						  <&gce1 SUBSYS_1c10XXXX 0x9000 0x1000>,
+						  <&gce1 SUBSYS_1c10XXXX 0xA000 0x1000>,
+						  <&gce1 SUBSYS_1c10XXXX 0xB000 0x1000>,
+						  <&gce1 SUBSYS_1c10XXXX 0xC000 0x1000>,
+						  <&gce1 SUBSYS_1c10XXXX 0xD000 0x1000>,
+						  <&gce1 SUBSYS_1c10XXXX 0xE000 0x1000>,
+						  <&gce1 SUBSYS_1c10XXXX 0xF000 0x1000>,
+						  <&gce1 SUBSYS_1c10XXXX 0x0000 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_MDP_RDMA0>,
+				 <&vdosys1 CLK_VDO1_MDP_RDMA1>,
+				 <&vdosys1 CLK_VDO1_MDP_RDMA2>,
+				 <&vdosys1 CLK_VDO1_MDP_RDMA3>,
+				 <&vdosys1 CLK_VDO1_MDP_RDMA4>,
+				 <&vdosys1 CLK_VDO1_MDP_RDMA5>,
+				 <&vdosys1 CLK_VDO1_MDP_RDMA6>,
+				 <&vdosys1 CLK_VDO1_MDP_RDMA7>,
+				 <&vdosys1 CLK_VDO1_VPP_MERGE0>,
+				 <&vdosys1 CLK_VDO1_VPP_MERGE1>,
+				 <&vdosys1 CLK_VDO1_VPP_MERGE2>,
+				 <&vdosys1 CLK_VDO1_VPP_MERGE3>,
+				 <&vdosys1 CLK_VDO1_MERGE0_DL_ASYNC>,
+				 <&vdosys1 CLK_VDO1_MERGE1_DL_ASYNC>,
+				 <&vdosys1 CLK_VDO1_MERGE2_DL_ASYNC>,
+				 <&vdosys1 CLK_VDO1_MERGE3_DL_ASYNC>;
+			clock-names = "vdo1_mdp_rdma0","vdo1_mdp_rdma1",
+				      "vdo1_mdp_rdma2","vdo1_mdp_rdma3",
+				      "vdo1_mdp_rdma4","vdo1_mdp_rdma5",
+				      "vdo1_mdp_rdma6","vdo1_mdp_rdma7",
+				      "vdo1_merge0","vdo1_merge1",
+				      "vdo1_merge2","vdo1_merge3",
+				      "vdo1_merge0_async","vdo1_merge1_async",
+				      "vdo1_merge2_async","vdo1_merge3_async";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
+			mediatek,larb = <&larb2>;
+			mediatek,smi-id = <0>;
+			iommus = <&iommu_vdo M4U_PORT_L2_MDP_RDMA0>;
+			interrupts = <GIC_SPI 495 IRQ_TYPE_LEVEL_HIGH 0>, /*rdma0*/
+				     <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH 0>, /*rdma1*/
+				     <GIC_SPI 497 IRQ_TYPE_LEVEL_HIGH 0>, /*rdma2*/
+				     <GIC_SPI 498 IRQ_TYPE_LEVEL_HIGH 0>, /*rdma3*/
+				     <GIC_SPI 499 IRQ_TYPE_LEVEL_HIGH 0>, /*rdma4*/
+				     <GIC_SPI 500 IRQ_TYPE_LEVEL_HIGH 0>, /*rdma5*/
+				     <GIC_SPI 501 IRQ_TYPE_LEVEL_HIGH 0>, /*rdma6*/
+				     <GIC_SPI 502 IRQ_TYPE_LEVEL_HIGH 0>, /*rdma7*/
+				     <GIC_SPI 503 IRQ_TYPE_LEVEL_HIGH 0>, /*merge0*/
+				     <GIC_SPI 504 IRQ_TYPE_LEVEL_HIGH 0>, /*merge1*/
+				     <GIC_SPI 505 IRQ_TYPE_LEVEL_HIGH 0>, /*merge2*/
+				     <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH 0>; /*merge3*/
+		};
+
+		merge5: disp_vpp_merge5@1c110000 {
+			compatible = "mediatek,mt8195-disp-merge";
+			reg = <0 0x1c110000 0 0x1000>;
+			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&vdosys1 CLK_VDO1_VPP_MERGE4>,
+				 <&vdosys1 CLK_VDO1_MERGE4_DL_ASYNC>;
+			clock-names = "merge5","merge5_async";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1c11XXXX 0x0000 0x1000>;
+		};
+
 		disp_dpi1: disp_dpi1@1c112000 {
 			compatible = "mediatek,mt8195-dpi";
 			reg = <0 0x1c112000 0 0x1000>;
@@ -2478,6 +2570,54 @@
 			status = "disabled";
 		};
 
+		disp_ethdr@1c114000 {
+			compatible = "mediatek,mt8195-disp-ethdr";
+			reg = <0 0x1c114000 0 0x1000>,
+			      <0 0x1c115000 0 0x1000>,
+			      <0 0x1c117000 0 0x1000>,
+			      <0 0x1c119000 0 0x1000>,
+			      <0 0x1c11A000 0 0x1000>,
+			      <0 0x1c11B000 0 0x1000>,
+			      <0 0x1c11C000 0 0x1000>,
+			      <0 0x1c100000 0 0x1000>;
+			reg-names = "hdr_disp_mixer","hdr_vdo_fe0","hdr_vdo_fe1",
+				    "hdr_gfx_fe0","hdr_gfx_fe1","hdr_vdo_be",
+				    "hdr_adl_ds","top";
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1c11XXXX 0x4000 0x1000>,
+						  <&gce1 SUBSYS_1c11XXXX 0x5000 0x1000>,
+						  <&gce1 SUBSYS_1c11XXXX 0x7000 0x1000>,
+						  <&gce1 SUBSYS_1c11XXXX 0x9000 0x1000>,
+						  <&gce1 SUBSYS_1c11XXXX 0xA000 0x1000>,
+						  <&gce1 SUBSYS_1c11XXXX 0xB000 0x1000>,
+						  <&gce1 SUBSYS_1c11XXXX 0xC000 0x1000>,
+						  <&gce1 SUBSYS_1c10XXXX 0x0000 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_DISP_MIXER>,
+				 <&vdosys1 CLK_VDO1_HDR_VDO_FE0>,
+				 <&vdosys1 CLK_VDO1_HDR_VDO_FE1>,
+				 <&vdosys1 CLK_VDO1_HDR_GFX_FE0>,
+				 <&vdosys1 CLK_VDO1_HDR_GFX_FE1>,
+				 <&vdosys1 CLK_VDO1_HDR_VDO_BE>,
+				 <&vdosys1 CLK_VDO1_26M_SLOW>,
+				 <&vdosys1 CLK_VDO1_HDR_VDO_FE0_DL_ASYNC>,
+				 <&vdosys1 CLK_VDO1_HDR_VDO_FE1_DL_ASYNC>,
+				 <&vdosys1 CLK_VDO1_HDR_GFX_FE0_DL_ASYNC>,
+				 <&vdosys1 CLK_VDO1_HDR_GFX_FE1_DL_ASYNC>,
+				 <&vdosys1 CLK_VDO1_HDR_VDO_BE_DL_ASYNC>,
+				 <&topckgen CLK_TOP_ETHDR_SEL>;
+			clock-names = "hdr_disp_mixer","hdr_vdo_fe0","hdr_vdo_fe1",
+				      "hdr_gfx_fe0","hdr_gfx_fe1","hdr_vdo_be",
+				      "hdr_adl_ds","hdr_vdo_fe0_async",
+				      "hdr_vdo_fe1_async","hdr_gfx_fe0_async",
+				      "hdr_gfx_fe1_async","hdr_vdo_be_async",
+				      "ethdr_top";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
+			mediatek,larb = <&larb3>;
+			mediatek,smi-id = <1>;
+			iommus = <&iommu_vpp M4U_PORT_L3_HDR_DS>,
+				 <&iommu_vpp M4U_PORT_L3_HDR_ADL>;
+			interrupts = <GIC_SPI 517 IRQ_TYPE_LEVEL_HIGH 0>; /*disp mixer*/
+		};
+
 		hdmi0: hdmi@1c300000 {
 			compatible = "mediatek,mt8195-hdmi";
 			reg = <0 0x1c300000 0 0x1000>;
@@ -2517,6 +2657,26 @@
 		};
 	};
 
+	disp_pseudo_ovl_l2 {
+		compatible = "mediatek,mt8195-pseudo-ovl-larb";
+		mediatek,larb-id = <2>;
+		power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
+		iommus = <&iommu_vdo M4U_PORT_L2_MDP_RDMA0>,
+			 <&iommu_vdo M4U_PORT_L2_MDP_RDMA2>,
+			 <&iommu_vdo M4U_PORT_L2_MDP_RDMA4>,
+			 <&iommu_vdo M4U_PORT_L2_MDP_RDMA6>;
+	};
+
+	disp_pseudo_ovl_l3 {
+		compatible = "mediatek,mt8195-pseudo-ovl-larb";
+		mediatek,larb-id = <3>;
+		power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
+		iommus = <&iommu_vpp M4U_PORT_L3_MDP_RDMA1>,
+			 <&iommu_vpp M4U_PORT_L3_MDP_RDMA3>,
+			 <&iommu_vpp M4U_PORT_L3_MDP_RDMA5>,
+			 <&iommu_vpp M4U_PORT_L3_MDP_RDMA7>;
+	};
+
 	hdmiddc0: ddc_i2c {
 		compatible = "mediatek,mt8195-hdmi-ddc";
 		clocks = <&clk26m>;
-- 
2.18.0

