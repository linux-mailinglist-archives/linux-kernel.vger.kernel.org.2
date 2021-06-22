Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32BD3B015F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 12:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhFVKbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 06:31:32 -0400
Received: from gloria.sntech.de ([185.11.138.130]:42092 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhFVKb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:31:26 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lvdeX-00031Z-Nt; Tue, 22 Jun 2021 12:29:09 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     cl@rock-chips.com
Cc:     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com
Subject: [PATCH 09/10] arm64: dts: rockchip: add pwm nodes for rk3568
Date:   Tue, 22 Jun 2021 12:29:06 +0200
Message-Id: <20210622102907.99242-1-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Add the pwm controller nodes to the core rk3568 dtsi.

Signed-off-by: Liang Chen <cl@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 176 +++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index d225e6a45d5c..33db226b46cb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -257,6 +257,50 @@ uart0: serial@fdd50000 {
 		status = "disabled";
 	};
 
+	pwm0: pwm@fdd70000 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfdd70000 0x0 0x10>;
+		clocks = <&pmucru CLK_PWM0>, <&pmucru PCLK_PWM0>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm0m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm1: pwm@fdd70010 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfdd70010 0x0 0x10>;
+		clocks = <&pmucru CLK_PWM0>, <&pmucru PCLK_PWM0>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm1m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm2: pwm@fdd70020 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfdd70020 0x0 0x10>;
+		clocks = <&pmucru CLK_PWM0>, <&pmucru PCLK_PWM0>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm2m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm3: pwm@fdd70030 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfdd70030 0x0 0x10>;
+		clocks = <&pmucru CLK_PWM0>, <&pmucru PCLK_PWM0>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm3_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
 	sdmmc2: mmc@fe000000 {
 		compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xfe000000 0x0 0x4000>;
@@ -525,6 +569,138 @@ uart9: serial@fe6d0000 {
 		status = "disabled";
 	};
 
+	pwm4: pwm@fe6e0000 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe6e0000 0x0 0x10>;
+		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm4_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm5: pwm@fe6e0010 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe6e0010 0x0 0x10>;
+		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm5_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm6: pwm@fe6e0020 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe6e0020 0x0 0x10>;
+		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm6_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm7: pwm@fe6e0030 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe6e0030 0x0 0x10>;
+		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm7_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm8: pwm@fe6f0000 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe6f0000 0x0 0x10>;
+		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm8m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm9: pwm@fe6f0010 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe6f0010 0x0 0x10>;
+		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm9m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm10: pwm@fe6f0020 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe6f0020 0x0 0x10>;
+		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm10m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm11: pwm@fe6f0030 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe6f0030 0x0 0x10>;
+		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm11m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm12: pwm@fe700000 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe700000 0x0 0x10>;
+		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm12m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm13: pwm@fe700010 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe700010 0x0 0x10>;
+		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm13m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm14: pwm@fe700020 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe700020 0x0 0x10>;
+		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm14m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm15: pwm@fe700030 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe700030 0x0 0x10>;
+		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm15m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3568-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.29.2

