Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DC33A87BB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhFORfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:35:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35324 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231161AbhFORex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:34:53 -0400
X-UUID: 710e977156df40f696cf861e13030b66-20210616
X-UUID: 710e977156df40f696cf861e13030b66-20210616
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1060949818; Wed, 16 Jun 2021 01:32:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 01:32:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 01:32:44 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <seiya.wang@mediatek.com>, <wenst@google.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        James Zheng <james.zheng@mediatek.com>
Subject: [PATCH 13/27] arm64: dts: mt8195: add hdmi nodes
Date:   Wed, 16 Jun 2021 01:32:19 +0800
Message-ID: <20210615173233.26682-13-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210615173233.26682-1-tinghan.shen@mediatek.com>
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Zheng <james.zheng@mediatek.com>

Add HDMI support for mt8195 SoC.

Signed-off-by: James Zheng <james.zheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 84 ++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 327ff1b856d2..1a281551d011 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -20,6 +20,10 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		dpi1 = &disp_dpi1;
+	};
+
 	clocks {
 		clk26m: oscillator0 {
 			compatible = "fixed-clock";
@@ -317,6 +321,28 @@
 			interrupt-controller;
 			interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH 0>;
 			#interrupt-cells = <2>;
+
+			hdmi_pin: hdmipinctrl {
+				hdmi_hotplug {
+					pinmux = <PINMUX_GPIO32__FUNC_HDMITX20_HTPLG>;
+					bias-pull-down;
+				};
+				hdmi_ddc {
+					pinmux = <PINMUX_GPIO34__FUNC_HDMITX20_SCL>,
+						<PINMUX_GPIO35__FUNC_HDMITX20_SDA>;
+					mediatek,drive-strength-adv = <0>;
+					drive-strength = <MTK_DRIVE_10mA>;
+				};
+				hdmi_cec {
+					pinmux = <PINMUX_GPIO33__FUNC_HDMITX20_CEC>;
+					bias-disable;
+				};
+				hdmi_5vctrl {
+					pinmux = <PINMUX_GPIO31__FUNC_GPIO31>;
+					slew-rate = <1>;
+					output-high;
+				};
+			};
 		};
 
 		scpsys: syscon@10006000 {
@@ -693,6 +719,12 @@
 			#clock-cells = <1>;
 		};
 
+		cec: cec@10014000 {
+			compatible = "mediatek,mt8195-cec";
+			reg = <0 0x10014000 0 0x100>;
+			interrupts = <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		systimer: timer@10017000 {
 			compatible = "mediatek,mt8195-timer", "mediatek,mt6765-timer";
 			reg = <0 0x10017000 0 0x1000>;
@@ -1105,6 +1137,22 @@
 			#clock-cells = <1>;
 		};
 
+		hdmi_phy: hdmi-phy@11d5f000 {
+			compatible = "mediatek,mt8195-hdmi-phy";
+			reg = <0 0x11d5f000 0 0x100>;
+			clocks = <&topckgen CLK_TOP_HDMI_XTAL_SEL>,
+				 <&infracfg_ao CLK_INFRA_AO_HDMI_26M>,
+				 <&apmixedsys CLK_APMIXED_HDMIPLL1>,
+				 <&apmixedsys CLK_APMIXED_HDMIPLL2>;
+			clock-names = "hdmi_xtal_sel",
+				      "hdmi_26m",
+				      "hdmi_pll1",
+				      "hdmi_pll2";
+			clock-output-names = "hdmi_txpll";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+		};
+
 		i2c0: i2c@11e00000 {
 			compatible = "mediatek,mt8195-i2c",
 				     "mediatek,mt8192-i2c";
@@ -1408,5 +1456,41 @@
 			reg = <0 0x1c100000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		disp_dpi1: disp_dpi1@1c112000 {
+			compatible = "mediatek,mt8195-dpi";
+			reg = <0 0x1c112000 0 0x1000>;
+			interrupts = <GIC_SPI 512 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "pixel", "engine";
+			status = "disabled";
+		};
+
+		hdmi0: hdmi@1c300000 {
+			compatible = "mediatek,mt8195-hdmi";
+			reg = <0 0x1c300000 0 0x1000>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_HDMI_TX>;
+			clocks = <&topckgen CLK_TOP_HDCP_SEL>,
+					<&topckgen CLK_TOP_HDCP_24M_SEL>,
+					<&topckgen CLK_TOP_HD20_HDCP_C_SEL>,
+					<&vppsys1 CLK_VPP1_VPP_SPLIT_HDMI>;
+			clock-names = "hdcp_sel",
+				      "hdcp24_sel",
+				      "hd20_hdcp_sel",
+				      "split_hdmi";
+			interrupts = <GIC_SPI 677 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hdmi_pin>;
+			phys = <&hdmi_phy>;
+			phy-names = "hdmi";
+			cec = <&cec>;
+			ddc-i2c-bus = <&hdmiddc0>;
+			status = "disabled";
+		};
+	};
+
+	hdmiddc0: ddc_i2c {
+		compatible = "mediatek,mt8195-hdmi-ddc";
+		clocks = <&clk26m>;
+		clock-names = "ddc-i2c";
 	};
 };
-- 
2.18.0

