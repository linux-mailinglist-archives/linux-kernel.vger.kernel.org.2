Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F181E3B57FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 06:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhF1EGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 00:06:02 -0400
Received: from regular1.263xmail.com ([211.150.70.204]:38308 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhF1EFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 00:05:55 -0400
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 54C3F57E;
        Mon, 28 Jun 2021 11:54:41 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED2: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 1
Received: from localhost.localdomain (unknown [14.20.131.7])
        by smtp.263.net (postfix) whith ESMTP id P12369T139709984536320S1624852472443677_;
        Mon, 28 Jun 2021 11:54:41 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <451d7a6f36f7fa01453738daed5d5208>
X-RL-SENDER: djw@t-chip.com.cn
X-SENDER: djw@t-chip.com.cn
X-LOGIN-NAME: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-RCPT-COUNT: 16
X-SENDER-IP: 14.20.131.7
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   djw@t-chip.com.cn
To:     linux-rockchip@lists.infradead.org
Cc:     Wayne Chou <zxf@t-chip.com.cn>, Kongxin Deng <dkx@t-chip.com.cn>,
        Levin Du <djw@t-chip.com.cn>, Heiko Stuebner <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Liang Chen <cl@rock-chips.com>,
        Marty Jones <mj8263788@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0 2/2] arm64: dts: rockchip: add support for Firefly ROC-RK3399-PC-PLUS
Date:   Mon, 28 Jun 2021 11:54:02 +0800
Message-Id: <20210628035402.16812-3-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.23.0.37.g745f6812895b
In-Reply-To: <20210628035402.16812-1-djw@t-chip.com.cn>
References: <20210628035402.16812-1-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>

ROC-RK3399-PC-PLUS is the board inside the portable Firefly Station P1 Geek
PC. As a redesign after the ROC-RK3399-PC, it uses DC-12V as power input
and spares a USB 3 host port. It is also equipped with a USB WiFi chip and
audio codec without the mezzanine board.

- Rockchip RK3399 SoC
- 4GB LPDDR4 RAM
- 16MB SPI-Flash
- eMMC slot
- TF card slot
- USB 3.0 Port x 1, USB 2.0 Port x 1, TypeC Port x 1
- HDMI
- Gigabit Ethernet
- WiFi: RTL8723DU
- Audio: ES8388
- Key: Recovery
- LED: WORK, DIY
- IR

Signed-off-by: Kongxin Deng <dkx@t-chip.com.cn>
Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3399-roc-pc-plus.dts  | 223 ++++++++++++++++++
 2 files changed, 224 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 7fdb41de01ec..d6ab171b2522 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -42,6 +42,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinebook-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4c.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
new file mode 100644
index 000000000000..370e8bf1b40c
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
@@ -0,1 +1,223 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2017 T-Chip Intelligent Technology Co., Ltd
+ */
+
+/dts-v1/;
+#include "rk3399-roc-pc.dtsi"
+
+/**
+ * Notice:
+ * 1. rk3399-roc-pc-plus is powered by dc_12v directly.
+ * 2. rk3399-roc-pc-plus has only vcc_bus_typec0 in schematic, which is coresponding
+ *    to vcc_vbus_typec1 in rk3399-roc-pc.
+ *    For simplicity, reserve the node name of vcc_vbus_typec1.
+ * 3. vcc5v0_host is actually 2 regulators (host0, 1) controlled by the same gpio.
+ */
+
+/delete-node/ &fusb1;
+/delete-node/ &hub_rst;
+/delete-node/ &mp8859;
+/delete-node/ &vcc_sys_en;
+/delete-node/ &vcc_vbus_typec0;
+/delete-node/ &yellow_led;
+
+/ {
+	model = "Firefly ROC-RK3399-PC-PLUS Board";
+	compatible = "firefly,roc-rk3399-pc-plus", "rockchip,rk3399";
+
+	dc_12v: dc-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_12v";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	gpio-fan {
+		#cooling-cells = <2>;
+		compatible = "gpio-fan";
+		gpio-fan,speed-map = <0 0 3000 1>;
+		gpios = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+
+	/delete-node/ gpio-keys;
+
+	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&work_led_pin>, <&diy_led_pin>;
+	};
+
+	es8388-sound {
+		compatible = "simple-audio-card";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_det_pin>;
+		simple-audio-card,name = "rockchip,es8388-codec";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,mclk-fs = <256>;
+
+		simple-audio-card,widgets =
+			"Microphone", "Mic Jack",
+			"Headphone", "Headphones";
+		simple-audio-card,routing =
+			"LINPUT1", "Mic Jack",
+			"Headphone Amp INL", "LOUT2",
+			"Headphone Amp INR", "ROUT2",
+			"Headphones", "Headphone Amp OUTL",
+			"Headphones", "Headphone Amp OUTR";
+
+		simple-audio-card,hp-det-gpio = <&gpio2 RK_PA6 GPIO_ACTIVE_HIGH>;
+		simple-audio-card,aux-devs = <&headphones_amp>;
+		simple-audio-card,pin-switches = "Headphones";
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s1>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&es8388>;
+		};
+	};
+
+	/* not amplifier, used as switcher only */
+	headphones_amp: headphones-amp {
+		compatible = "simple-audio-amplifier";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ear_ctl_pin>;
+		enable-gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
+		sound-name-prefix = "Headphone Amp";
+		VCC-supply = <&vcca3v0_codec>;
+	};
+
+	ir-receiver {
+		linux,rc-map-name = "rc-khadas";
+	};
+
+};
+
+&fusb0 {
+	vbus-supply = <&vcc_vbus_typec1>;
+};
+
+&i2c0 {
+	hym8563: hym8563@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "xin32k";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hym8563_int>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA5 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
+&i2c1 {
+	es8388: es8388@11 {
+		compatible = "everest,es8388";
+		reg = <0x11>;
+		clock-names = "mclk";
+		clocks = <&cru SCLK_I2S_8CH_OUT>;
+		#sound-dai-cells = <0>;
+		status = "okay";
+	};
+};
+
+// <4 RK_PA0 1 &pcfg_pull_none> is used as i2s_8ch_mclk_pin
+&i2s0_8ch_bus {
+	rockchip,pins =
+		<3 RK_PD0 1 &pcfg_pull_none>,
+		<3 RK_PD1 1 &pcfg_pull_none>,
+		<3 RK_PD2 1 &pcfg_pull_none>,
+		<3 RK_PD3 1 &pcfg_pull_none>,
+		<3 RK_PD4 1 &pcfg_pull_none>,
+		<3 RK_PD5 1 &pcfg_pull_none>,
+		<3 RK_PD6 1 &pcfg_pull_none>,
+		<3 RK_PD7 1 &pcfg_pull_none>;
+};
+
+&i2s1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s_8ch_mclk_pin>, <&i2s1_2ch_bus>;
+	rockchip,playback-channels = <2>;
+	rockchip,capture-channels = <2>;
+	status = "okay";
+};
+
+&pinctrl {
+	es8388 {
+		ear_ctl_pin: ear-ctl-pin {
+			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_output_high>;
+		};
+
+		hp_det_pin: hp-det-pin {
+			rockchip,pins = <2 RK_PA6 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	i2s1 {
+		i2s_8ch_mclk_pin: i2s-8ch-mclk-pin {
+			rockchip,pins = <4 RK_PA0 1 &pcfg_pull_none>;
+		};
+	};
+};
+
+&u2phy0 {
+	status = "okay";
+
+	u2phy0_otg: otg-port {
+		phy-supply = <&vcc_vbus_typec1>;
+		status = "okay";
+	};
+
+	u2phy0_host: host-port {
+		phy-supply = <&vcc5v0_host>;
+		status = "okay";
+	};
+};
+
+&u2phy1 {
+	status = "okay";
+
+	u2phy1_otg: otg-port {
+		phy-supply = <&vcc5v0_host>;
+		status = "okay";
+	};
+
+	u2phy1_host: host-port {
+		phy-supply = <&vcc5v0_host>;
+		status = "okay";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
+	status = "okay";
+};
+
+&usbdrd_dwc3_0 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&vcc_sys {
+	// vcc_sys is fixed, not controlled by any gpio
+	/delete-property/ gpio;
+	/delete-property/ pinctrl-names;
+	/delete-property/ pinctrl-0;
+};
+
+&vcc5v0_host {
+	pinctrl-names = "default";
+	pinctrl-0 = <&vcc5v0_host_en>;
+};
--
2.23.0.37.g745f6812895b



