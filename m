Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2805A3F4B98
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbhHWNUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:20:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:3607 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237413AbhHWNUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629724776; x=1661260776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hXKewkY3I5EwIJrxw8uwLa2pmaIf9I3+13mak8dkkWs=;
  b=Tv7SWmVStK5RaLXp+VJMCZhEfmFGTWFn2MnWoYDDV9W7dAeRTM/T2rjT
   FwKGarnZeSjFmqyXIRAHNlhG+3LnffCcBY/riaAaxEC7E4cKUxHzcWBKA
   8ius8Yr6mNqSEJ0IRaNckkNuEg15B10IsW78mQ+mCkBK24PwKvkxDvwU7
   d/7BASre+mM3GVaHJOST+L3jDJ6bZo/XYx0luJjqo1Un8D9Y6a0GhkUvT
   CGGUu9TpCzM2N0djNybSxQgav5zMHMtx3zhB3UznhCL5hbRtO80d3CiMP
   W+gsgi5OmTXF6r26BcvY/KiNesp6hGZo8Wp4PiM9DzHAW5Jl9w3HzhMVc
   Q==;
IronPort-SDR: LHPG1INUjLfWYeFnBcqoM/60j6oFKLYLCY7cCF2ay5xroGu03OZ5bRfAVXbi9qIz62cc7df8i8
 TUAiyh/shREtrZEqK3xSAVjKnaXqBo/ffiKRqHjZG4J3m70aJHZvQSIuinUiS6aCkFb3tmk2mm
 g0aZtsjIR+njEZNHowVHDgvkY5/gauY27TUVVr+JYI18w45XkHHUYfNTrdq/OuecObtMrMR0i0
 AWqOLBCjCm4aQ24XoDDwCOcRQjxpvr+5+lFjPD6PQMgGGwjftAkz8mJ7gcNCvMd1MmtQJA2Lfx
 QT94oaXm7no3u2WrBBCTTmkV
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="126756936"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2021 06:19:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 23 Aug 2021 06:19:35 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 23 Aug 2021 06:19:32 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 4/4] ARM: dts: at91: sama7g5: add shdwc node
Date:   Mon, 23 Aug 2021 16:19:15 +0300
Message-ID: <20210823131915.23857-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210823131915.23857-1-claudiu.beznea@microchip.com>
References: <20210823131915.23857-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add shutdown controller node and enable it.

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

