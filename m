Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACEA3606CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhDOKLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:11:52 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:49562 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232371AbhDOKL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:11:26 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FAAjiC025351;
        Thu, 15 Apr 2021 12:10:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=yl/1FZg/X+iwUfQ+294ApROhQ5bltXpnM5K9gWf8NBk=;
 b=XZfe16jy/huChnYIZz+3soVU/JEuPML7Xd0Mx7ZChFBX67A80w99mwdMPoBmJRYOi74Z
 MnIkBj/yO/m/pluFsWVmbjiwRVVSWCAbW4NWxA1dY6o9mNQagjRtfy+G23l3lQtwXdfZ
 OhMaHEpbldNbCVrDWxLnMNYRIRg98uM9rWwXxoRLHgOAwEKtE3JCBh+GBw2addilQI2p
 vIKAa08pJEFoyzcMWlrktLFRuhYr1R78fmuVLbZ2MxSUMYSmE2xDWlltypFNOjnyOFLg
 hOkDbb/aSizG5TTyYuRe1uc4LfNvhPE86ckNNbm5TFPWt4vNyv0HO1vcdMXw/nNIgLB1 cQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37xes0t60r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 12:10:51 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8DCE0100034;
        Thu, 15 Apr 2021 12:10:50 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7E936226378;
        Thu, 15 Apr 2021 12:10:50 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Apr 2021 12:10:50
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
Subject: [PATCH 13/13] ARM: dts: stm32: fix ltdc pinctrl on microdev2.0-of7
Date:   Thu, 15 Apr 2021 12:10:37 +0200
Message-ID: <20210415101037.1465-14-alexandre.torgue@foss.st.com>
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

It prevents the following warning:

 pin-controller@50002000: 'ltdc' does not match any of the regexes:
'-[0-9]*$', '^gpio@[0-9a-f]*$', 'pinctrl-[0-9]+'

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
index ba1e2d7f06bf..dffd9d588af2 100644
--- a/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
+++ b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts
@@ -88,7 +88,7 @@
 };
 
 &pinctrl {
-	ltdc_pins: ltdc {
+	ltdc_pins: ltdc-0 {
 		pins {
 			pinmux = <STM32_PINMUX('G', 10, AF14)>,	/* LTDC_B2 */
 				 <STM32_PINMUX('H', 12, AF14)>,	/* LTDC_R6 */
-- 
2.17.1

