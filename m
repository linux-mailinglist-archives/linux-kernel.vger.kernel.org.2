Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022E3312177
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 06:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhBGFUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 00:20:22 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:40897 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229609AbhBGFUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 00:20:07 -0500
X-UUID: bc6fe58a90e44935b7cbec4c58e033e9-20210207
X-UUID: bc6fe58a90e44935b7cbec4c58e033e9-20210207
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1005168940; Sun, 07 Feb 2021 13:19:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 7 Feb 2021 13:19:19 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 7 Feb 2021 13:19:19 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <drinkcat@chromium.org>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v6 4/4] arm64: dts: mt8192: add spmi node
Date:   Sun, 7 Feb 2021 13:19:14 +0800
Message-ID: <1612675154-2747-5-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1612675154-2747-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1612675154-2747-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spmi node to SOC MT8192.

Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
---
changes since v5:
- fix the build error of MT8192.dtsi.
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index e12e024de122..5e002512441f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -247,6 +247,23 @@
 			clock-names = "clk13m";
 		};
 
+		spmi: spmi@10027000 {
+			compatible = "mediatek,mt6873-spmi";
+			reg = <0 0x10027000 0 0x000e00>,
+			      <0 0x10029000 0 0x000100>;
+			reg-names = "pmif", "spmimst";
+			clocks = <&infracfg CLK_INFRA_PMIC_AP>,
+				 <&infracfg CLK_INFRA_PMIC_TMR>,
+				 <&topckgen CLK_TOP_SPMI_MST_SEL>;
+			clock-names = "pmif_sys_ck",
+				      "pmif_tmr_ck",
+				      "spmimst_clk_mux";
+			assigned-clocks = <&topckgen CLK_TOP_PWRAP_ULPOSC_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_OSC_D10>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
 		uart0: serial@11002000 {
 			compatible = "mediatek,mt8192-uart",
 				     "mediatek,mt6577-uart";
-- 
2.18.0

