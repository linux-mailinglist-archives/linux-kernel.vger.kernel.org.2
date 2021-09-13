Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FF4408831
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 11:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbhIMJ30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 05:29:26 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:51070 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238597AbhIMJ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 05:29:25 -0400
X-UUID: ce9b042b918847c99cb990bb1516e57c-20210913
X-UUID: ce9b042b918847c99cb990bb1516e57c-20210913
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1269922654; Mon, 13 Sep 2021 17:28:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 13 Sep 2021 17:28:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Sep 2021 17:28:02 +0800
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>
Subject: [PATCH] arm64: dts: mt8183: support coresight-cpu-debug for mt8183
Date:   Mon, 13 Sep 2021 17:27:36 +0800
Message-ID: <20210913092736.19207-1-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add coresight-cpu-debug nodes to mt8183 for dumping
EDPRSR, EDPCSR, EDCIDSR, EDVIDSR
while kernel panic happens

Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 64 ++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 409cf827970c..3ad4dd47518a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -367,6 +367,70 @@
 			reg = <0 0x0c530a80 0 0x50>;
 		};
 
+		cpu_debug0: cpu-debug@d410000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0x0 0xd410000 0x0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu0>;
+		};
+
+		cpu_debug1: cpu-debug@d510000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0x0 0xd510000 0x0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu1>;
+		};
+
+		cpu_debug2: cpu-debug@d610000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0x0 0xd610000 0x0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu2>;
+		};
+
+		cpu_debug3: cpu-debug@d710000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0x0 0xd710000 0x0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu3>;
+		};
+
+		cpu_debug4: cpu-debug@d810000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0x0 0xd810000 0x0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu4>;
+		};
+
+		cpu_debug5: cpu-debug@d910000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0x0 0xd910000 0x0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu5>;
+		};
+
+		cpu_debug6: cpu-debug@da10000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0x0 0xda10000 0x0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu6>;
+		};
+
+		cpu_debug7: cpu-debug@db10000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0x0 0xdb10000 0x0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu7>;
+		};
+
 		topckgen: syscon@10000000 {
 			compatible = "mediatek,mt8183-topckgen", "syscon";
 			reg = <0 0x10000000 0 0x1000>;
-- 
2.14.1

