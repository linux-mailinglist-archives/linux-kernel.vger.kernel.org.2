Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DB744721C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 08:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhKGH7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 02:59:43 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:42418 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235187AbhKGH7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 02:59:39 -0500
X-UUID: ddf747f5b5f64936bdd647253b11e4ab-20211107
X-UUID: ddf747f5b5f64936bdd647253b11e4ab-20211107
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 437193593; Sun, 07 Nov 2021 15:56:54 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sun, 7 Nov 2021 15:56:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkexhb02.mediatek.inc (172.21.101.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 7 Nov 2021 15:56:53 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs10n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Sun, 7 Nov 2021 15:56:52 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yz Wu <yz.wu@mediatek.com>
Subject: [PATCH 6/6] arm64: dts: mediatek: mt8195: add efuse node and cells
Date:   Sun, 7 Nov 2021 15:56:46 +0800
Message-ID: <20211107075646.4366-6-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211107075646.4366-1-chunfeng.yun@mediatek.com>
References: <20211107075646.4366-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add efuse node and cells used by t-phy to fix the bit shift issue

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
Depend on:

  [v4,1/1] arm64: dts: Add Mediatek SoC MT8195 and evaluation board dts and Makefile
  https://patchwork.kernel.org/patch/12509911
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 61 ++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 263eebfd2ea1..7fb23c1cb8cc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -933,6 +933,55 @@
 			status = "disabled";
 		};
 
+		efuse: efuse@11c10000 {
+			compatible = "mediatek,mt8195-efuse", "mediatek,efuse";
+			reg = <0 0x11c10000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			u3_tx_imp_p0: usb3-tx-imp@184 {
+				reg = <0x184 0x1>;
+				bits = <0 5>;
+			};
+			u3_rx_imp_p0: usb3-rx-imp@184 {
+				reg = <0x184 0x2>;
+				bits = <5 5>;
+			};
+			u3_intr_p0: usb3-intr@185 {
+				reg = <0x185 0x1>;
+				bits = <2 6>;
+			};
+			comb_tx_imp_p1: usb3-tx-imp@186 {
+				reg = <0x186 0x1>;
+				bits = <0 5>;
+			};
+			comb_rx_imp_p1: usb3-rx-imp@186 {
+				reg = <0x186 0x2>;
+				bits = <5 5>;
+			};
+			comb_intr_p1: usb3-intr@187 {
+				reg = <0x187 0x1>;
+				bits = <2 6>;
+			};
+			u2_intr_p0: usb2-intr-p0@188 {
+				reg = <0x188 0x1>;
+				bits = <0 5>;
+			};
+			u2_intr_p1: usb2-intr-p1@188 {
+				reg = <0x188 0x2>;
+				bits = <5 5>;
+			};
+			u2_intr_p2: usb2-intr-p2@189 {
+				reg = <0x189 0x1>;
+				bits = <2 5>;
+			};
+			u2_intr_p3: usb2-intr-p3@189 {
+				reg = <0x189 0x2>;
+				bits = <7 5>;
+			};
+		};
+
 		u3phy2: t-phy@11c40000 {
 			compatible = "mediatek,mt8195-tphy", "mediatek,generic-tphy-v2";
 			#address-cells = <1>;
@@ -986,6 +1035,8 @@
 				reg = <0x0 0x700>;
 				clocks = <&clk26m>;
 				clock-names = "ref";
+				nvmem-cells = <&u2_intr_p1>;
+				nvmem-cell-names = "intr";
 				#phy-cells = <1>;
 			};
 
@@ -993,6 +1044,10 @@
 				reg = <0x700 0x700>;
 				clocks = <&clk26m>;
 				clock-names = "ref";
+				nvmem-cells = <&comb_intr_p1>,
+					      <&comb_rx_imp_p1>,
+					      <&comb_tx_imp_p1>;
+				nvmem-cell-names = "intr", "rx_imp", "tx_imp";
 				#phy-cells = <1>;
 			};
 		};
@@ -1008,6 +1063,8 @@
 				reg = <0x0 0x700>;
 				clocks = <&clk26m>;
 				clock-names = "ref";
+				nvmem-cells = <&u2_intr_p0>;
+				nvmem-cell-names = "intr";
 				#phy-cells = <1>;
 			};
 
@@ -1015,6 +1072,10 @@
 				reg = <0x700 0x700>;
 				clocks = <&clk26m>;
 				clock-names = "ref";
+				nvmem-cells = <&u3_intr_p0>,
+					      <&u3_rx_imp_p0>,
+					      <&u3_tx_imp_p0>;
+				nvmem-cell-names = "intr", "rx_imp", "tx_imp";
 				#phy-cells = <1>;
 			};
 		};
-- 
2.18.0

