Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D2733D0AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhCPJXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:23:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57021 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236047AbhCPJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:22:46 -0400
X-UUID: cc794f5e977a4f49b8f40110ddcff1a8-20210316
X-UUID: cc794f5e977a4f49b8f40110ddcff1a8-20210316
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 80195745; Tue, 16 Mar 2021 17:22:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v5 09/13] arm64: dts: mediatek: mt7622: harmonize node names and compatibles
Date:   Tue, 16 Mar 2021 17:22:28 +0800
Message-ID: <20210316092232.9806-9-chunfeng.yun@mediatek.com>
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
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 7c6d871538a6..890a942ec608 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -742,8 +742,8 @@
 		status = "disabled";
 	};
 
-	u3phy: usb-phy@1a0c4000 {
-		compatible = "mediatek,mt7622-u3phy",
+	u3phy: t-phy@1a0c4000 {
+		compatible = "mediatek,mt7622-tphy",
 			     "mediatek,generic-tphy-v1";
 		reg = <0 0x1a0c4000 0 0x700>;
 		#address-cells = <2>;
@@ -877,8 +877,9 @@
 		status = "disabled";
 	};
 
-	sata_phy: sata-phy@1a243000 {
-		compatible = "mediatek,generic-tphy-v1";
+	sata_phy: t-phy@1a243000 {
+		compatible = "mediatek,mt7622-tphy",
+			     "mediatek,generic-tphy-v1";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-- 
2.18.0

