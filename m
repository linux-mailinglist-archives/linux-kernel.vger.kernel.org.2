Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB04A3561F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhDGD3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:29:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38989 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348370AbhDGD3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:29:13 -0400
X-UUID: 4a6fb3b086a5419c9a48f0741c839147-20210407
X-UUID: 4a6fb3b086a5419c9a48f0741c839147-20210407
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 415551506; Wed, 07 Apr 2021 11:29:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 7 Apr 2021 11:28:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Apr 2021 11:28:58 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Flora Fu <flora.fu@mediatek.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH 8/8] arm64: dts: mt8192: Add APU power domain node
Date:   Wed, 7 Apr 2021 11:28:06 +0800
Message-ID: <1617766086-5502-9-git-send-email-flora.fu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
References: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add APU power domain node to MT8192.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192-evb.dts |  7 +++++
 arch/arm64/boot/dts/mediatek/mt8192.dtsi    | 29 +++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-evb.dts b/arch/arm64/boot/dts/mediatek/mt8192-evb.dts
index 1769f3a9b510..9e89efb3dc8a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-evb.dts
@@ -65,3 +65,10 @@
 &mt6359_vrf12_ldo_reg {
 	regulator-always-on;
 };
+
+&apuspm {
+	vsram-supply = <&mt6359_vsram_md_ldo_reg>;
+	power-domain@MT8192_POWER_DOMAIN_APUSYS_TOP {
+		domain-supply = <&mt6359_vproc1_buck_reg>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index b1467ccbe5aa..546c058ef560 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/memory/mt8192-larb-port.h>
 #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
 #include <dt-bindings/power/mt8192-power.h>
+#include <dt-bindings/power/mt8192-apu-power.h>
 
 / {
 	compatible = "mediatek,mt8192";
@@ -1033,6 +1034,34 @@
 			#clock-cells = <1>;
 		};
 
+		apuspm: power-domain@190f0000 {
+			compatible = "mediatek,mt8192-apu-pm", "syscon";
+			reg = <0 0x190f0000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#power-domain-cells = <1>;
+			mediatek,scpsys = <&scpsys>;
+			mediatek,apu_conn = <&apu_conn>;
+			mediatek,apu_vcore = <&apu_vcore>;
+
+			power-domain@MT8192_POWER_DOMAIN_APUSYS_TOP {
+				reg = <MT8192_POWER_DOMAIN_APUSYS_TOP>;
+				#power-domain-cells = <0>;
+				clocks = <&topckgen CLK_TOP_DSP_SEL>,
+					 <&topckgen CLK_TOP_IPU_IF_SEL>,
+					 <&clk26m>,
+					 <&topckgen CLK_TOP_UNIVPLL_D6_D2>;
+				clock-names = "clk_top_conn",
+					      "clk_top_ipu_if",
+					      "clk_off",
+					      "clk_on_default";
+				assigned-clocks = <&topckgen CLK_TOP_DSP_SEL>,
+						  <&topckgen CLK_TOP_IPU_IF_SEL>;
+				assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
+							 <&topckgen CLK_TOP_UNIVPLL_D6_D2>;
+			};
+		};
+
 		larb13: larb@1a001000 {
 			compatible = "mediatek,mt8192-smi-larb";
 			reg = <0 0x1a001000 0 0x1000>;
-- 
2.18.0

