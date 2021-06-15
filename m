Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FC43A87CA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhFORfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:35:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34965 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231213AbhFORe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:34:56 -0400
X-UUID: d1cbf97e3e8d42d4b0523043857ad32e-20210616
X-UUID: d1cbf97e3e8d42d4b0523043857ad32e-20210616
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1865074562; Wed, 16 Jun 2021 01:32:45 +0800
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
        Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH 15/27] arm64: dts: mt8195: add IOMMU and smi nodes
Date:   Wed, 16 Jun 2021 01:32:21 +0800
Message-ID: <20210615173233.26682-15-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210615173233.26682-1-tinghan.shen@mediatek.com>
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yong Wu <yong.wu@mediatek.com>

add smi support for mt8195 SoC.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 445 +++++++++++++++++++++++
 1 file changed, 445 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 41d9f167701f..856b0e938009 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/mt8195-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/memory/mt8195-memory-port.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
 #include <dt-bindings/power/mt8195-power.h>
@@ -765,6 +766,17 @@
 			#clock-cells = <1>;
 		};
 
+		iommu_infra: infra-iommu@10315000 {
+			compatible = "mediatek,mt8195-iommu-infra";
+			reg = <0 0x10315000 0 0x1000>,
+			      <0 0x11003000 0 0x1000>;
+			interrupts = <GIC_SPI 795 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>;
+			clock-names = "bclk";
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
 		scp_adsp: syscon@10720000 {
 			compatible = "mediatek,mt8195-scp_adsp", "syscon";
 			reg = <0 0x10720000 0 0x1000>;
@@ -1403,6 +1415,55 @@
 			#clock-cells = <1>;
 		};
 
+		smi_common2: smi@1400e000 {
+			compatible = "mediatek,mt8195-smi-common";
+			mediatek,common-id = <2>;
+			reg = <0 0x1400e000 0 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_SMI_COMMON>,
+				 <&vppsys0 CLK_VPP0_SMI_COMMON>,
+				 <&vppsys0 CLK_VPP0_GALS_INFRA>,
+				 <&vppsys0 CLK_VPP0_GALS_CAMSYS>;
+			clock-names = "apb", "smi", "gals0", "gals1";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		smi_common1: smi@14012000 {
+			compatible = "mediatek,mt8195-smi-common";
+			mediatek,common-id = <1>;
+			reg = <0 0x14012000 0 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_SMI_COMMON_LARB4>,
+				 <&vppsys0 CLK_VPP0_SMI_COMMON_LARB4>,
+				 <&vppsys0 CLK_VPP0_GALS_EMI0_EMI1>,
+				 <&vppsys0 CLK_VPP0_SMI_SUB_COMMON_REORDER>;
+			clock-names = "apb", "smi", "gals0", "gals1";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		larb4: larb@14013000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x14013000 0 0x1000>;
+			mediatek,larb-id = <4>;
+			mediatek,smi = <&smi_common1>;
+			clocks = <&vppsys0 CLK_VPP0_GALS_VPP1_WPE>,
+				 <&vppsys0 CLK_VPP0_SMI_COMMON_LARB4>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		iommu_vpp: iommu@14018000 {
+			compatible = "mediatek,mt8195-iommu-vpp";
+			reg = <0 0x14018000 0 0x1000>;
+			mediatek,larbs = <&larb1 &larb3 &larb4 &larb6 &larb8
+					  &larb12 &larb14 &larb16 &larb18
+					  &larb20 &larb22 &larb23 &larb26
+					  &larb27>;
+			interrupts = <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&vppsys0 CLK_VPP0_SMI_IOMMU>;
+			clock-names = "bclk";
+			#iommu-cells = <1>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
+		};
+
 		wpesys: syscon@14e00000 {
 			compatible = "mediatek,mt8195-wpesys", "syscon";
 			reg = <0 0x14e00000 0 0x1000>;
@@ -1421,24 +1482,97 @@
 			#clock-cells = <1>;
 		};
 
+		larb7: larb@14e04000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x14e04000 0 0x1000>;
+			mediatek,larb-id = <7>;
+			mediatek,smi = <&smi_common0>;
+			clocks = <&wpesys CLK_WPE_SMI_LARB7>,
+				 <&wpesys CLK_WPE_SMI_LARB7>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_WPESYS>;
+		};
+
+		larb8: larb@14e05000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x14e05000 0 0x1000>;
+			mediatek,larb-id = <8>;
+			mediatek,smi = <&smi_common1>;
+			clocks = <&wpesys CLK_WPE_SMI_LARB8>,
+				 <&wpesys CLK_WPE_SMI_LARB8>,
+				 <&vppsys0 CLK_VPP0_GALS_VPP1_WPE>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_WPESYS>;
+		};
+
 		vppsys1: syscon@14f00000 {
 			compatible = "mediatek,mt8195-vppsys1", "syscon";
 			reg = <0 0x14f00000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb5: larb@14f02000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x14f02000 0 0x1000>;
+			mediatek,larb-id = <5>;
+			mediatek,smi = <&smi_common0>;
+			clocks = <&vppsys1 CLK_VPP1_VPPSYS1_LARB>,
+				 <&vppsys1 CLK_VPP1_VPPSYS1_GALS>,
+				 <&vppsys0 CLK_VPP0_GALS_VPP1_LARB5>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
+		larb6: larb@14f03000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x14f03000 0 0x1000>;
+			mediatek,larb-id = <6>;
+			mediatek,smi = <&smi_common1>;
+			clocks = <&vppsys0 CLK_VPP0_GALS_VPP1_WPE>,
+				 <&vppsys1 CLK_VPP1_VPPSYS1_LARB>,
+				 <&vppsys1 CLK_VPP1_VPPSYS1_GALS>,
+				 <&vppsys0 CLK_VPP0_GALS_VPP1_LARB6>;
+			clock-names = "apb", "smi", "gals", "gals1";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS1>;
+		};
+
 		imgsys: syscon@15000000 {
 			compatible = "mediatek,mt8195-imgsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb9: larb@15001000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x15001000 0 0x1000>;
+			mediatek,larb-id = <9>;
+			mediatek,smi = <&smi_common0>;
+			clocks = <&imgsys CLK_IMG_LARB9>,
+				 <&imgsys CLK_IMG_LARB9>,
+				 <&imgsys CLK_IMG_GALS>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_IMG>;
+		};
+
 		imgsys1_dip_top: syscon@15110000 {
 			compatible = "mediatek,mt8195-imgsys1_dip_top", "syscon";
 			reg = <0 0x15110000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb10: larb@15120000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x15120000 0 0x1000>;
+			mediatek,larb-id = <10>;
+			mediatek,smi = <&smi_common0>;
+			clocks = <&imgsys CLK_IMG_DIP0>,
+				 <&imgsys1_dip_top CLK_IMG1_DIP_TOP_LARB10>,
+				 <&imgsys CLK_IMG_LARB9>,
+				 <&imgsys CLK_IMG_GALS>;
+			clock-names = "apb", "smi", "gals", "gals1";
+			power-domains = <&spm MT8195_POWER_DOMAIN_DIP>;
+		};
+
 		imgsys1_dip_nr: syscon@15130000 {
 			compatible = "mediatek,mt8195-imgsys1_dip_nr", "syscon";
 			reg = <0 0x15130000 0 0x1000>;
@@ -1451,18 +1585,122 @@
 			#clock-cells = <1>;
 		};
 
+		larb11: larb@15230000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x15230000 0 0x1000>;
+			mediatek,larb-id = <11>;
+			mediatek,smi = <&smi_common0>;
+			clocks = <&imgsys CLK_IMG_WPE0>,
+				 <&imgsys1_wpe CLK_IMG1_WPE_LARB11>,
+				 <&imgsys CLK_IMG_LARB9>,
+				 <&imgsys CLK_IMG_GALS>;
+			clock-names = "apb", "smi", "gals", "gals1";
+			power-domains = <&spm MT8195_POWER_DOMAIN_DIP>;
+		};
+
 		ipesys: syscon@15330000 {
 			compatible = "mediatek,mt8195-ipesys", "syscon";
 			reg = <0 0x15330000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb12: larb@15340000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x15340000 0 0x1000>;
+			mediatek,larb-id = <12>;
+			mediatek,smi = <&smi_common1>;
+			clocks = <&imgsys CLK_IMG_IPE>,
+				 <&ipesys CLK_IPE_SMI_LARB12>,
+				 <&imgsys CLK_IMG_GALS>,
+				 <&vppsys0 CLK_VPP0_GALS_IMGSYS_CAMSYS>;
+			clock-names = "apb", "smi", "gals", "gals1";
+			power-domains = <&spm MT8195_POWER_DOMAIN_IPE>;
+		};
+
 		camsys: syscon@16000000 {
 			compatible = "mediatek,mt8195-camsys", "syscon";
 			reg = <0 0x16000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb13: larb@16001000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x16001000 0 0x1000>;
+			mediatek,larb-id = <13>;
+			mediatek,smi = <&smi_common0>;
+			clocks = <&camsys CLK_CAM_LARB13>,
+				 <&camsys CLK_CAM_LARB13>,
+				 <&camsys CLK_CAM_CAM2MM0_GALS>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM>;
+		};
+
+		larb14: larb@16002000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x16002000 0 0x1000>;
+			mediatek,larb-id = <14>;
+			mediatek,smi = <&smi_common1>;
+			clocks = <&camsys CLK_CAM_LARB14>,
+				 <&camsys CLK_CAM_LARB14>,
+				 <&camsys CLK_CAM_CAM2MM1_GALS>,
+				 <&camsys CLK_CAM_CAM2SYS_GALS>,
+				 <&vppsys0 CLK_VPP0_GALS_IMGSYS_CAMSYS>;
+			clock-names = "apb", "smi", "gals", "gals1", "gals2";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM>;
+		};
+
+		larb16: larb@16012000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x16012000 0 0x1000>;
+			mediatek,larb-id = <16>;
+			mediatek,smi = <&smi_common1>;
+			clocks = <&camsys CLK_CAM_LARB14>,
+				 <&camsys_rawa CLK_CAM_RAWA_LARBX>,
+				 <&camsys CLK_CAM_CAM2MM1_GALS>,
+				 <&camsys CLK_CAM_CAM2SYS_GALS>,
+				 <&vppsys0 CLK_VPP0_GALS_IMGSYS_CAMSYS>;
+			clock-names = "apb", "smi", "gals", "gals1", "gals2";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM_RAWA>;
+		};
+
+		larb17: larb@16013000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x16013000 0 0x1000>;
+			mediatek,larb-id = <17>;
+			mediatek,smi = <&smi_common0>;
+			clocks = <&camsys CLK_CAM_LARB13>,
+				 <&camsys_yuva CLK_CAM_YUVA_LARBX>,
+				 <&camsys CLK_CAM_CAM2MM0_GALS>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM_RAWA>;
+		};
+
+		larb27: larb@16014000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x16014000 0 0x1000>;
+			mediatek,larb-id = <27>;
+			mediatek,smi = <&smi_common1>;
+			clocks = <&camsys CLK_CAM_LARB14>,
+				 <&camsys_rawb CLK_CAM_RAWB_LARBX>,
+				 <&camsys CLK_CAM_CAM2MM1_GALS>,
+				 <&camsys CLK_CAM_CAM2SYS_GALS>,
+				 <&vppsys0 CLK_VPP0_GALS_IMGSYS_CAMSYS>;
+			clock-names = "apb", "smi", "gals", "gals1", "gals2";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM_RAWB>;
+		};
+
+		larb28: larb@16015000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x16015000 0 0x1000>;
+			mediatek,larb-id = <28>;
+			mediatek,smi = <&smi_common0>;
+			clocks = <&camsys CLK_CAM_LARB13>,
+				 <&camsys_yuvb CLK_CAM_YUVB_LARBX>,
+				 <&camsys CLK_CAM_CAM2MM0_GALS>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM_RAWB>;
+		};
+
 		camsys_rawa: syscon@1604f000 {
 			compatible = "mediatek,mt8195-camsys_rawa", "syscon";
 			reg = <0 0x1604f000 0 0x1000>;
@@ -1493,30 +1731,135 @@
 			#clock-cells = <1>;
 		};
 
+		larb25: larb@16141000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x16141000 0 0x1000>;
+			mediatek,larb-id = <25>;
+			mediatek,smi = <&smi_common0>;
+			clocks = <&camsys CLK_CAM_LARB13>,
+				 <&camsys_mraw CLK_CAM_MRAW_LARBX>,
+				 <&camsys CLK_CAM_CAM2MM0_GALS>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM_MRAW>;
+		};
+
+		larb26: larb@16142000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x16142000 0 0x1000>;
+			mediatek,larb-id = <26>;
+			mediatek,smi = <&smi_common1>;
+			clocks = <&camsys CLK_CAM_LARB14>,
+				<&camsys_mraw CLK_CAM_MRAW_LARBX>,
+				<&camsys CLK_CAM_CAM2MM1_GALS>,
+				<&vppsys0 CLK_VPP0_GALS_IMGSYS_CAMSYS>;
+			clock-names = "apb", "smi", "gals", "gals1";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM_MRAW>;
+
+		};
+
 		ccusys: syscon@17200000 {
 			compatible = "mediatek,mt8195-ccusys", "syscon";
 			reg = <0 0x17200000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb18: larb@17201000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x17201000 0 0x1000>;
+			mediatek,larb-id = <18>;
+			mediatek,smi = <&smi_common1>;
+			clocks = <&camsys CLK_CAM_LARB14>,
+				 <&ccusys CLK_CCU_LARB18>,
+				 <&camsys CLK_CAM_CAM2MM1_GALS>,
+				 <&vppsys0 CLK_VPP0_GALS_IMGSYS_CAMSYS>;
+			clock-names = "apb", "smi", "gals", "gals1";
+			power-domains = <&spm MT8195_POWER_DOMAIN_CAM>;
+		};
+
+		larb24: larb@1800d000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1800d000 0 0x1000>;
+			mediatek,larb-id = <24>;
+			mediatek,smi = <&smi_common0>;
+			clocks = <&vdecsys_soc CLK_VDEC_SOC_LARB1>,
+				 <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDEC0>;
+		};
+
+		larb23: larb@1800e000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1800e000 0 0x1000>;
+			mediatek,larb-id = <23>;
+			mediatek,smi = <&smi_common1>;
+			clocks = <&vppsys0 CLK_VPP0_GALS_VDEC_VDEC_CORE1>,
+				 <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDEC0>;
+		};
+
 		vdecsys_soc: syscon@1800f000 {
 			compatible = "mediatek,mt8195-vdecsys_soc", "syscon";
 			reg = <0 0x1800f000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb21: larb@1802e000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1802e000 0 0x1000>;
+			mediatek,larb-id = <21>;
+			mediatek,smi = <&smi_common0>;
+			clocks = <&vdecsys CLK_VDEC_LARB1>,
+				 <&vdecsys CLK_VDEC_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDEC1>;
+		};
+
 		vdecsys: syscon@1802f000 {
 			compatible = "mediatek,mt8195-vdecsys", "syscon";
 			reg = <0 0x1802f000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb22: larb@1803e000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1803e000 0 0x1000>;
+			mediatek,larb-id = <22>;
+			mediatek,smi = <&smi_common1>;
+			clocks = <&vppsys0 CLK_VPP0_GALS_VDEC_VDEC_CORE1>,
+				 <&vdecsys_core1 CLK_VDEC_CORE1_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDEC2>;
+		};
+
 		vdecsys_core1: syscon@1803f000 {
 			compatible = "mediatek,mt8195-vdecsys_core1", "syscon";
 			reg = <0 0x1803f000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		iommu_apu0: iommu@19010000 {
+			compatible = "mediatek,mt8195-iommu-apu";
+			reg = <0 0x19010000 0 0x1000>;
+			interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>;
+			clock-names = "bclk";
+			#iommu-cells = <1>;
+			/* power-domains = <&apuspm MT8195_POWER_DOMAIN_APUSYS_TOP>; */
+			status = "disabled";
+		};
+
+		iommu_apu1: iommu@19015000 {
+			compatible = "mediatek,mt8195-iommu-apu";
+			reg = <0 0x19015000 0 0x1000>;
+			interrupts = <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>;
+			clock-names = "bclk";
+			#iommu-cells = <1>;
+			/* power-domains = <&apuspm MT8195_POWER_DOMAIN_APUSYS_TOP>; */
+			status = "disabled";
+		};
+
 		apusys_pll: syscon@190f3000 {
 			compatible = "mediatek,mt8195-apusys_pll", "syscon";
 			reg = <0 0x190f3000 0 0x1000>;
@@ -1529,24 +1872,126 @@
 			#clock-cells = <1>;
 		};
 
+		larb19: larb@1a010000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1a010000 0 0x1000>;
+			mediatek,larb-id = <19>;
+			mediatek,smi = <&smi_common0>;
+			clocks = <&vencsys CLK_VENC_VENC>,
+				 <&vencsys CLK_VENC_LARB>,
+				 <&vencsys CLK_VENC_GALS>,
+				 <&vppsys0 CLK_VPP0_GALS_VENCSYS>;
+			clock-names = "apb", "smi", "gals", "gals1";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
+		};
+
 		vencsys_core1: syscon@1b000000 {
 			compatible = "mediatek,mt8195-vencsys_core1", "syscon";
 			reg = <0 0x1b000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb20: larb@1b010000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1b010000 0 0x1000>;
+			mediatek,larb-id = <20>;
+			mediatek,smi = <&smi_common1>;
+			clocks = <&vencsys_core1 CLK_VENC_CORE1_VENC>,
+				 <&vencsys_core1 CLK_VENC_CORE1_LARB>,
+				 <&vencsys_core1 CLK_VENC_CORE1_GALS>,
+				 <&vppsys0 CLK_VPP0_GALS_VDO0_VDO1_VENCSYS_CORE1>,
+				 <&vppsys0 CLK_VPP0_GALS_VENCSYS_CORE1>;
+			clock-names = "apb", "smi", "gals", "gals1", "gals2";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
+		};
+
 		vdosys0: syscon@1c01a000 {
 			compatible = "mediatek,mt8195-vdosys0", "syscon";
 			reg = <0 0x1c01a000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		smi_common0: smi@1c01b000 {
+			compatible = "mediatek,mt8195-smi-common";
+			mediatek,common-id = <0>;
+			reg = <0 0x1c01b000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_SMI_COMMON>,
+				 <&vdosys0 CLK_VDO0_SMI_COMMON>,
+				 <&vdosys0 CLK_VDO0_SMI_EMI>,
+				 <&vdosys0 CLK_VDO0_SMI_GALS>;
+			clock-names = "apb", "smi", "gals0", "gals1";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+
+		};
+
+		iommu_vdo: iommu@1c01f000 {
+			compatible = "mediatek,mt8195-iommu-vdo";
+			reg = <0 0x1c01f000 0 0x1000>;
+			mediatek,larbs = <&larb0 &larb2 &larb5 &larb7 &larb9
+					  &larb10 &larb11 &larb13 &larb17
+					  &larb19 &larb21 &larb24 &larb25
+					  &larb28>;
+			interrupts = <GIC_SPI 669 IRQ_TYPE_LEVEL_HIGH 0>;
+			#iommu-cells = <1>;
+			clocks = <&vdosys0 CLK_VDO0_SMI_IOMMU>;
+			clock-names = "bclk";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+		};
+
+		larb0: larb@1c018000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1c018000 0 0x1000>;
+			mediatek,larb-id = <0>;
+			mediatek,smi = <&smi_common0>;
+			clocks = <&vdosys0 CLK_VDO0_SMI_LARB>,
+				 <&vdosys0 CLK_VDO0_SMI_LARB>,
+				 <&vppsys0 CLK_VPP0_GALS_VDO0_LARB0>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+		};
+
+		larb1: larb@1c019000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1c019000 0 0x1000>;
+			mediatek,larb-id = <1>;
+			mediatek,smi = <&smi_common1>;
+			clocks = <&vdosys0 CLK_VDO0_SMI_LARB>,
+				 <&vppsys0 CLK_VPP0_GALS_VDO0_VDO1_VENCSYS_CORE1>,
+				 <&vppsys0 CLK_VPP0_GALS_VDO0_LARB1>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
+		};
+
 		vdosys1: syscon@1c100000 {
 			compatible = "mediatek,mt8195-vdosys1", "syscon";
 			reg = <0 0x1c100000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb2: larb@1c102000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1c102000 0 0x1000>;
+			mediatek,larb-id = <2>;
+			mediatek,smi = <&smi_common0>;
+			clocks = <&vdosys1 CLK_VDO1_SMI_LARB2>,
+				 <&vdosys1 CLK_VDO1_SMI_LARB2>,
+				 <&vdosys1 CLK_VDO1_GALS>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
+		};
+
+		larb3: larb@1c103000 {
+			compatible = "mediatek,mt8195-smi-larb";
+			reg = <0 0x1c103000 0 0x1000>;
+			mediatek,larb-id = <3>;
+			mediatek,smi = <&smi_common1>;
+			clocks = <&vdosys1 CLK_VDO1_SMI_LARB3>,
+				 <&vdosys1 CLK_VDO1_GALS>,
+				 <&vppsys0 CLK_VPP0_GALS_VDO0_VDO1_VENCSYS_CORE1>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
+		};
+
 		disp_dpi1: disp_dpi1@1c112000 {
 			compatible = "mediatek,mt8195-dpi";
 			reg = <0 0x1c112000 0 0x1000>;
-- 
2.18.0

