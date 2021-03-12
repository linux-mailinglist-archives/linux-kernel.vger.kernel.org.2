Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154C83385D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhCLGZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhCLGZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:25:00 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DB2C061574;
        Thu, 11 Mar 2021 22:25:00 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a24so11434509plm.11;
        Thu, 11 Mar 2021 22:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pev/ZfClpqLiK4P/V8mAyS2Ui0LgQSVba+zMuAxMqpI=;
        b=GD6AK8qcL59huTZZ/wYMZFr/cL7wHEMbcDxF8ySIGA77b0aWQkyvN36pQMTeHLuK7E
         sjoVtGDbiKPwJvZ2GJuqX7zlPLP2ip3PMIMCizmywb/bv+Yc5CMSb4o7xgXU9MfqQbGR
         kjO5/kV6QsN4R+2GiCJIx28c1vZu/MEy24L2XzRj0RkjltAT/2HG0S7PPJlStN7Lgr/d
         TwwRBdPxJ9ylVbKDQ0uRvhz2qw9wLgNEv3zB6HEuCEAt5R/85lxtU7crQLnAU3i1lO1R
         hztBwrF77J/byu+eeB2sODyBXzlsUMxzWBF+Lfu0CieKNqCU/bn6/bM4POgdywFoPBvD
         626g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pev/ZfClpqLiK4P/V8mAyS2Ui0LgQSVba+zMuAxMqpI=;
        b=kCQ+oahdttX5G1KLfC7HXzPuDWUbKFmZhkYuKtVpRiMpaIOhtBJzllxnl/qFmDYyxG
         O7xvHsI0ym9dhXSkSxZrQ3lUa1UUHeeIg4tS6/+VVVxy7SqNjyecEmtIdwcjB2e32iXa
         BZIoBuq/RrxAtav/TH8vio4kT82bKWQbceUUwvcDdpgq3OqUWSn+oOPG5HTWlmzfpQCc
         gZzpDhFzbsopQG8b7NgTIOToSU3FyI3ePLL7y2mrXP8kXouqX08l1o1UNxomy9YhU2bN
         1aQ+7m4jFEwCDeB0yKjD8Tnpb9tduWkdlMKCvlAKFARefqFupmnGrLAXbZOEV1fw57SI
         RrEw==
X-Gm-Message-State: AOAM532qBkhqndyBosAM4nT1SjfDx/5qmq2TDaQnFx7LklRy3LgrHZq8
        j9SDP9tr+Zuw9blf3r5feW8=
X-Google-Smtp-Source: ABdhPJwB7yQSrMQAFgcUeViHklcXQ6PhNu2kAO5E82EOCwUDSRadbdLSJZ02TAyVaPRCc4gzBOdmvA==
X-Received: by 2002:a17:902:b589:b029:e6:2875:aa4c with SMTP id a9-20020a170902b589b02900e62875aa4cmr12219206pls.71.1615530300106;
        Thu, 11 Mar 2021 22:25:00 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id h6sm4048406pfb.157.2021.03.11.22.24.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 22:24:59 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, alexandre.torgue@foss.st.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v2 6/8] ARM: dts: stm32: add support for art-pi board based on stm32h750xbh6
Date:   Fri, 12 Mar 2021 14:24:32 +0800
Message-Id: <1615530274-31422-7-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
References: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patchset has following changes:

- introduce stm32h750.dtsi to support stm32h750 value line
- add stm32h750i-art-pi.dtb (arch/arm/boot/dts/Makefile)
- add dts binding usart3 for bt, uart4 for console
  usart3/uart4 pinctrl in stm32h7-pinctrl.dtsi
  usart3/uart4 register in stm32h743.dtsi
- add dts binding sdmmc2 for wifi
  sdmmc2 pinctrl in stm32h7-pinctrl.dtsi
  sdmmc2 register in stm32h743.dtsi
- add spi1 pinctrl in stm32h7-pinctrl.dtsi for spi flash
- add stm32h750-art-pi.dts to support art-pi board

art-pi board component:
- 8MiB qspi flash
- 16MiB spi flash
- 32MiB sdram
- ap6212 wifi&bt&fm

the detail board information can be found at:
https://art-pi.gitee.io/website/

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
v2:
- fix author name/copyright mistake
- make item in stm32h750i-art-pi.dts sort by letter

 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/stm32h7-pinctrl.dtsi  |  87 ++++++++++++
 arch/arm/boot/dts/stm32h743.dtsi        |  30 +++++
 arch/arm/boot/dts/stm32h750.dtsi        |   5 +
 arch/arm/boot/dts/stm32h750i-art-pi.dts | 228 ++++++++++++++++++++++++++++++++
 5 files changed, 351 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32h750.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750i-art-pi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8e5d4ab4e75e..a19c5ab9df84 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1071,6 +1071,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32746g-eval.dtb \
 	stm32h743i-eval.dtb \
 	stm32h743i-disco.dtb \
+	stm32h750i-art-pi.dtb \
 	stm32mp153c-dhcom-drc02.dtb \
 	stm32mp157a-avenger96.dtb \
 	stm32mp157a-dhcor-avenger96.dtb \
diff --git a/arch/arm/boot/dts/stm32h7-pinctrl.dtsi b/arch/arm/boot/dts/stm32h7-pinctrl.dtsi
index 9fcc1e3ba925..0d08225a16de 100644
--- a/arch/arm/boot/dts/stm32h7-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32h7-pinctrl.dtsi
@@ -231,6 +231,50 @@
 				};
 			};
 
+			sdmmc2_b4_pins_a: sdmmc2-b4-0 {
+				pins {
+					pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC1_D0 */
+						 <STM32_PINMUX('B', 15, AF9)>, /* SDMMC1_D1 */
+						 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC1_D2 */
+						 <STM32_PINMUX('B', 4, AF9)>, /* SDMMC1_D3 */
+						 <STM32_PINMUX('D', 6, AF11)>, /* SDMMC1_CK */
+						 <STM32_PINMUX('D', 7, AF11)>; /* SDMMC1_CMD */
+					slew-rate = <3>;
+					drive-push-pull;
+					bias-disable;
+				};
+			};
+
+			sdmmc2_b4_od_pins_a: sdmmc2-b4-od-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
+						 <STM32_PINMUX('B', 15, AF9)>, /* SDMMC1_D1 */
+						 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC1_D2 */
+						 <STM32_PINMUX('B', 4, AF9)>, /* SDMMC1_D3 */
+						 <STM32_PINMUX('D', 6, AF11)>; /* SDMMC1_CK */
+					slew-rate = <3>;
+					drive-push-pull;
+					bias-disable;
+				};
+				pins2{
+					pinmux = <STM32_PINMUX('D', 7, AF11)>; /* SDMMC1_CMD */
+					slew-rate = <3>;
+					drive-open-drain;
+					bias-disable;
+				};
+			};
+
+			sdmmc2_b4_sleep_pins_a: sdmmc2-b4-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('B', 14, ANALOG)>, /* SDMMC1_D0 */
+						 <STM32_PINMUX('B', 15, ANALOG)>, /* SDMMC1_D1 */
+						 <STM32_PINMUX('B', 3, ANALOG)>, /* SDMMC1_D2 */
+						 <STM32_PINMUX('B', 4, ANALOG)>, /* SDMMC1_D3 */
+						 <STM32_PINMUX('D', 6, ANALOG)>, /* SDMMC1_CK */
+						 <STM32_PINMUX('D', 7, ANALOG)>; /* SDMMC1_CMD */
+				};
+			};
+
 			sdmmc1_dir_pins_a: sdmmc1-dir-0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('C', 6, AF8)>, /* SDMMC1_D0DIR */
@@ -281,6 +325,32 @@
 				};
 			};
 
+			usart3_pins: usart3-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 10, AF7)>; /* USART3_TX */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 11, AF7)>; /* USART3_RX */
+					bias-disable;
+				};
+			};
+
+			uart4_pins: uart4-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('A', 0, AF8)>; /* UART4_TX */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('I', 9, AF8)>; /* UART4_RX */
+					bias-disable;
+				};
+			};
+
 			usbotg_hs_pins_a: usbotg-hs-0 {
 				pins {
 					pinmux = <STM32_PINMUX('H', 4, AF10)>,	/* ULPI_NXT */
@@ -300,6 +370,23 @@
 					slew-rate = <2>;
 				};
 			};
+
+			spi1_pins: spi1-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('A', 5, AF5)>,
+						/* SPI1_CLK */
+						 <STM32_PINMUX('B', 5, AF5)>;
+						/* SPI1_MOSI */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('G', 9, AF5)>;
+						/* SPI1_MISO */
+					bias-disable;
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 4ebffb0a45a3..981d44051007 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -135,6 +135,22 @@
 			clocks = <&rcc USART2_CK>;
 		};
 
+		usart3: serial@40004800 {
+			compatible = "st,stm32h7-uart";
+			reg = <0x40004800 0x400>;
+			interrupts = <39>;
+			status = "disabled";
+			clocks = <&rcc USART3_CK>;
+		};
+
+		uart4: serial@40004c00 {
+			compatible = "st,stm32h7-uart";
+			reg = <0x40004c00 0x400>;
+			interrupts = <52>;
+			status = "disabled";
+			clocks = <&rcc UART4_CK>;
+		};
+
 		i2c1: i2c@40005400 {
 			compatible = "st,stm32f7-i2c";
 			#address-cells = <1>;
@@ -368,6 +384,20 @@
 			max-frequency = <120000000>;
 		};
 
+		sdmmc2: mmc@48022400 {
+			compatible = "arm,pl18x", "arm,primecell";
+			arm,primecell-periphid = <0x10153180>;
+			reg = <0x48022400 0x400>;
+			interrupts = <124>;
+			interrupt-names	= "cmd_irq";
+			clocks = <&rcc SDMMC2_CK>;
+			clock-names = "apb_pclk";
+			resets = <&rcc STM32H7_AHB2_RESET(SDMMC2)>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
+			max-frequency = <120000000>;
+		};
+
 		exti: interrupt-controller@58000000 {
 			compatible = "st,stm32h7-exti";
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/stm32h750.dtsi b/arch/arm/boot/dts/stm32h750.dtsi
new file mode 100644
index 000000000000..dd9166223c2f
--- /dev/null
+++ b/arch/arm/boot/dts/stm32h750.dtsi
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/* Copyright (C) STMicroelectronics 2021 - All Rights Reserved */
+
+#include "stm32h743.dtsi"
+
diff --git a/arch/arm/boot/dts/stm32h750i-art-pi.dts b/arch/arm/boot/dts/stm32h750i-art-pi.dts
new file mode 100644
index 000000000000..7f8bf8679725
--- /dev/null
+++ b/arch/arm/boot/dts/stm32h750i-art-pi.dts
@@ -0,0 +1,228 @@
+/*
+ * Copyright 2021 - Dillon Min <dillon.minfei@gmail.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * For art-pi board resources, you can refer to link:
+ * 	https://art-pi.gitee.io/website/
+ */
+
+/dts-v1/;
+#include "stm32h750.dtsi"
+#include "stm32h750-pinctrl.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "RT-Thread STM32H750i-ART-PI board";
+	compatible = "st,stm32h750i-art-pi", "st,stm32h750";
+
+	chosen {
+		bootargs = "root=/dev/ram";
+		stdout-path = "serial0:2000000n8";
+	};
+
+	memory@c0000000 {
+		device_type = "memory";
+		reg = <0xc0000000 0x2000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			no-map;
+			size = <0x100000>;
+			linux,dma-default;
+		};
+	};
+
+	aliases {
+		serial0 = &uart4;
+		serial1 = &usart3;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-red {
+			gpios = <&gpioi 8 0>;
+		};
+		led-green {
+			gpios = <&gpioc 15 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	v3v3: regulator-v3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "v3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	wlan_pwr: regulator-wlan {
+		compatible = "regulator-fixed";
+
+		regulator-name = "wl-reg";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpioc 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&clk_hse {
+	clock-frequency = <25000000>;
+};
+
+&dma1 {
+	status = "okay";
+};
+
+&dma2 {
+	status = "okay";
+};
+
+&mac {
+	status = "disabled";
+	pinctrl-0	= <&ethernet_rmii>;
+	pinctrl-names	= "default";
+	phy-mode	= "rmii";
+	phy-handle	= <&phy0>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&sdmmc1 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
+	broken-cd;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&v3v3>;
+	status = "okay";
+};
+
+&sdmmc2 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc2_b4_pins_a>;
+	pinctrl-1 = <&sdmmc2_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a>;
+	broken-cd;
+	non-removable;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&wlan_pwr>;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	brcmf: bcrmf@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-0 = <&spi1_pins>;
+	pinctrl-names = "default";
+	cs-gpios = <&gpioa 4 GPIO_ACTIVE_LOW>;
+	dmas = <&dmamux1 37 0x400 0x05>,
+	       <&dmamux1 38 0x400 0x05>;
+	dma-names = "rx", "tx";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q128", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <80000000>;
+
+		partition@0 {
+			label = "root filesystem";
+			reg = <0 0x1000000>;
+		};
+	};
+};
+
+&usart2 {
+	pinctrl-0 = <&usart2_pins>;
+	pinctrl-names = "default";
+	status = "disabled";
+};
+
+&usart3 {
+	/delete-property/st,hw-flow-ctrl;
+	cts-gpios = <&gpiod 11 GPIO_ACTIVE_LOW>;
+	rts-gpios = <&gpiod 12 GPIO_ACTIVE_LOW>;
+	dmas = <&dmamux1 45 0x400 0x05>,
+	       <&dmamux1 46 0x400 0x05>;
+	dma-names = "rx", "tx";
+	status = "okay";
+
+	bluetooth {
+		host-wakeup-gpios = <&gpioc 0 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&gpioi 10 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpioi 11 GPIO_ACTIVE_HIGH>;
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <115200>;
+	};
+};
+
+&uart4 {
+	pinctrl-0 = <&uart4_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
-- 
2.7.4

