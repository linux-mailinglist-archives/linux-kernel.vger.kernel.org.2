Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A924F352AE7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbhDBNCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:02:45 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16627 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbhDBNCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617368560; x=1648904560;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6TjwPj4SzTNtVIpweM1f0V6N7SUtRRTpjvX6dFNC7QA=;
  b=Li10EeGMZxDxuzG+I+2a/BTOxHP/b+A5dH0i6FqKU9ZA7xsT2GUT4B2a
   HpzE2+9yyvoSWyZNTc9UwwVNREQCPQ9KT8HZjLTsMewxFDmH1NMcu2D14
   nvIWuLaMhC3oxa8YCH8GKs2dEwEv7+k61pWvoE+/7c9EoR5ulM9OfZRHg
   KZ0suT1C/9OL1QNBeHHEYBQrilgUTrZLeYafOvKpqH1xDSmqELvGVKBUa
   psIEVrvFNJUPrxmAcnAUo6Qzhlb6vlmnFY5jRGocIgA2Q6xhs6lQm57zI
   0w4JT/js8tYq74pugjYGu64cRT8ZjZNHiCRLKr+2Udsz33ijPUsrw+JHN
   w==;
IronPort-SDR: s6pqj+lqagx542ZyXo8ev9h41bYH66qhj/cJ/BhueU5srCSuGX0OYPl96qVwV9Xpi94BFCXS/D
 /BVb3ulE0GlN7avrRo6hN7bRCj9dklr1P8fd2rS3JSfnRz6TblD4tRVvzFfMEw3WhEuEqlqktP
 5N6ekhs5Rzsc+NlD8pg+5jGLPEuebxk4j9/cp6OfMQIXbrMI93Ec7OGZX9+ZTpQIhYYu3tg6QG
 ufvRDPxZRdHuAK+tuv43f0Af+DGOIPR+nnZqZwlcU9CChhZiUuf6UJKET0plFTQLsiqz9Rz6Rf
 biI=
X-IronPort-AV: E=Sophos;i="5.81,299,1610434800"; 
   d="scan'208";a="109472935"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Apr 2021 06:02:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Apr 2021 06:02:39 -0700
Received: from ness.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 2 Apr 2021 06:02:38 -0700
From:   <nicolas.ferre@microchip.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: dts: at91: change the key code of the gpio key
Date:   Fri, 2 Apr 2021 15:02:27 +0200
Message-ID: <20210402130227.21478-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches@microchip.com>

Having a button code and not a key code causes issues with libinput.
udev won't set ID_INPUT_KEY. If it is forced, then it causes a bug
within libinput.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts          | 3 ++-
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts   | 3 ++-
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts | 3 ++-
 arch/arm/boot/dts/at91-sama5d2_icp.dts        | 3 ++-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts     | 3 ++-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts   | 3 ++-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts   | 3 ++-
 arch/arm/boot/dts/at91sam9260ek.dts           | 3 ++-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi   | 3 ++-
 9 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index 73b6b1f89de9..f68284cdff54 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -8,6 +8,7 @@
  */
 /dts-v1/;
 #include "sam9x60.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Microchip SAM9X60-EK";
@@ -84,7 +85,7 @@ gpio_keys {
 		sw1 {
 			label = "SW1";
 			gpios = <&pioD 18 GPIO_ACTIVE_LOW>;
-			linux,code=<0x104>;
+			linux,code=<KEY_PROG1>;
 			wakeup-source;
 		};
 	};
diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index 84e1180f3e89..a9e6fee55a2a 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -11,6 +11,7 @@
 #include "at91-sama5d27_som1.dtsi"
 #include <dt-bindings/mfd/atmel-flexcom.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Atmel SAMA5D27 SOM1 EK";
@@ -466,7 +467,7 @@ gpio_keys {
 		pb4 {
 			label = "USER";
 			gpios = <&pioA PIN_PA29 GPIO_ACTIVE_LOW>;
-			linux,code = <0x104>;
+			linux,code = <KEY_PROG1>;
 			wakeup-source;
 		};
 	};
diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
index 180a08765cb8..ff83967fd008 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
@@ -8,6 +8,7 @@
  */
 /dts-v1/;
 #include "at91-sama5d27_wlsom1.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Microchip SAMA5D27 WLSOM1 EK";
@@ -35,7 +36,7 @@ gpio_keys {
 		sw4 {
 			label = "USER BUTTON";
 			gpios = <&pioA PIN_PB2 GPIO_ACTIVE_LOW>;
-			linux,code = <0x104>;
+			linux,code = <KEY_PROG1>;
 			wakeup-source;
 		};
 	};
diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at91-sama5d2_icp.dts
index 46722a163184..bd64721fa23c 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -12,6 +12,7 @@
 #include "sama5d2.dtsi"
 #include "sama5d2-pinfunc.h"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/mfd/atmel-flexcom.h>
 
 / {
@@ -51,7 +52,7 @@ gpio_keys {
 		sw4 {
 			label = "USER_PB1";
 			gpios = <&pioA PIN_PD0 GPIO_ACTIVE_LOW>;
-			linux,code = <0x104>;
+			linux,code = <KEY_PROG1>;
 			wakeup-source;
 		};
 	};
diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
index 8de57d164acd..dfd150eb0fd8 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -11,6 +11,7 @@
 #include "sama5d2-pinfunc.h"
 #include <dt-bindings/mfd/atmel-flexcom.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/at91.h>
 
 / {
@@ -402,7 +403,7 @@ gpio_keys {
 		bp1 {
 			label = "PB_USER";
 			gpios = <&pioA PIN_PA10 GPIO_ACTIVE_LOW>;
-			linux,code = <0x104>;
+			linux,code = <KEY_PROG1>;
 			wakeup-source;
 		};
 	};
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 4e7cf21f124c..509c732a0d8b 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -10,6 +10,7 @@
 #include "sama5d2-pinfunc.h"
 #include <dt-bindings/mfd/atmel-flexcom.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/regulator/active-semi,8945a-regulator.h>
 
 / {
@@ -712,7 +713,7 @@ gpio_keys {
 		bp1 {
 			label = "PB_USER";
 			gpios = <&pioA PIN_PB9 GPIO_ACTIVE_LOW>;
-			linux,code = <0x104>;
+			linux,code = <KEY_PROG1>;
 			wakeup-source;
 		};
 	};
diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index 5179258f9247..9c55a921263b 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -7,6 +7,7 @@
  */
 /dts-v1/;
 #include "sama5d36.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "SAMA5D3 Xplained";
@@ -354,7 +355,7 @@ gpio_keys {
 		bp3 {
 			label = "PB_USER";
 			gpios = <&pioE 29 GPIO_ACTIVE_LOW>;
-			linux,code = <0x104>;
+			linux,code = <KEY_PROG1>;
 			wakeup-source;
 		};
 	};
diff --git a/arch/arm/boot/dts/at91sam9260ek.dts b/arch/arm/boot/dts/at91sam9260ek.dts
index d3446e42b598..ce96345d28a3 100644
--- a/arch/arm/boot/dts/at91sam9260ek.dts
+++ b/arch/arm/boot/dts/at91sam9260ek.dts
@@ -7,6 +7,7 @@
  */
 /dts-v1/;
 #include "at91sam9260.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Atmel at91sam9260ek";
@@ -156,7 +157,7 @@ btn3 {
 		btn4 {
 			label = "Button 4";
 			gpios = <&pioA 31 GPIO_ACTIVE_LOW>;
-			linux,code = <0x104>;
+			linux,code = <KEY_PROG1>;
 			wakeup-source;
 		};
 	};
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index 6e6e672c0b86..87bb39060e8b 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -5,6 +5,7 @@
  * Copyright (C) 2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
  */
 #include "at91sam9g20.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 
@@ -234,7 +235,7 @@ btn3 {
 		btn4 {
 			label = "Button 4";
 			gpios = <&pioA 31 GPIO_ACTIVE_LOW>;
-			linux,code = <0x104>;
+			linux,code = <KEY_PROG1>;
 			wakeup-source;
 		};
 	};
-- 
2.31.1

