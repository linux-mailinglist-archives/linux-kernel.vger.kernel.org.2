Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AE3348983
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 07:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhCYGzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 02:55:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40946 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229592AbhCYGzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 02:55:20 -0400
X-UUID: 594288f7940142768f2124bb6f17436a-20210325
X-UUID: 594288f7940142768f2124bb6f17436a-20210325
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1513651058; Thu, 25 Mar 2021 14:55:09 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 25 Mar 2021 14:55:08 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Mar 2021 14:55:08 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Jie Qiu <jie.qiu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH RESEND v5 07/12] arm64: dts: mediatek: mt8516: harmonize node names and compatibles
Date:   Thu, 25 Mar 2021 14:54:53 +0800
Message-ID: <20210325065458.43363-7-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210325065458.43363-1-chunfeng.yun@mediatek.com>
References: <20210325065458.43363-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to fix dtbs_check warning:
  harmonize node names and compatibles;
  add property "usb-role-switch" for connector dependence.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2~v5: no changes
---
 arch/arm64/boot/dts/mediatek/mt8516.dtsi         | 9 +++++----
 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
index b80e95574bef..bbe5a1419eff 100644
--- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
@@ -480,7 +480,7 @@
 		};
 
 		usb0: usb@11100000 {
-			compatible = "mediatek,mtk-musb";
+			compatible = "mediatek,mt8516-musb", "mediatek,mtk-musb";
 			reg = <0 0x11100000 0 0x1000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
 			interrupt-names = "mc";
@@ -493,7 +493,7 @@
 		};
 
 		usb1: usb@11190000 {
-			compatible = "mediatek,mtk-musb";
+			compatible = "mediatek,mt8516-musb", "mediatek,mtk-musb";
 			reg = <0 0x11190000 0 0x1000>;
 			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_LOW>;
 			interrupt-names = "mc";
@@ -506,8 +506,9 @@
 			status = "disabled";
 		};
 
-		usb_phy: usb@11110000 {
-			compatible = "mediatek,generic-tphy-v1";
+		usb_phy: t-phy@11110000 {
+			compatible = "mediatek,mt8516-tphy",
+				     "mediatek,generic-tphy-v1";
 			reg = <0 0x11110000 0 0x800>;
 			#address-cells = <2>;
 			#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
index 63fd70086bb8..7d738f01cf8d 100644
--- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -188,6 +188,7 @@
 &usb0 {
 	status = "okay";
 	dr_mode = "peripheral";
+	usb-role-switch;
 
 	usb_con: connector {
 		compatible = "usb-c-connector";
-- 
2.18.0

