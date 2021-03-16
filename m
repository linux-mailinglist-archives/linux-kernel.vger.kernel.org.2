Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5399233D091
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbhCPJXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:23:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55813 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235979AbhCPJWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:22:37 -0400
X-UUID: a239ab96116e4b9dae41940ae6756751-20210316
X-UUID: a239ab96116e4b9dae41940ae6756751-20210316
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1121097498; Tue, 16 Mar 2021 17:22:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v5 07/13] arm64: dts: mediatek: mt2712: harmonize node names
Date:   Tue, 16 Mar 2021 17:22:26 +0800
Message-ID: <20210316092232.9806-7-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210316092232.9806-1-chunfeng.yun@mediatek.com>
References: <20210316092232.9806-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to fix dtbs_check warning.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2~v5: no changes
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index db17d0a4ed57..a9cca9c146fd 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -805,7 +805,7 @@
 		ranges;
 		status = "disabled";
 
-		usb_host0: xhci@11270000 {
+		usb_host0: usb@11270000 {
 			compatible = "mediatek,mt2712-xhci",
 				     "mediatek,mtk-xhci";
 			reg = <0 0x11270000 0 0x1000>;
@@ -818,7 +818,7 @@
 		};
 	};
 
-	u3phy0: usb-phy@11290000 {
+	u3phy0: t-phy@11290000 {
 		compatible = "mediatek,mt2712-tphy",
 			     "mediatek,generic-tphy-v2";
 		#address-cells = <1>;
@@ -869,7 +869,7 @@
 		ranges;
 		status = "disabled";
 
-		usb_host1: xhci@112c0000 {
+		usb_host1: usb@112c0000 {
 			compatible = "mediatek,mt2712-xhci",
 				     "mediatek,mtk-xhci";
 			reg = <0 0x112c0000 0 0x1000>;
@@ -882,7 +882,7 @@
 		};
 	};
 
-	u3phy1: usb-phy@112e0000 {
+	u3phy1: t-phy@112e0000 {
 		compatible = "mediatek,mt2712-tphy",
 			     "mediatek,generic-tphy-v2";
 		#address-cells = <1>;
-- 
2.18.0

