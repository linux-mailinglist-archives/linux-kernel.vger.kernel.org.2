Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEED380BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhENOeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhENOeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:34:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261E1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:33:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i17so950390wrq.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Ay7DzUKeSQJtViEw11nvQpthZLN4Trb0Hciv0SkcJs=;
        b=n2FIOWZV6hzCQWZHlTk4o/g7J2rgUF0ONgvPystWv/MHBqGkqmDP46tc+DRLt6B0/o
         Ck1yEbOI4V8Lv1/8hJd6AZKT+sQvuWlRhY/L9JsmUf4PEkIvMHoEN1nvSiC5Zk0IlIE2
         iwCbG/26wKhc5x/OAh34dcnbtewSenyKX22ZRWOAvQJwus+HwnlPeTXW+OX2Nne42wot
         utHQfkS5erbpV+96aBa578uGpbXIZMNIkyZayvULCvmhMbYhjMCDCLvmFEGBH/xcDFDM
         fNGQeDoiwNnobMtzPVn8Q9EZ9otxaY3rj3rGjhpmWdFuz7N8Q+IGOV2LwmA4zsPMxyP6
         O/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Ay7DzUKeSQJtViEw11nvQpthZLN4Trb0Hciv0SkcJs=;
        b=fJUL8LmJIHlj0ym9u0wJsg6JBN5esLO73xzKaNxk5JjMsCmhz72oNZSrg94nBjtO2B
         xYlVappDNFkiKKosVjkFgcl1SrIZ0pm71J3LcbHH64NkodRtIN0IQq7ypVwj+PDr2OAx
         w0ll/Ka1KyfQZZtM4gzK/cLzD5RBZHt1CBLn5daipA6YonggSJNHTqE5RSrJ+12mMpEU
         03O/j3NC+tQJxT1zmnsHQuuiobm8BcaA/4yE6Tso3Y7/rYYqFFSkY6qCu6+Km56c7/9C
         HihHA15igLA3pyik2aLaqAWYBzjJaF73UDNLaLRoMoWMK15CcoPznWb0klIe+m4+gE8O
         1e9w==
X-Gm-Message-State: AOAM532h05N4Ku7FW4lxwOh2+gBji/HgsuhejTmEz6pt2D/ouMLiQKfe
        LDwFVsJXfRY2YBqciXh2fx4u1g==
X-Google-Smtp-Source: ABdhPJzyGr+YOCbdiCU7CbJIc42+zQPANvMop5pK3AdyHnQZgw76q5IKOXriSRuGEykLo3S6yGglSQ==
X-Received: by 2002:adf:f142:: with SMTP id y2mr22781691wro.426.1621002785751;
        Fri, 14 May 2021 07:33:05 -0700 (PDT)
Received: from localhost.localdomain ([37.173.48.34])
        by smtp.gmail.com with ESMTPSA id v21sm11552036wml.5.2021.05.14.07.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:33:05 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 3/3] arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts
Date:   Fri, 14 May 2021 16:32:55 +0200
Message-Id: <20210514143255.3352774-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514143255.3352774-1-narmstrong@baylibre.com>
References: <20210514143255.3352774-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=o3l5kyMfTrRlJEzw37lsDjMzoFymjgEfGgiFV70/FRQ=; m=HZhU4GC75A8VX335wLtFJnSZhgRa9XiiCZg4dphZaec=; p=76gLnBaKLXu+pmoNElkVLYZEw6EwO78qhIT5VCHAxUA=; g=a5d4555bfc55d843779f35c52c04c3a63a412abf
X-Patch-Sig: m=pgp; i=narmstrong@baylibre.com; s=0xA4CFF8AE; b=iQIzBAABCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAmCeigoACgkQd9zb2sjISdGYWxAAxf1 L9NloRK7ehdFq9w2wRDjN2kTJAIqZePErco+AXCTNW9MK3WvBVwIK8XJG5qUiwXuujbBnk6SGXYYI bsZyjqxogJ10Bf4GQJ2+tAaPbkdmtCk8jAb8u8d++j2p0m5tJLwngqk37i5ErTRySY11Xd9YtT9i4 S3sak440sNPJC+Mfl3/6UiBJhVZ6/1y4I3knwNkrXvgpGDgh6DbCREaw6SMTAki83X08HhknJCpDH itZqta+5fcp09nNdgB3VwcLQUfzpgAu7UPQECKTZRw6HNIWox+LpjcfZ/4Jxcq6eLLPXFLC/Yo0qH s3Cs29mMsiRk3xSadvk/veBSnWgETBwZAhSr9BeiB0gpOO9MLiUgY5CA0AK8ismb+wR9b2U8LSW4R 3UIMaWu4vXGVcojBYxfoW2Vx/b1Ebr0xYutrtkE1bbcWvRrT2GxBgTGpNL31xhLLkORItieSc8zN4 QdTzRXhgK+JRnWbuQEJYokHBnQlnRtRpTkvQ1tyosspIz/tB5U8EToCzoXErUJTSsT1yqbzHjP0bb z+D42tZviG1iPmpeFvxQ0s9RcFwXtAjJACCZp6I2mqykTLhsHmu01Cr2xF8goMTUSCiooYQ8Iu4++ 047ebMqC6mmOGilky4dBQLUoFCnPwuIJ9C4CEZyrBxR5gF/ypH9PX6hH+1vC4vuo=
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
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../dts/amlogic/meson-sm1-bananapi-m5.dts     | 646 ++++++++++++++++++
 2 files changed, 647 insertions(+)
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
index 000000000000..effaa138b5f9
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
@@ -0,0 +1,646 @@
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
+		key {
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
+	emmc_1v8: regulator-emmc_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "EMMC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	dc_in: regulator-dc_in {
+		compatible = "regulator-fixed";
+		regulator-name = "DC_IN";
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
+		regulator-min-microvolt = <690000>;
+		regulator-max-microvolt = <1050000>;
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
+	phy-mode = "rgmii-txid";
+	phy-handle = <&external_phy>;
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
+		"ETH_MDIO", /* GPIOZ_0 */
+		"ETH_MDC", /* GPIOZ_1 */
+		"ETH_RXCLK", /* GPIOZ_2 */
+		"ETH_RX_DV", /* GPIOZ_3 */
+		"ETH_RXD0", /* GPIOZ_4 */
+		"ETH_RXD1", /* GPIOZ_5 */
+		"ETH_RXD2", /* GPIOZ_6 */
+		"ETH_RXD3", /* GPIOZ_7 */
+		"ETH_TXCLK", /* GPIOZ_8 */
+		"ETH_TXEN", /* GPIOZ_9 */
+		"ETH_TXD0", /* GPIOZ_10 */
+		"ETH_TXD1", /* GPIOZ_11 */
+		"ETH_TXD2", /* GPIOZ_12 */
+		"ETH_TXD3", /* GPIOZ_13 */
+		"ETH_INTR", /* GPIOZ_14 */
+		"ETH_NRST", /* GPIOZ_15 */
+		/* GPIOH */
+		"HDMI_SDA", /* GPIOH_0 */
+		"HDMI_SCL", /* GPIOH_1 */
+		"HDMI_HPD", /* GPIOH_2 */
+		"HDMI_CEC", /* GPIOH_3 */
+		"VL-RST_N", /* GPIOH_4 */
+		"CON1-P36", /* GPIOH_5 */
+		"VL-PWREN", /* GPIOH_6 */
+		"WiFi_3V3_1V8", /* GPIOH_7 */
+		"TFLASH_VDD_EN", /* GPIOH_8 */
+		/* BOOT */
+		"eMMC_D0", /* BOOT_0 */
+		"eMMC_D1", /* BOOT_1 */
+		"eMMC_D2", /* BOOT_2 */
+		"eMMC_D3", /* BOOT_3 */
+		"eMMC_D4", /* BOOT_4 */
+		"eMMC_D5", /* BOOT_5 */
+		"eMMC_D6", /* BOOT_6 */
+		"eMMC_D7", /* BOOT_7 */
+		"eMMC_CLK", /* BOOT_8 */
+		"",
+		"eMMC_CMD", /* BOOT_10 */
+		"",
+		"eMMC_RST#", /* BOOT_12 */
+		"eMMC_DS", /* BOOT_13 */
+		/* GPIOC */
+		"SD_D0_B", /* GPIOC_0 */
+		"SD_D1_B", /* GPIOC_1 */
+		"SD_D2_B", /* GPIOC_2 */
+		"SD_D3_B", /* GPIOC_3 */
+		"SD_CLK_B", /* GPIOC_4 */
+		"SD_CMD_B", /* GPIOC_5 */
+		"CARD_EN_DET", /* GPIOC_6 */
+		"",
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
+	 * WARNING: The USB Hub on the BPI-M5 needs a reset signal
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
+		"IR_IN", /* GPIOAO_5 */
+		"TF_3V3N_1V8_EN", /* GPIOAO_6 */
+		"CON1-P35", /* GPIOAO_7 */
+		"CON1-P12", /* GPIOAO_8 */
+		"CON1-P37", /* GPIOAO_9 */
+		"CON1-P38", /* GPIOAO_10 */
+		"SYS_LED", /* GPIOAO_11 */
+		/* GPIOE */
+		"VDDEE_PWM", /* GPIOE_0 */
+		"VDDCPU_PWM", /* GPIOE_1 */
+		"TF_PWR_EN"; /* GPIOE_2 */
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
+	vqmmc-supply = <&emmc_1v8>;
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

