Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900B840BE36
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhIOD2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:28:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35934 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236079AbhIOD2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:28:46 -0400
X-UUID: d8bed79257a24e579c53626acf8e978f-20210915
X-UUID: d8bed79257a24e579c53626acf8e978f-20210915
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 883001550; Wed, 15 Sep 2021 11:27:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Sep 2021 11:27:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Sep 2021 11:27:23 +0800
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>
Subject: [PATCH v2] arm64: dts: mt8183: support coresight-cpu-debug for mt8183
Date:   Wed, 15 Sep 2021 11:27:19 +0800
Message-ID: <20210915032719.7194-1-seiya.wang@mediatek.com>
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
index 409cf827970c..2d36575e7dbe 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -367,6 +367,70 @@
 			reg = <0 0x0c530a80 0 0x50>;
 		};
 
+		cpu_debug0: cpu-debug@d410000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x0 0xd410000 0x0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu0>;
+		};
+
+		cpu_debug1: cpu-debug@d510000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x0 0xd510000 0x0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu1>;
+		};
+
+		cpu_debug2: cpu-debug@d610000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x0 0xd610000 0x0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu2>;
+		};
+
+		cpu_debug3: cpu-debug@d710000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x0 0xd710000 0x0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu3>;
+		};
+
+		cpu_debug4: cpu-debug@d810000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x0 0xd810000 0x0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu4>;
+		};
+
+		cpu_debug5: cpu-debug@d910000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x0 0xd910000 0x0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu5>;
+		};
+
+		cpu_debug6: cpu-debug@da10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x0 0xda10000 0x0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu6>;
+		};
+
+		cpu_debug7: cpu-debug@db10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
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

