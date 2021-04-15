Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FEC3606D1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhDOKMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:12:03 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:49564 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232408AbhDOKL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:11:26 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FAAinF025292;
        Thu, 15 Apr 2021 12:10:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=oCv+AjL4AK2U8fucSZBvmi/td4r/I61ahgMuiai0Pww=;
 b=mVxh5gN1hFTKHQsn6y/yI5K+Wteruv5AON5Nb70t6urX2eXo6lrOkmUq+QR1Xy8RoLhN
 Hdbhb6flzT+1dgj11fThNkq76OufhnN9jzr3NBGmkYRGA1kHflNowbKkNLU9lcpQyeV6
 Nsctz4jFmNG6MGR4s6iIYVcrkQfnPe51jY1lOkbJbpLcvhnqNT8eV3kv7NmBhd2Ay5xv
 YfsVi510rNzxuBLGfTd7BrdO6lFFU6z28kg13ukTPHevS5UAnesW9FFuyX0fR2QmJfK6
 Q4dL5i8CceLRijlJDXir42oaAK4xrQ5dSO5KQIxEvY7WSysFfGejQhXz472gU05bUOHY QQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37xes0t60d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 12:10:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EC20110002A;
        Thu, 15 Apr 2021 12:10:48 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DC31E226378;
        Thu, 15 Apr 2021 12:10:48 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Apr 2021 12:10:48
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
Subject: [PATCH 11/13] ARM: dts: stm32: fix LTDC port node on STM32 MCU ad MPU
Date:   Thu, 15 Apr 2021 12:10:35 +0200
Message-ID: <20210415101037.1465-12-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_03:2021-04-15,2021-04-15 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running "make dtbs_check W=1", some warnings are reported concerning
LTDC port subnode:

/soc/display-controller@5a001000/port:
unnecessary #address-cells/#size-cells without "ranges" or child "reg"
property
/soc/display-controller@5a001000/port: graph node has single child node
'endpoint', #address-cells/#size-cells are not necessary

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 8c982ae79f43..f530f84474ea 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -175,7 +175,7 @@
 	status = "okay";
 
 	port {
-		ltdc_out_dsi: endpoint@0 {
+		ltdc_out_dsi: endpoint {
 			remote-endpoint = <&dsi_in>;
 		};
 	};
diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 8aa87cb86821..98a703d1c3a0 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1471,11 +1471,7 @@
 			resets = <&rcc LTDC_R>;
 			status = "disabled";
 
-			port {
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
-		};
 
 		iwdg2: watchdog@5a002000 {
 			compatible = "st,stm32mp1-iwdg";
diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index 4c8be9c8eb20..c06763d24890 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -26,3 +26,11 @@
 		stdout-path = "serial0:115200n8";
 	};
 };
+
+&ltdc {
+	port {
+		ltdc_ep0_out: endpoint {
+			remote-endpoint = <&sii9022_in>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
index 674b2d330dc4..ba1e2d7f06bf 100644
--- a/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
+++ b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
@@ -81,8 +81,7 @@
 	status = "okay";
 
 	port {
-		ltdc_ep0_out: endpoint@0 {
-			reg = <0>;
+		ltdc_ep0_out: endpoint {
 			remote-endpoint = <&panel_in>;
 		};
 	};
diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts b/arch/arm/boot/dts/stm32mp157c-dk2.dts
index 2bc92ef3aeb9..19ef475a48fc 100644
--- a/arch/arm/boot/dts/stm32mp157c-dk2.dts
+++ b/arch/arm/boot/dts/stm32mp157c-dk2.dts
@@ -82,9 +82,15 @@
 };
 
 &ltdc {
-	status = "okay";
-
 	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ltdc_ep0_out: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&sii9022_in>;
+		};
+
 		ltdc_ep1_out: endpoint@1 {
 			reg = <1>;
 			remote-endpoint = <&dsi_in>;
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 5c5b1ddf7bfd..6fe5b0fee7c4 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -239,8 +239,7 @@
 	status = "okay";
 
 	port {
-		ltdc_ep0_out: endpoint@0 {
-			reg = <0>;
+		ltdc_ep0_out: endpoint {
 			remote-endpoint = <&dsi_in>;
 		};
 	};
diff --git a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
index 1e9bf7eea0f1..70202ef5267c 100644
--- a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
@@ -161,8 +161,7 @@
 	status = "okay";
 
 	port {
-		ltdc_ep0_out: endpoint@0 {
-			reg = <0>;
+		ltdc_ep0_out: endpoint {
 			remote-endpoint = <&panel_input>;
 		};
 	};
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
index 64dca5b7f748..e7f10975cacf 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
@@ -277,11 +277,7 @@
 	status = "okay";
 
 	port {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ltdc_ep0_out: endpoint@0 {
-			reg = <0>;
+		ltdc_ep0_out: endpoint {
 			remote-endpoint = <&adv7513_in>;
 		};
 	};
diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index 59f18846cf5d..ca2d21689ecc 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -458,13 +458,6 @@
 	pinctrl-0 = <&ltdc_pins_a>;
 	pinctrl-1 = <&ltdc_sleep_pins_a>;
 	status = "okay";
-
-	port {
-		ltdc_ep0_out: endpoint@0 {
-			reg = <0>;
-			remote-endpoint = <&sii9022_in>;
-		};
-	};
 };
 
 &m4_rproc {
-- 
2.17.1

