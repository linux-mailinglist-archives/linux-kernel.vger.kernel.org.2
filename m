Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DC233B059
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhCOKtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhCOKti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:49:38 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5E2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:49:38 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x7so6309494pfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NHWbpSbeEU/u/5K7gBBa6SF51Eq0qcQsRKUtsXf/iec=;
        b=hPdqPSO2nNJghl+hN4IhsWaQrfCEi52MdY2vhVdtdMknpANn/O3kBNePp1yez3e383
         XV0+BwF6ICPjhAHWXUr98PWaHSm2cGsYaGRWm0WNJH6HP/DfO3N5pVFsjryOHTLzTu3Z
         oYZ3b97JYxAby6TjZEKgkRTMxu9SWNFCrpYwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NHWbpSbeEU/u/5K7gBBa6SF51Eq0qcQsRKUtsXf/iec=;
        b=n/DZwdm1R3627eDsuhtF6jMYVKS6ASpM+w9Lft+CTjIAnHOLrWst51ibEVvcnXrj9k
         nWINVPnbH8viFpdipV941jF3fb0UX2ojvWICR4nSlWX81eTEdfP3Chnp2Vos9LQGjy8F
         yL0SjN0qsnHgmfDQqJ0046yCGuPBYRT/10oiNtRi5nZK2mnvSNdHIgT3BwPS8ZOd6+Ti
         07ZDADzVrRTn8RJJIslBDuQthVPC56zr/BYTegej1vLTX4nLH5ARBydKf15d+ITmMDQS
         bGp+Pn2yGnZyVMP13cCkFwVANQMrmZTmlHyd42S9FXaqUM0uTfvyz8VdhVAylrge3A2H
         U5oQ==
X-Gm-Message-State: AOAM53192Fw/ODaTQ7wk6QenzjQtpjHMqsdclW1anGYWEDDHVZfioX9i
        gRVLqxvtkQAi4mSDDRJnQTmRHGYMIq7MIajV
X-Google-Smtp-Source: ABdhPJzYxmQ/peUmSdW6ybeKPJqKtNhtcMgoHkwsFKszVFilK79PIx3G/s/xwkUZCNqsJe8lXFMAlA==
X-Received: by 2002:aa7:9192:0:b029:202:cf06:dba3 with SMTP id x18-20020aa791920000b0290202cf06dba3mr9732607pfa.16.1615805377274;
        Mon, 15 Mar 2021 03:49:37 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:89b7:339b:c097:5ebb])
        by smtp.gmail.com with ESMTPSA id s19sm12906201pfh.168.2021.03.15.03.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 03:49:36 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Ben Ho <Ben.Ho@mediatek.com>
Subject: [PATCH 2/2] arm64: dts: mt8183: Add kukui-jacuzzi-damu board
Date:   Mon, 15 Mar 2021 18:49:30 +0800
Message-Id: <20210315104930.1087142-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210315104930.1087142-1-hsinyi@chromium.org>
References: <20210315104930.1087142-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Damu is known as ASUS Chromebook Flip CM3.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../mediatek/mt8183-kukui-jacuzzi-damu.dts    |  35 ++
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    | 481 ++++++++++++++++++
 3 files changed, 517 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index deba27ab7657..554105d2c389 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana-rev7.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-damu.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
new file mode 100644
index 000000000000..d697336440d1
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi.dtsi"
+
+/ {
+	model = "Google damu board";
+	compatible = "google,damu", "mediatek,mt8183";
+};
+
+&cpu_thermal {
+	sustainable-power = <4500>; /* milliwatts */
+};
+
+&touchscreen {
+	status = "okay";
+
+	compatible = "hid-over-i2c";
+	reg = <0x10>;
+	interrupt-parent = <&pio>;
+	interrupts = <155 IRQ_TYPE_LEVEL_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&touchscreen_pins>;
+
+	post-power-on-delay-ms = <10>;
+	hid-descr-addr = <0x0001>;
+};
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_DAMU";
+};
+
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
new file mode 100644
index 000000000000..673f3b9a49ea
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+#include "mt8183-kukui.dtsi"
+
+/ {
+	panel: panel {
+		compatible = "auo,b116xw03";
+		power-supply = <&pp3300_panel>;
+		ddc-i2c-bus = <&i2c4>;
+		backlight = <&backlight_lcd0>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&anx7625_out>;
+			};
+		};
+	};
+
+	pp1200_mipibrdg: pp1200-mipibrdg {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1200_mipibrdg";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp1200_mipibrdg_en>;
+
+		enable-active-high;
+		regulator-boot-on;
+
+		gpio = <&pio 54 GPIO_ACTIVE_HIGH>;
+	};
+
+	pp1800_mipibrdg: pp1800-mipibrdg {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1800_mipibrdg";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp1800_lcd_en>;
+
+		enable-active-high;
+		regulator-boot-on;
+
+		gpio = <&pio 36 GPIO_ACTIVE_HIGH>;
+	};
+
+	pp3300_panel: pp3300-panel {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_panel";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp3300_panel_pins>;
+
+		enable-active-high;
+
+		gpio = <&pio 35 GPIO_ACTIVE_HIGH>;
+	};
+
+	vddio_mipibrdg: vddio-mipibrdg {
+		compatible = "regulator-fixed";
+		regulator-name = "vddio_mipibrdg";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vddio_mipibrdg_en>;
+
+		enable-active-high;
+		regulator-boot-on;
+
+		gpio = <&pio 37 GPIO_ACTIVE_HIGH>;
+	};
+
+	volume_buttons: volume-buttons {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&volume_button_pins>;
+
+		volume_down {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			debounce-interval = <100>;
+
+			gpios = <&pio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		volume_up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <100>;
+
+			gpios = <&pio 5 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&cros_ec {
+	cros_ec_pwm: ec-pwm {
+		compatible = "google,cros-ec-pwm";
+		#pwm-cells = <1>;
+		status = "disabled";
+	};
+};
+
+&dsi0 {
+	status = "okay";
+	/delete-node/panel@0;
+	ports {
+		port {
+			dsi_out: endpoint {
+				remote-endpoint = <&anx7625_in>;
+			};
+		};
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	touchscreen: touchscreen@10 {
+		compatible = "elan,ekth3500";
+		reg = <0x10>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+
+		interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
+
+		reset-gpios = <&pio 156 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+	status = "okay";
+	clock-frequency = <400000>;
+
+	trackpad@15 {
+		compatible = "elan,ekth3000";
+		reg = <0x15>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_pins>;
+
+		interrupts-extended = <&pio 7 IRQ_TYPE_LEVEL_LOW>;
+
+		wakeup-source;
+	};
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+	status = "okay";
+	clock-frequency = <100000>;
+
+	anx_bridge: anx7625@58 {
+		compatible = "analogix,anx7625";
+		reg = <0x58>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&anx7625_pins>;
+		panel_flags = <1>;
+		enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
+		vdd10-supply = <&pp1200_mipibrdg>;
+		vdd18-supply = <&pp1800_mipibrdg>;
+		vdd33-supply = <&vddio_mipibrdg>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port@0 {
+			reg = <0>;
+
+			anx7625_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			anx7625_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+};
+
+&i2c_tunnel {
+	google,remote-bus = <2>;
+};
+
+&pio {
+	/* 192 lines */
+	gpio-line-names =
+		"SPI_AP_EC_CS_L",
+		"SPI_AP_EC_MOSI",
+		"SPI_AP_EC_CLK",
+		"I2S3_DO",
+		"USB_PD_INT_ODL",
+		"",
+		"",
+		"",
+		"",
+		"IT6505_HPD_L",
+		"I2S3_TDM_D3",
+		"SOC_I2C6_1V8_SCL",
+		"SOC_I2C6_1V8_SDA",
+		"DPI_D0",
+		"DPI_D1",
+		"DPI_D2",
+		"DPI_D3",
+		"DPI_D4",
+		"DPI_D5",
+		"DPI_D6",
+		"DPI_D7",
+		"DPI_D8",
+		"DPI_D9",
+		"DPI_D10",
+		"DPI_D11",
+		"DPI_HSYNC",
+		"DPI_VSYNC",
+		"DPI_DE",
+		"DPI_CK",
+		"AP_MSDC1_CLK",
+		"AP_MSDC1_DAT3",
+		"AP_MSDC1_CMD",
+		"AP_MSDC1_DAT0",
+		"AP_MSDC1_DAT2",
+		"AP_MSDC1_DAT1",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"OTG_EN",
+		"DRVBUS",
+		"DISP_PWM",
+		"DSI_TE",
+		"LCM_RST_1V8",
+		"AP_CTS_WIFI_RTS",
+		"AP_RTS_WIFI_CTS",
+		"SOC_I2C5_1V8_SCL",
+		"SOC_I2C5_1V8_SDA",
+		"SOC_I2C3_1V8_SCL",
+		"SOC_I2C3_1V8_SDA",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"SOC_I2C1_1V8_SDA",
+		"SOC_I2C0_1V8_SDA",
+		"SOC_I2C0_1V8_SCL",
+		"SOC_I2C1_1V8_SCL",
+		"AP_SPI_H1_MISO",
+		"AP_SPI_H1_CS_L",
+		"AP_SPI_H1_MOSI",
+		"AP_SPI_H1_CLK",
+		"I2S5_BCK",
+		"I2S5_LRCK",
+		"I2S5_DO",
+		"BOOTBLOCK_EN_L",
+		"MT8183_KPCOL0",
+		"SPI_AP_EC_MISO",
+		"UART_DBG_TX_AP_RX",
+		"UART_AP_TX_DBG_RX",
+		"I2S2_MCK",
+		"I2S2_BCK",
+		"CLK_5M_WCAM",
+		"CLK_2M_UCAM",
+		"I2S2_LRCK",
+		"I2S2_DI",
+		"SOC_I2C2_1V8_SCL",
+		"SOC_I2C2_1V8_SDA",
+		"SOC_I2C4_1V8_SCL",
+		"SOC_I2C4_1V8_SDA",
+		"",
+		"SCL8",
+		"SDA8",
+		"FCAM_PWDN_L",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"I2S_PMIC",
+		"I2S_PMIC",
+		"I2S_PMIC",
+		"I2S_PMIC",
+		"I2S_PMIC",
+		"I2S_PMIC",
+		"I2S_PMIC",
+		"I2S_PMIC",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		/*
+		 * AP_FLASH_WP_L is crossystem ABI. Rev1 schematics
+		 * call it BIOS_FLASH_WP_R_L.
+		 */
+		"AP_FLASH_WP_L",
+		"EC_AP_INT_ODL",
+		"IT6505_INT_ODL",
+		"H1_INT_OD_L",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"AP_SPI_FLASH_MISO",
+		"AP_SPI_FLASH_CS_L",
+		"AP_SPI_FLASH_MOSI",
+		"AP_SPI_FLASH_CLK",
+		"DA7219_IRQ",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"";
+
+	pp1200_mipibrdg_en: pp1200-mipibrdg-en {
+		pins1 {
+			pinmux = <PINMUX_GPIO54__FUNC_GPIO54>;
+			output-low;
+		};
+	};
+
+	pp1800_lcd_en: pp1800-lcd-en {
+		pins1 {
+			pinmux = <PINMUX_GPIO36__FUNC_GPIO36>;
+			output-low;
+		};
+	};
+
+	pp3300_panel_pins: pp3300-panel-pins {
+		panel_3v3_enable: panel-3v3-enable {
+			pinmux = <PINMUX_GPIO35__FUNC_GPIO35>;
+			output-low;
+		};
+	};
+
+	ppvarp_lcd_en: ppvarp-lcd-en {
+		pins1 {
+			pinmux = <PINMUX_GPIO66__FUNC_GPIO66>;
+			output-low;
+		};
+	};
+
+	ppvarn_lcd_en: ppvarn-lcd-en {
+		pins1 {
+			pinmux = <PINMUX_GPIO166__FUNC_GPIO166>;
+			output-low;
+		};
+	};
+
+	anx7625_pins: anx7625-pins {
+		pins1 {
+			pinmux = <PINMUX_GPIO45__FUNC_GPIO45>,
+				 <PINMUX_GPIO73__FUNC_GPIO73>;
+			output-low;
+		};
+		pins2 {
+			pinmux = <PINMUX_GPIO4__FUNC_GPIO4>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+
+	touchscreen_pins: touchscreen-pins {
+		touch_int_odl {
+			pinmux = <PINMUX_GPIO155__FUNC_GPIO155>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		touch_rst_l {
+			pinmux = <PINMUX_GPIO156__FUNC_GPIO156>;
+			output-high;
+		};
+	};
+
+	trackpad_pins: trackpad-pins {
+		trackpad_int {
+			pinmux = <PINMUX_GPIO7__FUNC_GPIO7>;
+			input-enable;
+			bias-disable; /* pulled externally */
+		};
+	};
+
+	vddio_mipibrdg_en: vddio-mipibrdg-en {
+		pins1 {
+			pinmux = <PINMUX_GPIO37__FUNC_GPIO37>;
+			output-low;
+		};
+	};
+
+	volume_button_pins: volume-button-pins {
+		voldn-btn-odl {
+			pinmux = <PINMUX_GPIO6__FUNC_GPIO6>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		volup-btn-odl {
+			pinmux = <PINMUX_GPIO5__FUNC_GPIO5>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+};
+
-- 
2.31.0.rc2.261.g7f71774620-goog

