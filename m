Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492A134A588
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhCZK3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:29:09 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:50964 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCZK2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:28:41 -0400
Received: from localhost (unknown [192.168.167.223])
        by lucky1.263xmail.com (Postfix) with ESMTP id 06203CD1A6;
        Fri, 26 Mar 2021 18:28:39 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P2194T140113075984128S1616754516474912_;
        Fri, 26 Mar 2021 18:28:38 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d55795ee0f2dfcf690119141a334ac1e>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: robh+dt@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     robh+dt@kernel.org, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v6 06/11] arm64: dts: rockchip: Fix power-controller node names for rk3399
Date:   Fri, 26 Mar 2021 18:28:35 +0800
Message-Id: <20210326102835.14953-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326102738.14767-1-zhangqing@rock-chips.com>
References: <20210326102738.14767-1-zhangqing@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use more generic names (as recommended in the device tree specification
or the binding documentation)

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 40 ++++++++++++------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index edbbf35fe19e..142f5593d48b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -971,26 +971,26 @@
 			#size-cells = <0>;
 
 			/* These power domains are grouped by VD_CENTER */
-			pd_iep@RK3399_PD_IEP {
+			power-domain@RK3399_PD_IEP {
 				reg = <RK3399_PD_IEP>;
 				clocks = <&cru ACLK_IEP>,
 					 <&cru HCLK_IEP>;
 				pm_qos = <&qos_iep>;
 			};
-			pd_rga@RK3399_PD_RGA {
+			power-domain@RK3399_PD_RGA {
 				reg = <RK3399_PD_RGA>;
 				clocks = <&cru ACLK_RGA>,
 					 <&cru HCLK_RGA>;
 				pm_qos = <&qos_rga_r>,
 					 <&qos_rga_w>;
 			};
-			pd_vcodec@RK3399_PD_VCODEC {
+			power-domain@RK3399_PD_VCODEC {
 				reg = <RK3399_PD_VCODEC>;
 				clocks = <&cru ACLK_VCODEC>,
 					 <&cru HCLK_VCODEC>;
 				pm_qos = <&qos_video_m0>;
 			};
-			pd_vdu@RK3399_PD_VDU {
+			power-domain@RK3399_PD_VDU {
 				reg = <RK3399_PD_VDU>;
 				clocks = <&cru ACLK_VDU>,
 					 <&cru HCLK_VDU>;
@@ -999,94 +999,94 @@
 			};
 
 			/* These power domains are grouped by VD_GPU */
-			pd_gpu@RK3399_PD_GPU {
+			power-domain@RK3399_PD_GPU {
 				reg = <RK3399_PD_GPU>;
 				clocks = <&cru ACLK_GPU>;
 				pm_qos = <&qos_gpu>;
 			};
 
 			/* These power domains are grouped by VD_LOGIC */
-			pd_edp@RK3399_PD_EDP {
+			power-domain@RK3399_PD_EDP {
 				reg = <RK3399_PD_EDP>;
 				clocks = <&cru PCLK_EDP_CTRL>;
 			};
-			pd_emmc@RK3399_PD_EMMC {
+			power-domain@RK3399_PD_EMMC {
 				reg = <RK3399_PD_EMMC>;
 				clocks = <&cru ACLK_EMMC>;
 				pm_qos = <&qos_emmc>;
 			};
-			pd_gmac@RK3399_PD_GMAC {
+			power-domain@RK3399_PD_GMAC {
 				reg = <RK3399_PD_GMAC>;
 				clocks = <&cru ACLK_GMAC>,
 					 <&cru PCLK_GMAC>;
 				pm_qos = <&qos_gmac>;
 			};
-			pd_sd@RK3399_PD_SD {
+			power-domain@RK3399_PD_SD {
 				reg = <RK3399_PD_SD>;
 				clocks = <&cru HCLK_SDMMC>,
 					 <&cru SCLK_SDMMC>;
 				pm_qos = <&qos_sd>;
 			};
-			pd_sdioaudio@RK3399_PD_SDIOAUDIO {
+			power-domain@RK3399_PD_SDIOAUDIO {
 				reg = <RK3399_PD_SDIOAUDIO>;
 				clocks = <&cru HCLK_SDIO>;
 				pm_qos = <&qos_sdioaudio>;
 			};
-			pd_tcpc0@RK3399_PD_TCPD0 {
+			power-domain@RK3399_PD_TCPD0 {
 				reg = <RK3399_PD_TCPD0>;
 				clocks = <&cru SCLK_UPHY0_TCPDCORE>,
 					 <&cru SCLK_UPHY0_TCPDPHY_REF>;
 			};
-			pd_tcpc1@RK3399_PD_TCPD1 {
+			power-domain@RK3399_PD_TCPD1 {
 				reg = <RK3399_PD_TCPD1>;
 				clocks = <&cru SCLK_UPHY1_TCPDCORE>,
 					 <&cru SCLK_UPHY1_TCPDPHY_REF>;
 			};
-			pd_usb3@RK3399_PD_USB3 {
+			power-domain@RK3399_PD_USB3 {
 				reg = <RK3399_PD_USB3>;
 				clocks = <&cru ACLK_USB3>;
 				pm_qos = <&qos_usb_otg0>,
 					 <&qos_usb_otg1>;
 			};
-			pd_vio@RK3399_PD_VIO {
+			power-domain@RK3399_PD_VIO {
 				reg = <RK3399_PD_VIO>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				pd_hdcp@RK3399_PD_HDCP {
+				power-domain@RK3399_PD_HDCP {
 					reg = <RK3399_PD_HDCP>;
 					clocks = <&cru ACLK_HDCP>,
 						 <&cru HCLK_HDCP>,
 						 <&cru PCLK_HDCP>;
 					pm_qos = <&qos_hdcp>;
 				};
-				pd_isp0@RK3399_PD_ISP0 {
+				power-domain@RK3399_PD_ISP0 {
 					reg = <RK3399_PD_ISP0>;
 					clocks = <&cru ACLK_ISP0>,
 						 <&cru HCLK_ISP0>;
 					pm_qos = <&qos_isp0_m0>,
 						 <&qos_isp0_m1>;
 				};
-				pd_isp1@RK3399_PD_ISP1 {
+				power-domain@RK3399_PD_ISP1 {
 					reg = <RK3399_PD_ISP1>;
 					clocks = <&cru ACLK_ISP1>,
 						 <&cru HCLK_ISP1>;
 					pm_qos = <&qos_isp1_m0>,
 						 <&qos_isp1_m1>;
 				};
-				pd_vo@RK3399_PD_VO {
+				power-domain@RK3399_PD_VO {
 					reg = <RK3399_PD_VO>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					pd_vopb@RK3399_PD_VOPB {
+					power-domain@RK3399_PD_VOPB {
 						reg = <RK3399_PD_VOPB>;
 						clocks = <&cru ACLK_VOP0>,
 							 <&cru HCLK_VOP0>;
 						pm_qos = <&qos_vop_big_r>,
 							 <&qos_vop_big_w>;
 					};
-					pd_vopl@RK3399_PD_VOPL {
+					power-domain@RK3399_PD_VOPL {
 						reg = <RK3399_PD_VOPL>;
 						clocks = <&cru ACLK_VOP1>,
 							 <&cru HCLK_VOP1>;
-- 
2.17.1



