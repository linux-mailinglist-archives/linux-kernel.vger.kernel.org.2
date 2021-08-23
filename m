Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F643F482C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhHWKE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:04:57 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:33605 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbhHWKEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629713049; x=1661249049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VPtEntSKUmsBLiUgCDjEWvMqyP1hc6tx5lqticdHoTY=;
  b=BayyDLQdSpFvl1rU85mwxo0LNC9lSfuYt3r3EVtK2eBUo8cTAGFalW74
   +9Gkc0d1hBjDpmjMwU9253Bb237Bk9N0+I4amOV34ipSyZHM8kYbW+mok
   PFDVemmJ3xDrkWns8O3C3sZKw/cTLWy2zecPw8+s6VIQ7QBt4vzZl2ZUL
   C8i5VG2TXh+6ugzLl2HBmit1z5CE657+Ad9hgjNsQT6256f6mHpgUb3ly
   eo7kJvnLYIlnChuSJlqVWODq1CLL4KKGCMtvmdjEAt0pAwNtDLGrqo7qf
   SufcOhAed1jr5wtxoncoGp4HK82UGzmPiw2Vge7pnHpbiUEwfG8dsTqCe
   g==;
IronPort-SDR: GCvNjDdW5E3TwLI3gKxYo5kf7ILXxF89Nbd7Q4bKmAIOxTRSl+mqYRmRE9u1rQLZ7KXQqiSxrS
 w1n7iS7MtzwIYOeBCrzohI3cNQQ6Ye4dtTINAQja13g+y4Vg2dTFfR0bT8XdaguKsB22lQzRhu
 Uusa/nd8r9+YPR3f2xqvQA4n5TykJOsAT12+CBxp5wumKSYZvu0rAdwtWc7CCP2o/aN1hHFSCU
 TMkgmPFaDaZmc0Mewm6Oc06tx61A61NGGN6GeFUtHzHk2GUAgLEVKTcM5kgwiratiuegaEHXf7
 NDF94GaULI3qVtScmkC+P3BI
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="129220870"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2021 03:04:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 23 Aug 2021 03:04:08 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 23 Aug 2021 03:04:06 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] ARM: dts: at91: add bindings for shdwc
Date:   Mon, 23 Aug 2021 13:03:56 +0300
Message-ID: <20210823100356.22206-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210823100356.22206-1-claudiu.beznea@microchip.com>
References: <20210823100356.22206-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for shutdown controller and enable it.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama7g5ek.dts |  9 +++++++++
 arch/arm/boot/dts/sama7g5.dtsi       | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index 4cbed98cc2f4..8b13b031a167 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -634,6 +634,15 @@ &sdmmc2 {
 	pinctrl-0 = <&pinctrl_sdmmc2_default>;
 };
 
+&shdwc {
+	atmel,shdwc-debouncer = <976>;
+	status = "okay";
+
+	input@0 {
+		reg = <0>;
+	};
+};
+
 &spdifrx {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_spdifrx_default>;
diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index 3a4315ac0eb0..e50806cf7660 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -122,6 +122,17 @@ pmc: pmc@e0018000 {
 			clock-names = "td_slck", "md_slck", "main_xtal";
 		};
 
+		shdwc: shdwc@e001d010 {
+			compatible = "microchip,sama7g5-shdwc", "syscon";
+			reg = <0xe001d010 0x10>;
+			clocks = <&clk32k 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			atmel,wakeup-rtc-timer;
+			atmel,wakeup-rtt-timer;
+			status = "disabled";
+		};
+
 		rtt: rtt@e001d020 {
 			compatible = "microchip,sama7g5-rtt", "microchip,sam9x60-rtt", "atmel,at91sam9260-rtt";
 			reg = <0xe001d020 0x30>;
-- 
2.25.1

