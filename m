Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BA633D0A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhCPJXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:23:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55830 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236020AbhCPJWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:22:39 -0400
X-UUID: 66d0b981882e4ccb8f6504fe5b3f65b6-20210316
X-UUID: 66d0b981882e4ccb8f6504fe5b3f65b6-20210316
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 416835942; Tue, 16 Mar 2021 17:22:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Mar 2021 17:22:34 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Mar 2021 17:22:34 +0800
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
Subject: [PATCH v5 06/13] arm64: dts: mediatek: mt8173: fix dtbs_check warning
Date:   Tue, 16 Mar 2021 17:22:25 +0800
Message-ID: <20210316092232.9806-6-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210316092232.9806-1-chunfeng.yun@mediatek.com>
References: <20210316092232.9806-1-chunfeng.yun@mediatek.com>
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

