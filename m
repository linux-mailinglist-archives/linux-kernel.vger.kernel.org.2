Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B33D36EE8F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhD2RFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240929AbhD2RFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:05:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D4EC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:04:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 82-20020a1c01550000b0290142562ff7c9so136100wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=28ZqMe00x8Xq32OoNXPRZG1wXadnRT7bwRIiBkdqsv8=;
        b=ClSPNoY407+IK8RDinCocB4MhjEnA2xNsDXIZRoPOC7x4ArntkxXzcpzIJ5ltnfeGu
         LAZQH6CEjhuQug2TthC3wrajZwXaET49J+Jkn0XFIS6f8ssrIB1kRO2N+A3bzZOAs/wx
         vzDrE6y/Lv1Fr0nwR4g+uyRpKbL0+Z+mPyzkoLKq0+agNNJkploWBkpZDOxnyE4W1Ecz
         8bHkYmwtB3VsfqjNiNc63FpesGindzXVtcjLBF7wYzQQjfnHcNPr4fIfh+Inma/tCdRC
         nHPLRjd9CKfdwpd3C77L64+NuwzHMA2EtzpQu6oNj1DlN97HVjSjW0Y9JX35DHeUs+bn
         Uf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=28ZqMe00x8Xq32OoNXPRZG1wXadnRT7bwRIiBkdqsv8=;
        b=NniPvLiTm6aW0FtyELTUSikApoxMkVuUWhmc4QZ333Nsarrc6hMAaqDFwjTwYnxDzy
         joP71WWMLYxyQWdvIjjCslnDvLlEAw+qiIZTgLPClpP6bjomXYqK/TxHnBlMpl/Zn2uN
         T1UcCGJVe2nJSpmPtGf3d9oWMdktnCE5w16fyKDIQhkwaqRDzvDIIMRU4O3pM4qhzQRg
         ZH8N7nnhFe+rvibhgfMPfKrqnMEQ+ywZDIwEjL/dhBh/bg2gAruXt4BZ2Tt4J8YvvZwp
         bGvvKD19Kx2xxbQ4GGX+FNSX9pPuKNxGSfuNUmJm5IrcGIbqTfCUmvFWnH3KOCSvIBD1
         qkGQ==
X-Gm-Message-State: AOAM530xU9dc8zlPH1rflYeDT1KqVnCoGsx0FQU/gluWGgvcPIu60PkP
        tsouIG0PpTU61NjlaK3CKYs24UwSEynd90nE
X-Google-Smtp-Source: ABdhPJwjb8mwbGZH54C3x15B8dtuuVCo6tdk8+46YUEfP4XWWiMSfkxpY/A+FdcUKW3xU0tJBgip2w==
X-Received: by 2002:a1c:7e45:: with SMTP id z66mr1168019wmc.126.1619715851727;
        Thu, 29 Apr 2021 10:04:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:c304:4b2b:4a79:1da9])
        by smtp.gmail.com with ESMTPSA id 18sm11041275wmo.47.2021.04.29.10.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 10:04:11 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/3] arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts
Date:   Thu, 29 Apr 2021 19:04:04 +0200
Message-Id: <20210429170404.3616111-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210429170404.3616111-1-narmstrong@baylibre.com>
References: <20210429170404.3616111-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Banana Pi BPI-M5 is a credit card format SBC with the following features:
- Amlogic S905X3 quad core Cortex-A55
- Mali-G31 GPU
- 4GB LPDDR4
- 16GB eMMC flash
- 4 USB 3.0
- 1 GbE ethernet
- HDMI output
- 2x LEDS
- SDCard
- 2.5mm Jack with Stereo Audio + CVBS
- Infrared Received
- ADC Button
- GPIO Button
- 40 pins header + 3pins debug header

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../dts/amlogic/meson-sm1-bananapi-m5.dts     | 606 ++++++++++++++++++
 2 files changed, 607 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 78a569d7fa20..3cf6699b4f30 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -45,6 +45,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-libretech-pc.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-vega-s96.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-wetek-core2.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m5.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
new file mode 100644
index 000000000000..e5fc9d320577
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
@@ -0,0 +1,606 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2021 BayLibre SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include "meson-sm1.dtsi"
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/gpio/meson-g12a-gpio.h>
+#include <dt-bindings/sound/meson-g12a-toacodec.h>
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+
+/ {
+	compatible = "bananapi,bpi-m5", "amlogic,sm1";
+	model = "Banana Pi BPI-M5";
+
+	adc_keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 2>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+
+		button-onoff {
+			label = "SW3";
+			linux,code = <BTN_3>;
+			press-threshold-microvolt = <1700000>;
+		};
+	};
+
+	aliases {
+		serial0 = &uart_AO;
+		ethernet0 = &ethmac;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	/* TOFIX: handle CVBS_DET on SARADC channel 0 */
+	cvbs-connector {
+		compatible = "composite-video-connector";
+
+		port {
+			cvbs_connector_in: endpoint {
+				remote-endpoint = <&cvbs_vdac_out>;
+			};
+		};
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key {
+			label = "SW1";
+			linux,code = <BTN_1>;
+			gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_LOW>;
+			interrupt-parent = <&gpio_intc>;
+			interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
+		};
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_tmds_out>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		green {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
+		};
+
+		blue {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio_ao GPIOAO_11 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+
+	flash_1v8: regulator-flash_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "FLASH_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	dc_in: regulator-dc_in {
+		compatible = "regulator-fixed";
+		regulator-name = "5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	vddio_c: regulator-vddio_c {
+		compatible = "regulator-gpio";
+		regulator-name = "VDDIO_C";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		enable-gpio = <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+
+		gpios = <&gpio_ao GPIOAO_6 GPIO_OPEN_DRAIN>;
+		gpios-states = <1>;
+
+		states = <1800000 0>,
+			 <3300000 1>;
+	};
+
+	tflash_vdd: regulator-tflash_vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "TFLASH_VDD";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_in>;
+		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	vddao_1v8: regulator-vddao_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	vddao_3v3: regulator-vddao_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_in>;
+		regulator-always-on;
+	};
+
+	vddcpu: regulator-vddcpu {
+		/*
+		 * SY8120B1ABC DC/DC Regulator.
+		 */
+		compatible = "pwm-regulator";
+
+		regulator-name = "VDDCPU";
+		regulator-min-microvolt = <721000>;
+		regulator-max-microvolt = <1022000>;
+
+		vin-supply = <&dc_in>;
+
+		pwms = <&pwm_AO_cd 1 1250 0>;
+		pwm-dutycycle-range = <100 0>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	/* USB Hub Power Enable */
+	vl_pwr_en: regulator-vl_pwr_en {
+		compatible = "regulator-fixed";
+		regulator-name = "VL_PWR_EN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_in>;
+
+		gpio = <&gpio GPIOH_6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "BPI-M5";
+		audio-widgets = "Line", "Lineout";
+		audio-aux-devs = <&tdmout_b>, <&tdmout_c>,
+				 <&tdmin_a>, <&tdmin_b>, <&tdmin_c>;
+		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT",
+				"TDMOUT_C IN 0", "FRDDR_A OUT 2",
+				"TDMOUT_C IN 1", "FRDDR_B OUT 2",
+				"TDMOUT_C IN 2", "FRDDR_C OUT 2",
+				"TDM_C Playback", "TDMOUT_C OUT",
+				"TDMIN_A IN 4", "TDM_B Loopback",
+				"TDMIN_B IN 4", "TDM_B Loopback",
+				"TDMIN_C IN 4", "TDM_B Loopback",
+				"TDMIN_A IN 5", "TDM_C Loopback",
+				"TDMIN_B IN 5", "TDM_C Loopback",
+				"TDMIN_C IN 5", "TDM_C Loopback",
+				"TODDR_A IN 0", "TDMIN_A OUT",
+				"TODDR_B IN 0", "TDMIN_A OUT",
+				"TODDR_C IN 0", "TDMIN_A OUT",
+				"TODDR_A IN 1", "TDMIN_B OUT",
+				"TODDR_B IN 1", "TDMIN_B OUT",
+				"TODDR_C IN 1", "TDMIN_B OUT",
+				"TODDR_A IN 2", "TDMIN_C OUT",
+				"TODDR_B IN 2", "TDMIN_C OUT",
+				"TODDR_C IN 2", "TDMIN_C OUT",
+				"Lineout", "ACODEC LOLP",
+				"Lineout", "ACODEC LORP";
+
+		assigned-clocks = <&clkc CLKID_MPLL2>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		dai-link-3 {
+			sound-dai = <&toddr_a>;
+		};
+
+		dai-link-4 {
+			sound-dai = <&toddr_b>;
+		};
+
+		dai-link-5 {
+			sound-dai = <&toddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-6 {
+			sound-dai = <&tdmif_b>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-tx-mask-1 = <1 1>;
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-tx-mask-3 = <1 1>;
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
+			};
+
+			codec-1 {
+				sound-dai = <&toacodec TOACODEC_IN_B>;
+			};
+		};
+
+		/* i2s jack output interface */
+		dai-link-7 {
+			sound-dai = <&tdmif_c>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_C>;
+			};
+
+			codec-1 {
+				sound-dai = <&toacodec TOACODEC_IN_C>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-8 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+
+		/* acodec glue */
+		dai-link-9 {
+			sound-dai = <&toacodec TOACODEC_OUT>;
+
+			codec {
+				sound-dai = <&acodec>;
+			};
+		};
+	};
+};
+
+&acodec {
+	AVDD-supply = <&vddao_1v8>;
+	status = "okay";
+};
+
+&arb {
+	status = "okay";
+};
+
+&clkc_audio {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu1 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU1_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu2 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU2_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu3 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU3_CLK>;
+	clock-latency = <50000>;
+};
+
+&cvbs_vdac_port {
+	cvbs_vdac_out: endpoint {
+		remote-endpoint = <&cvbs_connector_in>;
+	};
+};
+
+&ext_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211F (0x001cc916) */
+		reg = <0>;
+		max-speed = <1000>;
+
+		interrupt-parent = <&gpio_intc>;
+		/* MAC_INTR on GPIOZ_14 */
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&ethmac {
+	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&external_phy>;
+	amlogic,tx-delay-ns = <2>;
+};
+
+&frddr_a {
+	status = "okay";
+};
+
+&frddr_b {
+	status = "okay";
+};
+
+&frddr_c {
+	status = "okay";
+};
+
+&gpio {
+	gpio-line-names =
+		/* GPIOZ */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* GPIOH */
+		"", "", "", "", "",
+		"CON1-P36", /* GPIOH_5 */
+		"", "", "",
+		/* BOOT */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* GPIOC */
+		"", "", "", "", "", "", "", "",
+		/* GPIOA */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "",
+		"CON1-P27", /* GPIOA_14 */
+		"CON1-P28", /* GPIOA_15 */
+		/* GPIOX */
+		"CON1-P16", /* GPIOX_0 */
+		"CON1-P18", /* GPIOX_1 */
+		"CON1-P22", /* GPIOX_2 */
+		"CON1-P11", /* GPIOX_3 */
+		"CON1-P13", /* GPIOX_4 */
+		"CON1-P07", /* GPIOX_5 */
+		"CON1-P33", /* GPIOX_6 */
+		"CON1-P15", /* GPIOX_7 */
+		"CON1-P19", /* GPIOX_8 */
+		"CON1-P21", /* GPIOX_9 */
+		"CON1-P24", /* GPIOX_10 */
+		"CON1-P23", /* GPIOX_11 */
+		"CON1-P08", /* GPIOX_12 */
+		"CON1-P10", /* GPIOX_13 */
+		"CON1-P29", /* GPIOX_14 */
+		"CON1-P31", /* GPIOX_15 */
+		"CON1-P26", /* GPIOX_16 */
+		"CON1-P03", /* GPIOX_17 */
+		"CON1-P05", /* GPIOX_18 */
+		"CON1-P32"; /* GPIOX_19 */
+
+	/*
+	 * WARNING: The USB Hub on the BPI-M54 needs a reset signal
+	 * to be turned high in order to be detected by the USB Controller
+	 * This signal should be handled by a USB specific power sequence
+	 * in order to reset the Hub when USB bus is powered down.
+	 */
+	usb-hub {
+		gpio-hog;
+		gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "usb-hub-reset";
+	};
+};
+
+&gpio_ao {
+	gpio-line-names =
+		/* GPIOAO */
+		"DEBUG TX", /* GPIOAO_0 */
+		"DEBUG RX", /* GPIOAO_1 */
+		"SYS_LED2", /* GPIOAO_2 */
+		"UPDATE_KEY", /* GPIOAO_3 */
+		"CON1-P40", /* GPIOAO_4 */
+		"",
+		"TF_3V3N_1V8_EN", /* GPIOAO_6 */
+		"CON1-P35", /* GPIOAO_7 */
+		"CON1-P12", /* GPIOAO_8 */
+		"CON1-P37", /* GPIOAO_9 */
+		"CON1-P38", /* GPIOAO_10 */
+		"SYS_LED", /* GPIOAO_11 */
+		/* GPIOE */
+		"", "", "";
+};
+
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
+	pinctrl-names = "default";
+	hdmi-supply = <&dc_in>;
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+};
+
+&pwm_AO_cd {
+	pinctrl-0 = <&pwm_ao_d_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&xtal>;
+	clock-names = "clkin1";
+	status = "okay";
+};
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vddao_1v8>;
+};
+
+/* SD card */
+&sd_emmc_b {
+	status = "okay";
+	pinctrl-0 = <&sdcard_c_pins>;
+	pinctrl-1 = <&sdcard_clk_gate_c_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <50000000>;
+	disable-wp;
+
+	/* TOFIX: SD card is barely usable in SDR modes */
+
+	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&tflash_vdd>;
+	vqmmc-supply = <&vddio_c>;
+};
+
+/* eMMC */
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	max-frequency = <200000000>;
+	disable-wp;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&flash_1v8>;
+};
+
+&tdmif_b {
+	status = "okay";
+};
+
+&tdmif_c {
+	status = "okay";
+};
+
+&tdmin_a {
+	status = "okay";
+};
+
+&tdmin_b {
+	status = "okay";
+};
+
+&tdmin_c {
+	status = "okay";
+};
+
+&tdmout_b {
+	status = "okay";
+};
+
+&tdmout_c {
+	status = "okay";
+};
+
+&toacodec {
+	status = "okay";
+};
+
+&tohdmitx {
+	status = "okay";
+};
+
+&toddr_a {
+	status = "okay";
+};
+
+&toddr_b {
+	status = "okay";
+};
+
+&toddr_c {
+	status = "okay";
+};
+
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+};
+
+&usb {
+	status = "okay";
+};
+
+&usb2_phy0 {
+	phy-supply = <&dc_in>;
+};
+
+&usb2_phy1 {
+	/* Enable the hub which is connected to this port */
+	phy-supply = <&vl_pwr_en>;
+};
-- 
2.25.1

