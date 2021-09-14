Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03A440A5E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 07:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbhINFWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 01:22:40 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:51082 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbhINFWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 01:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631596883; x=1663132883;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3soQi0wGvkkV/4g/5MUBAwvcwd+u3O8QELRrteHqQc8=;
  b=UDFjkAElxXH2FbWLTbvPbvDRZCkWCa46jxgeBvkz6vVdIUvlOE0HzFSz
   jsn9ieb7wl7aY18lyNlOlp5GPv2NzCFXEyO8p5GSWobImvlk3Jjc4K9B4
   XfOsQZF6Vb5cj+T6sKBCdjXbuQWJEGPvDeJ7Si5SsfPXYRrgIfclO+FPM
   BQ6/AxCuxtNWKW2YKBTJKGVj0kfMhxaFwBfdrjWX+26Yf1rGK3/vpWwTC
   IMwhAJzF9YgFEcx6ZHl7zb7vVZ1j5MmzfVdlJuHe5BB58X/3vuvgEEel8
   iyWBUEC7ztI0u+gMaCLwv6dOW57u20fLb9pcCgQvw6PV9Ul8Lj13jfdr7
   g==;
IronPort-SDR: YkxWtgnUTrET6EljaIWcNhy+lwz+6ODZyJ5iAQUcV7q1hBopV3j+kNnZRadiAyA2SHuS28BbxL
 jTiVTelxQe3HfATgtuI1oejnh50HSioPER5bJHyUROxWC9S6FkVnqaonZsqWYJzjC9/nSe7TJj
 GY6ChfiIM+ONNDM2LyOQh27oeoWVrWteKtwrmEOcp8jqesYaGHAQ3zo8lieEM4j3vlLp54XDHL
 z8L5y6DXIvfaaKsSqEE6e/46h1Ppi4zWToWtPKaWvNsG3GW5Ybp6LuTlEoyg3eGgdH78bNYw3D
 027XiYq8vI56gAcVk65RQGMm
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="143984321"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2021 22:21:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Sep 2021 22:21:22 -0700
Received: from CHE-LT-I66125LX.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 13 Sep 2021 22:21:17 -0700
From:   Durai Manickam KR <durai.manickamkr@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Hari.PrasathGE@microchip.com>
CC:     Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH] ARM: dts: at91-sama5d27_som1_ek: Added I2C bus recovery support
Date:   Tue, 14 Sep 2021 10:51:13 +0530
Message-ID: <20210914052113.85695-1-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDA and SCL is configured as GPIO for I2C bus to recover during
I2C bus malfunction.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi   | 12 ++++++++++-
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 23 +++++++++++++++++++--
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
index e3251f3e3eaa..edce6bcf6cd6 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
@@ -8,6 +8,7 @@
  */
 #include "sama5d2.dtsi"
 #include "sama5d2-pinfunc.h"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Atmel SAMA5D27 SoM1";
@@ -95,8 +96,11 @@ ethernet-phy@7 {
 
 			i2c0: i2c@f8028000 {
 				dmas = <0>, <0>;
-				pinctrl-names = "default";
+				pinctrl-names = "default", "gpio";
 				pinctrl-0 = <&pinctrl_i2c0_default>;
+				pinctrl-1 = <&pinctrl_i2c0_gpio>;
+				sda-gpios = <&pioA PIN_PD21 GPIO_ACTIVE_HIGH>;
+				scl-gpios = <&pioA PIN_PD22 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				status = "okay";
 
 				at24@50 {
@@ -113,6 +117,12 @@ pinctrl_i2c0_default: i2c0_default {
 					bias-disable;
 				};
 
+				pinctrl_i2c0_gpio: i2c0_gpio {
+					pinmux = <PIN_PD21__GPIO>,
+						 <PIN_PD22__GPIO>;
+					bias-disable;
+				};
+
 				pinctrl_qspi1_default: qspi1_default {
 					sck_cs {
 						pinmux = <PIN_PB5__QSPI1_SCK>,
diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index 614999dcb990..0f10e05d6e23 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -131,8 +131,11 @@ i2c3: i2c@600 {
 					i2c-analog-filter;
 					i2c-digital-filter;
 					i2c-digital-filter-width-ns = <35>;
-					pinctrl-names = "default";
+					pinctrl-names = "default", "gpio";
 					pinctrl-0 = <&pinctrl_mikrobus_i2c>;
+					pinctrl-1 = <&pinctrl_i2c3_gpio>;
+					sda-gpios = <&pioA PIN_PA24 GPIO_ACTIVE_HIGH>;
+					scl-gpios = <&pioA PIN_PA23 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 					status = "okay";
 				};
 			};
@@ -216,8 +219,11 @@ i2c1: i2c@fc028000 {
 				i2c-analog-filter;
 				i2c-digital-filter;
 				i2c-digital-filter-width-ns = <35>;
-				pinctrl-names = "default";
+				pinctrl-names = "default", "gpio";
 				pinctrl-0 = <&pinctrl_i2c1_default>;
+				pinctrl-1 = <&pinctrl_i2c1_gpio>;
+				sda-gpios = <&pioA PIN_PD4 GPIO_ACTIVE_HIGH>;
+				scl-gpios = <&pioA PIN_PD5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				status = "okay";
 			};
 
@@ -253,6 +259,13 @@ pinctrl_i2c1_default: i2c1_default {
 					bias-disable;
 				};
 
+				pinctrl_i2c1_gpio: i2c1_gpio {
+                                        pinmux = <PIN_PD4__GPIO>,
+                                                 <PIN_PD5__GPIO>;
+                                        bias-disable;
+                                };
+
+
 				pinctrl_isc_base: isc_base {
 					pinmux = <PIN_PC21__ISC_PCK>,
 						 <PIN_PC22__ISC_VSYNC>,
@@ -442,6 +455,12 @@ pinctrl_mikrobus_i2c: mikrobus1_i2c {
 					bias-disable;
 				};
 
+				pinctrl_i2c3_gpio: i2c3_gpio {
+					pinmux = <PIN_PA24__GPIO>,
+						 <PIN_PA23__GPIO>;
+					bias-disable;
+				};
+
 				pinctrl_flx4_default: flx4_uart_default {
 					pinmux = <PIN_PC28__FLEXCOM4_IO0>,
 						 <PIN_PC29__FLEXCOM4_IO1>,
-- 
2.25.1

