Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E673A412EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 08:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhIUGrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 02:47:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:55505 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhIUGrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 02:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632206754; x=1663742754;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o6lZk7/5WF5P0l2QkPxsSgucPRrvLaW9ltnagGvs3Ts=;
  b=nOrxSakIOFUsFuj9YihH/ubI/+iH3KOaIEsflIWeJiervmsy4wMCflpj
   n6+8PweNtpMRxEeuOGVIVhOJ+IXqEyfpu6Gyq4xY6/nLu8ykEnvnEPTBH
   Kmqjc/XZPegTDLMkdC0d6g6UZ4lXz3FaUrBX92ucvK8Qd6Bk9wUOj+mKy
   9ASl243UF/+ILfCiKOqbO2A3RvsR/D2Ek2/xicm8pUNGq3gunJ8oSYan/
   Ibq3zGxDyyIaSfbewiYwu52HI5SuL8KIZuxi6xpBvHkgQsliMDW+Ary18
   nk93z05mPaQx7K7tni4lMZjkwxDqju9Zlv3yLAH9FVbfOTscVDGX5bCIL
   w==;
IronPort-SDR: DvFRNCRS0JnYcPmGrGwhRYqvK+jLwSSmsjpBF40qA+m9JSVloxHKzWsfa//4BL8rQ0d7H4DHrU
 ey8NVXketEc6YwcLVZUq04XY8Pmj+I2S2qtEz0yphYMJ8E/IJ6kNVJCRuPwONJIXUBblFQvFFS
 6spEJ58exI5RFoJxjga6tobQUUKHb5Y7evTDJ4hDT70RlbCQzLvXAtzlLLdOuN77oqji3swl1n
 SDmDJdpUyue/fT0T1zTe1RK1y0ydvb3+d6riQwItU578LUvAbGInocKcsyboy4szKOmhrneAtY
 iaBvMqN68O8YqU4EUty9pzz+
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="144928458"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Sep 2021 23:45:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 20 Sep 2021 23:45:53 -0700
Received: from CHE-LT-I66125LX.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 20 Sep 2021 23:45:46 -0700
From:   Durai Manickam KR <durai.manickamkr@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Hari.PrasathGE@microchip.com>
CC:     Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH] ARM: dts: at91-sama5d2_icp.dts: Added I2C bus recovery support
Date:   Tue, 21 Sep 2021 12:13:44 +0530
Message-ID: <20210921064344.889304-1-durai.manickamkr@microchip.com>
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
 arch/arm/boot/dts/at91-sama5d2_icp.dts | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at91-sama5d2_icp.dts
index e06b58724ca8..806eb1d911d7 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -307,8 +307,11 @@ regulator-state-mem {
 };
 
 &i2c0 { /* mikrobus i2c */
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_mikrobus_i2c>;
+	pinctrl-1 = <&pinctrl_i2c0_gpio>;
+	sda-gpios = <&pioA PIN_PD21 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&pioA PIN_PD22 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	i2c-digital-filter;
 	i2c-digital-filter-width-ns = <35>;
 	status = "okay";
@@ -316,8 +319,11 @@ &i2c0 { /* mikrobus i2c */
 
 &i2c1 {
 	dmas = <0>, <0>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	sda-gpios = <&pioA PIN_PD19 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&pioA PIN_PD20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	i2c-digital-filter;
 	i2c-digital-filter-width-ns = <35>;
 	status = "okay";
@@ -402,6 +408,12 @@ pinctrl_i2c1_default: i2c1_default {
 		bias-disable;
 	};
 
+	pinctrl_i2c1_gpio: i2c1_gpio {
+                pinmux = <PIN_PD19__GPIO>,
+                         <PIN_PD20__GPIO>;
+                bias-disable;
+        };
+
 	pinctrl_key_gpio_default: key_gpio_default {
 		pinmux = <PIN_PD0__GPIO>;
 		bias-pull-up;
@@ -463,6 +475,12 @@ pinctrl_mikrobus_i2c: mikrobus_i2c {
 		bias-disable;
 	};
 
+	pinctrl_i2c0_gpio: i2c0_gpio {
+		pinmux = <PIN_PD21__GPIO>,
+			 <PIN_PD22__GPIO>;
+		bias-disable;
+	};
+
 	pinctrl_mikrobus1_an: mikrobus1_an {
 		pinmux = <PIN_PD26__GPIO>;
 		bias-disable;
-- 
2.25.1

