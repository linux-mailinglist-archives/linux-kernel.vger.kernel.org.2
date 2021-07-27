Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B193D7085
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbhG0HmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:42:21 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:11440 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbhG0HmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1627371738; x=1658907738;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YYqCnUFjfxdKkesvNpfb8fe1gg3NvBlJiLkJdWQ+NZQ=;
  b=02s1f90gBgv9uuOuIxUbI+6KLljvJQi+0mHOh+S86oldAzn5ClxXw+w7
   24jM+tOE7xWr1sk+I6Qx1jsD7n/5TnTnqLMO8rEhIpme3PWTWfcrllLSq
   WpMZz7hk4/WCiWHUMY41LQQUdwQj3Apxgn+xdyOKMOyS+lxPt0Q+aERcp
   EH4OlKLgm6IsXruqA/lQyKH2IIxHg+kwanShCFk+s6DwA7P/yVLu3U7wM
   XNk8salSKGsHXaHqrZ7XoZoA3vV5bXSiDyoA5vnI9UdhBXY+rOpsSGI2O
   952ik54iiyfMoYOSfeeqZn9LSvWAQVt21yrMrYPUt9F9hABrYCreSsAb/
   g==;
IronPort-SDR: iNf23HBFIBFkVWID/WifE91v1Y/k1itGUwN/CE56YAHScu8lkUrO01Uj4lo8irmWJwMkcJA9S0
 cW3Zr9gUHrgCYVAesIEHq9lUifXsqq0GVTxxAE+NUioHPljVEClh4xtn3wfaSgRSBiOnVkGyFp
 j4A9oelWxo8tWqsQM+lTurmezznBqg0k5Otzto1LmBqnJ6+4XAyBU2NL2TsuKMvD+XXsFsBMjm
 tz+octaKlVsd7arQPOs/aNE6S0IAZMONwoCBkmC03wIY+Wn0M78T1SqgkUp4q91oU6f9WzQEbe
 4NVlW0I03Gd+5yNw2rJ579i/
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="126068669"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2021 00:42:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 00:42:12 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Jul 2021 00:42:09 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/2] ARM: dts: at91: add pinctrl-{names, 0} for all gpios
Date:   Tue, 27 Jul 2021 10:40:05 +0300
Message-ID: <20210727074006.1609989-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl-names and pinctrl-0 properties on controllers that claims to
use pins to avoid failures due to
commit 2ab73c6d8323 ("gpio: Support GPIO controllers without pin-ranges")
and also to avoid using pins that may be claimed my other IPs.

Fixes: b7c2b6157079 ("ARM: at91: add Atmel's SAMA5D3 Xplained board")
Fixes: 1e5f532c2737 ("ARM: dts: at91: sam9x60: add device tree for soc and board")
Fixes: 38153a017896 ("ARM: at91/dt: sama5d4: add dts for sama5d4 xplained
board")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts        | 16 +++++++++++-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 29 +++++++++++++++++++++
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 19 ++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index edca66c232c1..ebbc9b23aef1 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -92,6 +92,8 @@ sw1 {
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
 		status = "okay"; /* Conflict with pwm0. */
 
 		red {
@@ -537,6 +539,10 @@ AT91_PIOA 18 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_H
 				 AT91_PIOA 19 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA19 DAT2 periph A with pullup */
 				 AT91_PIOA 20 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)>;	/* PA20 DAT3 periph A with pullup */
 		};
+		pinctrl_sdmmc0_cd: sdmmc0_cd {
+			atmel,pins =
+				<AT91_PIOA 23 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
 	};
 
 	sdmmc1 {
@@ -569,6 +575,14 @@ pinctrl_usb_default: usb_default {
 				      AT91_PIOD 16 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
 		};
 	};
+
+	leds {
+		pinctrl_gpio_leds: gpio_leds {
+			atmel,pins = <AT91_PIOB 11 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				      AT91_PIOB 12 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				      AT91_PIOB 13 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
 }; /* pinctrl */
 
 &pwm0 {
@@ -580,7 +594,7 @@ &pwm0 {
 &sdmmc0 {
 	bus-width = <4>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sdmmc0_default>;
+	pinctrl-0 = <&pinctrl_sdmmc0_default &pinctrl_sdmmc0_cd>;
 	status = "okay";
 	cd-gpios = <&pioA 23 GPIO_ACTIVE_LOW>;
 	disable-wp;
diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index 9c55a921263b..cc55d1684322 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -57,6 +57,8 @@ slot@0 {
 			};
 
 			spi0: spi@f0004000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_spi0_cs>;
 				cs-gpios = <&pioD 13 0>, <0>, <0>, <&pioD 16 0>;
 				status = "okay";
 			};
@@ -169,6 +171,8 @@ slot@0 {
 			};
 
 			spi1: spi@f8008000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_spi1_cs>;
 				cs-gpios = <&pioC 25 0>;
 				status = "okay";
 			};
@@ -248,6 +252,26 @@ pinctrl_usb_default: usb_default {
 							<AT91_PIOE 3 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
 							 AT91_PIOE 4 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
 					};
+
+					pinctrl_gpio_leds: gpio_leds_default {
+						atmel,pins =
+							<AT91_PIOE 23 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+							 AT91_PIOE 24 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_spi0_cs: spi0_cs_default {
+						atmel,pins =
+							<AT91_PIOD 13 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+							 AT91_PIOD 16 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_spi1_cs: spi1_cs_default {
+						atmel,pins = <AT91_PIOC 25 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_vcc_mmc0_reg_gpio: vcc_mmc0_reg_gpio_default {
+						atmel,pins = <AT91_PIOE 2 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+					};
 				};
 			};
 		};
@@ -339,6 +363,8 @@ rootfs@800000 {
 
 	vcc_mmc0_reg: fixedregulator_mmc0 {
 		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_vcc_mmc0_reg_gpio>;
 		gpio = <&pioE 2 GPIO_ACTIVE_LOW>;
 		regulator-name = "mmc0-card-supply";
 		regulator-min-microvolt = <3300000>;
@@ -362,6 +388,9 @@ bp3 {
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+		status = "okay";
 
 		d2 {
 			label = "d2";
diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index 046796c5b9b0..541779af049f 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -80,6 +80,8 @@ usart4: serial@fc010000 {
 			};
 
 			spi1: spi@fc018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_spi0_cs>;
 				cs-gpios = <&pioB 21 0>;
 				status = "okay";
 			};
@@ -137,6 +139,19 @@ pinctrl_macb0_phy_irq: macb0_phy_irq_0 {
 						atmel,pins =
 							<AT91_PIOE 1 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
 					};
+					pinctrl_spi0_cs: spi0_cs_default {
+						atmel,pins =
+							<AT91_PIOB 21 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+					};
+					pinctrl_gpio_leds: gpio_leds_default {
+						atmel,pins =
+							<AT91_PIOD 30 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+							 AT91_PIOE 15 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+					};
+					pinctrl_vcc_mmc1_reg: vcc_mmc1_reg {
+						atmel,pins =
+							<AT91_PIOE 4 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+					};
 				};
 			};
 		};
@@ -242,6 +257,8 @@ pb_user1 {
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
 		status = "okay";
 
 		d8 {
@@ -268,6 +285,8 @@ vcc_3v3_reg: fixedregulator_3v3 {
 
 	vcc_mmc1_reg: fixedregulator_mmc1 {
 		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_vcc_mmc1_reg>;
 		gpio = <&pioE 4 GPIO_ACTIVE_LOW>;
 		regulator-name = "VDD MCI1";
 		regulator-min-microvolt = <3300000>;
-- 
2.25.1

