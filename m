Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15B9348986
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 07:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCYGzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 02:55:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40946 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229635AbhCYGzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 02:55:22 -0400
X-UUID: b9985f24fd144109844c9cd76055326d-20210325
X-UUID: b9985f24fd144109844c9cd76055326d-20210325
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 274709755; Thu, 25 Mar 2021 14:55:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH RESEND v5 05/12] arm64: dts: mediatek: mt8173: fix dtbs_check warning
Date:   Thu, 25 Mar 2021 14:54:51 +0800
Message-ID: <20210325065458.43363-5-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210325065458.43363-1-chunfeng.yun@mediatek.com>
References: <20210325065458.43363-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Harmonize nodes names, compatibles and remove unused property.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2~v5: no changes
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |  4 +---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 13 +++++++------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 6dffada2e66b..0ce81c4fe81e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -516,10 +516,8 @@
 	extcon = <&extcon_usb>;
 	dr_mode = "otg";
 	wakeup-source;
-	pinctrl-names = "default", "id_float", "id_ground";
+	pinctrl-names = "default";
 	pinctrl-0 = <&usb_id_pins_float>;
-	pinctrl-1 = <&usb_id_pins_float>;
-	pinctrl-2 = <&usb_id_pins_ground>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index ecb37a7e6870..003a5653c505 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -631,7 +631,7 @@
 			#mbox-cells = <2>;
 		};
 
-		mipi_tx0: mipi-dphy@10215000 {
+		mipi_tx0: dsi-phy@10215000 {
 			compatible = "mediatek,mt8173-mipi-tx";
 			reg = <0 0x10215000 0 0x1000>;
 			clocks = <&clk26m>;
@@ -641,7 +641,7 @@
 			status = "disabled";
 		};
 
-		mipi_tx1: mipi-dphy@10216000 {
+		mipi_tx1: dsi-phy@10216000 {
 			compatible = "mediatek,mt8173-mipi-tx";
 			reg = <0 0x10216000 0 0x1000>;
 			clocks = <&clk26m>;
@@ -926,7 +926,7 @@
 		};
 
 		ssusb: usb@11271000 {
-			compatible = "mediatek,mt8173-mtu3";
+			compatible = "mediatek,mt8173-mtu3", "mediatek,mtu3";
 			reg = <0 0x11271000 0 0x3000>,
 			      <0 0x11280700 0 0x0100>;
 			reg-names = "mac", "ippc";
@@ -943,8 +943,9 @@
 			ranges;
 			status = "disabled";
 
-			usb_host: xhci@11270000 {
-				compatible = "mediatek,mt8173-xhci";
+			usb_host: usb@11270000 {
+				compatible = "mediatek,mt8173-xhci",
+					     "mediatek,mtk-xhci";
 				reg = <0 0x11270000 0 0x1000>;
 				reg-names = "mac";
 				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
@@ -955,7 +956,7 @@
 			};
 		};
 
-		u3phy: usb-phy@11290000 {
+		u3phy: t-phy@11290000 {
 			compatible = "mediatek,mt8173-u3phy";
 			reg = <0 0x11290000 0 0x800>;
 			#address-cells = <2>;
-- 
2.18.0

