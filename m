Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289703A6A09
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhFNP2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbhFNP16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:27:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90312C0613A3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:25:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k25so17347977eja.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mVp2vdhh4RAmyJm3DKsG3NC6mTldWx3CxYZSdDKTnJI=;
        b=l0asTT7oPy1f+I8X4oPMb3QkX0Cxg0dMDPkX8tYzTO5y7iSREB0/pf1jcZ+rDoyri9
         2vbSpB8KTdSBfLQwAAVWtC4FVjI+4xiQ5OJtUU/IYCGahqI68LV6PyU0YixtjMTi5z9f
         PdBQyAXmUJEciAgcj9YH0vX6HEcJtjS4afM0iiXnN+jBtYE273uoz7pI3stj6Z3xFd+1
         KPytBJQLOLltZfgyWfYWsBI1Puzwzk6ZjhGvQPWqa7hWDdaLBP9wCKoDSUY1qV7Iwr0R
         IKKmIF69HzMv3QpFBGieqy47f5sE26iElD+GvHp+6tMzIHNo4J0ieEMbqKfcj0gdS1hP
         LWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mVp2vdhh4RAmyJm3DKsG3NC6mTldWx3CxYZSdDKTnJI=;
        b=ebKTVteccjyQB070DigbZv4hhDIijdzhxgBSdnJ72nx51SuXjM3LicHPkWCKnkl6/M
         BLaifV6mGvNihuU4MKWolj54TO2QKf8e7CTU0yO2yOdKmy1ZV87chW4HZFlwh8FXJ0h6
         M7HnQL4EuxBoh60IyqXcpexOD/Ig0xTo5fBl9QT01oSzbeqBvBbQHTKPJ/mgPNOljSBV
         deAOmzJErzD7Nr0DqSVpYz22pknxpyFfoOsAEo9spV8SpFDnvOF8p3oJ1SNfhvIXBuD6
         oUQRm1wOO9CfEwXJRwLIek2YKuZv7B5Mz2/y4PzuCdSseWjUAJo2eSvT+2s2b+/HwaLy
         fGOA==
X-Gm-Message-State: AOAM530L086iU1iYnPQFQee7r5gmyyhlMbWBJRNGYd24qQUij7sbZhsz
        0y9QkVs/fxAVpC0F4sOv0IxpahX2zeSiktFg
X-Google-Smtp-Source: ABdhPJzXSPXdHkorFcK7TOR4r5+ZfRvqovwJl1q7rBnrKuE5JAtXeKnBCc/zondlDhJlVI7FyNyX/A==
X-Received: by 2002:a17:906:80cd:: with SMTP id a13mr15889371ejx.421.1623684350889;
        Mon, 14 Jun 2021 08:25:50 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id f8sm7521987ejw.75.2021.06.14.08.25.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:25:50 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 05/33] arm64: zynqmp: Add pinctrl description for all boards
Date:   Mon, 14 Jun 2021 17:25:13 +0200
Message-Id: <d8bc42600da85f5a23d977d4b61e6528720573e5.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 1dccb5ec0123 ("dt-bindings: pinctrl: Add binding for ZynqMP
pinctrl driver") and commit 8b242ca700f8 ("pinctrl: Add Xilinx ZynqMP
pinctrl driver support") add support for Xilinx ZynqMP pinctrl driver
that's why describe pins configuration for current boards.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    | 230 +++++++++++-
 .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    | 303 +++++++++++++++-
 .../dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    | 329 +++++++++++++++++-
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 241 ++++++++++++-
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 290 ++++++++++++++-
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 218 +++++++++++-
 .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 218 +++++++++++-
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 290 ++++++++++++++-
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 227 +++++++++++-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   5 +
 10 files changed, 2340 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index 69f6e4610739..5b258129c7ef 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP zc1751-xm015-dc1
  *
- * (C) Copyright 2015 - 2019, Xilinx, Inc.
+ * (C) Copyright 2015 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@xilinx.com>
  */
@@ -12,6 +12,7 @@
 #include "zynqmp.dtsi"
 #include "zynqmp-clk-ccf.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
 
 / {
 	model = "ZynqMP zc1751-xm015-dc1 RevA";
@@ -73,6 +74,8 @@ &gem3 {
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gem3_default>;
 	phy0: ethernet-phy@0 {
 		reg = <0>;
 	};
@@ -80,12 +83,19 @@ phy0: ethernet-phy@0 {
 
 &gpio {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_default>;
 };
 
 
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 36 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio 37 GPIO_ACTIVE_HIGH>;
 
 	eeprom: eeprom@55 {
 		compatible = "atmel,24c64"; /* 24AA64 */
@@ -93,6 +103,216 @@ eeprom: eeprom@55 {
 	};
 };
 
+&pinctrl0 {
+	status = "okay";
+	pinctrl_i2c1_default: i2c1-default {
+		mux {
+			groups = "i2c1_9_grp";
+			function = "i2c1";
+		};
+
+		conf {
+			groups = "i2c1_9_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpio {
+		mux {
+			groups = "gpio0_36_grp", "gpio0_37_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_36_grp", "gpio0_37_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_uart0_default: uart0-default {
+		mux {
+			groups = "uart0_8_grp";
+			function = "uart0";
+		};
+
+		conf {
+			groups = "uart0_8_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO34";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO35";
+			bias-disable;
+		};
+	};
+
+	pinctrl_usb0_default: usb0-default {
+		mux {
+			groups = "usb0_0_grp";
+			function = "usb0";
+		};
+
+		conf {
+			groups = "usb0_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO52", "MIO53", "MIO55";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
+			       "MIO60", "MIO61", "MIO62", "MIO63";
+			bias-disable;
+		};
+	};
+
+	pinctrl_gem3_default: gem3-default {
+		mux {
+			function = "ethernet3";
+			groups = "ethernet3_0_grp";
+		};
+
+		conf {
+			groups = "ethernet3_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO70", "MIO71", "MIO72", "MIO73", "MIO74",
+									"MIO75";
+			bias-high-impedance;
+			low-power-disable;
+		};
+
+		conf-tx {
+			pins = "MIO64", "MIO65", "MIO66", "MIO67", "MIO68",
+									"MIO69";
+			bias-disable;
+			low-power-enable;
+		};
+
+		mux-mdio {
+			function = "mdio3";
+			groups = "mdio3_0_grp";
+		};
+
+		conf-mdio {
+			groups = "mdio3_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_sdhci0_default: sdhci0-default {
+		mux {
+			groups = "sdio0_0_grp";
+			function = "sdio0";
+		};
+
+		conf {
+			groups = "sdio0_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+
+		mux-cd {
+			groups = "sdio0_cd_0_grp";
+			function = "sdio0_cd";
+		};
+
+		conf-cd {
+			groups = "sdio0_cd_0_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux-wp {
+			groups = "sdio0_wp_0_grp";
+			function = "sdio0_wp";
+		};
+
+		conf-wp {
+			groups = "sdio0_wp_0_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_sdhci1_default: sdhci1-default {
+		mux {
+			groups = "sdio1_0_grp";
+			function = "sdio1";
+		};
+
+		conf {
+			groups = "sdio1_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+
+		mux-cd {
+			groups = "sdio1_cd_0_grp";
+			function = "sdio1_cd";
+		};
+
+		conf-cd {
+			groups = "sdio1_cd_0_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux-wp {
+			groups = "sdio1_wp_0_grp";
+			function = "sdio1_wp";
+		};
+
+		conf-wp {
+			groups = "sdio1_wp_0_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_gpio_default: gpio-default {
+		mux {
+			function = "gpio0";
+			groups = "gpio0_38_grp";
+		};
+
+		conf {
+			groups = "gpio0_38_grp";
+			bias-disable;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+};
+
 &rtc {
 	status = "okay";
 };
@@ -113,20 +333,28 @@ &sata {
 /* eMMC */
 &sdhci0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci0_default>;
 	bus-width = <8>;
 };
 
 /* SD1 with level shifter */
 &sdhci1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci1_default>;
 };
 
 &uart0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0_default>;
 };
 
 /* ULPI SMSC USB3320 */
 &usb0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "host";
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
index f7124e15f0ff..1ac105a82e1b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP zc1751-xm016-dc2
  *
- * (C) Copyright 2015 - 2019, Xilinx, Inc.
+ * (C) Copyright 2015 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@xilinx.com>
  */
@@ -12,6 +12,7 @@
 #include "zynqmp.dtsi"
 #include "zynqmp-clk-ccf.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
 
 / {
 	model = "ZynqMP zc1751-xm016-dc2 RevA";
@@ -42,10 +43,14 @@ memory@0 {
 
 &can0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can0_default>;
 };
 
 &can1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1_default>;
 };
 
 &fpd_dma_chan1 {
@@ -84,6 +89,8 @@ &gem2 {
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gem2_default>;
 	phy0: ethernet-phy@5 {
 		reg = <5>;
 		ti,rx-internal-delay = <0x8>;
@@ -100,6 +107,11 @@ &gpio {
 &i2c0 {
 	status = "okay";
 	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c0_default>;
+	pinctrl-1 = <&pinctrl_i2c0_gpio>;
+	scl-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
 
 	tca6416_u26: gpio@20 {
 		compatible = "ti,tca6416";
@@ -115,6 +127,285 @@ rtc@68 {
 	};
 };
 
+&pinctrl0 {
+	status = "okay";
+	pinctrl_can0_default: can0-default {
+		mux {
+			function = "can0";
+			groups = "can0_9_grp";
+		};
+
+		conf {
+			groups = "can0_9_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO38";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO39";
+			bias-disable;
+		};
+	};
+
+	pinctrl_can1_default: can1-default {
+		mux {
+			function = "can1";
+			groups = "can1_8_grp";
+		};
+
+		conf {
+			groups = "can1_8_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO33";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO32";
+			bias-disable;
+		};
+	};
+
+	pinctrl_i2c0_default: i2c0-default {
+		mux {
+			groups = "i2c0_1_grp";
+			function = "i2c0";
+		};
+
+		conf {
+			groups = "i2c0_1_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c0_gpio: i2c0-gpio {
+		mux {
+			groups = "gpio0_6_grp", "gpio0_7_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_6_grp", "gpio0_7_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_uart0_default: uart0-default {
+		mux {
+			groups = "uart0_10_grp";
+			function = "uart0";
+		};
+
+		conf {
+			groups = "uart0_10_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO42";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO43";
+			bias-disable;
+		};
+	};
+
+	pinctrl_uart1_default: uart1-default {
+		mux {
+			groups = "uart1_10_grp";
+			function = "uart1";
+		};
+
+		conf {
+			groups = "uart1_10_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO41";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO40";
+			bias-disable;
+		};
+	};
+
+	pinctrl_usb1_default: usb1-default {
+		mux {
+			groups = "usb1_0_grp";
+			function = "usb1";
+		};
+
+		conf {
+			groups = "usb1_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO64", "MIO65", "MIO67";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
+			       "MIO72", "MIO73", "MIO74", "MIO75";
+			bias-disable;
+		};
+	};
+
+	pinctrl_gem2_default: gem2-default {
+		mux {
+			function = "ethernet2";
+			groups = "ethernet2_0_grp";
+		};
+
+		conf {
+			groups = "ethernet2_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO58", "MIO59", "MIO60", "MIO61", "MIO62",
+									"MIO63";
+			bias-high-impedance;
+			low-power-disable;
+		};
+
+		conf-tx {
+			pins = "MIO52", "MIO53", "MIO54", "MIO55", "MIO56",
+									"MIO57";
+			bias-disable;
+			low-power-enable;
+		};
+
+		mux-mdio {
+			function = "mdio2";
+			groups = "mdio2_0_grp";
+		};
+
+		conf-mdio {
+			groups = "mdio2_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_nand0_default: nand0-default {
+		mux {
+			groups = "nand0_0_grp";
+			function = "nand0";
+		};
+
+		conf {
+			groups = "nand0_0_grp";
+			bias-pull-up;
+		};
+
+		mux-ce {
+			groups = "nand0_ce_0_grp";
+			function = "nand0_ce";
+		};
+
+		conf-ce {
+			groups = "nand0_ce_0_grp";
+			bias-pull-up;
+		};
+
+		mux-rb {
+			groups = "nand0_rb_0_grp";
+			function = "nand0_rb";
+		};
+
+		conf-rb {
+			groups = "nand0_rb_0_grp";
+			bias-pull-up;
+		};
+
+		mux-dqs {
+			groups = "nand0_dqs_0_grp";
+			function = "nand0_dqs";
+		};
+
+		conf-dqs {
+			groups = "nand0_dqs_0_grp";
+			bias-pull-up;
+		};
+	};
+
+	pinctrl_spi0_default: spi0-default {
+		mux {
+			groups = "spi0_0_grp";
+			function = "spi0";
+		};
+
+		conf {
+			groups = "spi0_0_grp";
+			bias-disable;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux-cs {
+			groups = "spi0_ss_0_grp", "spi0_ss_1_grp",
+							"spi0_ss_2_grp";
+			function = "spi0_ss";
+		};
+
+		conf-cs {
+			groups = "spi0_ss_0_grp", "spi0_ss_1_grp",
+							"spi0_ss_2_grp";
+			bias-disable;
+		};
+	};
+
+	pinctrl_spi1_default: spi1-default {
+		mux {
+			groups = "spi1_3_grp";
+			function = "spi1";
+		};
+
+		conf {
+			groups = "spi1_3_grp";
+			bias-disable;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux-cs {
+			groups = "spi1_ss_9_grp", "spi1_ss_10_grp",
+							"spi1_ss_11_grp";
+			function = "spi1_ss";
+		};
+
+		conf-cs {
+			groups = "spi1_ss_9_grp", "spi1_ss_10_grp",
+							"spi1_ss_11_grp";
+			bias-disable;
+		};
+	};
+};
+
 &rtc {
 	status = "okay";
 };
@@ -122,6 +413,8 @@ &rtc {
 &spi0 {
 	status = "okay";
 	num-cs = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi0_default>;
 
 	spi0_flash0: flash@0 {
 		#address-cells = <1>;
@@ -140,6 +433,8 @@ partition@0 {
 &spi1 {
 	status = "okay";
 	num-cs = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
 
 	spi1_flash0: flash@0 {
 		#address-cells = <1>;
@@ -158,13 +453,19 @@ partition@0 {
 /* ULPI SMSC USB3320 */
 &usb1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb1_default>;
 	dr_mode = "host";
 };
 
 &uart0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0_default>;
 };
 
 &uart1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_default>;
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
index 41934e3525c6..6c9460a0707c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP zc1751-xm019-dc5
  *
- * (C) Copyright 2015 - 2019, Xilinx, Inc.
+ * (C) Copyright 2015 - 2021, Xilinx, Inc.
  *
  * Siva Durga Prasad <siva.durga.paladugu@xilinx.com>
  * Michal Simek <michal.simek@xilinx.com>
@@ -13,6 +13,7 @@
 #include "zynqmp.dtsi"
 #include "zynqmp-clk-ccf.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
 
 / {
 	model = "ZynqMP zc1751-xm019-dc5 RevA";
@@ -74,6 +75,8 @@ &gem1 {
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gem1_default>;
 	phy0: ethernet-phy@0 {
 		reg = <0>;
 	};
@@ -85,41 +88,365 @@ &gpio {
 
 &i2c0 {
 	status = "okay";
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c0_default>;
+	pinctrl-1 = <&pinctrl_i2c0_gpio>;
+	scl-gpios = <&gpio 74 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio 75 GPIO_ACTIVE_HIGH>;
 };
 
 &i2c1 {
 	status = "okay";
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 76 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio 77 GPIO_ACTIVE_HIGH>;
+
+};
+
+&pinctrl0 {
+	status = "okay";
+	pinctrl_i2c0_default: i2c0-default {
+		mux {
+			groups = "i2c0_18_grp";
+			function = "i2c0";
+		};
+
+		conf {
+			groups = "i2c0_18_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c0_gpio: i2c0-gpio {
+		mux {
+			groups = "gpio0_74_grp", "gpio0_75_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_74_grp", "gpio0_75_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c1_default: i2c1-default {
+		mux {
+			groups = "i2c1_19_grp";
+			function = "i2c1";
+		};
+
+		conf {
+			groups = "i2c1_19_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpio {
+		mux {
+			groups = "gpio0_76_grp", "gpio0_77_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_76_grp", "gpio0_77_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_uart0_default: uart0-default {
+		mux {
+			groups = "uart0_17_grp";
+			function = "uart0";
+		};
+
+		conf {
+			groups = "uart0_17_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO70";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO71";
+			bias-disable;
+		};
+	};
+
+	pinctrl_uart1_default: uart1-default {
+		mux {
+			groups = "uart1_18_grp";
+			function = "uart1";
+		};
+
+		conf {
+			groups = "uart1_18_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO73";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO72";
+			bias-disable;
+		};
+	};
+
+	pinctrl_gem1_default: gem1-default {
+		mux {
+			function = "ethernet1";
+			groups = "ethernet1_0_grp";
+		};
+
+		conf {
+			groups = "ethernet1_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO44", "MIO45", "MIO46", "MIO47", "MIO48",
+									"MIO49";
+			bias-high-impedance;
+			low-power-disable;
+		};
+
+		conf-tx {
+			pins = "MIO38", "MIO39", "MIO40", "MIO41", "MIO42",
+									"MIO43";
+			bias-disable;
+			low-power-enable;
+		};
+
+		mux-mdio {
+			function = "mdio1";
+			groups = "mdio1_0_grp";
+		};
+
+		conf-mdio {
+			groups = "mdio1_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_sdhci0_default: sdhci0-default {
+		mux {
+			groups = "sdio0_0_grp";
+			function = "sdio0";
+		};
+
+		conf {
+			groups = "sdio0_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+
+		mux-cd {
+			groups = "sdio0_cd_0_grp";
+			function = "sdio0_cd";
+		};
+
+		conf-cd {
+			groups = "sdio0_cd_0_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux-wp {
+			groups = "sdio0_wp_0_grp";
+			function = "sdio0_wp";
+		};
+
+		conf-wp {
+			groups = "sdio0_wp_0_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_watchdog0_default: watchdog0-default {
+		mux-clk {
+			groups = "swdt0_clk_1_grp";
+			function = "swdt0_clk";
+		};
+
+		conf-clk {
+			groups = "swdt0_clk_1_grp";
+			bias-pull-up;
+		};
+
+		mux-rst {
+			groups = "swdt0_rst_1_grp";
+			function = "swdt0_rst";
+		};
+
+		conf-rst {
+			groups = "swdt0_rst_1_grp";
+			bias-disable;
+			slew-rate = <SLEW_RATE_SLOW>;
+		};
+	};
+
+	pinctrl_ttc0_default: ttc0-default {
+		mux-clk {
+			groups = "ttc0_clk_0_grp";
+			function = "ttc0_clk";
+		};
+
+		conf-clk {
+			groups = "ttc0_clk_0_grp";
+			bias-pull-up;
+		};
+
+		mux-wav {
+			groups = "ttc0_wav_0_grp";
+			function = "ttc0_wav";
+		};
+
+		conf-wav {
+			groups = "ttc0_wav_0_grp";
+			bias-disable;
+			slew-rate = <SLEW_RATE_SLOW>;
+		};
+	};
+
+	pinctrl_ttc1_default: ttc1-default {
+		mux-clk {
+			groups = "ttc1_clk_0_grp";
+			function = "ttc1_clk";
+		};
+
+		conf-clk {
+			groups = "ttc1_clk_0_grp";
+			bias-pull-up;
+		};
+
+		mux-wav {
+			groups = "ttc1_wav_0_grp";
+			function = "ttc1_wav";
+		};
+
+		conf-wav {
+			groups = "ttc1_wav_0_grp";
+			bias-disable;
+			slew-rate = <SLEW_RATE_SLOW>;
+		};
+	};
+
+	pinctrl_ttc2_default: ttc2-default {
+		mux-clk {
+			groups = "ttc2_clk_0_grp";
+			function = "ttc2_clk";
+		};
+
+		conf-clk {
+			groups = "ttc2_clk_0_grp";
+			bias-pull-up;
+		};
+
+		mux-wav {
+			groups = "ttc2_wav_0_grp";
+			function = "ttc2_wav";
+		};
+
+		conf-wav {
+			groups = "ttc2_wav_0_grp";
+			bias-disable;
+			slew-rate = <SLEW_RATE_SLOW>;
+		};
+	};
+
+	pinctrl_ttc3_default: ttc3-default {
+		mux-clk {
+			groups = "ttc3_clk_0_grp";
+			function = "ttc3_clk";
+		};
+
+		conf-clk {
+			groups = "ttc3_clk_0_grp";
+			bias-pull-up;
+		};
+
+		mux-wav {
+			groups = "ttc3_wav_0_grp";
+			function = "ttc3_wav";
+		};
+
+		conf-wav {
+			groups = "ttc3_wav_0_grp";
+			bias-disable;
+			slew-rate = <SLEW_RATE_SLOW>;
+		};
+	};
 };
 
 &sdhci0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci0_default>;
 	no-1-8-v;
 };
 
 &ttc0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ttc0_default>;
 };
 
 &ttc1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ttc1_default>;
 };
 
 &ttc2 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ttc2_default>;
 };
 
 &ttc3 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ttc3_default>;
 };
 
 &uart0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0_default>;
 };
 
 &uart1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_default>;
 };
 
 &watchdog0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_watchdog0_default>;
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index a53598c3624b..9c40c6552c32 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP ZCU100 revC
  *
- * (C) Copyright 2016 - 2019, Xilinx, Inc.
+ * (C) Copyright 2016 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@xilinx.com>
  * Nathalie Chan King Choy
@@ -15,6 +15,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
 #include <dt-bindings/phy/phy.h>
 
 / {
@@ -160,6 +161,11 @@ &gpio {
 
 &i2c1 {
 	status = "okay";
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 4 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
 	clock-frequency = <100000>;
 	i2c-mux@75 { /* u11 */
 		compatible = "nxp,pca9548";
@@ -237,8 +243,222 @@ i2csw_7: i2c@7 {
 	};
 };
 
-&psgtr {
+&pinctrl0 {
 	status = "okay";
+	pinctrl_i2c1_default: i2c1-default {
+		mux {
+			groups = "i2c1_1_grp";
+			function = "i2c1";
+		};
+
+		conf {
+			groups = "i2c1_1_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpio {
+		mux {
+			groups = "gpio0_4_grp", "gpio0_5_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_4_grp", "gpio0_5_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_sdhci0_default: sdhci0-default {
+		mux {
+			groups = "sdio0_3_grp";
+			function = "sdio0";
+		};
+
+		conf {
+			groups = "sdio0_3_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+
+		mux-cd {
+			groups = "sdio0_cd_0_grp";
+			function = "sdio0_cd";
+		};
+
+		conf-cd {
+			groups = "sdio0_cd_0_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_sdhci1_default: sdhci1-default {
+		mux {
+			groups = "sdio1_2_grp";
+			function = "sdio1";
+		};
+
+		conf {
+			groups = "sdio1_2_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_spi0_default: spi0-default {
+		mux {
+			groups = "spi0_3_grp";
+			function = "spi0";
+		};
+
+		conf {
+			groups = "spi0_3_grp";
+			bias-disable;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux-cs {
+			groups = "spi0_ss_9_grp";
+			function = "spi0_ss";
+		};
+
+		conf-cs {
+			groups = "spi0_ss_9_grp";
+			bias-disable;
+		};
+
+	};
+
+	pinctrl_spi1_default: spi1-default {
+		mux {
+			groups = "spi1_0_grp";
+			function = "spi1";
+		};
+
+		conf {
+			groups = "spi1_0_grp";
+			bias-disable;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux-cs {
+			groups = "spi1_ss_0_grp";
+			function = "spi1_ss";
+		};
+
+		conf-cs {
+			groups = "spi1_ss_0_grp";
+			bias-disable;
+		};
+
+	};
+
+	pinctrl_uart0_default: uart0-default {
+		mux {
+			groups = "uart0_0_grp";
+			function = "uart0";
+		};
+
+		conf {
+			groups = "uart0_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO3";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO2";
+			bias-disable;
+		};
+	};
+
+	pinctrl_uart1_default: uart1-default {
+		mux {
+			groups = "uart1_0_grp";
+			function = "uart1";
+		};
+
+		conf {
+			groups = "uart1_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO1";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO0";
+			bias-disable;
+		};
+	};
+
+	pinctrl_usb0_default: usb0-default {
+		mux {
+			groups = "usb0_0_grp";
+			function = "usb0";
+		};
+
+		conf {
+			groups = "usb0_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO52", "MIO53", "MIO55";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
+			       "MIO60", "MIO61", "MIO62", "MIO63";
+			bias-disable;
+		};
+	};
+
+	pinctrl_usb1_default: usb1-default {
+		mux {
+			groups = "usb1_0_grp";
+			function = "usb1";
+		};
+
+		conf {
+			groups = "usb1_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO64", "MIO65", "MIO67";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
+			       "MIO72", "MIO73", "MIO74", "MIO75";
+			bias-disable;
+		};
+	};
+};
+
+&psgtr {
 	/* usb3, dps */
 	clocks = <&si5335a_0>, <&si5335a_1>;
 	clock-names = "ref0", "ref1";
@@ -253,12 +473,16 @@ &sdhci0 {
 	status = "okay";
 	no-1-8-v;
 	disable-wp;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci0_default>;
 	xlnx,mio-bank = <0>;
 };
 
 &sdhci1 {
 	status = "okay";
 	bus-width = <0x4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci1_default>;
 	xlnx,mio-bank = <0>;
 	non-removable;
 	disable-wp;
@@ -279,16 +503,22 @@ &spi0 { /* Low Speed connector */
 	status = "okay";
 	label = "LS-SPI0";
 	num-cs = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi0_default>;
 };
 
 &spi1 { /* High Speed connector */
 	status = "okay";
 	label = "HS-SPI1";
 	num-cs = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
 };
 
 &uart0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0_default>;
 	bluetooth {
 		compatible = "ti,wl1831-st";
 		enable-gpios = <&gpio 8 GPIO_ACTIVE_HIGH>;
@@ -297,18 +527,23 @@ bluetooth {
 
 &uart1 {
 	status = "okay";
-
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_default>;
 };
 
 /* ULPI SMSC USB3320 */
 &usb0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "peripheral";
 };
 
 /* ULPI SMSC USB3320 */
 &usb1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb1_default>;
 	dr_mode = "host";
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index eca6c2de84a7..b37aee2d85b9 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP ZCU102 RevA
  *
- * (C) Copyright 2015 - 2019, Xilinx, Inc.
+ * (C) Copyright 2015 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@xilinx.com>
  */
@@ -13,6 +13,7 @@
 #include "zynqmp-clk-ccf.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
 #include <dt-bindings/phy/phy.h>
 
 / {
@@ -150,6 +151,8 @@ refhdmi: refhdmi {
 
 &can1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1_default>;
 };
 
 &dcc {
@@ -192,6 +195,8 @@ &gem3 {
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gem3_default>;
 	phy0: ethernet-phy@21 {
 		reg = <21>;
 		ti,rx-internal-delay = <0x8>;
@@ -203,11 +208,18 @@ phy0: ethernet-phy@21 {
 
 &gpio {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_default>;
 };
 
 &i2c0 {
 	status = "okay";
 	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c0_default>;
+	pinctrl-1 = <&pinctrl_i2c0_gpio>;
+	scl-gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
 
 	tca6416_u97: gpio@20 {
 		compatible = "ti,tca6416";
@@ -468,6 +480,11 @@ max20751@73 { /* u96 */
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
 
 	/* PL i2c via PCA9306 - u45 */
 	i2c-mux@74 { /* u34 */
@@ -642,6 +659,269 @@ i2c@7 {
 	};
 };
 
+&pinctrl0 {
+	status = "okay";
+	pinctrl_i2c0_default: i2c0-default {
+		mux {
+			groups = "i2c0_3_grp";
+			function = "i2c0";
+		};
+
+		conf {
+			groups = "i2c0_3_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c0_gpio: i2c0-gpio {
+		mux {
+			groups = "gpio0_14_grp", "gpio0_15_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_14_grp", "gpio0_15_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c1_default: i2c1-default {
+		mux {
+			groups = "i2c1_4_grp";
+			function = "i2c1";
+		};
+
+		conf {
+			groups = "i2c1_4_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpio {
+		mux {
+			groups = "gpio0_16_grp", "gpio0_17_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_16_grp", "gpio0_17_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_uart0_default: uart0-default {
+		mux {
+			groups = "uart0_4_grp";
+			function = "uart0";
+		};
+
+		conf {
+			groups = "uart0_4_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO18";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO19";
+			bias-disable;
+		};
+	};
+
+	pinctrl_uart1_default: uart1-default {
+		mux {
+			groups = "uart1_5_grp";
+			function = "uart1";
+		};
+
+		conf {
+			groups = "uart1_5_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO21";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO20";
+			bias-disable;
+		};
+	};
+
+	pinctrl_usb0_default: usb0-default {
+		mux {
+			groups = "usb0_0_grp";
+			function = "usb0";
+		};
+
+		conf {
+			groups = "usb0_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO52", "MIO53", "MIO55";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
+			       "MIO60", "MIO61", "MIO62", "MIO63";
+			bias-disable;
+		};
+	};
+
+	pinctrl_gem3_default: gem3-default {
+		mux {
+			function = "ethernet3";
+			groups = "ethernet3_0_grp";
+		};
+
+		conf {
+			groups = "ethernet3_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO70", "MIO71", "MIO72", "MIO73", "MIO74",
+									"MIO75";
+			bias-high-impedance;
+			low-power-disable;
+		};
+
+		conf-tx {
+			pins = "MIO64", "MIO65", "MIO66", "MIO67", "MIO68",
+									"MIO69";
+			bias-disable;
+			low-power-enable;
+		};
+
+		mux-mdio {
+			function = "mdio3";
+			groups = "mdio3_0_grp";
+		};
+
+		conf-mdio {
+			groups = "mdio3_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_can1_default: can1-default {
+		mux {
+			function = "can1";
+			groups = "can1_6_grp";
+		};
+
+		conf {
+			groups = "can1_6_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO25";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO24";
+			bias-disable;
+		};
+	};
+
+	pinctrl_sdhci1_default: sdhci1-default {
+		mux {
+			groups = "sdio1_0_grp";
+			function = "sdio1";
+		};
+
+		conf {
+			groups = "sdio1_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+
+		mux-cd {
+			groups = "sdio1_cd_0_grp";
+			function = "sdio1_cd";
+		};
+
+		conf-cd {
+			groups = "sdio1_cd_0_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux-wp {
+			groups = "sdio1_wp_0_grp";
+			function = "sdio1_wp";
+		};
+
+		conf-wp {
+			groups = "sdio1_wp_0_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_gpio_default: gpio-default {
+		mux-sw {
+			function = "gpio0";
+			groups = "gpio0_22_grp", "gpio0_23_grp";
+		};
+
+		conf-sw {
+			groups = "gpio0_22_grp", "gpio0_23_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux-msp {
+			function = "gpio0";
+			groups = "gpio0_13_grp", "gpio0_38_grp";
+		};
+
+		conf-msp {
+			groups = "gpio0_13_grp", "gpio0_38_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-pull-up {
+			pins = "MIO22", "MIO23";
+			bias-pull-up;
+		};
+
+		conf-pull-none {
+			pins = "MIO13", "MIO38";
+			bias-disable;
+		};
+	};
+};
+
 &pcie {
 	status = "okay";
 };
@@ -676,20 +956,28 @@ &sata {
 &sdhci1 {
 	status = "okay";
 	no-1-8-v;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci1_default>;
 	xlnx,mio-bank = <1>;
 };
 
 &uart0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0_default>;
 };
 
 &uart1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_default>;
 };
 
 /* ULPI SMSC USB3320 */
 &usb0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "host";
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 5c35edd736aa..7e1b024f71e1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP ZCU104
  *
- * (C) Copyright 2017 - 2019, Xilinx, Inc.
+ * (C) Copyright 2017 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@xilinx.com>
  */
@@ -12,6 +12,7 @@
 #include "zynqmp.dtsi"
 #include "zynqmp-clk-ccf.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
 #include <dt-bindings/phy/phy.h>
 
 / {
@@ -59,6 +60,8 @@ clock_8t49n287_3: clk27 {
 
 &can1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1_default>;
 };
 
 &dcc {
@@ -101,6 +104,8 @@ &gem3 {
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gem3_default>;
 	phy0: ethernet-phy@c {
 		reg = <0xc>;
 		ti,rx-internal-delay = <0x8>;
@@ -117,6 +122,11 @@ &gpio {
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
 
 	/* Another connection to this bus via PL i2c via PCA9306 - u45 */
 	i2c-mux@74 { /* u34 */
@@ -207,6 +217,204 @@ i2c@7 {
 	};
 };
 
+&pinctrl0 {
+	status = "okay";
+
+	pinctrl_can1_default: can1-default {
+		mux {
+			function = "can1";
+			groups = "can1_6_grp";
+		};
+
+		conf {
+			groups = "can1_6_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+
+		conf-rx {
+			pins = "MIO25";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO24";
+			bias-disable;
+		};
+	};
+
+	pinctrl_i2c1_default: i2c1-default {
+		mux {
+			groups = "i2c1_4_grp";
+			function = "i2c1";
+		};
+
+		conf {
+			groups = "i2c1_4_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpio {
+		mux {
+			groups = "gpio0_16_grp", "gpio0_17_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_16_grp", "gpio0_17_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+	};
+
+	pinctrl_gem3_default: gem3-default {
+		mux {
+			function = "ethernet3";
+			groups = "ethernet3_0_grp";
+		};
+
+		conf {
+			groups = "ethernet3_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+
+		conf-rx {
+			pins = "MIO70", "MIO71", "MIO72", "MIO73", "MIO74",
+									"MIO75";
+			bias-high-impedance;
+			low-power-disable;
+		};
+
+		conf-tx {
+			pins = "MIO64", "MIO65", "MIO66", "MIO67", "MIO68",
+									"MIO69";
+			bias-disable;
+			low-power-enable;
+		};
+
+		mux-mdio {
+			function = "mdio3";
+			groups = "mdio3_0_grp";
+		};
+
+		conf-mdio {
+			groups = "mdio3_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_sdhci1_default: sdhci1-default {
+		mux {
+			groups = "sdio1_0_grp";
+			function = "sdio1";
+		};
+
+		conf {
+			groups = "sdio1_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+			drive-strength = <12>;
+		};
+
+		mux-cd {
+			groups = "sdio1_cd_0_grp";
+			function = "sdio1_cd";
+		};
+
+		conf-cd {
+			groups = "sdio1_cd_0_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_uart0_default: uart0-default {
+		mux {
+			groups = "uart0_4_grp";
+			function = "uart0";
+		};
+
+		conf {
+			groups = "uart0_4_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+
+		conf-rx {
+			pins = "MIO18";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO19";
+			bias-disable;
+		};
+	};
+
+	pinctrl_uart1_default: uart1-default {
+		mux {
+			groups = "uart1_5_grp";
+			function = "uart1";
+		};
+
+		conf {
+			groups = "uart1_5_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+
+		conf-rx {
+			pins = "MIO21";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO20";
+			bias-disable;
+		};
+	};
+
+	pinctrl_usb0_default: usb0-default {
+		mux {
+			groups = "usb0_0_grp";
+			function = "usb0";
+		};
+
+		conf {
+			groups = "usb0_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+
+		conf-rx {
+			pins = "MIO52", "MIO53", "MIO55";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
+			       "MIO60", "MIO61", "MIO62", "MIO63";
+			bias-disable;
+		};
+	};
+};
+
 &rtc {
 	status = "okay";
 };
@@ -237,21 +445,29 @@ &sata {
 &sdhci1 {
 	status = "okay";
 	no-1-8-v;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci1_default>;
 	xlnx,mio-bank = <1>;
 	disable-wp;
 };
 
 &uart0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0_default>;
 };
 
 &uart1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_default>;
 };
 
 /* ULPI SMSC USB3320 */
 &usb0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "host";
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index 7f2e32831b05..b140fd2c86aa 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP ZCU104
  *
- * (C) Copyright 2017 - 2020, Xilinx, Inc.
+ * (C) Copyright 2017 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@xilinx.com>
  */
@@ -12,6 +12,7 @@
 #include "zynqmp.dtsi"
 #include "zynqmp-clk-ccf.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
 #include <dt-bindings/phy/phy.h>
 
 / {
@@ -64,6 +65,8 @@ clock_8t49n287_3: clk27 {
 
 &can1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1_default>;
 };
 
 &dcc {
@@ -106,6 +109,8 @@ &gem3 {
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gem3_default>;
 	phy0: ethernet-phy@c {
 		reg = <0xc>;
 		ti,rx-internal-delay = <0x8>;
@@ -122,6 +127,11 @@ &gpio {
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
 
 	tca6416_u97: gpio@20 {
 		compatible = "ti,tca6416";
@@ -219,6 +229,204 @@ i2c@7 {
 	};
 };
 
+&pinctrl0 {
+	status = "okay";
+
+	pinctrl_can1_default: can1-default {
+		mux {
+			function = "can1";
+			groups = "can1_6_grp";
+		};
+
+		conf {
+			groups = "can1_6_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+
+		conf-rx {
+			pins = "MIO25";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO24";
+			bias-disable;
+		};
+	};
+
+	pinctrl_i2c1_default: i2c1-default {
+		mux {
+			groups = "i2c1_4_grp";
+			function = "i2c1";
+		};
+
+		conf {
+			groups = "i2c1_4_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpio {
+		mux {
+			groups = "gpio0_16_grp", "gpio0_17_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_16_grp", "gpio0_17_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+	};
+
+	pinctrl_gem3_default: gem3-default {
+		mux {
+			function = "ethernet3";
+			groups = "ethernet3_0_grp";
+		};
+
+		conf {
+			groups = "ethernet3_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+
+		conf-rx {
+			pins = "MIO70", "MIO71", "MIO72", "MIO73", "MIO74",
+									"MIO75";
+			bias-high-impedance;
+			low-power-disable;
+		};
+
+		conf-tx {
+			pins = "MIO64", "MIO65", "MIO66", "MIO67", "MIO68",
+									"MIO69";
+			bias-disable;
+			low-power-enable;
+		};
+
+		mux-mdio {
+			function = "mdio3";
+			groups = "mdio3_0_grp";
+		};
+
+		conf-mdio {
+			groups = "mdio3_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_sdhci1_default: sdhci1-default {
+		mux {
+			groups = "sdio1_0_grp";
+			function = "sdio1";
+		};
+
+		conf {
+			groups = "sdio1_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+			drive-strength = <12>;
+		};
+
+		mux-cd {
+			groups = "sdio1_cd_0_grp";
+			function = "sdio1_cd";
+		};
+
+		conf-cd {
+			groups = "sdio1_cd_0_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_uart0_default: uart0-default {
+		mux {
+			groups = "uart0_4_grp";
+			function = "uart0";
+		};
+
+		conf {
+			groups = "uart0_4_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+
+		conf-rx {
+			pins = "MIO18";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO19";
+			bias-disable;
+		};
+	};
+
+	pinctrl_uart1_default: uart1-default {
+		mux {
+			groups = "uart1_5_grp";
+			function = "uart1";
+		};
+
+		conf {
+			groups = "uart1_5_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+
+		conf-rx {
+			pins = "MIO21";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO20";
+			bias-disable;
+		};
+	};
+
+	pinctrl_usb0_default: usb0-default {
+		mux {
+			groups = "usb0_0_grp";
+			function = "usb0";
+		};
+
+		conf {
+			groups = "usb0_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+
+		conf-rx {
+			pins = "MIO52", "MIO53", "MIO55";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
+			       "MIO60", "MIO61", "MIO62", "MIO63";
+			bias-disable;
+		};
+	};
+};
+
 &qspi {
 	status = "okay";
 	flash@0 {
@@ -259,21 +467,29 @@ &sata {
 &sdhci1 {
 	status = "okay";
 	no-1-8-v;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci1_default>;
 	xlnx,mio-bank = <1>;
 	disable-wp;
 };
 
 &uart0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0_default>;
 };
 
 &uart1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_default>;
 };
 
 /* ULPI SMSC USB3320 */
 &usb0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "host";
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index eff7c6447087..4919cdec835b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP ZCU106
  *
- * (C) Copyright 2016 - 2019, Xilinx, Inc.
+ * (C) Copyright 2016 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@xilinx.com>
  */
@@ -13,6 +13,7 @@
 #include "zynqmp-clk-ccf.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
 #include <dt-bindings/phy/phy.h>
 
 / {
@@ -150,6 +151,8 @@ refhdmi: refhdmi {
 
 &can1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1_default>;
 };
 
 &dcc {
@@ -204,6 +207,8 @@ &gem3 {
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gem3_default>;
 	phy0: ethernet-phy@c {
 		reg = <0xc>;
 		ti,rx-internal-delay = <0x8>;
@@ -215,11 +220,18 @@ phy0: ethernet-phy@c {
 
 &gpio {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_default>;
 };
 
 &i2c0 {
 	status = "okay";
 	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c0_default>;
+	pinctrl-1 = <&pinctrl_i2c0_gpio>;
+	scl-gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
 
 	tca6416_u97: gpio@20 {
 		compatible = "ti,tca6416";
@@ -478,6 +490,11 @@ max20751@73 { /* u96 */
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
 
 	/* PL i2c via PCA9306 - u45 */
 	i2c-mux@74 { /* u34 */
@@ -652,6 +669,269 @@ i2c@7 {
 	};
 };
 
+&pinctrl0 {
+	status = "okay";
+	pinctrl_i2c0_default: i2c0-default {
+		mux {
+			groups = "i2c0_3_grp";
+			function = "i2c0";
+		};
+
+		conf {
+			groups = "i2c0_3_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c0_gpio: i2c0-gpio {
+		mux {
+			groups = "gpio0_14_grp", "gpio0_15_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_14_grp", "gpio0_15_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c1_default: i2c1-default {
+		mux {
+			groups = "i2c1_4_grp";
+			function = "i2c1";
+		};
+
+		conf {
+			groups = "i2c1_4_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpio {
+		mux {
+			groups = "gpio0_16_grp", "gpio0_17_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_16_grp", "gpio0_17_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_uart0_default: uart0-default {
+		mux {
+			groups = "uart0_4_grp";
+			function = "uart0";
+		};
+
+		conf {
+			groups = "uart0_4_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO18";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO19";
+			bias-disable;
+		};
+	};
+
+	pinctrl_uart1_default: uart1-default {
+		mux {
+			groups = "uart1_5_grp";
+			function = "uart1";
+		};
+
+		conf {
+			groups = "uart1_5_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO21";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO20";
+			bias-disable;
+		};
+	};
+
+	pinctrl_usb0_default: usb0-default {
+		mux {
+			groups = "usb0_0_grp";
+			function = "usb0";
+		};
+
+		conf {
+			groups = "usb0_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO52", "MIO53", "MIO55";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
+			       "MIO60", "MIO61", "MIO62", "MIO63";
+			bias-disable;
+		};
+	};
+
+	pinctrl_gem3_default: gem3-default {
+		mux {
+			function = "ethernet3";
+			groups = "ethernet3_0_grp";
+		};
+
+		conf {
+			groups = "ethernet3_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO70", "MIO71", "MIO72", "MIO73", "MIO74",
+									"MIO75";
+			bias-high-impedance;
+			low-power-disable;
+		};
+
+		conf-tx {
+			pins = "MIO64", "MIO65", "MIO66", "MIO67", "MIO68",
+									"MIO69";
+			bias-disable;
+			low-power-enable;
+		};
+
+		mux-mdio {
+			function = "mdio3";
+			groups = "mdio3_0_grp";
+		};
+
+		conf-mdio {
+			groups = "mdio3_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_can1_default: can1-default {
+		mux {
+			function = "can1";
+			groups = "can1_6_grp";
+		};
+
+		conf {
+			groups = "can1_6_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO25";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO24";
+			bias-disable;
+		};
+	};
+
+	pinctrl_sdhci1_default: sdhci1-default {
+		mux {
+			groups = "sdio1_0_grp";
+			function = "sdio1";
+		};
+
+		conf {
+			groups = "sdio1_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+
+		mux-cd {
+			groups = "sdio1_cd_0_grp";
+			function = "sdio1_cd";
+		};
+
+		conf-cd {
+			groups = "sdio1_cd_0_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux-wp {
+			groups = "sdio1_wp_0_grp";
+			function = "sdio1_wp";
+		};
+
+		conf-wp {
+			groups = "sdio1_wp_0_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_gpio_default: gpio-default {
+		mux {
+			function = "gpio0";
+			groups = "gpio0_22_grp", "gpio0_23_grp";
+		};
+
+		conf {
+			groups = "gpio0_22_grp", "gpio0_23_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux-msp {
+			function = "gpio0";
+			groups = "gpio0_13_grp", "gpio0_38_grp";
+		};
+
+		conf-msp {
+			groups = "gpio0_13_grp", "gpio0_38_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-pull-up {
+			pins = "MIO22";
+			bias-pull-up;
+		};
+
+		conf-pull-none {
+			pins = "MIO13", "MIO23", "MIO38";
+			bias-disable;
+		};
+	};
+};
+
 &psgtr {
 	status = "okay";
 	/* nc, sata, usb3, dp */
@@ -682,20 +962,28 @@ &sata {
 &sdhci1 {
 	status = "okay";
 	no-1-8-v;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci1_default>;
 	xlnx,mio-bank = <1>;
 };
 
 &uart0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0_default>;
 };
 
 &uart1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_default>;
 };
 
 /* ULPI SMSC USB3320 */
 &usb0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "host";
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 68b758e40f80..2e9fe675a718 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP ZCU111
  *
- * (C) Copyright 2017 - 2019, Xilinx, Inc.
+ * (C) Copyright 2017 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@xilinx.com>
  */
@@ -13,6 +13,7 @@
 #include "zynqmp-clk-ccf.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
 #include <dt-bindings/phy/phy.h>
 
 / {
@@ -166,6 +167,8 @@ &gem3 {
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gem3_default>;
 	phy0: ethernet-phy@c {
 		reg = <0xc>;
 		ti,rx-internal-delay = <0x8>;
@@ -177,11 +180,18 @@ phy0: ethernet-phy@c {
 
 &gpio {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_default>;
 };
 
 &i2c0 {
 	status = "okay";
 	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c0_default>;
+	pinctrl-1 = <&pinctrl_i2c0_gpio>;
+	scl-gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
 
 	tca6416_u22: gpio@20 {
 		compatible = "ti,tca6416";
@@ -357,6 +367,11 @@ i2c@3 {
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
 
 	i2c-mux@74 { /* u26 */
 		compatible = "nxp,pca9548";
@@ -545,6 +560,210 @@ i2c@7 {
 	};
 };
 
+&pinctrl0 {
+	status = "okay";
+	pinctrl_i2c0_default: i2c0-default {
+		mux {
+			groups = "i2c0_3_grp";
+			function = "i2c0";
+		};
+
+		conf {
+			groups = "i2c0_3_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c0_gpio: i2c0-gpio {
+		mux {
+			groups = "gpio0_14_grp", "gpio0_15_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_14_grp", "gpio0_15_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c1_default: i2c1-default {
+		mux {
+			groups = "i2c1_4_grp";
+			function = "i2c1";
+		};
+
+		conf {
+			groups = "i2c1_4_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpio {
+		mux {
+			groups = "gpio0_16_grp", "gpio0_17_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_16_grp", "gpio0_17_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_uart0_default: uart0-default {
+		mux {
+			groups = "uart0_4_grp";
+			function = "uart0";
+		};
+
+		conf {
+			groups = "uart0_4_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO18";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO19";
+			bias-disable;
+		};
+	};
+
+	pinctrl_usb0_default: usb0-default {
+		mux {
+			groups = "usb0_0_grp";
+			function = "usb0";
+		};
+
+		conf {
+			groups = "usb0_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO52", "MIO53", "MIO55";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
+			       "MIO60", "MIO61", "MIO62", "MIO63";
+			bias-disable;
+		};
+	};
+
+	pinctrl_gem3_default: gem3-default {
+		mux {
+			function = "ethernet3";
+			groups = "ethernet3_0_grp";
+		};
+
+		conf {
+			groups = "ethernet3_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO70", "MIO71", "MIO72", "MIO73", "MIO74",
+									"MIO75";
+			bias-high-impedance;
+			low-power-disable;
+		};
+
+		conf-tx {
+			pins = "MIO64", "MIO65", "MIO66", "MIO67", "MIO68",
+									"MIO69";
+			bias-disable;
+			low-power-enable;
+		};
+
+		mux-mdio {
+			function = "mdio3";
+			groups = "mdio3_0_grp";
+		};
+
+		conf-mdio {
+			groups = "mdio3_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_sdhci1_default: sdhci1-default {
+		mux {
+			groups = "sdio1_0_grp";
+			function = "sdio1";
+		};
+
+		conf {
+			groups = "sdio1_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+
+		mux-cd {
+			groups = "sdio1_cd_0_grp";
+			function = "sdio1_cd";
+		};
+
+		conf-cd {
+			groups = "sdio1_cd_0_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_gpio_default: gpio-default {
+		mux {
+			function = "gpio0";
+			groups = "gpio0_22_grp", "gpio0_23_grp";
+		};
+
+		conf {
+			groups = "gpio0_22_grp", "gpio0_23_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux-msp {
+			function = "gpio0";
+			groups = "gpio0_13_grp", "gpio0_38_grp";
+		};
+
+		conf-msp {
+			groups = "gpio0_13_grp", "gpio0_38_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-pull-up {
+			pins = "MIO22";
+			bias-pull-up;
+		};
+
+		conf-pull-none {
+			pins = "MIO13", "MIO23", "MIO38";
+			bias-disable;
+		};
+	};
+};
+
 &psgtr {
 	status = "okay";
 	/* nc, sata, usb3, dp */
@@ -574,17 +793,23 @@ &sata {
 /* SD1 with level shifter */
 &sdhci1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci1_default>;
 	no-1-8-v;
 	xlnx,mio-bank = <1>;
 };
 
 &uart0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0_default>;
 };
 
 /* ULPI SMSC USB3320 */
 &usb0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "host";
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 302ca0196c34..f860e90ea2a6 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -193,6 +193,11 @@ zynqmp_reset: reset-controller {
 				compatible = "xlnx,zynqmp-reset";
 				#reset-cells = <1>;
 			};
+
+			pinctrl0: pinctrl {
+				compatible = "xlnx,zynqmp-pinctrl";
+				status = "disabled";
+			};
 		};
 	};
 
-- 
2.32.0

