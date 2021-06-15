Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ABA3A87C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhFORfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:35:25 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34925 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231174AbhFORey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:34:54 -0400
X-UUID: 3bb73b996dca47ec92289ec07e4fe47d-20210616
X-UUID: 3bb73b996dca47ec92289ec07e4fe47d-20210616
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1061415854; Wed, 16 Jun 2021 01:32:44 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 01:32:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 01:32:43 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <seiya.wang@mediatek.com>, <wenst@google.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH 06/27] arm64: dts: mt8195: add clock controllers
Date:   Wed, 16 Jun 2021 01:32:12 +0800
Message-ID: <20210615173233.26682-6-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210615173233.26682-1-tinghan.shen@mediatek.com>
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weiyi Lu <weiyi.lu@mediatek.com>

Add clock controller nodes for SoC mt8195

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 215 ++++++++++++++++++++++-
 1 file changed, 213 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 965445d07e92..7946a13fcbc3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/clock/mt8195-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
@@ -275,8 +276,14 @@
 			};
 		};
 
-		infracfg: syscon@10001000 {
-			compatible = "mediatek,mt8195-infracfg", "syscon", "simple-mfd";
+		topckgen: syscon@10000000 {
+			compatible = "mediatek,mt8195-topckgen", "syscon";
+			reg = <0 0x10000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		infracfg_ao: infracfg_ao@10001000 {
+			compatible = "mediatek,mt8195-infracfg_ao", "syscon", "simple-mfd";
 			reg = <0 0x10001000 0 0x1000>;
 			#clock-cells = <1>;
 
@@ -315,6 +322,12 @@
 			reg = <0 0x10007000 0 0x100>;
 		};
 
+		apmixedsys: syscon@1000c000 {
+			compatible = "mediatek,mt8195-apmixedsys", "syscon";
+			reg = <0 0x1000c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		systimer: timer@10017000 {
 			compatible = "mediatek,mt8195-timer", "mediatek,mt6765-timer";
 			reg = <0 0x10017000 0 0x1000>;
@@ -349,6 +362,30 @@
 			assigned-clock-parents = <&topckgen CLK_TOP_ULPOSC_D10>;
 		};
 
+		nnasys: syscon@10211000 {
+			compatible = "mediatek,mt8195-nnasys", "syscon";
+			reg = <0 0x10211000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		scp_adsp: syscon@10720000 {
+			compatible = "mediatek,mt8195-scp_adsp", "syscon";
+			reg = <0 0x10720000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		audsys: syscon@10890000 {
+			compatible = "mediatek,mt8195-audsys", "syscon";
+			reg = <0 0x10890000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		audsys_src: syscon@108a0000 {
+			compatible = "mediatek,mt8195-audsys_src", "syscon";
+			reg = <0 0x108a0000 0 0x2000>;
+			#clock-cells = <1>;
+		};
+
 		uart0: serial@11001100 {
 			compatible = "mediatek,mt8195-uart", "mediatek,mt6577-uart";
 			reg = <0 0x11001100 0 0x100>;
@@ -411,6 +448,12 @@
 			status = "disabled";
 		};
 
+		pericfg_ao: syscon@11003000 {
+			compatible = "mediatek,mt8195-pericfg_ao", "syscon";
+			reg = <0 0x11003000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		mmc0: mmc@11230000 {
 			compatible = "mediatek,mt8195-mmc", "mediatek,mt8192-mmc";
 			reg = <0 0x11230000 0 0x10000>,
@@ -472,6 +515,18 @@
 			};
 		};
 
+		imp_iic_wrap_s: syscon@11d03000 {
+			compatible = "mediatek,mt8195-imp_iic_wrap_s", "syscon";
+			reg = <0 0x11d03000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imp_iic_wrap_w: syscon@11e05000 {
+			compatible = "mediatek,mt8195-imp_iic_wrap_w", "syscon";
+			reg = <0 0x11e05000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		u3phy1: t-phy@11e30000 {
 			compatible = "mediatek,mt8195-tphy", "mediatek,generic-tphy-v2";
 			#address-cells = <1>;
@@ -524,5 +579,161 @@
 			#phy-cells = <0>;
 			status = "disabled";
 		};
+
+		mfgcfg: syscon@13fbf000 {
+			compatible = "mediatek,mt8195-mfgcfg", "syscon";
+			reg = <0 0x13fbf000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vppsys0: syscon@14000000 {
+			compatible = "mediatek,mt8195-vppsys0", "syscon";
+			reg = <0 0x14000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		wpesys: syscon@14e00000 {
+			compatible = "mediatek,mt8195-wpesys", "syscon";
+			reg = <0 0x14e00000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		wpesys_vpp0: syscon@14e02000 {
+			compatible = "mediatek,mt8195-wpesys_vpp0", "syscon";
+			reg = <0 0x14e02000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		wpesys_vpp1: syscon@14e03000 {
+			compatible = "mediatek,mt8195-wpesys_vpp1", "syscon";
+			reg = <0 0x14e03000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vppsys1: syscon@14f00000 {
+			compatible = "mediatek,mt8195-vppsys1", "syscon";
+			reg = <0 0x14f00000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imgsys: syscon@15000000 {
+			compatible = "mediatek,mt8195-imgsys", "syscon";
+			reg = <0 0x15000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imgsys1_dip_top: syscon@15110000 {
+			compatible = "mediatek,mt8195-imgsys1_dip_top", "syscon";
+			reg = <0 0x15110000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imgsys1_dip_nr: syscon@15130000 {
+			compatible = "mediatek,mt8195-imgsys1_dip_nr", "syscon";
+			reg = <0 0x15130000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imgsys1_wpe: syscon@15220000 {
+			compatible = "mediatek,mt8195-imgsys1_wpe", "syscon";
+			reg = <0 0x15220000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		ipesys: syscon@15330000 {
+			compatible = "mediatek,mt8195-ipesys", "syscon";
+			reg = <0 0x15330000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys: syscon@16000000 {
+			compatible = "mediatek,mt8195-camsys", "syscon";
+			reg = <0 0x16000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys_rawa: syscon@1604f000 {
+			compatible = "mediatek,mt8195-camsys_rawa", "syscon";
+			reg = <0 0x1604f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys_yuva: syscon@1606f000 {
+			compatible = "mediatek,mt8195-camsys_yuva", "syscon";
+			reg = <0 0x1606f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys_rawb: syscon@1608f000 {
+			compatible = "mediatek,mt8195-camsys_rawb", "syscon";
+			reg = <0 0x1608f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys_yuvb: syscon@160af000 {
+			compatible = "mediatek,mt8195-camsys_yuvb", "syscon";
+			reg = <0 0x160af000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys_mraw: syscon@16140000 {
+			compatible = "mediatek,mt8195-camsys_mraw", "syscon";
+			reg = <0 0x16140000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		ccusys: syscon@17200000 {
+			compatible = "mediatek,mt8195-ccusys", "syscon";
+			reg = <0 0x17200000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vdecsys_soc: syscon@1800f000 {
+			compatible = "mediatek,mt8195-vdecsys_soc", "syscon";
+			reg = <0 0x1800f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vdecsys: syscon@1802f000 {
+			compatible = "mediatek,mt8195-vdecsys", "syscon";
+			reg = <0 0x1802f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vdecsys_core1: syscon@1803f000 {
+			compatible = "mediatek,mt8195-vdecsys_core1", "syscon";
+			reg = <0 0x1803f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		apusys_pll: syscon@190f3000 {
+			compatible = "mediatek,mt8195-apusys_pll", "syscon";
+			reg = <0 0x190f3000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vencsys: syscon@1a000000 {
+			compatible = "mediatek,mt8195-vencsys", "syscon";
+			reg = <0 0x1a000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vencsys_core1: syscon@1b000000 {
+			compatible = "mediatek,mt8195-vencsys_core1", "syscon";
+			reg = <0 0x1b000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vdosys0: syscon@1c01a000 {
+			compatible = "mediatek,mt8195-vdosys0", "syscon";
+			reg = <0 0x1c01a000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vdosys1: syscon@1c100000 {
+			compatible = "mediatek,mt8195-vdosys1", "syscon";
+			reg = <0 0x1c100000 0 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 };
-- 
2.18.0

