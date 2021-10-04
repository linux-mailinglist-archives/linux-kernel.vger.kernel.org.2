Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9F84207C9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 11:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhJDJFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:05:39 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:58688 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229716AbhJDJFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:05:37 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19493Sph008959;
        Mon, 4 Oct 2021 11:03:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=nJpxX9PGQq7OHBwCh6Km3sL4rv9XksaSXEVrd4QAuFc=;
 b=tbkpxkKvj+VO404KHISL2TMnk3AZxb9hxVqanjJmg9RYtbQtdg8f+mxmouc34wx3Yet7
 rr8Xj2xjL9LzMVWJl4Ule6Ha7TLsGnSjOABmrwdurCjSu9ZMUX9CkO3X9dpoWYHGwtvz
 QOWqnpWik14IEOPXpGI+nZtomNTk9vf4CVGTNJwEA5klfEc08erfdGWnCrChGNFil4lv
 0Cv7dse3+QDbu97rlKPdrU2UVssG72jgPXQsp/8ujvpoXyhZK8v5uerAPPORFm6fyAHW
 FVQn1xS6gLW9xEwj20ceAbMn87q7ZO3rnjLOnpLaO6BPn49frOqMpyOPNAxo398SRDRD 6g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bfxn7800u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 11:03:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F3592100040;
        Mon,  4 Oct 2021 11:03:32 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D09B822FA2E;
        Mon,  4 Oct 2021 11:03:32 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 4 Oct 2021 11:03:32
 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marek Vasut <marex@denx.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
Subject: [PATCH v2] ARM: dts: stm32: fix AV96 board SAI2 pin muxing on stm32mp15
Date:   Mon, 4 Oct 2021 11:03:04 +0200
Message-ID: <20211004090304.8984-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_02,2021-10-01_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix SAI2A and SAI2B pin muxings for AV96 board on STM32MP15.
Change sai2a-4 & sai2a-5 to sai2a-2 & sai2a-2.
Change sai2a-4 & sai2a-sleep-5 to sai2b-2 & sai2b-sleep-2

Fixes: dcf185ca8175 ("ARM: dts: stm32: Add alternate pinmux for SAI2 pins on stm32mp15")

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index 5b60ecbd718f..2ebafe27a865 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1179,7 +1179,7 @@
 		};
 	};
 
-	sai2a_pins_c: sai2a-4 {
+	sai2a_pins_c: sai2a-2 {
 		pins {
 			pinmux = <STM32_PINMUX('D', 13, AF10)>, /* SAI2_SCK_A */
 				 <STM32_PINMUX('D', 11, AF10)>, /* SAI2_SD_A */
@@ -1190,7 +1190,7 @@
 		};
 	};
 
-	sai2a_sleep_pins_c: sai2a-5 {
+	sai2a_sleep_pins_c: sai2a-2 {
 		pins {
 			pinmux = <STM32_PINMUX('D', 13, ANALOG)>, /* SAI2_SCK_A */
 				 <STM32_PINMUX('D', 11, ANALOG)>, /* SAI2_SD_A */
@@ -1235,14 +1235,14 @@
 		};
 	};
 
-	sai2b_pins_c: sai2a-4 {
+	sai2b_pins_c: sai2b-2 {
 		pins1 {
 			pinmux = <STM32_PINMUX('F', 11, AF10)>; /* SAI2_SD_B */
 			bias-disable;
 		};
 	};
 
-	sai2b_sleep_pins_c: sai2a-sleep-5 {
+	sai2b_sleep_pins_c: sai2b-sleep-2 {
 		pins {
 			pinmux = <STM32_PINMUX('F', 11, ANALOG)>; /* SAI2_SD_B */
 		};
-- 
2.17.1

