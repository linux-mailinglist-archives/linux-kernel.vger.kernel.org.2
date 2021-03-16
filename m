Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D25533D0AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbhCPJXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:23:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:56908 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236021AbhCPJWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:22:40 -0400
X-UUID: 94af934e8aa64eefad752738ba325592-20210316
X-UUID: 94af934e8aa64eefad752738ba325592-20210316
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1344638571; Tue, 16 Mar 2021 17:22:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Mar 2021 17:22:35 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Mar 2021 17:22:35 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jie Qiu <jie.qiu@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH v5 13/13] arm: dts: mt2701: harmonize node names and compatibles
Date:   Tue, 16 Mar 2021 17:22:32 +0800
Message-ID: <20210316092232.9806-13-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210316092232.9806-1-chunfeng.yun@mediatek.com>
References: <20210316092232.9806-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to fix dtbs_check warning

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2~v5: no changes
---
 arch/arm/boot/dts/mt2701.dtsi | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index fade14284017..4776f85d6d5b 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -607,7 +607,7 @@
 	};
 
 	usb0: usb@1a1c0000 {
-		compatible = "mediatek,mt8173-xhci";
+		compatible = "mediatek,mt2701-xhci", "mediatek,mtk-xhci";
 		reg = <0 0x1a1c0000 0 0x1000>,
 		      <0 0x1a1c4700 0 0x0100>;
 		reg-names = "mac", "ippc";
@@ -620,8 +620,9 @@
 		status = "disabled";
 	};
 
-	u3phy0: usb-phy@1a1c4000 {
-		compatible = "mediatek,mt2701-u3phy";
+	u3phy0: t-phy@1a1c4000 {
+		compatible = "mediatek,mt2701-tphy",
+			     "mediatek,generic-tphy-v1";
 		reg = <0 0x1a1c4000 0 0x0700>;
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -646,7 +647,7 @@
 	};
 
 	usb1: usb@1a240000 {
-		compatible = "mediatek,mt8173-xhci";
+		compatible = "mediatek,mt2701-xhci", "mediatek,mtk-xhci";
 		reg = <0 0x1a240000 0 0x1000>,
 		      <0 0x1a244700 0 0x0100>;
 		reg-names = "mac", "ippc";
@@ -659,8 +660,9 @@
 		status = "disabled";
 	};
 
-	u3phy1: usb-phy@1a244000 {
-		compatible = "mediatek,mt2701-u3phy";
+	u3phy1: t-phy@1a244000 {
+		compatible = "mediatek,mt2701-tphy",
+			     "mediatek,generic-tphy-v1";
 		reg = <0 0x1a244000 0 0x0700>;
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -700,8 +702,9 @@
 		status = "disabled";
 	};
 
-	u2phy0: usb-phy@11210000 {
-		compatible = "mediatek,generic-tphy-v1";
+	u2phy0: t-phy@11210000 {
+		compatible = "mediatek,mt2701-tphy",
+			     "mediatek,generic-tphy-v1";
 		reg = <0 0x11210000 0 0x0800>;
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.18.0

