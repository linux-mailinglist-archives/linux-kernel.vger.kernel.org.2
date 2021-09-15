Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E82440C0D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhIOHua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:50:30 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:58937 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbhIOHuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631692133; x=1663228133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DrUrIkN919I36jDniIebt0/1keT56bFRv5l7cFRP50c=;
  b=CdK2PdLW8c7NpStNEhQa/2Ga2nIY14TzqviZu7K6rwuNllACywvJRxl9
   SQUDw73MGyv7sEtI77sPOy5gct9lY0XCV/Nm19BbeCpIYYmZeoea+3ryH
   g1vejo3yJ/5zu3uesUTL4hpbP8F+jmmtap8/HrgzgnUezjPK6jQbPbufP
   /nYbeqreA8+ZsY+oOrAXJ/Yk+C9jJcRLqi5/ZcLHt0pvnD7i/dp0J7bso
   7UbrtpKVgN2hB0uDYmoW4gcYUWhpkuJsVvRD2zprqVGfsW5ALjIDjulFb
   zZopEY3Re7pPzz6ykJuJ0FO00eGo1h13oLvAbnJ6v2LtVbS1oob+6lRBi
   g==;
IronPort-SDR: hTqNy8gN3y3yGDih/uevQ8T9UegiWMz0bhkLV9JWstVcQIaoJg1gfHOj6SeQ+HQIWn4mJsPeJv
 emSVQI9hnO4o7R7tOvLC/AKf3BZq3KdZdeJT2Gw10jA95nZGHvsHmgiRu7DgOVLcB8z+df/kGm
 gE4vwjGbSA7L2VV+NawOjg9DumILCsUaz9ggPs6LEAqYJi+O8JooL8/cn58a3S0R7AsZK28EBf
 tX2k2njpCy3d0dRsaWvomEN6GxYZsNmDB5oTkxrfFwpW0X/Eaw1/GK685rYq2x/c0op5xdzJRF
 iA+IRzZadoUzbn605AvxD7ZO
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="131883930"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2021 00:48:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 15 Sep 2021 00:48:52 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 15 Sep 2021 00:48:50 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/2] ARM: dts: at91: sama7g5ek: use proper slew-rate settings for GMACs
Date:   Wed, 15 Sep 2021 10:48:35 +0300
Message-ID: <20210915074836.6574-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210915074836.6574-1-claudiu.beznea@microchip.com>
References: <20210915074836.6574-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Datasheet chapter "EMAC Timings" specifies that while in 3.3V domain
GMAC's MDIO pins should be configured with slew-rate enabled, while the
data + signaling pins should be configured with slew-rate disabled when
GMAC works in RGMII or RMII modes. The pin controller for SAMA7G5 sets
the slew-rate as enabled for all pins. Adapt the device tree to comply
with these.

Fixes: 7540629e2fc7 ("ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama7g5ek.dts | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index 8b13b031a167..0bed8207d498 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -353,7 +353,10 @@ &gmac0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gmac0_default &pinctrl_gmac0_txck_default &pinctrl_gmac0_phy_irq>;
+	pinctrl-0 = <&pinctrl_gmac0_default
+		     &pinctrl_gmac0_mdio_default
+		     &pinctrl_gmac0_txck_default
+		     &pinctrl_gmac0_phy_irq>;
 	phy-mode = "rgmii-id";
 	status = "okay";
 
@@ -368,7 +371,9 @@ &gmac1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gmac1_default &pinctrl_gmac1_phy_irq>;
+	pinctrl-0 = <&pinctrl_gmac1_default
+		     &pinctrl_gmac1_mdio_default
+		     &pinctrl_gmac1_phy_irq>;
 	phy-mode = "rmii";
 	status = "okay";
 
@@ -423,14 +428,20 @@ pinctrl_gmac0_default: gmac0_default {
 			 <PIN_PA15__G0_TXEN>,
 			 <PIN_PA30__G0_RXCK>,
 			 <PIN_PA18__G0_RXDV>,
-			 <PIN_PA22__G0_MDC>,
-			 <PIN_PA23__G0_MDIO>,
 			 <PIN_PA25__G0_125CK>;
+		slew-rate = <0>;
+		bias-disable;
+	};
+
+	pinctrl_gmac0_mdio_default: gmac0_mdio_default {
+		pinmux = <PIN_PA22__G0_MDC>,
+			 <PIN_PA23__G0_MDIO>;
 		bias-disable;
 	};
 
 	pinctrl_gmac0_txck_default: gmac0_txck_default {
 		pinmux = <PIN_PA24__G0_TXCK>;
+		slew-rate = <0>;
 		bias-pull-up;
 	};
 
@@ -447,8 +458,13 @@ pinctrl_gmac1_default: gmac1_default {
 			 <PIN_PD25__G1_RX0>,
 			 <PIN_PD26__G1_RX1>,
 			 <PIN_PD27__G1_RXER>,
-			 <PIN_PD24__G1_RXDV>,
-			 <PIN_PD28__G1_MDC>,
+			 <PIN_PD24__G1_RXDV>;
+		slew-rate = <0>;
+		bias-disable;
+	};
+
+	pinctrl_gmac1_mdio_default: gmac1_mdio_default {
+		pinmux = <PIN_PD28__G1_MDC>,
 			 <PIN_PD29__G1_MDIO>;
 		bias-disable;
 	};
-- 
2.25.1

