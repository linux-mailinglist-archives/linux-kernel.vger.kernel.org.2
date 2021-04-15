Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA793606C9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhDOKLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:11:42 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:38151 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232376AbhDOKL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:11:26 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FA2V9t022655;
        Thu, 15 Apr 2021 12:10:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=zAsTAyEa/cfbJ+ARFpsGVMB0dvP+SVgqIgihW5fS1e8=;
 b=EqpiTD5E8wv1DCISRLTI0LiblpxD7rmYOpBAxUUolEWMw3g9ViE6SXNciNLR/p8S+dW7
 2MnTNV8yDVB/lLfiGkqK4wCuaNaNd7CvlALWB3h4vbcA18as0xSGUF3M6A9WM4gX8b9b
 TDhEWd4QI546tPQTG4MqieO16f3DfEpxM5+QR6kqkt9xEONATSXSERnPxn8NuxTk+j0/
 jdoXFUtiAljsMqIwCjYrnbPJQ8frovJxS/JJa5lBwXJ4s5S8FevqeUn+BRSCVoPg/a40
 6EOxma/ryO/djpNJm0xRcwsZtcwEdZn+1qJkIeBVjuGUWoJ1MJJt5vvTdyuJnkVGWCJO CA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37xg6w1qag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 12:10:44 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0F0B5100034;
        Thu, 15 Apr 2021 12:10:44 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F2D13226377;
        Thu, 15 Apr 2021 12:10:43 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Apr 2021 12:10:43
 +0200
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     <arnd@arndb.de>, <robh+dt@kernel.org>, Marek Vasut <marex@denx.de>,
        <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
        <kuba@kernel.org>
Subject: [PATCH 05/13] ARM: dts: stm32: update pinctrl node name on STM32 MCU to prevent warnings
Date:   Thu, 15 Apr 2021 12:10:29 +0200
Message-ID: <20210415101037.1465-6-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_03:2021-04-15,2021-04-15 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update node name to avoid a DT schema validation issue seen with
"make dtbs_check W=1". It also cleans picntrl dtsi files for f429/f469 MCU.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
index 4774163af54b..155d9ffacc83 100644
--- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -45,7 +45,7 @@
 
 / {
 	soc {
-		pinctrl: pin-controller {
+		pinctrl: pin-controller@40020000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x40020000 0x3000>;
diff --git a/arch/arm/boot/dts/stm32f429-pinctrl.dtsi b/arch/arm/boot/dts/stm32f429-pinctrl.dtsi
index 3e7a17d9112e..e10d7a1f3207 100644
--- a/arch/arm/boot/dts/stm32f429-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f429-pinctrl.dtsi
@@ -42,54 +42,50 @@
 
 #include "stm32f4-pinctrl.dtsi"
 
-/ {
-	soc {
-		pinctrl: pin-controller {
-			compatible = "st,stm32f429-pinctrl";
+&pinctrl {
+	compatible = "st,stm32f429-pinctrl";
 
-			gpioa: gpio@40020000 {
-				gpio-ranges = <&pinctrl 0 0 16>;
-			};
+	gpioa: gpio@40020000 {
+		gpio-ranges = <&pinctrl 0 0 16>;
+	};
 
-			gpiob: gpio@40020400 {
-				gpio-ranges = <&pinctrl 0 16 16>;
-			};
+	gpiob: gpio@40020400 {
+		gpio-ranges = <&pinctrl 0 16 16>;
+	};
 
-			gpioc: gpio@40020800 {
-				gpio-ranges = <&pinctrl 0 32 16>;
-			};
+	gpioc: gpio@40020800 {
+		gpio-ranges = <&pinctrl 0 32 16>;
+	};
 
-			gpiod: gpio@40020c00 {
-				gpio-ranges = <&pinctrl 0 48 16>;
-			};
+	gpiod: gpio@40020c00 {
+		gpio-ranges = <&pinctrl 0 48 16>;
+	};
 
-			gpioe: gpio@40021000 {
-				gpio-ranges = <&pinctrl 0 64 16>;
-			};
+	gpioe: gpio@40021000 {
+		gpio-ranges = <&pinctrl 0 64 16>;
+	};
 
-			gpiof: gpio@40021400 {
-				gpio-ranges = <&pinctrl 0 80 16>;
-			};
+	gpiof: gpio@40021400 {
+		gpio-ranges = <&pinctrl 0 80 16>;
+	};
 
-			gpiog: gpio@40021800 {
-				gpio-ranges = <&pinctrl 0 96 16>;
-			};
+	gpiog: gpio@40021800 {
+		gpio-ranges = <&pinctrl 0 96 16>;
+	};
 
-			gpioh: gpio@40021c00 {
-				gpio-ranges = <&pinctrl 0 112 16>;
-			};
+	gpioh: gpio@40021c00 {
+		gpio-ranges = <&pinctrl 0 112 16>;
+	};
 
-			gpioi: gpio@40022000 {
-				gpio-ranges = <&pinctrl 0 128 16>;
-			};
+	gpioi: gpio@40022000 {
+		gpio-ranges = <&pinctrl 0 128 16>;
+	};
 
-			gpioj: gpio@40022400 {
-				gpio-ranges = <&pinctrl 0 144 16>;
-			};
+	gpioj: gpio@40022400 {
+		gpio-ranges = <&pinctrl 0 144 16>;
+	};
 
-			gpiok: gpio@40022800 {
-				gpio-ranges = <&pinctrl 0 160 8>;
-			};
-		};
+	gpiok: gpio@40022800 {
+		gpio-ranges = <&pinctrl 0 160 8>;
 	};
 };
diff --git a/arch/arm/boot/dts/stm32f469-pinctrl.dtsi b/arch/arm/boot/dts/stm32f469-pinctrl.dtsi
index fff542662eea..6bf60263dff8 100644
--- a/arch/arm/boot/dts/stm32f469-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f469-pinctrl.dtsi
@@ -42,55 +42,51 @@
 
 #include "stm32f4-pinctrl.dtsi"
 
-/ {
-	soc {
-		pinctrl: pin-controller {
-			compatible = "st,stm32f469-pinctrl";
+&pinctrl {
+	compatible = "st,stm32f469-pinctrl";
 
-			gpioa: gpio@40020000 {
-				gpio-ranges = <&pinctrl 0 0 16>;
-			};
+	gpioa: gpio@40020000 {
+		gpio-ranges = <&pinctrl 0 0 16>;
+	};
 
-			gpiob: gpio@40020400 {
-				gpio-ranges = <&pinctrl 0 16 16>;
-			};
+	gpiob: gpio@40020400 {
+		gpio-ranges = <&pinctrl 0 16 16>;
+	};
 
-			gpioc: gpio@40020800 {
-				gpio-ranges = <&pinctrl 0 32 16>;
-			};
+	gpioc: gpio@40020800 {
+		gpio-ranges = <&pinctrl 0 32 16>;
+	};
 
-			gpiod: gpio@40020c00 {
-				gpio-ranges = <&pinctrl 0 48 16>;
-			};
+	gpiod: gpio@40020c00 {
+		gpio-ranges = <&pinctrl 0 48 16>;
+	};
 
-			gpioe: gpio@40021000 {
-				gpio-ranges = <&pinctrl 0 64 16>;
-			};
+	gpioe: gpio@40021000 {
+		gpio-ranges = <&pinctrl 0 64 16>;
+	};
 
-			gpiof: gpio@40021400 {
-				gpio-ranges = <&pinctrl 0 80 16>;
-			};
+	gpiof: gpio@40021400 {
+		gpio-ranges = <&pinctrl 0 80 16>;
+	};
 
-			gpiog: gpio@40021800 {
-				gpio-ranges = <&pinctrl 0 96 16>;
-			};
+	gpiog: gpio@40021800 {
+		gpio-ranges = <&pinctrl 0 96 16>;
+	};
 
-			gpioh: gpio@40021c00 {
-				gpio-ranges = <&pinctrl 0 112 16>;
-			};
+	gpioh: gpio@40021c00 {
+		gpio-ranges = <&pinctrl 0 112 16>;
+	};
 
-			gpioi: gpio@40022000 {
-				gpio-ranges = <&pinctrl 0 128 16>;
-			};
+	gpioi: gpio@40022000 {
+		gpio-ranges = <&pinctrl 0 128 16>;
+	};
 
-			gpioj: gpio@40022400 {
-				gpio-ranges = <&pinctrl 0 144 6>,
-					      <&pinctrl 12 156 4>;
-			};
+	gpioj: gpio@40022400 {
+		gpio-ranges = <&pinctrl 0 144 6>,
+			      <&pinctrl 12 156 4>;
+	};
 
-			gpiok: gpio@40022800 {
-				gpio-ranges = <&pinctrl 3 163 5>;
-			};
-		};
+	gpiok: gpio@40022800 {
+		gpio-ranges = <&pinctrl 3 163 5>;
 	};
 };
diff --git a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
index fe4cfda72a47..1cf8a23c2644 100644
--- a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
@@ -9,7 +9,7 @@
 
 / {
 	soc {
-		pinctrl: pin-controller {
+		pinctrl: pin-controller@40020000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x40020000 0x3000>;
-- 
2.17.1

