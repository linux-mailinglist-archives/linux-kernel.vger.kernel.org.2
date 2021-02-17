Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBBA31E0F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 22:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhBQVA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 16:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbhBQVAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:00:46 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F5AC061788
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 13:00:05 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n10so5126478wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 13:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WRHkkoe+YsEGr5m8KHM4pzifUeDMlV9wrEew71SHtm4=;
        b=qAs7LCg1JZiil8M/j0ksYX6qiLCWEnN7GGUcpxmlJOKlidR2x6KDWLY+oI4u8VGmio
         SXbk0LC2ySBEhrIdhSmHC5VGfWdxgQAzEaVulOnTyPEZVg6vPw8s1SuRODGB7yEUaLnr
         uCT/toFYketAsypthIWy4oJ9U3UUY1poG/wZh6c3OTRYpxaPmp+jTJh6pbkWV5DuH6MG
         AaH3hmRv9Qgg5i7DhA76RzgGTMRtlBY7uMZkBFHCuqFriLw5VXdL0G16UfGV0qaMhMKo
         XIgV8CDooVLeaSz53wrIZ/d1J+jSb35VC812zuxVgv/2bBJ5HbmluT3RHTKNPxY3RkZ/
         Nnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WRHkkoe+YsEGr5m8KHM4pzifUeDMlV9wrEew71SHtm4=;
        b=G2RfDlC8eFKN9A5kbLRyG4tyojtIQwdFbW4+x5Vk83q+MTAnNVIvWXZFv07a6KGLG0
         Amy7H/aBbfYynThQWsYgHolRZFsXya7JuTAt4XumxsgOSpu0udoJo0XTtcV6IGTnPA7I
         rjN7eObNlqfUuuNk2d9LJdvWs+NS1YLSAO7/khnGL3O3Ck7sfXMTdzL15cTyjzBbHadw
         Jknfx4F7kSVo8CAWJ9+3OqdobiPnpWIzGQMaemkvqldETs3yeA4MGPQmh/kX11k71X6M
         ukjLZPFCBKWHkRebnBOSV96H7soOfxfNW1WgxdacYmaNPghB+PL4bFA1dMTgCeOh365y
         bCKA==
X-Gm-Message-State: AOAM531+qFSsbokEWDHw17IhTXl70M2wVdKyAlzYsqry46NWBtEMUSAS
        B6a89Py6Y913jSYQ9RZXATFXEA==
X-Google-Smtp-Source: ABdhPJyHbYXXHeCWoxhYg9AdJJ6TzM39rpwzdzKKR+yd5RT7WKfveF0V9o/uaQ8ZambGDYrXdJdQNw==
X-Received: by 2002:a05:600c:19cb:: with SMTP id u11mr618663wmq.5.1613595604307;
        Wed, 17 Feb 2021 13:00:04 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id m2sm4140264wml.34.2021.02.17.13.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:00:03 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: mt8183: add mt8183 pumpkin board
Date:   Wed, 17 Feb 2021 21:59:44 +0100
Message-Id: <20210217205945.830006-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217205945.830006-1-fparent@baylibre.com>
References: <20210217205945.830006-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT8183 Pumpkin board is manufactured by OLogic and includes
a MediaTek MT8183 SoC with 2GB of RAM.

The board provides the following IOs:
	* 2 USB Type-A ports
	* Ethernet
	* Serial UART over micro-USB port
	* 1 USB Type-C dual role port
	* 1 USB Type-C power only port
	* 1 Jack for audio
	* RPI compatible header
	* MT7668 wiresless chip with Wi-Fi AC and BT 5
	* Micro-HDMI port
	* 2 connectors for CSI cameras
	* 1 connector for DSI display
	* 1 JTAG port

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../boot/dts/mediatek/mt8183-pumpkin.dts      | 378 ++++++++++++++++++
 2 files changed, 379 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 18f7b46c4095..331b2e9f72fd 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -14,5 +14,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana-rev7.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
new file mode 100644
index 000000000000..eb6e595c2975
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 BayLibre, SAS.
+ * Author: Fabien Parent <fparent@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "mt8183.dtsi"
+#include "mt6358.dtsi"
+
+/ {
+	model = "Pumpkin MT8183";
+	compatible = "mediatek,mt8183-pumpkin", "mediatek,mt8183";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scp_mem_reserved: scp_mem_region {
+			compatible = "shared-dma-pool";
+			reg = <0 0x50000000 0 0x2900000>;
+			no-map;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-red {
+			label = "red";
+			gpios = <&pio 155 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-green {
+			label = "green";
+			gpios = <&pio 156 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	ntc@0 {
+		compatible = "murata,ncp03wf104";
+		pullup-uv = <1800000>;
+		pullup-ohm = <390000>;
+		pulldown-ohm = <0>;
+		io-channels = <&auxadc 0>;
+	};
+};
+
+&auxadc {
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c_pins_0>;
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c_pins_1>;
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c_pins_2>;
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c_pins_3>;
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c_pins_4>;
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&i2c5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c_pins_5>;
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&i2c6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c6_pins>;
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	cap-mmc-hw-reset;
+	no-sdio;
+	no-sd;
+	hs400-ds-delay = <0x12814>;
+	vmmc-supply = <&mt6358_vemc_reg>;
+	vqmmc-supply = <&mt6358_vio18_reg>;
+	assigned-clocks = <&topckgen CLK_TOP_MUX_MSDC50_0>;
+	assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_CK>;
+	non-removable;
+};
+
+&mmc1 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_uhs>;
+	bus-width = <4>;
+	max-frequency = <200000000>;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	cap-sdio-irq;
+	no-mmc;
+	no-sd;
+	vmmc-supply = <&mt6358_vmch_reg>;
+	vqmmc-supply = <&mt6358_vmc_reg>;
+	keep-power-in-suspend;
+	enable-sdio-wakeup;
+	non-removable;
+};
+
+&pio {
+	i2c_pins_0: i2c0 {
+		pins_i2c{
+			pinmux = <PINMUX_GPIO82__FUNC_SDA0>,
+				 <PINMUX_GPIO83__FUNC_SCL0>;
+			mediatek,pull-up-adv = <3>;
+			mediatek,drive-strength-adv = <00>;
+		};
+	};
+
+	i2c_pins_1: i2c1 {
+		pins_i2c{
+			pinmux = <PINMUX_GPIO81__FUNC_SDA1>,
+				 <PINMUX_GPIO84__FUNC_SCL1>;
+			mediatek,pull-up-adv = <3>;
+			mediatek,drive-strength-adv = <00>;
+		};
+	};
+
+	i2c_pins_2: i2c2 {
+		pins_i2c{
+			pinmux = <PINMUX_GPIO103__FUNC_SCL2>,
+				 <PINMUX_GPIO104__FUNC_SDA2>;
+			mediatek,pull-up-adv = <3>;
+			mediatek,drive-strength-adv = <00>;
+		};
+	};
+
+	i2c_pins_3: i2c3 {
+		pins_i2c{
+			pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
+				 <PINMUX_GPIO51__FUNC_SDA3>;
+			mediatek,pull-up-adv = <3>;
+			mediatek,drive-strength-adv = <00>;
+		};
+	};
+
+	i2c_pins_4: i2c4 {
+		pins_i2c{
+			pinmux = <PINMUX_GPIO105__FUNC_SCL4>,
+				 <PINMUX_GPIO106__FUNC_SDA4>;
+			mediatek,pull-up-adv = <3>;
+			mediatek,drive-strength-adv = <00>;
+		};
+	};
+
+	i2c_pins_5: i2c5 {
+		pins_i2c{
+			pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
+				 <PINMUX_GPIO49__FUNC_SDA5>;
+			mediatek,pull-up-adv = <3>;
+			mediatek,drive-strength-adv = <00>;
+		};
+	};
+
+	i2c6_pins: i2c6 {
+		pins_cmd_dat {
+			pinmux = <PINMUX_GPIO113__FUNC_SCL6>,
+				 <PINMUX_GPIO114__FUNC_SDA6>;
+			mediatek,pull-up-adv = <3>;
+		};
+	};
+
+	mmc0_pins_default: mmc0-pins-default {
+		pins_cmd_dat {
+			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO128__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO125__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO132__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO126__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO129__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO127__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO130__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO122__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_14mA>;
+			mediatek,pull-up-adv = <01>;
+		};
+
+		pins_clk {
+			pinmux = <PINMUX_GPIO124__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_14mA>;
+			mediatek,pull-down-adv = <10>;
+		};
+
+		pins_rst {
+			pinmux = <PINMUX_GPIO133__FUNC_MSDC0_RSTB>;
+			drive-strength = <MTK_DRIVE_14mA>;
+			mediatek,pull-down-adv = <01>;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0-pins-uhs {
+		pins_cmd_dat {
+			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO128__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO125__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO132__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO126__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO129__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO127__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO130__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO122__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_14mA>;
+			mediatek,pull-up-adv = <01>;
+		};
+
+		pins_clk {
+			pinmux = <PINMUX_GPIO124__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_14mA>;
+			mediatek,pull-down-adv = <10>;
+		};
+
+		pins_ds {
+			pinmux = <PINMUX_GPIO131__FUNC_MSDC0_DSL>;
+			drive-strength = <MTK_DRIVE_14mA>;
+			mediatek,pull-down-adv = <10>;
+		};
+
+		pins_rst {
+			pinmux = <PINMUX_GPIO133__FUNC_MSDC0_RSTB>;
+			drive-strength = <MTK_DRIVE_14mA>;
+			mediatek,pull-up-adv = <01>;
+		};
+	};
+
+	mmc1_pins_default: mmc1-pins-default {
+		pins_cmd_dat {
+			pinmux = <PINMUX_GPIO31__FUNC_MSDC1_CMD>,
+				 <PINMUX_GPIO32__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO34__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO33__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO30__FUNC_MSDC1_DAT3>;
+			input-enable;
+			mediatek,pull-up-adv = <10>;
+		};
+
+		pins_clk {
+			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
+			input-enable;
+			mediatek,pull-down-adv = <10>;
+		};
+
+		pins_pmu {
+			pinmux = <PINMUX_GPIO178__FUNC_GPIO178>;
+			output-high;
+		};
+	};
+
+	mmc1_pins_uhs: mmc1-pins-uhs {
+		pins_cmd_dat {
+			pinmux = <PINMUX_GPIO31__FUNC_MSDC1_CMD>,
+				 <PINMUX_GPIO32__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO34__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO33__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO30__FUNC_MSDC1_DAT3>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			input-enable;
+			mediatek,pull-up-adv = <10>;
+		};
+
+		pins_clk {
+			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			mediatek,pull-down-adv = <10>;
+			input-enable;
+		};
+	};
+};
+
+&mfg {
+	domain-supply = <&mt6358_vgpu_reg>;
+};
+
+&cpu0 {
+	proc-supply = <&mt6358_vproc12_reg>;
+};
+
+&cpu1 {
+	proc-supply = <&mt6358_vproc12_reg>;
+};
+
+&cpu2 {
+	proc-supply = <&mt6358_vproc12_reg>;
+};
+
+&cpu3 {
+	proc-supply = <&mt6358_vproc12_reg>;
+};
+
+&cpu4 {
+	proc-supply = <&mt6358_vproc11_reg>;
+};
+
+&cpu5 {
+	proc-supply = <&mt6358_vproc11_reg>;
+};
+
+&cpu6 {
+	proc-supply = <&mt6358_vproc11_reg>;
+};
+
+&cpu7 {
+	proc-supply = <&mt6358_vproc11_reg>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&scp {
+	status = "okay";
+};
+
+&dsi0 {
+	status = "disabled";
+};
-- 
2.30.0

