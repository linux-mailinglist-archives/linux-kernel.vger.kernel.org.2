Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B915D348988
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 07:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhCYGzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 02:55:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38470 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229619AbhCYGzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 02:55:21 -0400
X-UUID: b54d48cef81b45109151dedd17c68a73-20210325
X-UUID: b54d48cef81b45109151dedd17c68a73-20210325
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1425173657; Thu, 25 Mar 2021 14:55:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 25 Mar 2021 14:55:09 +0800
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
Subject: [PATCH RESEND v5 06/12] arm64: dts: mediatek: mt2712: harmonize node names
Date:   Thu, 25 Mar 2021 14:54:52 +0800
Message-ID: <20210325065458.43363-6-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210325065458.43363-1-chunfeng.yun@mediatek.com>
References: <20210325065458.43363-1-chunfeng.yun@mediatek.com>
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

