Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554643F7216
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbhHYJoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:44:04 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31134 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbhHYJoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629884597; x=1661420597;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qyh5WgATX9Xy0HOqROUyqu7EUpT8CmuQVGV9fQ0MnF8=;
  b=XTYtk2ZhjbVtIdPS4p66xIzaKczM2iirgmSva5jneRGunDxbQWtBQAjD
   /T37e96lbZPIOVb8Ee0AJ8mmCXQu4aVjHlF9ymwufACKDqB8rOp29gdQ5
   iQInpgjwKfAIhuZXLtpWUGVX4P9b2lee6RHxC7MAFWI9fZq6D42Fzwr5A
   cbPE4ZnhIUvhycsMtKQWXc2A4UGnoFJIMgNdtkf0yFbV9inzBpp+WO3nb
   gkPRPIZKPL0n4r31azhYx2Mlw2Y4+3lk9PnwH4bvRl6TYFNqQ+7pd4irq
   YC6R5euSKh1zLbwt7ZYSc5+PlzOpE31UdX/b97WutlUF+rt+vaWeIxO7m
   Q==;
IronPort-SDR: ixp3ZCRhTlN34kOJT6vexmzvrvaSckmpkQvhIkfBHtceC4NAJRRu0LxVaiNvtqCaQGlJEC3IYN
 L2k7OzylpXI8e4IfXXGR51cVEAnvuC8oYB6GnRuxwJslVj35HRFSQ6dOhCD3saewmlOrtT4aF6
 LF3Ap+fZuCoqw/sETVYZzaMoYF2HkAuPCEIxesstD9Zvul/VMr+8lf2hVii9nrC9iRMrPL3M86
 hDNSBU95F7avhxm4Nnh7owNjEr9lquLgxz98412nVdOHK7ulaYffUY8YaH/GMyy3kv7vk7YQaV
 V+cg7lkP1M5EV6+I2KpQ9ynE
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="scan'208";a="141504717"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2021 02:43:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 25 Aug 2021 02:43:16 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 25 Aug 2021 02:43:10 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4] ARM: dts: at91: sama5d27_wlsom1: add wifi device
Date:   Wed, 25 Aug 2021 12:40:55 +0300
Message-ID: <20210825094055.642941-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

SAMA5D27 WLSOM1 boards has a WILC3000 device soldered. Add proper
device tree nodes for this.

[eugen.hristev: original author of this code]
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
[nicolas.ferre: original author of this code]
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[claudiu.beznea: adapt such that make dtbs_check is happy, remove status
 for wifi_pwrseq and wifi nodes]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Changes in v4:
- keep only this patch as the rest from series were applied on mmc tree
- remove status="okay" on wifi node and pwrseq node
- adapt to remove all warnings thown by make dtbs_check

 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 70 +++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
index 025a78310e3a..21c86171e462 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
@@ -30,6 +30,14 @@ main_xtal {
 			clock-frequency = <24000000>;
 		};
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-wilc1000";
+		reset-gpios = <&pioA PIN_PA27 GPIO_ACTIVE_HIGH>;
+		powerdown-gpios = <&pioA PIN_PA29 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&pinctrl_wilc_pwrseq>;
+		pinctrl-names = "default";
+	};
 };
 
 &flx1 {
@@ -310,5 +318,67 @@ pinctrl_qspi1_default: qspi1_default {
 			 <PIN_PB10__QSPI1_IO3>;
 		bias-pull-up;
 	};
+
+	pinctrl_sdmmc1_default: sdmmc1_default {
+		cmd-data {
+			pinmux = <PIN_PA28__SDMMC1_CMD>,
+				 <PIN_PA18__SDMMC1_DAT0>,
+				 <PIN_PA19__SDMMC1_DAT1>,
+				 <PIN_PA20__SDMMC1_DAT2>,
+				 <PIN_PA21__SDMMC1_DAT3>;
+			bias-disable;
+		};
+
+		conf-ck {
+			pinmux = <PIN_PA22__SDMMC1_CK>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_wilc_default: wilc_default {
+		conf-irq {
+			pinmux = <PIN_PB25__GPIO>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_wilc_pwrseq: wilc_pwrseq {
+		conf-ce-nrst {
+			pinmux = <PIN_PA27__GPIO>,
+				 <PIN_PA29__GPIO>;
+			bias-disable;
+		};
+
+		conf-rtcclk {
+			pinmux = <PIN_PB13__PCK1>;
+			bias-disable;
+		};
+	};
+};
+
+&sdmmc1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdmmc1_default>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	no-1-8-v;
+	non-removable;
+	bus-width = <4>;
+	status = "okay";
+
+	wilc: wifi@0 {
+		reg = <0>;
+		compatible = "microchip,wilc1000";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wilc_default>;
+		clocks = <&pmc PMC_TYPE_SYSTEM 9>;
+		clock-names = "rtc";
+		interrupts = <PIN_PB25 IRQ_TYPE_NONE>;
+		interrupt-parent = <&pioA>;
+		assigned-clocks = <&pmc PMC_TYPE_SYSTEM 9>;
+		assigned-clock-rates = <32768>;
+	};
 };
 
-- 
2.25.1

