Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08B834FC51
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhCaJOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbhCaJNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:13:36 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB55C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:13:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f3so4556430pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+aJ7wviR0oGA/7YbUnTjJ7Jb4IahT++RfnfTz9SeqeQ=;
        b=AMgt+/p1d/4Xa2ZnvY4sRSDrjKp4AdUxhdzgMyxKgRR3DhAxvFaDRPXQq2rzMXs5kI
         b44RzOEeSdeQAbtoI5cNQzXkbEK5W7sfvDsqea1MKFClYm8tYJh0NkIhiZUynzVIyRQa
         wT+JFgBNcoyxXw6GrTlGhVVpkyOjZ6qa6iilw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+aJ7wviR0oGA/7YbUnTjJ7Jb4IahT++RfnfTz9SeqeQ=;
        b=s577Jb4e/15otgDtvmpJW8Oy6B9evW9rWr6QZRvM2LgdjeDf4lYWPoOcxB/Bu7euxn
         1byG3YlawDWotYCHIeNOMBolo9Dx9UMRN7cGPHya2gGHKcIa8AkkF5aFuZXIAkx/qCq8
         l2oQVLzughQC8FJZAMHwO2CpFazIbJ1N3EEalHDjkLs67kKITn5ygEg3nduQ3z+ckY1F
         AnydhzuHfI0onqW7KU28lNiBE+Z00hUAnpnzVLDHlhOPp2uMOw5JiDSu9uSXEnxa5aI5
         k93d6zJWpngw4LUWGNvbRK6l3SlVNaouwGEkDPAQEklOsOq9fmnpAY17M/NluZEr3luf
         v5Pg==
X-Gm-Message-State: AOAM532GrVpmjpWHq2RrY9VFYYIcCvIr9vTU6TyPTzbz/H2GhKtccLBr
        4c07tta3NqgpwuV/lInOymp6swvMiroPH0b+
X-Google-Smtp-Source: ABdhPJzoQrhkW0rQVeqGkjnDbDH1+sfV1B+AsZuU3V2FimK7+URVHvLdgp4fHcXhoaOt18h19IvP/g==
X-Received: by 2002:a63:b906:: with SMTP id z6mr2385314pge.302.1617182015788;
        Wed, 31 Mar 2021 02:13:35 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:85fc:9f25:6293:28f1])
        by smtp.gmail.com with ESMTPSA id s7sm1484723pjr.18.2021.03.31.02.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:13:35 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 3/4] arm64: dts: mt8183: Add kukui kakadu board
Date:   Wed, 31 Mar 2021 17:13:26 +0800
Message-Id: <20210331091327.1198529-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210331091327.1198529-1-hsinyi@chromium.org>
References: <20210331091327.1198529-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Boichat <drinkcat@chromium.org>

Kakadu is also known as ASUS Chromebook Detachable CM3.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../boot/dts/mediatek/mt8183-kukui-kakadu.dts |  13 +
 .../dts/mediatek/mt8183-kukui-kakadu.dtsi     | 378 ++++++++++++++++++
 3 files changed, 392 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index db4753d82a4b..fb891492ad66 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-damu.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-juniper-sku16.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dts
new file mode 100644
index 000000000000..20eb0dc68f09
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2020 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-kakadu.dtsi"
+
+/ {
+	model = "MediaTek kakadu board";
+	compatible = "google,kakadu-rev3", "google,kakadu-rev2",
+			"google,kakadu", "mediatek,mt8183";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
new file mode 100644
index 000000000000..b442e38a3156
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2020 Google LLC
+ */
+
+#include "mt8183-kukui.dtsi"
+#include <dt-bindings/input/gpio-keys.h>
+
+/ {
+	ppvarn_lcd: ppvarn-lcd {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvarn_lcd";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ppvarn_lcd_en>;
+
+		enable-active-high;
+
+		gpio = <&pio 66 GPIO_ACTIVE_HIGH>;
+	};
+
+	ppvarp_lcd: ppvarp-lcd {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvarp_lcd";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ppvarp_lcd_en>;
+
+		enable-active-high;
+
+		gpio = <&pio 166 GPIO_ACTIVE_HIGH>;
+	};
+
+	pp1800_lcd: pp1800-lcd {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1800_lcd";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp1800_lcd_en>;
+
+		enable-active-high;
+
+		gpio = <&pio 36 GPIO_ACTIVE_HIGH>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pen_eject>;
+
+		pen-insert {
+			label = "Pen Insert";
+			/* Insert = low, eject = high */
+			gpios = <&pio 6 GPIO_ACTIVE_LOW>;
+			linux,code = <SW_PEN_INSERTED>;
+			linux,input-type = <EV_SW>;
+			wakeup-event-action = <EV_ACT_DEASSERTED>;
+			wakeup-source;
+		};
+	};
+};
+
+&bluetooth {
+	firmware-name = "nvm_00440302_i2s_eu.bin";
+};
+
+&i2c0 {
+	status = "okay";
+
+	touchscreen: touchscreen@10 {
+		compatible = "hid-over-i2c";
+		reg = <0x10>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&open_touch>;
+
+		interrupt-parent = <&pio>;
+		interrupts = <155 IRQ_TYPE_EDGE_FALLING>;
+
+		post-power-on-delay-ms = <10>;
+		hid-descr-addr = <0x0001>;
+	};
+};
+
+&mt6358_vcama2_reg {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom@58 {
+		compatible = "atmel,24c32";
+		reg = <0x58>;
+		pagesize = <32>;
+	};
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom@54 {
+		compatible = "atmel,24c32";
+		reg = <0x54>;
+		pagesize = <32>;
+	};
+};
+
+&mipi_tx0 {
+	drive-strength-microamp = <5800>;
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
+	pp1800_lcd_en: pp1800-lcd-en {
+		pins1 {
+			pinmux = <PINMUX_GPIO36__FUNC_GPIO36>;
+			output-low;
+		};
+	};
+
+	open_touch: open_touch {
+		irq_pin {
+			pinmux = <PINMUX_GPIO155__FUNC_GPIO155>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		rst_pin {
+			pinmux = <PINMUX_GPIO156__FUNC_GPIO156>;
+
+			/*
+			 * The pen driver doesn't currently support  driving
+			 * this reset line.  By specifying output-high here
+			 * we're relying on the fact that this pin has a default
+			 * pulldown at boot (which makes sure the pen was in
+			 * reset if it was powered) and then we set it high here
+			 * to take it out of reset.  Better would be if the pen
+			 * driver could control this and we could remove
+			 * "output-high" here.
+			 */
+			output-high;
+		};
+	};
+
+	pen_eject: peneject {
+		pen_eject {
+			pinmux = <PINMUX_GPIO6__FUNC_GPIO6>;
+			input-enable;
+			/* External pull-up. */
+			bias-disable;
+		};
+	};
+};
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_KAKADU";
+};
+
+&panel {
+	status = "okay";
+	compatible = "boe,tv105wum-nw0";
+};
-- 
2.31.0.291.g576ba9dcdaf-goog

