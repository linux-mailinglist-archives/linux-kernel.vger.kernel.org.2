Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E6134A409
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhCZJQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:16:45 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:50804 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhCZJQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:16:07 -0400
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id 03A5BC7DAD;
        Fri, 26 Mar 2021 17:15:54 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P13407T140450203645696S1616750150047354_;
        Fri, 26 Mar 2021 17:15:53 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c6725fa945849af30612a04e9522e05b>
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
Subject: [PATCH v5 02/11] arm: dts: rockchip: Fix power-controller node names for rk3188
Date:   Fri, 26 Mar 2021 17:15:38 +0800
Message-Id: <20210326091547.12375-3-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326091547.12375-1-zhangqing@rock-chips.com>
References: <20210326091547.12375-1-zhangqing@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use more generic names (as recommended in the device tree specification
or the binding documentation)

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 arch/arm/boot/dts/rk3188.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 2298a8d840ba..5db32fdbe6e7 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -699,7 +699,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pd_vio@RK3188_PD_VIO {
+		power-domain@RK3188_PD_VIO {
 			reg = <RK3188_PD_VIO>;
 			clocks = <&cru ACLK_LCDC0>,
 				 <&cru ACLK_LCDC1>,
@@ -721,7 +721,7 @@
 				 <&qos_rga>;
 		};
 
-		pd_video@RK3188_PD_VIDEO {
+		power-domain@RK3188_PD_VIDEO {
 			reg = <RK3188_PD_VIDEO>;
 			clocks = <&cru ACLK_VDPU>,
 				 <&cru ACLK_VEPU>,
@@ -730,7 +730,7 @@
 			pm_qos = <&qos_vpu>;
 		};
 
-		pd_gpu@RK3188_PD_GPU {
+		power-domain@RK3188_PD_GPU {
 			reg = <RK3188_PD_GPU>;
 			clocks = <&cru ACLK_GPU>;
 			pm_qos = <&qos_gpu>;
-- 
2.17.1



