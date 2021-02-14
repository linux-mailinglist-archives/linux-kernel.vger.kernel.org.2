Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A3331B078
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 14:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhBNNQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 08:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhBNNQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 08:16:27 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA91C0613D6;
        Sun, 14 Feb 2021 05:15:46 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ot7so4264050ejb.9;
        Sun, 14 Feb 2021 05:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=It/tnchFTL5BU0mnlVkVrdQSaCCBWgmelB0GwnqJJyA=;
        b=YcrRQ10fhOvk3EguiqPeZ/qwyoXHA0krmoC2Pf+giRf/uonRTpiL4d9YBJvxOVXWu6
         7AUu04CH+RnwCTNpulx2zv9jpOX3pJmoYQwuNu5p5c35w7NClR7xHYeOluoubXgxOCOJ
         zvjoTXdpA04DVXvaEnPZooeTfgP1fV/ITWUYaa++cuYTXXMLp1UkceGPclw32NNoVOu2
         fZFRJ/uRWcfTOe6Oe/dqHkKCY939d8PXtr5ASpWbvhgzvCL0ynwspRsIojFJzzfe5CZ/
         JT1XND6bad16E1ZJjOKUAfWBlX1N/GWGYzSy9+TtFFLLovSHACusRf9IHnariIMfft7c
         X4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=It/tnchFTL5BU0mnlVkVrdQSaCCBWgmelB0GwnqJJyA=;
        b=Sm8gnoBCjfF3ExlLq5bbgDDLCPLfL8BwmXBuFIQTMz+BoOt1WSTKyKhKcgmt+FYGey
         ONuiUp2c794Wr/YLXM5QjmLFNX+NSnZ7iT5/CkN0B75xjPNaUm1mTIzYPtt5+3iEg8yw
         sgbO0NQFSqaEsjotyIFBZ6V2Jor51UNhAqi8hLZu3Gri7mlOow1WaBi1KtMoDMcu6NRS
         O1lXCuXg/ttzp+r4cI/Vlbcx20j5zhI7swNdzQKM2GVxiysMQawUvYyRWClx47nUDs4A
         HflBCSidxYoUhKo+y3TVQW8g+1hNQkftwJCcpvQaISTSHbb0KG5NBCulfBqRlYwABdRj
         AanQ==
X-Gm-Message-State: AOAM531JR8Wrpzl7eLp7vXODJSdxjfOFf8lcgPlTHsAn6BxmzPJGQb+B
        VeTNE0r/ffp7agu4QFwd/n4=
X-Google-Smtp-Source: ABdhPJw4mp8gtML/z1TDmBxI+p/j5CP5kukJELG5m1IYi1pY2Kwb9qeocJQUGmUzC0hnh0ac/FMboQ==
X-Received: by 2002:a17:906:755:: with SMTP id z21mr11680010ejb.514.1613308543969;
        Sun, 14 Feb 2021 05:15:43 -0800 (PST)
Received: from localhost (ipv6-31ee9f1acdb5aef4.ost.clients.hamburg.freifunk.net. [2a03:2267:4:0:31ee:9f1a:cdb5:aef4])
        by smtp.gmail.com with ESMTPSA id kb25sm8993004ejc.19.2021.02.14.05.15.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2021 05:15:43 -0800 (PST)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     shawnguo@kernel.org
Cc:     m.felsch@pengutronix.de, festevam@gmail.com,
        narmstrong@baylibre.com, Oliver Graute <oliver.graute@gmail.com>,
        Parthiban Nallathambi <parthitce@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/3] ARM: dts: Add support for i.MX6 UltraLite DART Variscite Customboard
Date:   Sun, 14 Feb 2021 14:13:49 +0100
Message-Id: <1613308450-27958-3-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613308450-27958-1-git-send-email-oliver.graute@gmail.com>
References: <1613308450-27958-1-git-send-email-oliver.graute@gmail.com>
X-Patchwork-Bot: notify
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DeviceTree Source for the i.MX6 UltraLite DART NAND/WIFI

Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>
Cc: Parthiban Nallathambi <parthitce@gmail.com>
---
Changelog:

v9:
 - removed display-timing node
 - added 5V power supply for display
 - added assigned clocks for display

v8:
 - backlight droped the status line
 - port the display panel
 - added pinctrl for touch

v7:
 - fixed wakeup-source

v6:
 - added some muxing
 - added codec in sound node
 - added adc1 node

 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts | 255 ++++++++++++++++++++++++
 2 files changed, 256 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ce66ffd..9f72446 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -626,6 +626,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
 	imx6ul-tx6ul-mainboard.dtb \
+	imx6ul-var-6ulcustomboard.dtb \
 	imx6ull-14x14-evk.dtb \
 	imx6ull-colibri-eval-v3.dtb \
 	imx6ull-colibri-wifi-eval-v3.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts b/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
new file mode 100644
index 00000000..bf18888
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/*
+ * Support for Variscite DART-6UL Module
+ *
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ * Copyright (C) 2015-2016 Variscite Ltd. - http://www.variscite.com
+ * Copyright (C) 2018-2021 Oliver Graute <oliver.graute@gmail.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "imx6ul-imx6ull-var-dart-common.dtsi"
+
+/ {
+	model = "Variscite i.MX6 UltraLite Carrier-board";
+	compatible = "variscite,6ulcustomboard", "fsl,imx6ul";
+
+	backlight_lcd: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 20000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		status = "okay";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		user {
+			gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+			wakeup-source;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		d16-led {
+			gpios = <&gpio4 20 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	panel1: panel-lcd {
+		compatible = "sgd,gktw70sdad1sd";
+
+		backlight = <&backlight_lcd>;
+		label = "gktw70sdad1sd";
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lcdif_out>;
+			};
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "wm8731audio";
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Line", "Line Jack",
+			"Microphone", "Mic Jack";
+		simple-audio-card,routing =
+			"Headphone Jack", "RHPOUT",
+			"Headphone Jack", "LHPOUT",
+			"LLINEIN", "Line Jack",
+			"RLINEIN", "Line Jack",
+			"MICIN", "Mic Bias",
+			"Mic Bias", "Mic Jack";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,frame-master = <&codec_dai>;
+
+		codec_dai: simple-audio-card,codec {
+			sound-dai = <&wm8731>;
+			system-clock-frequency = <12288000>;
+		};
+	};
+};
+
+&adc1 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&can2 {
+	status = "okay";
+};
+
+&fec1 {
+	status = "okay";
+};
+
+&fec2 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	clock_frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	wm8731: audio-codec@1a {
+		compatible = "wlf,wm8731";
+		reg = <0x1a>;
+		#sound-dai-cells = <0>;
+		clocks = <&clks IMX6UL_CLK_SAI2>;
+		clock-names = "mclk";
+	};
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <4 IRQ_TYPE_NONE>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+		wakeup-source;
+	};
+
+	rtc@68 {
+		compatible = "dallas,ds1337";
+		reg = <0x68>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rtc>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
+&lcdif {
+	assigned-clocks = <&clks IMX6UL_CLK_LCDIF_PRE_SEL>;
+	assigned-clock-parents = <&clks IMX6UL_CLK_PLL5_VIDEO_DIV>;
+	pinctrl-names = "default";
+	power-supply = <&reg_5v0>;
+	pinctrl-0 = <&pinctrl_lcdif>;
+	status = "okay";
+
+	port {
+		lcdif_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usbotg1 {
+	disable-over-current;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbotg2 {
+	disable-over-current;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_gpio_keys: gpio_keysgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO00__GPIO1_IO00	0x17059
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledsgrp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_HSYNC__GPIO4_IO20		0x1b0b0
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6UL_PAD_UART5_TX_DATA__I2C2_SCL	0x4001b8b0
+			MX6UL_PAD_UART5_RX_DATA__I2C2_SDA	0x4001b8b0
+		>;
+	};
+
+	pinctrl_lcdif: lcdif {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02	0x79
+			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03	0x79
+			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04	0x79
+			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05	0x79
+			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06	0x79
+			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07	0x79
+			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10	0x79
+			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11	0x79
+			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12	0x79
+			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13	0x79
+			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14	0x79
+			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15	0x79
+			MX6UL_PAD_LCD_DATA18__LCDIF_DATA18	0x79
+			MX6UL_PAD_LCD_DATA19__LCDIF_DATA19	0x79
+			MX6UL_PAD_LCD_DATA20__LCDIF_DATA20	0x79
+			MX6UL_PAD_LCD_DATA21__LCDIF_DATA21	0x79
+			MX6UL_PAD_LCD_DATA22__LCDIF_DATA22	0x79
+			MX6UL_PAD_LCD_DATA23__LCDIF_DATA23	0x79
+			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x79
+			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x79
+		>;
+	};
+
+	pinctrl_rtc: rtcgrp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x1b0b0
+		>;
+	};
+
+	pinctrl_touch: touchgrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_RESET__GPIO3_IO04		0x80000000
+		>;
+	};
+
+};
-- 
2.7.4

