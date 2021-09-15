Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7098F40C0D6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhIOHue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:50:34 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:39390 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbhIOHuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631692135; x=1663228135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kPCGV8DIG1G0UlXqDVvdKWo8Ofqa09/5ZQfY3r2xBcM=;
  b=OXTyYSlAFiE5qM4DRjlYtk5MZucNzHj0ToFbaz5PxkFkmVDMhtE9CKqZ
   GoGIu9u7woBM13an1t4AbbIzeBskhHnuvXjyOOcn/GXXIelA75GQfaPXS
   PQYujzwiHywwKDvrU8PXroNQvaAK49ZsJizu8cJmH3WzoSvDXPbd+XNjC
   UpfBdi0273ugnwHquTN/rIURPJp2hHYQ8m3+9vvHzmUwtD/Xg40m14TjF
   9yN3viyKYZAyGUR4OBJJX1Y3wPjzVe4Op457K5FTB6+JPxJ5MUlUqZps8
   QszUBQHFGVkfueht/aSj3FFjbCuuSxh1PTitR6uF2oYLIy64J/enB5EO3
   g==;
IronPort-SDR: 1BpRbL4QaNW4NAHdpfeyOpWDhIBjBEO0tem4jpljT2iaHgPsfBsBa9VZ8zQcSlgBpsHBTypOa+
 PTjTFVn5QX9QckV9SRNrogiQtDFa937XzP88cOPOjZfxZ/JT0qbyAlu2cpqs+oSaTbEZBAl4P9
 awOOpx0nye2SZOWGoJiiAI5SgDrlg8sn7AEa8mds0smW6AtSwFYpPsO+kp5dnKUxyPds5LHzY6
 4KeYjvx8wVzI23gPeRfDgV+WGZqWD2xRxvLYDhx3SofdLLjiWqguBiI9wldK+Ds/yJoe4027cD
 MEYtZtZgJ9gA559sTO/4YKn2
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="136600228"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2021 00:48:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 15 Sep 2021 00:48:54 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 15 Sep 2021 00:48:52 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] ARM: dts: at91: sama7g5ek: to not touch slew-rate for SDMMC pins
Date:   Wed, 15 Sep 2021 10:48:36 +0300
Message-ID: <20210915074836.6574-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210915074836.6574-1-claudiu.beznea@microchip.com>
References: <20210915074836.6574-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit c709135e576b ("pinctrl: at91-pio4: add support for slew-rate")
and commit cbde6c823bfa ("pinctrl: at91-pio4: Fix slew rate disablement")
the slew-rate is enabled by default for each configured pin. The datasheet
specifies at chapter "Output Driver AC Characteristics" that HSIO
drivers (use in SDMMCx and QSPI0 peripherals), don't have a slewrate
setting but are rather calibrated against an external 1% resistor mounted
on the SDMMCx_CAL or QSPI0_CAL pins. Depending on the target signal
frequency and the external load, it is possible to adjust their target
output impedance. Thus set slew-rate = <0> for SDMMC (QSPI is not enabled
at the moment in device tree).

Fixes: 7540629e2fc7 ("ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama7g5ek.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index 0bed8207d498..624162fec223 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -556,6 +556,7 @@ cmd_data {
 				 <PIN_PA8__SDMMC0_DAT5>,
 				 <PIN_PA9__SDMMC0_DAT6>,
 				 <PIN_PA10__SDMMC0_DAT7>;
+			slew-rate = <0>;
 			bias-pull-up;
 		};
 
@@ -563,6 +564,7 @@ ck_cd_rstn_vddsel {
 			pinmux = <PIN_PA0__SDMMC0_CK>,
 				 <PIN_PA2__SDMMC0_RSTN>,
 				 <PIN_PA11__SDMMC0_DS>;
+			slew-rate = <0>;
 			bias-pull-up;
 		};
 	};
@@ -574,6 +576,7 @@ cmd_data {
 				 <PIN_PC0__SDMMC1_DAT1>,
 				 <PIN_PC1__SDMMC1_DAT2>,
 				 <PIN_PC2__SDMMC1_DAT3>;
+			slew-rate = <0>;
 			bias-pull-up;
 		};
 
@@ -582,6 +585,7 @@ ck_cd_rstn_vddsel {
 				 <PIN_PB28__SDMMC1_RSTN>,
 				 <PIN_PC5__SDMMC1_1V8SEL>,
 				 <PIN_PC4__SDMMC1_CD>;
+			slew-rate = <0>;
 			bias-pull-up;
 		};
 	};
@@ -593,11 +597,13 @@ cmd_data {
 				 <PIN_PD6__SDMMC2_DAT1>,
 				 <PIN_PD7__SDMMC2_DAT2>,
 				 <PIN_PD8__SDMMC2_DAT3>;
+			slew-rate = <0>;
 			bias-pull-up;
 		};
 
 		ck {
 			pinmux = <PIN_PD4__SDMMC2_CK>;
+			slew-rate = <0>;
 			bias-pull-up;
 		};
 	};
-- 
2.25.1

