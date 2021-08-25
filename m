Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104F83F6CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 03:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbhHYBMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 21:12:48 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:54518 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237165AbhHYBMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 21:12:44 -0400
X-UUID: 80c691fd9bf84cbf81f10f7d12309179-20210825
X-UUID: 80c691fd9bf84cbf81f10f7d12309179-20210825
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 557206151; Wed, 25 Aug 2021 09:11:55 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 25 Aug 2021 09:11:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 25 Aug 2021 09:11:53 +0800
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
Subject: [v1 5/5] arm64: dts: mediatek: Correct I2C clock of MT8192
Date:   Wed, 25 Aug 2021 09:11:20 +0800
Message-ID: <20210825011120.30481-6-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210825011120.30481-1-chun-jie.chen@mediatek.com>
References: <20210825011120.30481-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update i2c 0 ~ 9 clocks to the real ones.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 30 ++++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index db6f4c6dc404..866b04e78690 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -484,7 +484,8 @@
 			reg = <0 0x11cb0000 0 0x1000>,
 			      <0 0x10217300 0 0x80>;
 			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_e CLK_IMP_IIC_WRAP_E_I2C3>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -503,7 +504,8 @@
 			reg = <0 0x11d00000 0 0x1000>,
 			      <0 0x10217600 0 0x180>;
 			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_s CLK_IMP_IIC_WRAP_S_I2C7>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -516,7 +518,8 @@
 			reg = <0 0x11d01000 0 0x1000>,
 			      <0 0x10217780 0 0x180>;
 			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_s CLK_IMP_IIC_WRAP_S_I2C8>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -529,7 +532,8 @@
 			reg = <0 0x11d02000 0 0x1000>,
 			      <0 0x10217900 0 0x180>;
 			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_s CLK_IMP_IIC_WRAP_S_I2C9>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -548,7 +552,8 @@
 			reg = <0 0x11d20000 0 0x1000>,
 			      <0 0x10217100 0 0x80>;
 			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_ws CLK_IMP_IIC_WRAP_WS_I2C1>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -561,7 +566,8 @@
 			reg = <0 0x11d21000 0 0x1000>,
 			      <0 0x10217180 0 0x180>;
 			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_ws CLK_IMP_IIC_WRAP_WS_I2C2>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -574,7 +580,8 @@
 			reg = <0 0x11d22000 0 0x1000>,
 			      <0 0x10217380 0 0x180>;
 			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_ws CLK_IMP_IIC_WRAP_WS_I2C4>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -593,7 +600,8 @@
 			reg = <0 0x11e00000 0 0x1000>,
 			      <0 0x10217500 0 0x80>;
 			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_w CLK_IMP_IIC_WRAP_W_I2C5>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -612,7 +620,8 @@
 			reg = <0 0x11f00000 0 0x1000>,
 			      <0 0x10217080 0 0x80>;
 			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_n CLK_IMP_IIC_WRAP_N_I2C0>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -625,7 +634,8 @@
 			reg = <0 0x11f01000 0 0x1000>,
 			      <0 0x10217580 0 0x80>;
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_n CLK_IMP_IIC_WRAP_N_I2C6>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
-- 
2.18.0

