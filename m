Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0709939A310
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhFCOZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:25:40 -0400
Received: from mx01.ayax.eu ([188.137.98.110]:40856 "EHLO mx01.ayax.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhFCOZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:25:39 -0400
Received: from [192.168.192.146] (port=48224 helo=nx64de-df6d00)
        by mx01.ayax.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gszymaszek@short.pl>)
        id 1looG4-0005O6-8n; Thu, 03 Jun 2021 16:23:40 +0200
Date:   Thu, 3 Jun 2021 16:23:38 +0200
From:   Grzegorz Szymaszek <gszymaszek@short.pl>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: set stm32mp157c-odyssey DCMI pins
Message-ID: <YLjl6lE+uZ5ZCdiS@nx64de-df6d00>
Mail-Followup-To: Grzegorz Szymaszek <gszymaszek@short.pl>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Seeed Odyssey-STM32MP157C board has a 20-pin DVP camera output.
stm32mp15-pinctrl.dtsi contains one pin state definition for the DCMI
interface, dcmi-0, AKA phandle dcmi_pins_a. This definition is
incompatible with the pins used on the Odyssey board, where:
- there are 8 data pins instead of 12,
- DCMI_HSYNC is available at PA4 instead of PH8,
- DCMI_D0 is at PC6 instead of PH9,
- DCMI_D3 is at PE1 instead of PH12,
- DCMI_D4 is at PE11 instead of PH14,
- DCMI_D5 is at PD3 instead of PI4,
- DCMI_D6 is at PE13 instead of PB8,
- DCMI_D7 is at PB9 instead of PE6.

Override the dcmi_pins_a definition (as well as dcmi_sleep_pins_a) in
the Odyssey device tree.

Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
---
 arch/arm/boot/dts/stm32mp157c-odyssey.dts | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey.dts b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
index be1dd5e9e744..2d6cf70ca623 100644
--- a/arch/arm/boot/dts/stm32mp157c-odyssey.dts
+++ b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
@@ -22,6 +22,38 @@ chosen {
 	};
 };
 
+&dcmi_pins_a {
+	pins {
+		pinmux = <STM32_PINMUX('A', 4,  AF13)>,/* DCMI_HSYNC */
+			 <STM32_PINMUX('B', 7,  AF13)>,/* DCMI_VSYNC */
+			 <STM32_PINMUX('A', 6,  AF13)>,/* DCMI_PIXCLK */
+			 <STM32_PINMUX('C', 6,  AF13)>,/* DCMI_D0 */
+			 <STM32_PINMUX('H', 10, AF13)>,/* DCMI_D1 */
+			 <STM32_PINMUX('H', 11, AF13)>,/* DCMI_D2 */
+			 <STM32_PINMUX('E', 1,  AF13)>,/* DCMI_D3 */
+			 <STM32_PINMUX('E', 11, AF13)>,/* DCMI_D4 */
+			 <STM32_PINMUX('D', 3,  AF13)>,/* DCMI_D5 */
+			 <STM32_PINMUX('E', 13, AF13)>,/* DCMI_D6 */
+			 <STM32_PINMUX('B', 9,  AF13)>;/* DCMI_D7 */
+	};
+};
+
+&dcmi_sleep_pins_a {
+	pins {
+		pinmux = <STM32_PINMUX('A', 4,  ANALOG)>,/* DCMI_HSYNC */
+			 <STM32_PINMUX('B', 7,  ANALOG)>,/* DCMI_VSYNC */
+			 <STM32_PINMUX('A', 6,  ANALOG)>,/* DCMI_PIXCLK */
+			 <STM32_PINMUX('C', 6,  ANALOG)>,/* DCMI_D0 */
+			 <STM32_PINMUX('H', 10, ANALOG)>,/* DCMI_D1 */
+			 <STM32_PINMUX('H', 11, ANALOG)>,/* DCMI_D2 */
+			 <STM32_PINMUX('E', 1,  ANALOG)>,/* DCMI_D3 */
+			 <STM32_PINMUX('E', 11, ANALOG)>,/* DCMI_D4 */
+			 <STM32_PINMUX('D', 3,  ANALOG)>,/* DCMI_D5 */
+			 <STM32_PINMUX('E', 13, ANALOG)>,/* DCMI_D6 */
+			 <STM32_PINMUX('B', 9,  ANALOG)>;/* DCMI_D7 */
+	};
+};
+
 &ethernet0 {
 	status = "okay";
 	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
-- 
2.30.2

