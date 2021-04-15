Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EBF360207
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhDOFxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:53:34 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59545 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230447AbhDOFxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:53:23 -0400
X-UUID: 5a4badabbefd4641bf4f78e72aae2150-20210415
X-UUID: 5a4badabbefd4641bf4f78e72aae2150-20210415
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1876903005; Thu, 15 Apr 2021 13:52:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Apr 2021 13:52:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Apr 2021 13:52:54 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Flora Fu <flora.fu@mediatek.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Subject: [PATCH v2 7/7] arm64: dts: mt8192: Add APU power domain node
Date:   Thu, 15 Apr 2021 13:52:40 +0800
Message-ID: <1618465960-3013-8-git-send-email-flora.fu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1618465960-3013-1-git-send-email-flora.fu@mediatek.com>
References: <1618465960-3013-1-git-send-email-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9D8029BC1D72AC5253A108D378D8BE10E10239E313A5DFE914921084B05E37CD2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add APU power domain node to MT8192.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
Note:
This patch depends on MT8192 clock[1] and PMIC[2] patches which haven't yet been accepted.
[1] https://patchwork.kernel.org/project/linux-mediatek/patch/20210324104110.13383-7-chun-jie.chen@mediatek.com/
[2] https://patchwork.kernel.org/project/linux-mediatek/patch/1617188527-3392-9-git-send-email-hsin-hsiung.wang@mediatek.com/
---
 arch/arm64/boot/dts/mediatek/mt8192-evb.dts |  7 ++++++
 arch/arm64/boot/dts/mediatek/mt8192.dtsi    | 28 +++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-evb.dts b/arch/arm64/boot/dts/mediatek/mt8192-evb.dts
index 1769f3a9b510..688c97c46d44 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-evb.dts
@@ -65,3 +65,10 @@
 &mt6359_vrf12_ldo_reg {
 	regulator-always-on;
 };
+
+&apuspm {
+	vsram-supply = <&mt6359_vsram_md_ldo_reg>;
+	apu_top: power-domain@0 {
+		domain-supply = <&mt6359_vproc1_buck_reg>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 561025d2ebab..90436757386e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1033,6 +1033,34 @@
 			#clock-cells = <1>;
 		};
 
+		apuspm: power-domain@190f0000 {
+			compatible = "mediatek,mt8192-apu-pm", "syscon";
+			reg = <0 0x190f0000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#power-domain-cells = <1>;
+			mediatek,scpsys = <&scpsys>;
+			mediatek,apu-conn = <&apu_conn>;
+			mediatek,apu-vcore = <&apu_vcore>;
+
+			apu_top: power-domain@0 {
+				reg = <0>;
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

