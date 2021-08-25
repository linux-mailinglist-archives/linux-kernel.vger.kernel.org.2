Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB7C3F6CF3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 03:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbhHYBM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 21:12:26 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:54000 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236497AbhHYBMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 21:12:25 -0400
X-UUID: 4861531b95bd460e89be396c95f6c1b9-20210825
X-UUID: 4861531b95bd460e89be396c95f6c1b9-20210825
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 662215541; Wed, 25 Aug 2021 09:11:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 25 Aug 2021 09:11:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 25 Aug 2021 09:11:37 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v1 2/5] arm64: dts: mediatek: Correct UART clock of MT8192
Date:   Wed, 25 Aug 2021 09:11:17 +0800
Message-ID: <20210825011120.30481-3-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210825011120.30481-1-chun-jie.chen@mediatek.com>
References: <20210825011120.30481-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update uart0 and uart1 bus clock to the real one.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 2b63d2ea6cb6..31d135e18784 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -327,7 +327,7 @@
 				     "mediatek,mt6577-uart";
 			reg = <0 0x11002000 0 0x1000>;
 			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&clk26m>, <&infracfg CLK_INFRA_UART0>;
 			clock-names = "baud", "bus";
 			status = "disabled";
 		};
@@ -337,7 +337,7 @@
 				     "mediatek,mt6577-uart";
 			reg = <0 0x11003000 0 0x1000>;
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&clk26m>, <&infracfg CLK_INFRA_UART1>;
 			clock-names = "baud", "bus";
 			status = "disabled";
 		};
-- 
2.18.0

