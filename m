Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4053D3582
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhGWG7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233298AbhGWG7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:59:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EEBE60EE6;
        Fri, 23 Jul 2021 07:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627026012;
        bh=z12ohAzjRBP3E8089FPH94RrqDgdT25W23fpakluff8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qtmegvyKGQ6idupFOq9cG/C5UqOWEZ8zpn/ozBPACGruNogRWvg7zrefBfwzSSg31
         gsH9O6IhGqtsvx7jNxA8zPCyruoTd/j1lGLDtmsPuM27g5zhgXF+JnDXj3gJ0Eg0o/
         +5DLlOMmw240YVIR2GY+NOVc+sBuPpo+ogHCbw8G54DvgYZQtlKRh7LaEb16XrSMHm
         XS+CdYIlOuERsydZgU5uBbQrN+xjlZOc8Wxf+/Oll1x21q9Dqr3kyR4BLU8zJ/qmme
         QJYd7E4FNF/28FZbhqmxcZag3vjiJbRc92hsu3V+FYB0VyZGB9mX8PRRSZe3YOrLc4
         YJdjINYII/qgg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6pn0-00A6vW-MA; Fri, 23 Jul 2021 09:40:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v15 3/3] dts: hisilicon: add support for USB3 on Hikey 970
Date:   Fri, 23 Jul 2021 09:40:08 +0200
Message-Id: <da0401daebfc1bb33dac0d3f8358118b8ea59d06.1627025657.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627025657.git.mchehab+huawei@kernel.org>
References: <cover.1627025657.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the USB3 bindings for Kirin 970 phy and Hikey 970 board.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 107 ++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  56 +++++++++
 2 files changed, 163 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index 7c32f5fd5cc5..16f81f86e3fa 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -53,6 +53,30 @@ wlan_en: wlan-en-1-8v {
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
+
+	hikey_usbhub: hikey_usbhub {
+		compatible = "hisilicon,kirin970_hikey_usbhub";
+
+		typec-vbus-gpios = <&gpio26 1 0>;
+		otg-switch-gpios = <&gpio4 2 0>;
+		hub_reset_en_gpio = <&gpio0 3 0>;
+		hub-vdd-supply = <&ldo17>;
+		usb-role-switch;
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hikey_usb_ep0: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&dwc3_role_switch>;
+			};
+			hikey_usb_ep1: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&rt1711h_ep>;
+			};
+		};
+	};
 };
 
 /*
@@ -430,3 +454,86 @@ &uart6 {
 	label = "LS-UART1";
 	status = "okay";
 };
+
+&usb_phy {
+	phy-supply = <&ldo17>;
+};
+
+&i2c1 {
+	status = "okay";
+
+	rt1711h: rt1711h@4e {
+		compatible = "richtek,rt1711h";
+		reg = <0x4e>;
+		status = "okay";
+		interrupt-parent = <&gpio27>;
+		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_cfg_func>;
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+			power-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
+				PDO_VAR(5000, 5000, 1000)>;
+			op-sink-microwatt = <10000000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@1 {
+					reg = <1>;
+					usb_con_ss: endpoint {
+						remote-endpoint = <&dwc3_ss>;
+					};
+				};
+			};
+		};
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rt1711h_ep: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&hikey_usb_ep1>;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	/* USB HUB is on this bus at address 0x44 */
+	status = "okay";
+};
+
+&dwc3 { /* USB */
+	dr_mode = "otg";
+	maximum-speed = "super-speed";
+	phy_type = "utmi";
+	snps,dis-del-phy-power-chg-quirk;
+	snps,dis_u2_susphy_quirk;
+	snps,dis_u3_susphy_quirk;
+	snps,tx_de_emphasis_quirk;
+	snps,tx_de_emphasis = <1>;
+	snps,dis-split-quirk;
+	snps,gctl-reset-quirk;
+	usb-role-switch;
+	role-switch-default-mode = "host";
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		dwc3_role_switch: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&hikey_usb_ep0>;
+		};
+
+		dwc3_ss: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&usb_con_ss>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 20698cfd0637..1f228612192c 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/hi3670-clock.h>
+#include <dt-bindings/usb/pd.h>
 
 / {
 	compatible = "hisilicon,hi3670";
@@ -785,5 +786,60 @@ i2c4: i2c@fdf0d000 {
 			pinctrl-0 = <&i2c4_pmx_func &i2c4_cfg_func>;
 			status = "disabled";
 		};
+
+		usb3_otg_bc: usb3_otg_bc@ff200000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x0 0xff200000 0x0 0x1000>;
+
+			usb_phy: usbphy {
+				compatible = "hisilicon,hi3670-usb-phy";
+				#phy-cells = <0>;
+				hisilicon,pericrg-syscon = <&crg_ctrl>;
+				hisilicon,pctrl-syscon = <&pctrl>;
+				hisilicon,sctrl-syscon = <&sctrl>;
+				hisilicon,eye-diagram-param = <0xFDFEE4>;
+				hisilicon,tx-vboost-lvl = <0x5>;
+			};
+		};
+
+		usb31_misc_rst: usb31_misc_rst_controller {
+			compatible = "hisilicon,hi3660-reset";
+			#reset-cells = <2>;
+			hisi,rst-syscon = <&usb3_otg_bc>;
+		};
+
+		usb3: hisi_dwc3 {
+			compatible = "hisilicon,hi3670-dwc3";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&crg_ctrl HI3670_CLK_GATE_ABB_USB>,
+				  <&crg_ctrl HI3670_HCLK_GATE_USB3OTG>,
+				  <&crg_ctrl HI3670_CLK_GATE_USB3OTG_REF>,
+				  <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
+			clock-names = "clk_gate_abb_usb",
+				      "hclk_gate_usb3otg",
+				      "clk_gate_usb3otg_ref",
+				      "aclk_gate_usb3dvfs";
+
+			assigned-clocks = <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
+			assigned-clock-rates = <238000000>;
+			resets = <&crg_rst 0x90 6>,
+				 <&crg_rst 0x90 7>,
+				 <&usb31_misc_rst 0xA0 8>,
+				 <&usb31_misc_rst 0xA0 9>;
+
+			dwc3: usb@ff100000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0xff100000 0x0 0x100000>;
+
+				interrupts = <0 159 IRQ_TYPE_LEVEL_HIGH>,
+					    <0 161 IRQ_TYPE_LEVEL_HIGH>;
+
+				phys = <&usb_phy>;
+				phy-names = "usb3-phy";
+			};
+		};
 	};
 };
-- 
2.31.1

