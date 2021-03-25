Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2FE34898B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 07:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhCYGzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 02:55:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40946 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229670AbhCYGzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 02:55:24 -0400
X-UUID: 2b975b3ebb624cdab16878ff2d6cc882-20210325
X-UUID: 2b975b3ebb624cdab16878ff2d6cc882-20210325
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 666527190; Thu, 25 Mar 2021 14:55:17 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 25 Mar 2021 14:55:09 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Mar 2021 14:55:09 +0800
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
Subject: [PATCH RESEND v5 11/12] arm: dts: mt7623: harmonize node names and compatibles
Date:   Thu, 25 Mar 2021 14:54:57 +0800
Message-ID: <20210325065458.43363-11-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210325065458.43363-1-chunfeng.yun@mediatek.com>
References: <20210325065458.43363-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 56F3879681E2CF554F2F722F69E70FCB42B7A0776F56C9CFB13C5F9E5A31057C2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to fix dtbs_check warning

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2~v5: no changes
---
 arch/arm/boot/dts/mt7623.dtsi  | 26 ++++++++++++++------------
 arch/arm/boot/dts/mt7623n.dtsi |  4 ++--
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index aea6809500d7..3c11f7cfcc40 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -787,8 +787,9 @@
 		};
 	};
 
-	pcie0_phy: pcie-phy@1a149000 {
-		compatible = "mediatek,generic-tphy-v1";
+	pcie0_phy: t-phy@1a149000 {
+		compatible = "mediatek,mt7623-tphy",
+			     "mediatek,generic-tphy-v1";
 		reg = <0 0x1a149000 0 0x0700>;
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -804,8 +805,9 @@
 		};
 	};
 
-	pcie1_phy: pcie-phy@1a14a000 {
-		compatible = "mediatek,generic-tphy-v1";
+	pcie1_phy: t-phy@1a14a000 {
+		compatible = "mediatek,mt7623-tphy",
+			     "mediatek,generic-tphy-v1";
 		reg = <0 0x1a14a000 0 0x0700>;
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -823,7 +825,7 @@
 
 	usb1: usb@1a1c0000 {
 		compatible = "mediatek,mt7623-xhci",
-			     "mediatek,mt8173-xhci";
+			     "mediatek,mtk-xhci";
 		reg = <0 0x1a1c0000 0 0x1000>,
 		      <0 0x1a1c4700 0 0x0100>;
 		reg-names = "mac", "ippc";
@@ -836,9 +838,9 @@
 		status = "disabled";
 	};
 
-	u3phy1: usb-phy@1a1c4000 {
-		compatible = "mediatek,mt7623-u3phy",
-			     "mediatek,mt2701-u3phy";
+	u3phy1: t-phy@1a1c4000 {
+		compatible = "mediatek,mt7623-tphy",
+			     "mediatek,generic-tphy-v1";
 		reg = <0 0x1a1c4000 0 0x0700>;
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -864,7 +866,7 @@
 
 	usb2: usb@1a240000 {
 		compatible = "mediatek,mt7623-xhci",
-			     "mediatek,mt8173-xhci";
+			     "mediatek,mtk-xhci";
 		reg = <0 0x1a240000 0 0x1000>,
 		      <0 0x1a244700 0 0x0100>;
 		reg-names = "mac", "ippc";
@@ -877,9 +879,9 @@
 		status = "disabled";
 	};
 
-	u3phy2: usb-phy@1a244000 {
-		compatible = "mediatek,mt7623-u3phy",
-			     "mediatek,mt2701-u3phy";
+	u3phy2: t-phy@1a244000 {
+		compatible = "mediatek,mt7623-tphy",
+			     "mediatek,generic-tphy-v1";
 		reg = <0 0x1a244000 0 0x0700>;
 		#address-cells = <2>;
 		#size-cells = <2>;
diff --git a/arch/arm/boot/dts/mt7623n.dtsi b/arch/arm/boot/dts/mt7623n.dtsi
index 1880ac9e32cf..bcb0846e29fd 100644
--- a/arch/arm/boot/dts/mt7623n.dtsi
+++ b/arch/arm/boot/dts/mt7623n.dtsi
@@ -246,7 +246,7 @@
 		status = "disabled";
 	};
 
-	mipi_tx0: mipi-dphy@10010000 {
+	mipi_tx0: dsi-phy@10010000 {
 		compatible = "mediatek,mt7623-mipi-tx",
 			     "mediatek,mt2701-mipi-tx";
 		reg = <0 0x10010000 0 0x90>;
@@ -265,7 +265,7 @@
 		status = "disabled";
 	};
 
-	hdmi_phy: phy@10209100 {
+	hdmi_phy: hdmi-phy@10209100 {
 		compatible = "mediatek,mt7623-hdmi-phy",
 			     "mediatek,mt2701-hdmi-phy";
 		reg = <0 0x10209100 0 0x24>;
-- 
2.18.0

