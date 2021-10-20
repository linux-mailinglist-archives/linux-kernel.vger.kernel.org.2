Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735E6434837
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhJTJtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:49:47 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:58600 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhJTJt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634723233; x=1666259233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CABlwbLXag53VSb8b75PX018uNHhjQZnUI8U01hO3aM=;
  b=JkzKV0rP7dNIh8RfbAMvRjVptZAajKvOAqjLw9L7WIBRZP5DEQeWJZmA
   zLEOga9+djBAWfYSWL7j6pOADVOK1Q03844E+tZkB5s9HD/AdSh9h5Tai
   n3jB6apahaR9PpQnbO9reBTsABjLY05SyQP+pf/MHUcgo8FTDVJhk8OmD
   bMENmBLgCE7DLMr+q+w4WbldpXFnSZDp6urnXKHnEi9zK27TtOsmJx4ga
   EHu32twaXN3RTb8r5ywtPbTlbi881rs57WVwvuH+Lg5YDXRpSXgGwtJB5
   omIZKSAk/ZrIMPy3efMhvwDkTbpHc62VyeZU4v7+jbpryAaNH1WrvLK4t
   Q==;
IronPort-SDR: 2lTc3CMbMaWacjjRePtzdXvv2x2DR9iuEbJwWF976KKn/MSF/Z6+/yaYXyy7i3uhnzEl5QnO18
 ofDXlD5r+sdenn6rig4EWK+7qJJh7n7UkmovP7Bqi+r7xuMu9feeMsC+h1uSqDZ+hMmsd+hFtm
 acjlEXm1lP/nwGt08ytPof60ghUhtLu98UE1q5zGhPzVfJ4s4Yxv5WVU6ZOtV6rOYmpFkj1ueF
 pV+OwcV9aAhcdwpL+dUJ86PYDG8irwQmXR8IF/AmknshMMLxuSSg+LXNQfMaYXZDA5jTFdJxQN
 x5FMvtZhY5oyBzWExXr1Gp7e
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="133739620"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Oct 2021 02:47:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Oct 2021 02:47:12 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Oct 2021 02:47:10 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/3] ARM: dts: at91: sama7g5: add tcb nodes
Date:   Wed, 20 Oct 2021 12:46:55 +0300
Message-ID: <20211020094656.3343242-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211020094656.3343242-1-claudiu.beznea@microchip.com>
References: <20211020094656.3343242-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TCB nodes.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index e16a337fd100..b6ebfceaa78b 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -166,6 +166,16 @@ ps_wdt: watchdog@e001d180 {
 			clocks = <&clk32k 0>;
 		};
 
+		tcb1: timer@e0800000 {
+			compatible = "atmel,sama5d2-tcb", "simple-mfd", "syscon";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xe0800000 0x100>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 91>, <&pmc PMC_TYPE_PERIPHERAL 92>, <&pmc PMC_TYPE_PERIPHERAL 93>, <&clk32k 1>;
+			clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
+		};
+
 		adc: adc@e1000000 {
 			compatible = "microchip,sama7g5-adc";
 			reg = <0xe1000000 0x200>;
@@ -488,6 +498,16 @@ dma2: dma-controller@e1200000 {
 			status = "disabled";
 		};
 
+		tcb0: timer@e2814000 {
+			compatible = "atmel,sama5d2-tcb", "simple-mfd", "syscon";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xe2814000 0x100>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 88>, <&pmc PMC_TYPE_PERIPHERAL 89>, <&pmc PMC_TYPE_PERIPHERAL 90>, <&clk32k 1>;
+			clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
+		};
+
 		flx8: flexcom@e2818000 {
 			compatible = "atmel,sama5d2-flexcom";
 			reg = <0xe2818000 0x200>;
-- 
2.25.1

