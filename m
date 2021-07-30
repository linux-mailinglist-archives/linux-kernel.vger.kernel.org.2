Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57F53DBDAF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 19:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhG3R1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 13:27:52 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:34449 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhG3R1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 13:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1627666065; x=1659202065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=222i4rwJ8kye2GQ1RI7paRWBjvdM//GLJf/iWez9ZL4=;
  b=QG+agjaRN1KO/GeiZgWGoZT5ZOUipcOIeRto6u5wvXLwJcOqqMuQA8h5
   W3PO2OlKvgMB1QmIveDvTumnokEJ2ph/XaP5C5OwLsTvJnMulOYciiWRO
   CddrZnucW7LlvMOPt4flyFLJjufsexD6uXTkPUUazGBWq54qUwABde523
   pql5fQA2tBXDHgqeCmvtP6fJDtJYpRc0NOd1unGpLRs9ZaZgPq6YBMOOz
   Vwzs4u8MofAPwfIJ9MJrxORdQozaEri7dpDZNIyaxUciEfrSgeTkBL2Bi
   nDwnrkDx0MLVE4wGTxNeBAArVx5tvW/vDUxxuH3y36g5aEFAEU9SusAff
   Q==;
IronPort-SDR: UO2zf8wiEgOMxM1waSYPhEgi6X/AIxcndlRFkVYzosrlVoCJNdwc07DqwT6il8n13T6fJGafj/
 SJMvk31DLw21q1oM6Zge/r4XAj7IV9HUrWxofefnBZb56j3biOqY2PcvjTG9TWoU9Eja8DZdlv
 +kOJDiAKAV9TMT77LabBN9OVo2UIWrpWvUY6151G8f4+ll9aZdlL8lPC5xMq37fdD2GgV3gk/p
 miOJ800EQG02EUFzf6M+jkOim4MFzLccqZJ2p7kZseqndSveZ0TjzFpDp0v3o0WXtMsS1Uvsrf
 IHNJhwJN8NRwosRYFA5+B/Ys
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="138192147"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jul 2021 10:27:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Jul 2021 10:27:45 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 30 Jul 2021 10:27:43 -0700
From:   <nicolas.ferre@microchip.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <clement.leger@bootlin.com>, <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] ARM: dts: at91: use the right property for shutdown controller
Date:   Fri, 30 Jul 2021 19:27:29 +0200
Message-ID: <20210730172729.28093-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

The wrong property "atmel,shdwc-debouncer" was used to specify the
debounce delay for the shutdown controler. Replace it with the
documented and implemented property "debounce-delay-us", as mentioned
in v4 driver submission. See:
https://lore.kernel.org/linux-arm-kernel/1458134390-23847-3-git-send-email-nicolas.ferre@atmel.com/

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Reported-by: Clément Léger <clement.leger@bootlin.co
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-kizbox3_common.dtsi    | 2 +-
 arch/arm/boot/dts/at91-sam9x60ek.dts          | 2 +-
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts   | 2 +-
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts | 2 +-
 arch/arm/boot/dts/at91-sama5d2_icp.dts        | 2 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts     | 2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox3_common.dtsi b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
index c4b3750495da..abe27adfa4d6 100644
--- a/arch/arm/boot/dts/at91-kizbox3_common.dtsi
+++ b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
@@ -336,7 +336,7 @@ &pwm0 {
 };
 
 &shutdown_controller {
-	atmel,shdwc-debouncer = <976>;
+	debounce-delay-us = <976>;
 	atmel,wakeup-rtc-timer;
 
 	input@0 {
diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index ebbc9b23aef1..b1068cca4228 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -662,7 +662,7 @@ &rtt {
 };
 
 &shutdown_controller {
-	atmel,shdwc-debouncer = <976>;
+	debounce-delay-us = <976>;
 	status = "okay";
 
 	input@0 {
diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index 261a7dbcfdee..614999dcb990 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -138,7 +138,7 @@ i2c3: i2c@600 {
 			};
 
 			shdwc@f8048010 {
-				atmel,shdwc-debouncer = <976>;
+				debounce-delay-us = <976>;
 				atmel,wakeup-rtc-timer;
 
 				input@0 {
diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
index ff83967fd008..c145c4e5ef58 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
@@ -205,7 +205,7 @@ &sdmmc0 {
 };
 
 &shutdown_controller {
-	atmel,shdwc-debouncer = <976>;
+	debounce-delay-us = <976>;
 	atmel,wakeup-rtc-timer;
 
 	input@0 {
diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at91-sama5d2_icp.dts
index 1c235fc5f788..e06b58724ca8 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -699,7 +699,7 @@ &sdmmc0 {
 };
 
 &shutdown_controller {
-	atmel,shdwc-debouncer = <976>;
+	debounce-delay-us = <976>;
 	atmel,wakeup-rtc-timer;
 
 	input@0 {
diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
index dfd150eb0fd8..3f972a4086c3 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -203,7 +203,7 @@ i2c2: i2c@600 {
 			};
 
 			shdwc@f8048010 {
-				atmel,shdwc-debouncer = <976>;
+				debounce-delay-us = <976>;
 
 				input@0 {
 					reg = <0>;
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 509c732a0d8b..627b7bf88d83 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -347,7 +347,7 @@ i2c2: i2c@600 {
 			};
 
 			shdwc@f8048010 {
-				atmel,shdwc-debouncer = <976>;
+				debounce-delay-us = <976>;
 				atmel,wakeup-rtc-timer;
 
 				input@0 {
-- 
2.32.0

