Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9F9416687
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 22:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243177AbhIWUUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 16:20:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33308 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243148AbhIWUUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 16:20:10 -0400
Received: from p5b1274d2.dip0.t-ipconnect.de ([91.18.116.210] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mTVAx-00081Y-5F; Thu, 23 Sep 2021 22:18:35 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH] arm64: dts: rockchip: add powerdomains to rk3368
Date:   Thu, 23 Sep 2021 22:18:32 +0200
Message-Id: <20210923201832.2553667-1-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Add the core io-domain node for rk3368.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 173 +++++++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 4217897cd454..a3835dd97f99 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/power/rk3368-power.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -615,6 +616,110 @@ mbox: mbox@ff6b0000 {
 		status = "disabled";
 	};
 
+	pmu: power-management@ff730000 {
+		compatible = "rockchip,rk3368-pmu", "syscon", "simple-mfd";
+		reg = <0x0 0xff730000 0x0 0x1000>;
+
+		power: power-controller {
+			compatible = "rockchip,rk3368-power-controller";
+			#power-domain-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/*
+			 * Note: Although SCLK_* are the working clocks
+			 * of device without including on the NOC, needed for
+			 * synchronous reset.
+			 *
+			 * The clocks on the which NOC:
+			 * ACLK_IEP/ACLK_VIP/ACLK_VOP0 are on ACLK_VIO0_NIU.
+			 * ACLK_ISP/ACLK_VOP1 are on ACLK_VIO1_NIU.
+			 * ACLK_RGA is on ACLK_RGA_NIU.
+			 * The others (HCLK_*,PLCK_*) are on HCLK_VIO_NIU.
+			 *
+			 * Which clock are device clocks:
+			 *	clocks		devices
+			 *	*_IEP		IEP:Image Enhancement Processor
+			 *	*_ISP		ISP:Image Signal Processing
+			 *	*_VIP		VIP:Video Input Processor
+			 *	*_VOP*		VOP:Visual Output Processor
+			 *	*_RGA		RGA
+			 *	*_EDP*		EDP
+			 *	*_DPHY*		LVDS
+			 *	*_HDMI		HDMI
+			 *	*_MIPI_*	MIPI
+			 */
+			pd_vio@RK3368_PD_VIO {
+				reg = <RK3368_PD_VIO>;
+				clocks = <&cru ACLK_IEP>,
+					 <&cru ACLK_ISP>,
+					 <&cru ACLK_VIP>,
+					 <&cru ACLK_RGA>,
+					 <&cru ACLK_VOP>,
+					 <&cru ACLK_VOP_IEP>,
+					 <&cru DCLK_VOP>,
+					 <&cru HCLK_IEP>,
+					 <&cru HCLK_ISP>,
+					 <&cru HCLK_RGA>,
+					 <&cru HCLK_VIP>,
+					 <&cru HCLK_VOP>,
+					 <&cru HCLK_VIO_HDCPMMU>,
+					 <&cru PCLK_EDP_CTRL>,
+					 <&cru PCLK_HDMI_CTRL>,
+					 <&cru PCLK_HDCP>,
+					 <&cru PCLK_ISP>,
+					 <&cru PCLK_VIP>,
+					 <&cru PCLK_DPHYRX>,
+					 <&cru PCLK_DPHYTX0>,
+					 <&cru PCLK_MIPI_CSI>,
+					 <&cru PCLK_MIPI_DSI0>,
+					 <&cru SCLK_VOP0_PWM>,
+					 <&cru SCLK_EDP_24M>,
+					 <&cru SCLK_EDP>,
+					 <&cru SCLK_HDCP>,
+					 <&cru SCLK_ISP>,
+					 <&cru SCLK_RGA>,
+					 <&cru SCLK_HDMI_CEC>,
+					 <&cru SCLK_HDMI_HDCP>;
+				pm_qos = <&qos_iep>,
+					 <&qos_isp_r0>,
+					 <&qos_isp_r1>,
+					 <&qos_isp_w0>,
+					 <&qos_isp_w1>,
+					 <&qos_vip>,
+					 <&qos_vop>,
+					 <&qos_rga_r>,
+					 <&qos_rga_w>;
+			};
+			/*
+			 * Note: ACLK_VCODEC/HCLK_VCODEC are VCODEC
+			 * (video endecoder & decoder) clocks that on the
+			 * ACLK_VCODEC_NIU and HCLK_VCODEC_NIU (NOC).
+			 */
+			pd_video@RK3368_PD_VIDEO {
+				reg = <RK3368_PD_VIDEO>;
+				clocks = <&cru ACLK_VIDEO>,
+					 <&cru HCLK_VIDEO>,
+					 <&cru SCLK_HEVC_CABAC>,
+					 <&cru SCLK_HEVC_CORE>;
+				pm_qos = <&qos_hevc_r>,
+					 <&qos_vpu_r>,
+					 <&qos_vpu_w>;
+			};
+			/*
+			 * Note: ACLK_GPU is the GPU clock,
+			 * and on the ACLK_GPU_NIU (NOC).
+			 */
+			pd_gpu_1@RK3368_PD_GPU_1 {
+				reg = <RK3368_PD_GPU_1>;
+				clocks = <&cru ACLK_GPU_CFG>,
+					 <&cru ACLK_GPU_MEM>,
+					 <&cru SCLK_GPU_CORE>;
+				pm_qos = <&qos_gpu>;
+			};
+		};
+	};
+
 	pmugrf: syscon@ff738000 {
 		compatible = "rockchip,rk3368-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xff738000 0x0 0x1000>;
@@ -711,6 +816,7 @@ iep_mmu: iommu@ff900800 {
 		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_IEP>, <&cru HCLK_IEP>;
 		clock-names = "aclk", "iface";
+		power-domains = <&power RK3368_PD_VIO>;
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -723,6 +829,7 @@ isp_mmu: iommu@ff914000 {
 		clocks = <&cru ACLK_ISP>, <&cru HCLK_ISP>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
+		power-domains = <&power RK3368_PD_VIO>;
 		rockchip,disable-mmu-reset;
 		status = "disabled";
 	};
@@ -733,6 +840,7 @@ vop_mmu: iommu@ff930300 {
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
 		clock-names = "aclk", "iface";
+		power-domains = <&power RK3368_PD_VIO>;
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -759,6 +867,71 @@ vpu_mmu: iommu@ff9a0800 {
 		status = "disabled";
 	};
 
+	qos_iep: qos@ffad0000 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0000 0x0 0x20>;
+	};
+
+	qos_isp_r0: qos@ffad0080 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0080 0x0 0x20>;
+	};
+
+	qos_isp_r1: qos@ffad0100 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0100 0x0 0x20>;
+	};
+
+	qos_isp_w0: qos@ffad0180 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0180 0x0 0x20>;
+	};
+
+	qos_isp_w1: qos@ffad0200 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0200 0x0 0x20>;
+	};
+
+	qos_vip: qos@ffad0280 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0280 0x0 0x20>;
+	};
+
+	qos_vop: qos@ffad0300 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0300 0x0 0x20>;
+	};
+
+	qos_rga_r: qos@ffad0380 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0380 0x0 0x20>;
+	};
+
+	qos_rga_w: qos@ffad0400 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0400 0x0 0x20>;
+	};
+
+	qos_hevc_r: qos@ffae0000 {
+		compatible = "syscon";
+		reg = <0x0 0xffae0000 0x0 0x20>;
+	};
+
+	qos_vpu_r: qos@ffae0100 {
+		compatible = "syscon";
+		reg = <0x0 0xffae0100 0x0 0x20>;
+	};
+
+	qos_vpu_w: qos@ffae0180 {
+		compatible = "syscon";
+		reg = <0x0 0xffae0180 0x0 0x20>;
+	};
+
+	qos_gpu: qos@ffaf0000 {
+		compatible = "syscon";
+		reg = <0x0 0xffaf0000 0x0 0x20>;
+	};
+
 	efuse256: efuse@ffb00000 {
 		compatible = "rockchip,rk3368-efuse";
 		reg = <0x0 0xffb00000 0x0 0x20>;
-- 
2.29.2

