Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060453D6BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 04:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbhG0Bwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 21:52:44 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:51604 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233727AbhG0Bwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 21:52:42 -0400
X-UUID: ed6bfca47495419bbc85633cd183b740-20210727
X-UUID: ed6bfca47495419bbc85633cd183b740-20210727
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1283711243; Tue, 27 Jul 2021 10:33:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Jul 2021 10:33:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Jul 2021 10:33:06 +0800
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
Subject: [v6 1/2] arm64: dts: mediatek: Add mt8192 clock controllers
Date:   Tue, 27 Jul 2021 10:32:04 +0800
Message-ID: <20210727023205.20319-2-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210727023205.20319-1-chun-jie.chen@mediatek.com>
References: <20210727023205.20319-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock controller nodes for SoC mt8192

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 163 +++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 9757138a8bbd..c7c7d4e017ae 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -5,6 +5,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/clock/mt8192-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
@@ -257,6 +258,24 @@
 			};
 		};
 
+		topckgen: syscon@10000000 {
+			compatible = "mediatek,mt8192-topckgen", "syscon";
+			reg = <0 0x10000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		infracfg: syscon@10001000 {
+			compatible = "mediatek,mt8192-infracfg", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pericfg: syscon@10003000 {
+			compatible = "mediatek,mt8192-pericfg", "syscon";
+			reg = <0 0x10003000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		pio: pinctrl@10005000 {
 			compatible = "mediatek,mt8192-pinctrl";
 			reg = <0 0x10005000 0 0x1000>,
@@ -282,6 +301,12 @@
 			#interrupt-cells = <2>;
 		};
 
+		apmixedsys: syscon@1000c000 {
+			compatible = "mediatek,mt8192-apmixedsys", "syscon";
+			reg = <0 0x1000c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		systimer: timer@10017000 {
 			compatible = "mediatek,mt8192-timer",
 				     "mediatek,mt6765-timer";
@@ -291,6 +316,12 @@
 			clock-names = "clk13m";
 		};
 
+		scp_adsp: clock-controller@10720000 {
+			compatible = "mediatek,mt8192-scp_adsp";
+			reg = <0 0x10720000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		uart0: serial@11002000 {
 			compatible = "mediatek,mt8192-uart",
 				     "mediatek,mt6577-uart";
@@ -311,6 +342,12 @@
 			status = "disabled";
 		};
 
+		imp_iic_wrap_c: clock-controller@11007000 {
+			compatible = "mediatek,mt8192-imp_iic_wrap_c";
+			reg = <0 0x11007000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		spi0: spi@1100a000 {
 			compatible = "mediatek,mt8192-spi",
 				     "mediatek,mt6765-spi";
@@ -436,6 +473,12 @@
 			status = "disable";
 		};
 
+		audsys: clock-controller@11210000 {
+			compatible = "mediatek,mt8192-audsys", "syscon";
+			reg = <0 0x11210000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		i2c3: i2c3@11cb0000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11cb0000 0 0x1000>,
@@ -449,6 +492,12 @@
 			status = "disabled";
 		};
 
+		imp_iic_wrap_e: clock-controller@11cb1000 {
+			compatible = "mediatek,mt8192-imp_iic_wrap_e";
+			reg = <0 0x11cb1000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		i2c7: i2c7@11d00000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11d00000 0 0x1000>,
@@ -488,6 +537,12 @@
 			status = "disabled";
 		};
 
+		imp_iic_wrap_s: clock-controller@11d03000 {
+			compatible = "mediatek,mt8192-imp_iic_wrap_s";
+			reg = <0 0x11d03000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		i2c1: i2c1@11d20000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11d20000 0 0x1000>,
@@ -527,6 +582,12 @@
 			status = "disabled";
 		};
 
+		imp_iic_wrap_ws: clock-controller@11d23000 {
+			compatible = "mediatek,mt8192-imp_iic_wrap_ws";
+			reg = <0 0x11d23000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		i2c5: i2c5@11e00000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11e00000 0 0x1000>,
@@ -540,6 +601,12 @@
 			status = "disabled";
 		};
 
+		imp_iic_wrap_w: clock-controller@11e01000 {
+			compatible = "mediatek,mt8192-imp_iic_wrap_w";
+			reg = <0 0x11e01000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		i2c0: i2c0@11f00000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11f00000 0 0x1000>,
@@ -565,5 +632,101 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		imp_iic_wrap_n: clock-controller@11f02000 {
+			compatible = "mediatek,mt8192-imp_iic_wrap_n";
+			reg = <0 0x11f02000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		msdc_top: clock-controller@11f10000 {
+			compatible = "mediatek,mt8192-msdc_top";
+			reg = <0 0x11f10000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		msdc: clock-controller@11f60000 {
+			compatible = "mediatek,mt8192-msdc";
+			reg = <0 0x11f60000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		mfgcfg: clock-controller@13fbf000 {
+			compatible = "mediatek,mt8192-mfgcfg";
+			reg = <0 0x13fbf000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		mmsys: syscon@14000000 {
+			compatible = "mediatek,mt8192-mmsys", "syscon";
+			reg = <0 0x14000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imgsys: clock-controller@15020000 {
+			compatible = "mediatek,mt8192-imgsys";
+			reg = <0 0x15020000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imgsys2: clock-controller@15820000 {
+			compatible = "mediatek,mt8192-imgsys2";
+			reg = <0 0x15820000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vdecsys_soc: clock-controller@1600f000 {
+			compatible = "mediatek,mt8192-vdecsys_soc";
+			reg = <0 0x1600f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vdecsys: clock-controller@1602f000 {
+			compatible = "mediatek,mt8192-vdecsys";
+			reg = <0 0x1602f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vencsys: clock-controller@17000000 {
+			compatible = "mediatek,mt8192-vencsys";
+			reg = <0 0x17000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys: clock-controller@1a000000 {
+			compatible = "mediatek,mt8192-camsys";
+			reg = <0 0x1a000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys_rawa: clock-controller@1a04f000 {
+			compatible = "mediatek,mt8192-camsys_rawa";
+			reg = <0 0x1a04f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys_rawb: clock-controller@1a06f000 {
+			compatible = "mediatek,mt8192-camsys_rawb";
+			reg = <0 0x1a06f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys_rawc: clock-controller@1a08f000 {
+			compatible = "mediatek,mt8192-camsys_rawc";
+			reg = <0 0x1a08f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		ipesys: clock-controller@1b000000 {
+			compatible = "mediatek,mt8192-ipesys";
+			reg = <0 0x1b000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		mdpsys: clock-controller@1f000000 {
+			compatible = "mediatek,mt8192-mdpsys";
+			reg = <0 0x1f000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 };
-- 
2.18.0

