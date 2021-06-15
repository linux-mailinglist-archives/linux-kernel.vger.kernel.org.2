Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1523A87C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhFORfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:35:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34885 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231166AbhFORey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:34:54 -0400
X-UUID: b24082219a414d1da813fcba98545cfd-20210616
X-UUID: b24082219a414d1da813fcba98545cfd-20210616
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 20401373; Wed, 16 Jun 2021 01:32:44 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
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
        Kewei Xu <kewei.xu@mediatek.com>
Subject: [PATCH 08/27] arm64: dts: mt8195: add i2c dts
Date:   Wed, 16 Jun 2021 01:32:14 +0800
Message-ID: <20210615173233.26682-8-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210615173233.26682-1-tinghan.shen@mediatek.com>
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kewei Xu <kewei.xu@mediatek.com>

add i2c dts config for mt8195 soc.

Signed-off-by: Kewei Xu <kewei.xu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 105 +++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 5463e7ba1061..9b002bb6d344 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -879,12 +879,117 @@
 			};
 		};
 
+		i2c5: i2c@11d00000 {
+			compatible = "mediatek,mt8195-i2c",
+				     "mediatek,mt8192-i2c";
+			reg = <0 0x11d00000 0 0x1000>,
+			      <0 0x10220580 0 0x80>;
+			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH 0>;
+			clock-div = <1>;
+			clocks = <&imp_iic_wrap_s CLK_IMP_IIC_WRAP_S_I2C5>,
+				 <&infracfg_ao CLK_INFRA_AO_APDMA_B>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c7: i2c@11d02000 {
+			compatible = "mediatek,mt8195-i2c",
+				     "mediatek,mt8192-i2c";
+			reg = <0 0x11d02000 0 0x1000>,
+			      <0 0x10220680 0 0x80>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH 0>;
+			clock-div = <1>;
+			clocks = <&imp_iic_wrap_s CLK_IMP_IIC_WRAP_S_I2C7>,
+				 <&infracfg_ao CLK_INFRA_AO_APDMA_B>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		imp_iic_wrap_s: syscon@11d03000 {
 			compatible = "mediatek,mt8195-imp_iic_wrap_s", "syscon";
 			reg = <0 0x11d03000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		i2c0: i2c@11e00000 {
+			compatible = "mediatek,mt8195-i2c",
+				     "mediatek,mt8192-i2c";
+			reg = <0 0x11e00000 0 0x1000>,
+			      <0 0x10220080 0 0x80>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH 0>;
+			clock-div = <1>;
+			clocks = <&imp_iic_wrap_w CLK_IMP_IIC_WRAP_W_I2C0>,
+				 <&infracfg_ao CLK_INFRA_AO_APDMA_B>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "okay";
+		};
+
+		i2c1: i2c@11e01000 {
+			compatible = "mediatek,mt8195-i2c",
+				     "mediatek,mt8192-i2c";
+			reg = <0 0x11e01000 0 0x1000>,
+			      <0 0x10220200 0 0x80>;
+			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH 0>;
+			clock-div = <1>;
+			clocks = <&imp_iic_wrap_w CLK_IMP_IIC_WRAP_W_I2C1>,
+				 <&infracfg_ao CLK_INFRA_AO_APDMA_B>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@11e02000 {
+			compatible = "mediatek,mt8195-i2c",
+				     "mediatek,mt8192-i2c";
+			reg = <0 0x11e02000 0 0x1000>,
+			      <0 0x10220380 0 0x80>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH 0>;
+			clock-div = <1>;
+			clocks = <&imp_iic_wrap_w CLK_IMP_IIC_WRAP_W_I2C2>,
+				 <&infracfg_ao CLK_INFRA_AO_APDMA_B>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@11e03000 {
+			compatible = "mediatek,mt8195-i2c",
+				     "mediatek,mt8192-i2c";
+			reg = <0 0x11e03000 0 0x1000>,
+			      <0 0x10220480 0 0x80>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH 0>;
+			clock-div = <1>;
+			clocks = <&imp_iic_wrap_w CLK_IMP_IIC_WRAP_W_I2C3>,
+				 <&infracfg_ao CLK_INFRA_AO_APDMA_B>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@11e04000 {
+			compatible = "mediatek,mt8195-i2c",
+				     "mediatek,mt8192-i2c";
+			reg = <0 0x11e04000 0 0x1000>,
+			      <0 0x10220500 0 0x80>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH 0>;
+			clock-div = <1>;
+			clocks = <&imp_iic_wrap_w CLK_IMP_IIC_WRAP_W_I2C4>,
+				 <&infracfg_ao CLK_INFRA_AO_APDMA_B>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		imp_iic_wrap_w: syscon@11e05000 {
 			compatible = "mediatek,mt8195-imp_iic_wrap_w", "syscon";
 			reg = <0 0x11e05000 0 0x1000>;
-- 
2.18.0

