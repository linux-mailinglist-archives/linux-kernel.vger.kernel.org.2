Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAD53D6BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 04:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhG0Bwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 21:52:49 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:51712 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234623AbhG0Bws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 21:52:48 -0400
X-UUID: 7c39e8c0d8b743c788e2896cabf98e73-20210727
X-UUID: 7c39e8c0d8b743c788e2896cabf98e73-20210727
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1620099905; Tue, 27 Jul 2021 10:33:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Jul 2021 10:33:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Jul 2021 10:33:10 +0800
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
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v6 2/2] arm64: dts: mediatek: Correct UART0 bus clock of MT8192
Date:   Tue, 27 Jul 2021 10:32:05 +0800
Message-ID: <20210727023205.20319-3-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210727023205.20319-1-chun-jie.chen@mediatek.com>
References: <20210727023205.20319-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

infra_uart0 clock is the real one what uart0 uses as bus clock.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index c7c7d4e017ae..9810f1d441da 100644
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
-- 
2.18.0

