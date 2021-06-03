Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704F339A4A5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFCPgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:36:25 -0400
Received: from mx01.ayax.eu ([188.137.98.110]:41572 "EHLO mx01.ayax.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhFCPgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:36:24 -0400
Received: from [192.168.192.146] (port=48286 helo=nx64de-df6d00)
        by mx01.ayax.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gszymaszek@short.pl>)
        id 1lopMR-0005wd-L7; Thu, 03 Jun 2021 17:34:19 +0200
Date:   Thu, 3 Jun 2021 17:34:18 +0200
From:   Grzegorz Szymaszek <gszymaszek@short.pl>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2] ARM: dts: stm32: add a new DCMI pins group
Message-ID: <YLj2emwxhAVVOeIo@nx64de-df6d00>
Mail-Followup-To: Grzegorz Szymaszek <gszymaszek@short.pl>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <fcee4f30-446e-f4da-6d95-c9223cf82981@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcee4f30-446e-f4da-6d95-c9223cf82981@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Seeed Odyssey-STM32MP157C board has a 20-pin DVP camera output.
stm32mp15-pinctrl.dtsi contained one pin state definition for the DCMI
interface, dcmi-0, AKA phandle dcmi_pins_a. This definition was
incompatible with the pins used on the Odyssey board, where:
- there are 8 data pins instead of 12,
- DCMI_HSYNC is available at PA4 instead of PH8,
- DCMI_D0 is at PC6 instead of PH9,
- DCMI_D3 is at PE1 instead of PH12,
- DCMI_D4 is at PE11 instead of PH14,
- DCMI_D5 is at PD3 instead of PI4,
- DCMI_D6 is at PE13 instead of PB8,
- DCMI_D7 is at PB9 instead of PE6.

Add the DCMI pins used on the Odyssey board as a new DCMI pin state
definition, dcmi-1, AKA phandle dcmi_pins_b.

Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
---
V1 -> V2: Removed the pinctrl override from the Odyssey device tree,
added a new pinctrl in stm32mp15-pinctrl.dtsi instead

 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 33 ++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index 060baa8b7e9d..5b60ecbd718f 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -118,6 +118,39 @@ pins {
 		};
 	};
 
+	dcmi_pins_b: dcmi-1 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 4,  AF13)>,/* DCMI_HSYNC */
+				 <STM32_PINMUX('B', 7,  AF13)>,/* DCMI_VSYNC */
+				 <STM32_PINMUX('A', 6,  AF13)>,/* DCMI_PIXCLK */
+				 <STM32_PINMUX('C', 6,  AF13)>,/* DCMI_D0 */
+				 <STM32_PINMUX('H', 10, AF13)>,/* DCMI_D1 */
+				 <STM32_PINMUX('H', 11, AF13)>,/* DCMI_D2 */
+				 <STM32_PINMUX('E', 1,  AF13)>,/* DCMI_D3 */
+				 <STM32_PINMUX('E', 11, AF13)>,/* DCMI_D4 */
+				 <STM32_PINMUX('D', 3,  AF13)>,/* DCMI_D5 */
+				 <STM32_PINMUX('E', 13, AF13)>,/* DCMI_D6 */
+				 <STM32_PINMUX('B', 9,  AF13)>;/* DCMI_D7 */
+			bias-disable;
+		};
+	};
+
+	dcmi_sleep_pins_b: dcmi-sleep-1 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 4,  ANALOG)>,/* DCMI_HSYNC */
+				 <STM32_PINMUX('B', 7,  ANALOG)>,/* DCMI_VSYNC */
+				 <STM32_PINMUX('A', 6,  ANALOG)>,/* DCMI_PIXCLK */
+				 <STM32_PINMUX('C', 6,  ANALOG)>,/* DCMI_D0 */
+				 <STM32_PINMUX('H', 10, ANALOG)>,/* DCMI_D1 */
+				 <STM32_PINMUX('H', 11, ANALOG)>,/* DCMI_D2 */
+				 <STM32_PINMUX('E', 1,  ANALOG)>,/* DCMI_D3 */
+				 <STM32_PINMUX('E', 11, ANALOG)>,/* DCMI_D4 */
+				 <STM32_PINMUX('D', 3,  ANALOG)>,/* DCMI_D5 */
+				 <STM32_PINMUX('E', 13, ANALOG)>,/* DCMI_D6 */
+				 <STM32_PINMUX('B', 9,  ANALOG)>;/* DCMI_D7 */
+		};
+	};
+
 	ethernet0_rgmii_pins_a: rgmii-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('G', 5, AF11)>, /* ETH_RGMII_CLK125 */
-- 
2.30.2

