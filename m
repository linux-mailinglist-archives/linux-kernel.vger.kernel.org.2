Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CD53606C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhDOKLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:11:35 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:49548 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232130AbhDOKLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:11:24 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FAAiO8025296;
        Thu, 15 Apr 2021 12:10:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=YgR95qJbnY88GSSbGo8/E0RP3WdZAqX5gAb2nU9n4cc=;
 b=ji4mrK8yKwlf2gpM9qLBzdDLEMG7krQZ9cXFHEXpR//lr6XGPrp1dG/6pP6L32nnLWhK
 2k3dlgbSVUsEyvxmWm2Xw9TCiwY/vb9S2sXYAz9VLfJI++VxZQzrTIKaafxoud1QGq32
 51wodNnZ6BL4fnOGmi9XsqRUsOO3TfpgFxm84pmNrt9hJo1vA9KGNhd1fu8MbpwdeJ1I
 QCQnqrPf6Ll0vx2RGe5aWsGJe1DW+yq+t7gBJTvpGo78V9OKTRKyLCwaSjuivIcJmpa5
 n7zSN8sO0QeWVFQ/l8vWUgKTAU3GrjvxmixE9Der4qEcPBCWmcK9tPsvCkfHuteiSnGK bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37xes0t5yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 12:10:45 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CF1EA100034;
        Thu, 15 Apr 2021 12:10:44 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BE77A226377;
        Thu, 15 Apr 2021 12:10:44 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Apr 2021 12:10:44
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
Subject: [PATCH 06/13] ARM: dts: stm32: fix i2c node name on stm32f746 to prevent warnings
Date:   Thu, 15 Apr 2021 12:10:30 +0200
Message-ID: <20210415101037.1465-7-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_03:2021-04-15,2021-04-15 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace upper case by lower case in i2c nodes name.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 72c1b76684b6..014b416f57e6 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -360,9 +360,9 @@
 			status = "disabled";
 		};
 
-		i2c3: i2c@40005C00 {
+		i2c3: i2c@40005c00 {
 			compatible = "st,stm32f7-i2c";
-			reg = <0x40005C00 0x400>;
+			reg = <0x40005c00 0x400>;
 			interrupts = <72>,
 				     <73>;
 			resets = <&rcc STM32F7_APB1_RESET(I2C3)>;
-- 
2.17.1

