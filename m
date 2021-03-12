Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72ED3385D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhCLGZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhCLGYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:24:54 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EDAC061574;
        Thu, 11 Mar 2021 22:24:53 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id s21so4662899pjq.1;
        Thu, 11 Mar 2021 22:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HQMVCNAc7ZXto7u6S/CyLXY5wvMOSv2wTlirnS5odIc=;
        b=f04nJV23heF66IW4OcWZGtzAS1vHE3XLdgnE+TLuaZ9VYgljMSZeX+Nll3rdGDAHqD
         bLtmsK7gC2Sxgbm24SMomtP7tFdSLz7kDtl0vUOBVqW0AxWKOsPSfVoUoiz0vN7vx+1x
         MjHaBmHu2sCmJIFPeMCUwODu/mkJxqx+hs0n/iA6oYlxtYemaHt1q/L6GS5CPGwRVkGO
         oKTyHqer2nf21gBxhA3qY3Bn4tyneOOflwvsm67lp+to3yrBMrjFJKz4wshl3tkActsK
         yV36gmooq9iyqWUo9KmDgTOl1U6WS0H3aI8+AKb1eC8ClinwZ0MxKE/sI7f3WMvKjuE/
         Dkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HQMVCNAc7ZXto7u6S/CyLXY5wvMOSv2wTlirnS5odIc=;
        b=HjF96N5Pwl6TulAu1A5GmPnBf+FRwMwt3GfY0d8a/8NYwcAfmdiABSkRlJlwlIvHAR
         FsgetivgQCSeidMGiurZZwAQkf7zuawxZVWojL8UbVagFQ9mZ4/jFwpjL4Usy5Fkaieu
         buDEme32GsdJXWHPPjozqbUWK8X5bF8/wOW+fbq9Tc1/R6usfuWX/4jXbRRcmmtwXwx5
         QlgyodlgU+IBzduSGJsiJcZZVZwp4hIcRbJZvn+1j3JOAj62NrFLIehYbqGIugO6pDFZ
         412WnRtCfoGMTDUuSEU8oEv2e/j3pCLx6SIen3W8UdJ9Xg23SQQvTTa3cL6j4ndVXiwk
         fjwg==
X-Gm-Message-State: AOAM532Kd/uFdMybOSMd/HCGPnbsIym6yBOIqiak5Y2s6osyNa+51Mmo
        60xiVtMOx6Ds7oFKFe5gLUM=
X-Google-Smtp-Source: ABdhPJz2f3cknGBaMbpaICshKZu59UP2BsZB/l80KxAKkh7dYtfMhWE383Z8TXOg2iyhsU2wWGAjTQ==
X-Received: by 2002:a17:90a:6c22:: with SMTP id x31mr12995375pjj.213.1615530293344;
        Thu, 11 Mar 2021 22:24:53 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id h6sm4048406pfb.157.2021.03.11.22.24.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 22:24:53 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, alexandre.torgue@foss.st.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v2 4/8] ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to support stm32h750
Date:   Fri, 12 Mar 2021 14:24:30 +0800
Message-Id: <1615530274-31422-5-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
References: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch is intend to add support stm32h750 value line,
just add stm32h7-pinctrl.dtsi for extending, with following changes:

- rename stm32h743-pinctrl.dtsi to stm32h7-pinctrl.dtsi
- move compatible string "st,stm32h743-pinctrl" from stm32h7-pinctrl.dtsi
  to stm32h743-pinctrl.dtsi

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
v2:
- reorganize the pinctrl device tree about stm32h7-pinctrl/stm32h743/750-pinctrl
  stm32h7-pinctrl.dtsi --> stm32h743-pinctrl.dtsi --> stm32h743i-disco.dts
                       |                          |-> stm32h743i-eval.dts
                       |-> stm32h750-pinctrl.dtsi --> stm32h750i-art-pi.dts
   same to the stm32f7/f4's pinctrl style

 arch/arm/boot/dts/stm32h7-pinctrl.dtsi   | 305 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 307 +------------------------------
 2 files changed, 311 insertions(+), 301 deletions(-)
 create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi

diff --git a/arch/arm/boot/dts/stm32h7-pinctrl.dtsi b/arch/arm/boot/dts/stm32h7-pinctrl.dtsi
new file mode 100644
index 000000000000..9fcc1e3ba925
--- /dev/null
+++ b/arch/arm/boot/dts/stm32h7-pinctrl.dtsi
@@ -0,0 +1,305 @@
+/*
+ * Copyright 2017 - Alexandre Torgue <alexandre.torgue@st.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <dt-bindings/pinctrl/stm32-pinfunc.h>
+
+/ {
+	soc {
+		pinctrl: pin-controller {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x58020000 0x3000>;
+			interrupt-parent = <&exti>;
+			st,syscfg = <&syscfg 0x8>;
+			pins-are-numbered;
+
+			gpioa: gpio@58020000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x0 0x400>;
+				clocks = <&rcc GPIOA_CK>;
+				st,bank-name = "GPIOA";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiob: gpio@58020400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x400 0x400>;
+				clocks = <&rcc GPIOB_CK>;
+				st,bank-name = "GPIOB";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioc: gpio@58020800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x800 0x400>;
+				clocks = <&rcc GPIOC_CK>;
+				st,bank-name = "GPIOC";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiod: gpio@58020c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0xc00 0x400>;
+				clocks = <&rcc GPIOD_CK>;
+				st,bank-name = "GPIOD";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioe: gpio@58021000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1000 0x400>;
+				clocks = <&rcc GPIOE_CK>;
+				st,bank-name = "GPIOE";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiof: gpio@58021400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1400 0x400>;
+				clocks = <&rcc GPIOF_CK>;
+				st,bank-name = "GPIOF";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiog: gpio@58021800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1800 0x400>;
+				clocks = <&rcc GPIOG_CK>;
+				st,bank-name = "GPIOG";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioh: gpio@58021c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1c00 0x400>;
+				clocks = <&rcc GPIOH_CK>;
+				st,bank-name = "GPIOH";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioi: gpio@58022000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2000 0x400>;
+				clocks = <&rcc GPIOI_CK>;
+				st,bank-name = "GPIOI";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioj: gpio@58022400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2400 0x400>;
+				clocks = <&rcc GPIOJ_CK>;
+				st,bank-name = "GPIOJ";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiok: gpio@58022800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2800 0x400>;
+				clocks = <&rcc GPIOK_CK>;
+				st,bank-name = "GPIOK";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			i2c1_pins_a: i2c1-0 {
+				pins {
+					pinmux = <STM32_PINMUX('B', 6, AF4)>, /* I2C1_SCL */
+						 <STM32_PINMUX('B', 7, AF4)>; /* I2C1_SDA */
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <0>;
+				};
+			};
+
+			ethernet_rmii: rmii-0 {
+				pins {
+					pinmux = <STM32_PINMUX('G', 11, AF11)>,
+						 <STM32_PINMUX('G', 13, AF11)>,
+						 <STM32_PINMUX('G', 12, AF11)>,
+						 <STM32_PINMUX('C', 4, AF11)>,
+						 <STM32_PINMUX('C', 5, AF11)>,
+						 <STM32_PINMUX('A', 7, AF11)>,
+						 <STM32_PINMUX('C', 1, AF11)>,
+						 <STM32_PINMUX('A', 2, AF11)>,
+						 <STM32_PINMUX('A', 1, AF11)>;
+					slew-rate = <2>;
+				};
+			};
+
+			sdmmc1_b4_pins_a: sdmmc1-b4-0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
+						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
+						 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
+						 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
+						 <STM32_PINMUX('C', 12, AF12)>, /* SDMMC1_CK */
+						 <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
+					slew-rate = <3>;
+					drive-push-pull;
+					bias-disable;
+				};
+			};
+
+			sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
+						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
+						 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
+						 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
+						 <STM32_PINMUX('C', 12, AF12)>; /* SDMMC1_CK */
+					slew-rate = <3>;
+					drive-push-pull;
+					bias-disable;
+				};
+				pins2{
+					pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
+					slew-rate = <3>;
+					drive-open-drain;
+					bias-disable;
+				};
+			};
+
+			sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 8, ANALOG)>, /* SDMMC1_D0 */
+						 <STM32_PINMUX('C', 9, ANALOG)>, /* SDMMC1_D1 */
+						 <STM32_PINMUX('C', 10, ANALOG)>, /* SDMMC1_D2 */
+						 <STM32_PINMUX('C', 11, ANALOG)>, /* SDMMC1_D3 */
+						 <STM32_PINMUX('C', 12, ANALOG)>, /* SDMMC1_CK */
+						 <STM32_PINMUX('D', 2, ANALOG)>; /* SDMMC1_CMD */
+				};
+			};
+
+			sdmmc1_dir_pins_a: sdmmc1-dir-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('C', 6, AF8)>, /* SDMMC1_D0DIR */
+						 <STM32_PINMUX('C', 7, AF8)>, /* SDMMC1_D123DIR */
+						 <STM32_PINMUX('B', 9, AF7)>; /* SDMMC1_CDIR */
+					slew-rate = <3>;
+					drive-push-pull;
+					bias-pull-up;
+				};
+				pins2{
+					pinmux = <STM32_PINMUX('B', 8, AF7)>; /* SDMMC1_CKIN */
+					bias-pull-up;
+				};
+			};
+
+			sdmmc1_dir_sleep_pins_a: sdmmc1-dir-sleep-0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 6, ANALOG)>, /* SDMMC1_D0DIR */
+						 <STM32_PINMUX('C', 7, ANALOG)>, /* SDMMC1_D123DIR */
+						 <STM32_PINMUX('B', 9, ANALOG)>, /* SDMMC1_CDIR */
+						 <STM32_PINMUX('B', 8, ANALOG)>; /* SDMMC1_CKIN */
+				};
+			};
+
+			usart1_pins: usart1-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 15, AF4)>; /* USART1_RX */
+					bias-disable;
+				};
+			};
+
+			usart2_pins: usart2-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('D', 5, AF7)>; /* USART2_TX */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('D', 6, AF7)>; /* USART2_RX */
+					bias-disable;
+				};
+			};
+
+			usbotg_hs_pins_a: usbotg-hs-0 {
+				pins {
+					pinmux = <STM32_PINMUX('H', 4, AF10)>,	/* ULPI_NXT */
+							 <STM32_PINMUX('I', 11, AF10)>, /* ULPI_DIR> */
+							 <STM32_PINMUX('C', 0, AF10)>,	/* ULPI_STP> */
+							 <STM32_PINMUX('A', 5, AF10)>,	/* ULPI_CK> */
+							 <STM32_PINMUX('A', 3, AF10)>,	/* ULPI_D0> */
+							 <STM32_PINMUX('B', 0, AF10)>,	/* ULPI_D1> */
+							 <STM32_PINMUX('B', 1, AF10)>,	/* ULPI_D2> */
+							 <STM32_PINMUX('B', 10, AF10)>, /* ULPI_D3> */
+							 <STM32_PINMUX('B', 11, AF10)>, /* ULPI_D4> */
+							 <STM32_PINMUX('B', 12, AF10)>, /* ULPI_D5> */
+							 <STM32_PINMUX('B', 13, AF10)>, /* ULPI_D6> */
+							 <STM32_PINMUX('B', 5, AF10)>;	/* ULPI_D7> */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
index fa5dcb6a5fdd..6b1e115307b9 100644
--- a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
@@ -1,306 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
- * Copyright 2017 - Alexandre Torgue <alexandre.torgue@st.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright (C) STMicroelectronics 2017 - All Rights Reserved
+ * Author: Alexandre Torgue  <alexandre.torgue@st.com> for STMicroelectronics.
  */
 
-#include <dt-bindings/pinctrl/stm32-pinfunc.h>
+#include "stm32h7-pinctrl.dtsi"
 
-/ {
-	soc {
-		pin-controller {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "st,stm32h743-pinctrl";
-			ranges = <0 0x58020000 0x3000>;
-			interrupt-parent = <&exti>;
-			st,syscfg = <&syscfg 0x8>;
-			pins-are-numbered;
-
-			gpioa: gpio@58020000 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x0 0x400>;
-				clocks = <&rcc GPIOA_CK>;
-				st,bank-name = "GPIOA";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpiob: gpio@58020400 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x400 0x400>;
-				clocks = <&rcc GPIOB_CK>;
-				st,bank-name = "GPIOB";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpioc: gpio@58020800 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x800 0x400>;
-				clocks = <&rcc GPIOC_CK>;
-				st,bank-name = "GPIOC";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpiod: gpio@58020c00 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0xc00 0x400>;
-				clocks = <&rcc GPIOD_CK>;
-				st,bank-name = "GPIOD";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpioe: gpio@58021000 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x1000 0x400>;
-				clocks = <&rcc GPIOE_CK>;
-				st,bank-name = "GPIOE";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpiof: gpio@58021400 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x1400 0x400>;
-				clocks = <&rcc GPIOF_CK>;
-				st,bank-name = "GPIOF";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpiog: gpio@58021800 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x1800 0x400>;
-				clocks = <&rcc GPIOG_CK>;
-				st,bank-name = "GPIOG";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpioh: gpio@58021c00 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x1c00 0x400>;
-				clocks = <&rcc GPIOH_CK>;
-				st,bank-name = "GPIOH";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpioi: gpio@58022000 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x2000 0x400>;
-				clocks = <&rcc GPIOI_CK>;
-				st,bank-name = "GPIOI";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpioj: gpio@58022400 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x2400 0x400>;
-				clocks = <&rcc GPIOJ_CK>;
-				st,bank-name = "GPIOJ";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpiok: gpio@58022800 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x2800 0x400>;
-				clocks = <&rcc GPIOK_CK>;
-				st,bank-name = "GPIOK";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			i2c1_pins_a: i2c1-0 {
-				pins {
-					pinmux = <STM32_PINMUX('B', 6, AF4)>, /* I2C1_SCL */
-						 <STM32_PINMUX('B', 7, AF4)>; /* I2C1_SDA */
-					bias-disable;
-					drive-open-drain;
-					slew-rate = <0>;
-				};
-			};
-
-			ethernet_rmii: rmii-0 {
-				pins {
-					pinmux = <STM32_PINMUX('G', 11, AF11)>,
-						 <STM32_PINMUX('G', 13, AF11)>,
-						 <STM32_PINMUX('G', 12, AF11)>,
-						 <STM32_PINMUX('C', 4, AF11)>,
-						 <STM32_PINMUX('C', 5, AF11)>,
-						 <STM32_PINMUX('A', 7, AF11)>,
-						 <STM32_PINMUX('C', 1, AF11)>,
-						 <STM32_PINMUX('A', 2, AF11)>,
-						 <STM32_PINMUX('A', 1, AF11)>;
-					slew-rate = <2>;
-				};
-			};
-
-			sdmmc1_b4_pins_a: sdmmc1-b4-0 {
-				pins {
-					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
-						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
-						 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
-						 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
-						 <STM32_PINMUX('C', 12, AF12)>, /* SDMMC1_CK */
-						 <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
-					slew-rate = <3>;
-					drive-push-pull;
-					bias-disable;
-				};
-			};
-
-			sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
-				pins1 {
-					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
-						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
-						 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
-						 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
-						 <STM32_PINMUX('C', 12, AF12)>; /* SDMMC1_CK */
-					slew-rate = <3>;
-					drive-push-pull;
-					bias-disable;
-				};
-				pins2{
-					pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
-					slew-rate = <3>;
-					drive-open-drain;
-					bias-disable;
-				};
-			};
-
-			sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
-				pins {
-					pinmux = <STM32_PINMUX('C', 8, ANALOG)>, /* SDMMC1_D0 */
-						 <STM32_PINMUX('C', 9, ANALOG)>, /* SDMMC1_D1 */
-						 <STM32_PINMUX('C', 10, ANALOG)>, /* SDMMC1_D2 */
-						 <STM32_PINMUX('C', 11, ANALOG)>, /* SDMMC1_D3 */
-						 <STM32_PINMUX('C', 12, ANALOG)>, /* SDMMC1_CK */
-						 <STM32_PINMUX('D', 2, ANALOG)>; /* SDMMC1_CMD */
-				};
-			};
-
-			sdmmc1_dir_pins_a: sdmmc1-dir-0 {
-				pins1 {
-					pinmux = <STM32_PINMUX('C', 6, AF8)>, /* SDMMC1_D0DIR */
-						 <STM32_PINMUX('C', 7, AF8)>, /* SDMMC1_D123DIR */
-						 <STM32_PINMUX('B', 9, AF7)>; /* SDMMC1_CDIR */
-					slew-rate = <3>;
-					drive-push-pull;
-					bias-pull-up;
-				};
-				pins2{
-					pinmux = <STM32_PINMUX('B', 8, AF7)>; /* SDMMC1_CKIN */
-					bias-pull-up;
-				};
-			};
-
-			sdmmc1_dir_sleep_pins_a: sdmmc1-dir-sleep-0 {
-				pins {
-					pinmux = <STM32_PINMUX('C', 6, ANALOG)>, /* SDMMC1_D0DIR */
-						 <STM32_PINMUX('C', 7, ANALOG)>, /* SDMMC1_D123DIR */
-						 <STM32_PINMUX('B', 9, ANALOG)>, /* SDMMC1_CDIR */
-						 <STM32_PINMUX('B', 8, ANALOG)>; /* SDMMC1_CKIN */
-				};
-			};
-
-			usart1_pins: usart1-0 {
-				pins1 {
-					pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
-					bias-disable;
-					drive-push-pull;
-					slew-rate = <0>;
-				};
-				pins2 {
-					pinmux = <STM32_PINMUX('B', 15, AF4)>; /* USART1_RX */
-					bias-disable;
-				};
-			};
-
-			usart2_pins: usart2-0 {
-				pins1 {
-					pinmux = <STM32_PINMUX('D', 5, AF7)>; /* USART2_TX */
-					bias-disable;
-					drive-push-pull;
-					slew-rate = <0>;
-				};
-				pins2 {
-					pinmux = <STM32_PINMUX('D', 6, AF7)>; /* USART2_RX */
-					bias-disable;
-				};
-			};
-
-			usbotg_hs_pins_a: usbotg-hs-0 {
-				pins {
-					pinmux = <STM32_PINMUX('H', 4, AF10)>,	/* ULPI_NXT */
-							 <STM32_PINMUX('I', 11, AF10)>, /* ULPI_DIR> */
-							 <STM32_PINMUX('C', 0, AF10)>,	/* ULPI_STP> */
-							 <STM32_PINMUX('A', 5, AF10)>,	/* ULPI_CK> */
-							 <STM32_PINMUX('A', 3, AF10)>,	/* ULPI_D0> */
-							 <STM32_PINMUX('B', 0, AF10)>,	/* ULPI_D1> */
-							 <STM32_PINMUX('B', 1, AF10)>,	/* ULPI_D2> */
-							 <STM32_PINMUX('B', 10, AF10)>, /* ULPI_D3> */
-							 <STM32_PINMUX('B', 11, AF10)>, /* ULPI_D4> */
-							 <STM32_PINMUX('B', 12, AF10)>, /* ULPI_D5> */
-							 <STM32_PINMUX('B', 13, AF10)>, /* ULPI_D6> */
-							 <STM32_PINMUX('B', 5, AF10)>;	/* ULPI_D7> */
-					bias-disable;
-					drive-push-pull;
-					slew-rate = <2>;
-				};
-			};
-		};
-	};
+&pinctrl{
+	compatible = "st,stm32h743-pinctrl";
 };
-- 
2.7.4

