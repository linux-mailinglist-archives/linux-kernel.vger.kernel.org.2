Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87F83F6CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 03:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbhHYBFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 21:05:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39946 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236920AbhHYBFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 21:05:41 -0400
X-UUID: 35f9c4e6bc0948a68bd0895e82daf7de-20210825
X-UUID: 35f9c4e6bc0948a68bd0895e82daf7de-20210825
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1798344261; Wed, 25 Aug 2021 09:04:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 25 Aug 2021 09:04:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 25 Aug 2021 09:04:51 +0800
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
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v5] arm64: dts: mediatek: Add mt8192 power domains controller
Date:   Wed, 25 Aug 2021 09:04:26 +0800
Message-ID: <20210825010426.30303-1-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power domains controller node for SoC mt8192

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
This patch is base on v5.14-rc1,
series "Mediatek MT8192 clock support"[1] and [2].
No changes compare v4

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=521127
[2] https://patchwork.kernel.org/project/linux-mediatek/patch/20210727023205.20319-2-chun-jie.chen@mediatek.com/
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 201 +++++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index c7c7d4e017ae..a0084a7a5bcd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
+#include <dt-bindings/power/mt8192-power.h>
 
 / {
 	compatible = "mediatek,mt8192";
@@ -301,6 +302,206 @@
 			#interrupt-cells = <2>;
 		};
 
+		scpsys: syscon@10006000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0 0x10006000 0 0x1000>;
+			#power-domain-cells = <1>;
+
+			/* System Power Manager */
+			spm: power-controller {
+				compatible = "mediatek,mt8192-power-controller";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <1>;
+
+				/* power domain of the SoC */
+				power-domain@MT8192_POWER_DOMAIN_AUDIO {
+					reg = <MT8192_POWER_DOMAIN_AUDIO>;
+					clocks = <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
+						 <&infracfg CLK_INFRA_AUDIO_26M_B>,
+						 <&infracfg CLK_INFRA_AUDIO>;
+					clock-names = "audio", "audio1", "audio2";
+					mediatek,infracfg = <&infracfg>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8192_POWER_DOMAIN_CONN {
+					reg = <MT8192_POWER_DOMAIN_CONN>;
+					clocks = <&infracfg CLK_INFRA_PMIC_CONN>;
+					clock-names = "conn";
+					mediatek,infracfg = <&infracfg>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8192_POWER_DOMAIN_MFG0 {
+					reg = <MT8192_POWER_DOMAIN_MFG0>;
+					clocks = <&topckgen CLK_TOP_MFG_PLL_SEL>;
+					clock-names = "mfg";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8192_POWER_DOMAIN_MFG1 {
+						reg = <MT8192_POWER_DOMAIN_MFG1>;
+						mediatek,infracfg = <&infracfg>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8192_POWER_DOMAIN_MFG2 {
+							reg = <MT8192_POWER_DOMAIN_MFG2>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8192_POWER_DOMAIN_MFG3 {
+							reg = <MT8192_POWER_DOMAIN_MFG3>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8192_POWER_DOMAIN_MFG4 {
+							reg = <MT8192_POWER_DOMAIN_MFG4>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8192_POWER_DOMAIN_MFG5 {
+							reg = <MT8192_POWER_DOMAIN_MFG5>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8192_POWER_DOMAIN_MFG6 {
+							reg = <MT8192_POWER_DOMAIN_MFG6>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+
+				power-domain@MT8192_POWER_DOMAIN_DISP {
+					reg = <MT8192_POWER_DOMAIN_DISP>;
+					clocks = <&topckgen CLK_TOP_DISP_SEL>,
+						 <&mmsys CLK_MM_SMI_INFRA>,
+						 <&mmsys CLK_MM_SMI_COMMON>,
+						 <&mmsys CLK_MM_SMI_GALS>,
+						 <&mmsys CLK_MM_SMI_IOMMU>;
+					clock-names = "disp", "disp-0", "disp-1", "disp-2",
+						      "disp-3";
+					mediatek,infracfg = <&infracfg>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8192_POWER_DOMAIN_IPE {
+						reg = <MT8192_POWER_DOMAIN_IPE>;
+						clocks = <&topckgen CLK_TOP_IPE_SEL>,
+							 <&ipesys CLK_IPE_LARB19>,
+							 <&ipesys CLK_IPE_LARB20>,
+							 <&ipesys CLK_IPE_SMI_SUBCOM>,
+							 <&ipesys CLK_IPE_GALS>;
+						clock-names = "ipe", "ipe-0", "ipe-1", "ipe-2",
+							      "ipe-3";
+						mediatek,infracfg = <&infracfg>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8192_POWER_DOMAIN_ISP {
+						reg = <MT8192_POWER_DOMAIN_ISP>;
+						clocks = <&topckgen CLK_TOP_IMG1_SEL>,
+							 <&imgsys CLK_IMG_LARB9>,
+							 <&imgsys CLK_IMG_GALS>;
+						clock-names = "isp", "isp-0", "isp-1";
+						mediatek,infracfg = <&infracfg>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8192_POWER_DOMAIN_ISP2 {
+						reg = <MT8192_POWER_DOMAIN_ISP2>;
+						clocks = <&topckgen CLK_TOP_IMG2_SEL>,
+							 <&imgsys2 CLK_IMG2_LARB11>,
+							 <&imgsys2 CLK_IMG2_GALS>;
+						clock-names = "isp2", "isp2-0", "isp2-1";
+						mediatek,infracfg = <&infracfg>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8192_POWER_DOMAIN_MDP {
+						reg = <MT8192_POWER_DOMAIN_MDP>;
+						clocks = <&topckgen CLK_TOP_MDP_SEL>,
+							 <&mdpsys CLK_MDP_SMI0>;
+						clock-names = "mdp", "mdp-0";
+						mediatek,infracfg = <&infracfg>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8192_POWER_DOMAIN_VENC {
+						reg = <MT8192_POWER_DOMAIN_VENC>;
+						clocks = <&topckgen CLK_TOP_VENC_SEL>,
+							 <&vencsys CLK_VENC_SET1_VENC>;
+						clock-names = "venc", "venc-0";
+						mediatek,infracfg = <&infracfg>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8192_POWER_DOMAIN_VDEC {
+						reg = <MT8192_POWER_DOMAIN_VDEC>;
+						clocks = <&topckgen CLK_TOP_VDEC_SEL>,
+							 <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
+							 <&vdecsys_soc CLK_VDEC_SOC_LAT>,
+							 <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
+						clock-names = "vdec", "vdec-0", "vdec-1", "vdec-2";
+						mediatek,infracfg = <&infracfg>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8192_POWER_DOMAIN_VDEC2 {
+							reg = <MT8192_POWER_DOMAIN_VDEC2>;
+							clocks = <&vdecsys CLK_VDEC_VDEC>,
+								 <&vdecsys CLK_VDEC_LAT>,
+								 <&vdecsys CLK_VDEC_LARB1>;
+							clock-names = "vdec2-0", "vdec2-1",
+								      "vdec2-2";
+							#power-domain-cells = <0>;
+						};
+					};
+
+					power-domain@MT8192_POWER_DOMAIN_CAM {
+						reg = <MT8192_POWER_DOMAIN_CAM>;
+						clocks = <&topckgen CLK_TOP_CAM_SEL>,
+							 <&camsys CLK_CAM_LARB13>,
+							 <&camsys CLK_CAM_LARB14>,
+							 <&camsys CLK_CAM_CCU_GALS>,
+							 <&camsys CLK_CAM_CAM2MM_GALS>;
+						clock-names = "cam", "cam-0", "cam-1", "cam-2",
+							      "cam-3";
+						mediatek,infracfg = <&infracfg>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8192_POWER_DOMAIN_CAM_RAWA {
+							reg = <MT8192_POWER_DOMAIN_CAM_RAWA>;
+							clocks = <&camsys_rawa CLK_CAM_RAWA_LARBX>;
+							clock-names = "cam_rawa-0";
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8192_POWER_DOMAIN_CAM_RAWB {
+							reg = <MT8192_POWER_DOMAIN_CAM_RAWB>;
+							clocks = <&camsys_rawb CLK_CAM_RAWB_LARBX>;
+							clock-names = "cam_rawb-0";
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8192_POWER_DOMAIN_CAM_RAWC {
+							reg = <MT8192_POWER_DOMAIN_CAM_RAWC>;
+							clocks = <&camsys_rawc CLK_CAM_RAWC_LARBX>;
+							clock-names = "cam_rawc-0";
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+			};
+		};
+
 		apmixedsys: syscon@1000c000 {
 			compatible = "mediatek,mt8192-apmixedsys", "syscon";
 			reg = <0 0x1000c000 0 0x1000>;
-- 
2.18.0

