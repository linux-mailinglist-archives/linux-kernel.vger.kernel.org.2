Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA8D3A87D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhFORgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:36:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34885 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231320AbhFORfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:35:00 -0400
X-UUID: f9c254ca4329491b8106fffdfce3f0ac-20210616
X-UUID: f9c254ca4329491b8106fffdfce3f0ac-20210616
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 636951409; Wed, 16 Jun 2021 01:32:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 01:32:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 01:32:45 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <seiya.wang@mediatek.com>, <wenst@google.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Dong Huang <Dong.Huang@mediatek.com>,
        Yidi Lin <yidi.lin@mediatek.com>
Subject: [PATCH 20/27] arm64: dts: mt8195: fix nor_flash node
Date:   Wed, 16 Jun 2021 01:32:26 +0800
Message-ID: <20210615173233.26682-20-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210615173233.26682-1-tinghan.shen@mediatek.com>
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Huang <Dong.Huang@mediatek.com>

Fix nor_flash with proper clock for mt8195

Signed-off-by: Dong Huang <Dong.Huang@mediatek.com>
Signed-off-by: Yidi Lin <yidi.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 560a0583ca0b..d78cd4d4201b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1162,8 +1162,12 @@
 			compatible = "mediatek,mt8195-nor", "mediatek,mt8173-nor";
 			reg = <0 0x1132c000 0 0x1000>;
 			interrupts = <GIC_SPI 825 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
-			clock-names = "spi", "sf";
+			clocks = <&topckgen CLK_TOP_SPINOR_SEL>,
+				 <&pericfg_ao CLK_PERI_AO_FLASHIF_FLASH>,
+				 <&pericfg_ao CLK_PERI_AO_FLASHIF_BUS>;
+			clock-names = "spi", "sf", "axi";
+			assigned-clocks = <&topckgen CLK_TOP_SPINOR_SEL>;
+			assigned-clock-parents = <&clk26m>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
-- 
2.18.0

