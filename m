Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DCF3B2FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 15:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhFXNM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:12:56 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:43204 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhFXNMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:12:55 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 8A393C09D8;
        Thu, 24 Jun 2021 21:10:30 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P1335T140034512512768S1624540229513361_;
        Thu, 24 Jun 2021 21:10:30 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <dde917c3c63dee57581db4e4cdf3fa57>
X-RL-SENDER: cl@rock-chips.com
X-SENDER: cl@rock-chips.com
X-LOGIN-NAME: cl@rock-chips.com
X-FST-TO: heiko@sntech.de
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   <cl@rock-chips.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, jbx6244@gmail.com, zhangqing@rock-chips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, Liang Chen <cl@rock-chips.com>
Subject: [RESEND PATCH v1 3/3] arm64: dts: rockchip: add pmu and qos nodes for rk3568
Date:   Thu, 24 Jun 2021 21:10:27 +0800
Message-Id: <20210624131027.3719-1-cl@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210624114719.1685-1-cl@rock-chips.com>
References: <20210624114719.1685-1-cl@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Add the power-management and QoS nodes to the core rk3568 dtsi.

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 229 +++++++++++++++++++++++
 1 file changed, 229 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index d225e6a45d5c..618849186c39 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/power/rk3568-power.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -257,6 +258,99 @@
 		status = "disabled";
 	};
 
+	pmu: power-management@fdd90000 {
+		compatible = "rockchip,rk3568-pmu", "syscon", "simple-mfd";
+		reg = <0x0 0xfdd90000 0x0 0x1000>;
+
+		power: power-controller {
+			compatible = "rockchip,rk3568-power-controller";
+			#power-domain-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* These power domains are grouped by VD_GPU */
+			power-domain@RK3568_PD_GPU {
+				reg = <RK3568_PD_GPU>;
+				clocks = <&cru ACLK_GPU_PRE>,
+					 <&cru PCLK_GPU_PRE>;
+				pm_qos = <&qos_gpu>;
+				#power-domain-cells = <0>;
+			};
+
+			/* These power domains are grouped by VD_LOGIC */
+			power-domain@RK3568_PD_VI {
+				reg = <RK3568_PD_VI>;
+				clocks = <&cru HCLK_VI>,
+					 <&cru PCLK_VI>;
+				pm_qos = <&qos_isp>,
+					 <&qos_vicap0>,
+					 <&qos_vicap1>;
+				#power-domain-cells = <0>;
+			};
+
+			power-domain@RK3568_PD_VO {
+				reg = <RK3568_PD_VO>;
+				clocks = <&cru HCLK_VO>,
+					 <&cru PCLK_VO>,
+					 <&cru ACLK_VOP_PRE>;
+				pm_qos = <&qos_hdcp>,
+					 <&qos_vop_m0>,
+					 <&qos_vop_m1>;
+				#power-domain-cells = <0>;
+			};
+
+			power-domain@RK3568_PD_RGA {
+				reg = <RK3568_PD_RGA>;
+				clocks = <&cru HCLK_RGA_PRE>,
+					 <&cru PCLK_RGA_PRE>;
+				pm_qos = <&qos_ebc>,
+					 <&qos_iep>,
+					 <&qos_jpeg_dec>,
+					 <&qos_jpeg_enc>,
+					 <&qos_rga_rd>,
+					 <&qos_rga_wr>;
+				#power-domain-cells = <0>;
+			};
+
+			power-domain@RK3568_PD_VPU {
+				reg = <RK3568_PD_VPU>;
+				clocks = <&cru HCLK_VPU_PRE>;
+				pm_qos = <&qos_vpu>;
+				#power-domain-cells = <0>;
+			};
+
+			power-domain@RK3568_PD_RKVDEC {
+				clocks = <&cru HCLK_RKVDEC_PRE>;
+				reg = <RK3568_PD_RKVDEC>;
+				pm_qos = <&qos_rkvdec>;
+				#power-domain-cells = <0>;
+			};
+
+			power-domain@RK3568_PD_RKVENC {
+				reg = <RK3568_PD_RKVENC>;
+				clocks = <&cru HCLK_RKVENC_PRE>;
+				pm_qos = <&qos_rkvenc_rd_m0>,
+					 <&qos_rkvenc_rd_m1>,
+					 <&qos_rkvenc_wr_m0>;
+				#power-domain-cells = <0>;
+			};
+
+			power-domain@RK3568_PD_PIPE {
+				reg = <RK3568_PD_PIPE>;
+				clocks = <&cru PCLK_PIPE>;
+				pm_qos = <&qos_pcie2x1>,
+					 <&qos_pcie3x1>,
+					 <&qos_pcie3x2>,
+					 <&qos_sata0>,
+					 <&qos_sata1>,
+					 <&qos_sata2>,
+					 <&qos_usb3_0>,
+					 <&qos_usb3_1>;
+				#power-domain-cells = <0>;
+			};
+		};
+	};
+
 	sdmmc2: mmc@fe000000 {
 		compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xfe000000 0x0 0x4000>;
@@ -271,6 +365,141 @@
 		status = "disabled";
 	};
 
+	qos_gpu: qos@fe128000 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe128000 0x0 0x20>;
+	};
+
+	qos_rkvenc_rd_m0: qos@fe138080 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe138080 0x0 0x20>;
+	};
+
+	qos_rkvenc_rd_m1: qos@fe138100 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe138100 0x0 0x20>;
+	};
+
+	qos_rkvenc_wr_m0: qos@fe138180 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe138180 0x0 0x20>;
+	};
+
+	qos_isp: qos@fe148000 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe148000 0x0 0x20>;
+	};
+
+	qos_vicap0: qos@fe148080 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe148080 0x0 0x20>;
+	};
+
+	qos_vicap1: qos@fe148100 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe148100 0x0 0x20>;
+	};
+
+	qos_vpu: qos@fe150000 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe150000 0x0 0x20>;
+	};
+
+	qos_ebc: qos@fe158000 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe158000 0x0 0x20>;
+	};
+
+	qos_iep: qos@fe158100 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe158100 0x0 0x20>;
+	};
+
+	qos_jpeg_dec: qos@fe158180 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe158180 0x0 0x20>;
+	};
+
+	qos_jpeg_enc: qos@fe158200 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe158200 0x0 0x20>;
+	};
+
+	qos_rga_rd: qos@fe158280 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe158280 0x0 0x20>;
+	};
+
+	qos_rga_wr: qos@fe158300 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe158300 0x0 0x20>;
+	};
+
+	qos_npu: qos@fe180000 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe180000 0x0 0x20>;
+	};
+
+	qos_pcie2x1: qos@fe190000 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe190000 0x0 0x20>;
+	};
+
+	qos_pcie3x1: qos@fe190080 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe190080 0x0 0x20>;
+	};
+
+	qos_pcie3x2: qos@fe190100 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe190100 0x0 0x20>;
+	};
+
+	qos_sata0: qos@fe190200 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe190200 0x0 0x20>;
+	};
+
+	qos_sata1: qos@fe190280 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe190280 0x0 0x20>;
+	};
+
+	qos_sata2: qos@fe190300 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe190300 0x0 0x20>;
+	};
+
+	qos_usb3_0: qos@fe190380 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe190380 0x0 0x20>;
+	};
+
+	qos_usb3_1: qos@fe190400 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe190400 0x0 0x20>;
+	};
+
+	qos_rkvdec: qos@fe198000 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe198000 0x0 0x20>;
+	};
+
+	qos_hdcp: qos@fe1a8000 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe1a8000 0x0 0x20>;
+	};
+
+	qos_vop_m0: qos@fe1a8080 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe1a8080 0x0 0x20>;
+	};
+
+	qos_vop_m1: qos@fe1a8100 {
+		compatible = "rockchip,rk3568-qos", "syscon";
+		reg = <0x0 0xfe1a8100 0x0 0x20>;
+	};
+
 	sdmmc0: mmc@fe2b0000 {
 		compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xfe2b0000 0x0 0x4000>;
-- 
2.17.1



