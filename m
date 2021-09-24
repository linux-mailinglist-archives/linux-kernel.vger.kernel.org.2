Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0C5416E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 10:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245040AbhIXJAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245028AbhIXJAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:00:16 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5455BC061760;
        Fri, 24 Sep 2021 01:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TfTPNKExtFG0VA3U5UU/f/0OeC+tLclz/zCpStWBNVU=; b=d/1TYa0e0hwhlFNMqMarEhxhdC
        92a0zYrygShCdfM836YW36jpn+qEHRgLuOBlVyyNlSsUjVw4U/cYTaw9k3Lic9cV/nPatfd4Cyyg8
        eiX8zmgLGfpkt/4U8TuR808VWeUh7/r75dj2Yn7cSybf1A+ThjorZFHucFEqFEL9RZRo=;
Received: from p200300ccff0ce8001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:e800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mTh2R-00024p-Mo; Fri, 24 Sep 2021 10:58:36 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1mTh2R-00Ak4O-8H; Fri, 24 Sep 2021 10:58:35 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, krzk@kernel.org,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 2/4] ARM: dts: add Netronix E70K02 board common file
Date:   Fri, 24 Sep 2021 10:58:30 +0200
Message-Id: <20210924085832.2560317-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924085832.2560317-1-andreas@kemnade.info>
References: <20210924085832.2560317-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Netronix board E70K02 can be found some several Ebook-Readers,
at least the Kobo Libra H2O and the Tolino Vision 5. The board
is equipped with different SoCs requiring different pinmuxes.

    For now the following peripherals are included:
    - LED
    - Power Key
    - Cover (gpio via hall sensor)
    - RC5T619 PMIC
    - Backlight via lm3630a
    - Wifi sdio chip detection (mmc-powerseq and stuff)

    It is based on vendor kernel but heavily reworked due to many
    changed bindings.

Known limitations: cold colored backlight does not work due to
incompatible hard coded overvoltage setting in the driver.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changed in v2:
- s/_/-/ in node name wifi-powerseq
- correct led node name

 arch/arm/boot/dts/e70k02.dtsi | 320 ++++++++++++++++++++++++++++++++++
 1 file changed, 320 insertions(+)
 create mode 100644 arch/arm/boot/dts/e70k02.dtsi

diff --git a/arch/arm/boot/dts/e70k02.dtsi b/arch/arm/boot/dts/e70k02.dtsi
new file mode 100644
index 000000000000..156de653f2cd
--- /dev/null
+++ b/arch/arm/boot/dts/e70k02.dtsi
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 Andreas Kemnade
+ * based on works
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ * and
+ * Copyright (C) 2014 Ricoh Electronic Devices Co., Ltd
+ *
+ * Netronix E70K02 board common.
+ * This board is equipped with different SoCs and
+ * found in ebook-readers like the Kobo Clara HD (with i.MX6SLL) and
+ * the Tolino Shine 3 (with i.MX6SL)
+ */
+#include <dt-bindings/input/input.h>
+
+/ {
+	aliases {
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc3;
+	};
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "Power";
+			gpios = <&gpio4 25 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		cover {
+			label = "Cover";
+			gpios = <&gpio4 23 GPIO_ACTIVE_LOW>;
+			linux,code = <SW_LID>;
+			linux,input-type = <EV_SW>;
+			wakeup-source;
+		};
+
+		pageup {
+			label = "PageUp";
+			gpios = <&gpio4 0 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_PAGEUP>;
+		};
+
+		pagedown {
+			label = "PageDown";
+			gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_PAGEDOWN>;
+		};
+	};
+
+	leds: leds {
+		compatible = "gpio-leds";
+
+		led {
+			label = "e70k02:white:on";
+			gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "timer";
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reg_wifi: regulator-wifi {
+		compatible = "regulator-fixed";
+		regulator-name = "SD3_SPWR";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		post-power-on-delay-ms = <20>;
+		reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	status = "okay";
+
+	lm3630a: backlight@36 {
+		reg = <0x36>;
+		compatible = "ti,lm3630a";
+		enable-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			led-sources = <0>;
+			label = "backlight_warm";
+			default-brightness = <0>;
+			max-brightness = <255>;
+		};
+
+		led@1 {
+			reg = <1>;
+			led-sources = <1>;
+			label = "backlight_cold";
+			default-brightness = <0>;
+			max-brightness = <255>;
+		};
+	};
+
+	/* TODO: KX122 acceleration sensor a 0x1e */
+
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	status = "okay";
+
+	/* TODO: CYTTSP5 touch controller at 0x24 */
+
+	/* TODO: SY7636 PMIC for E Ink at 0x62 */
+
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	status = "okay";
+
+	ricoh619: pmic@32 {
+		compatible = "ricoh,rc5t619";
+		reg = <0x32>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
+		system-power-controller;
+
+		regulators {
+			dcdc1_reg: DCDC1 {
+				regulator-name = "DCDC1";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <900000>;
+					regulator-suspend-min-microvolt = <900000>;
+				};
+			};
+
+			/* Core3_3V3 */
+			dcdc2_reg: DCDC2 {
+				regulator-name = "DCDC2";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <3300000>;
+					regulator-suspend-min-microvolt = <3300000>;
+				};
+			};
+
+			dcdc3_reg: DCDC3 {
+				regulator-name = "DCDC3";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <1140000>;
+					regulator-suspend-min-microvolt = <1140000>;
+				};
+			};
+
+			/* Core4_1V2 */
+			dcdc4_reg: DCDC4 {
+				regulator-name = "DCDC4";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <1140000>;
+					regulator-suspend-min-microvolt = <1140000>;
+				};
+			};
+
+			/* Core4_1V8 */
+			dcdc5_reg: DCDC5 {
+				regulator-name = "DCDC5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <1700000>;
+					regulator-suspend-min-microvolt = <1700000>;
+				};
+			};
+
+			ldo1_reg: LDO1  {
+				regulator-name = "LDO1";
+				regulator-boot-on;
+			};
+
+			/* Core1_3V3 */
+			ldo2_reg: LDO2  {
+				regulator-name = "LDO2";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <3000000>;
+					regulator-suspend-min-microvolt = <3000000>;
+				};
+			};
+
+			/* Core5_1V2 */
+			ldo3_reg: LDO3  {
+				regulator-name = "LDO3";
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			ldo4_reg: LDO4 {
+				regulator-name = "LDO4";
+				regulator-boot-on;
+			};
+
+			/* SPD_3V3 */
+			ldo5_reg: LDO5 {
+				regulator-name = "LDO5";
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			/* DDR_0V6 */
+			ldo6_reg: LDO6 {
+				regulator-name = "LDO6";
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			/* VDD_PWM */
+			ldo7_reg: LDO7 {
+				regulator-name = "LDO7";
+				regulator-boot-on;
+			};
+
+			/* ldo_1v8 */
+			ldo8_reg: LDO8 {
+				regulator-name = "LDO8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+			};
+
+			ldo9_reg: LDO9 {
+				regulator-name = "LDO9";
+				regulator-boot-on;
+			};
+
+			ldo10_reg: LDO10 {
+				regulator-name = "LDO10";
+				regulator-boot-on;
+			};
+
+			ldortc1_reg: LDORTC1  {
+				regulator-name = "LDORTC1";
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
+&snvs_rtc {
+	/* we are using the rtc in the pmic, not disabled in imx6sll.dtsi */
+	status = "disabled";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usdhc1 {
+	non-removable;
+	no-1-8-v;
+	status = "okay";
+};
+
+&usdhc3 {
+	vmmc-supply = <&reg_wifi>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	cap-power-off-card;
+	non-removable;
+	status = "okay";
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	disable-over-current;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	status = "okay";
+};
-- 
2.30.2

