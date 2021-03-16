Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6822D33D0AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbhCPJXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:23:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57021 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236044AbhCPJWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:22:45 -0400
X-UUID: 02d04726da214e63a628ffd855575ca0-20210316
X-UUID: 02d04726da214e63a628ffd855575ca0-20210316
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1874887238; Tue, 16 Mar 2021 17:22:42 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Mar 2021 17:22:34 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Mar 2021 17:22:35 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Chun-Kuang Hu" <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jie Qiu <jie.qiu@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH v5 11/13] arm: dts: mt7629: harmonize node names and compatibles
Date:   Tue, 16 Mar 2021 17:22:30 +0800
Message-ID: <20210316092232.9806-11-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210316092232.9806-1-chunfeng.yun@mediatek.com>
References: <20210316092232.9806-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 61F338BCA16A9E0EA2E83DB3185949E357E7C3EF4CF8C6F8F6381591DDE2A0802000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to fix dtbs_check warning

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2~v5: no changes
---
 arch/arm/boot/dts/mt7629.dtsi | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/mt7629.dtsi b/arch/arm/boot/dts/mt7629.dtsi
index 5cbb3d244c75..874043f0490d 100644
--- a/arch/arm/boot/dts/mt7629.dtsi
+++ b/arch/arm/boot/dts/mt7629.dtsi
@@ -329,8 +329,9 @@
 			status = "disabled";
 		};
 
-		u3phy0: usb-phy@1a0c4000 {
-			compatible = "mediatek,generic-tphy-v2";
+		u3phy0: t-phy@1a0c4000 {
+			compatible = "mediatek,mt7629-tphy",
+				     "mediatek,generic-tphy-v2";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x1a0c4000 0xe00>;
@@ -413,14 +414,15 @@
 			};
 		};
 
-		pciephy1: pcie-phy@1a14a000 {
-			compatible = "mediatek,generic-tphy-v2";
+		pciephy1: t-phy@1a14a000 {
+			compatible = "mediatek,mt7629-tphy",
+				     "mediatek,generic-tphy-v2";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x1a14a000 0x1000>;
 			status = "disabled";
 
-			pcieport1: port1phy@0 {
+			pcieport1: pcie-phy@0 {
 				reg = <0 0x1000>;
 				clocks = <&clk20m>;
 				clock-names = "ref";
-- 
2.18.0

