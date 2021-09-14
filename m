Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99F040AA2A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhINJFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:05:12 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:43908 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231423AbhINJFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:05:03 -0400
X-UUID: 6921a3e531fa41db8b66e9e9a47642ad-20210914
X-UUID: 6921a3e531fa41db8b66e9e9a47642ad-20210914
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 311808013; Tue, 14 Sep 2021 17:03:42 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 17:03:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 17:03:41 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v12 5/5] arm64: dts: mt8192: add spmi node
Date:   Tue, 14 Sep 2021 17:03:38 +0800
Message-ID: <20210914090338.5945-6-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210914090338.5945-1-hsin-hsiung.wang@mediatek.com>
References: <20210914090338.5945-1-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spmi node to SOC MT8192.

Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
---
changes since v11:
- No change.
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 9810f1d441da..1237e3624e44 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -316,6 +316,23 @@
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
 		scp_adsp: clock-controller@10720000 {
 			compatible = "mediatek,mt8192-scp_adsp";
 			reg = <0 0x10720000 0 0x1000>;
-- 
2.18.0

