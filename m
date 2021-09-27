Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E8441938C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhI0Lrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:47:52 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:51802 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234067AbhI0Lrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:47:51 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RAcRWp015313;
        Mon, 27 Sep 2021 13:45:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=JY/RZy696PhrTY1tk4j9/0LRz+75bBXuC1oBNKXvcTs=;
 b=RQ52hqg2BHAeLjSbXR4c7+zE72RzsmoE14XirXepeh7GalqqA6Qc23L8HfIoVJGAZlNA
 xr7J13ih6x6nCFdT4S5iYx0CxwJ4VFZytD4u4hdoC810TSiiRSOcPQ9rKskITBbJm4Pr
 YHeO1CmQLvzL4xIywpRp18k5Aw19L/p+v8n4ktx5KBIP4pytX6JnMPYteFFdFx6LDh7X
 QJxGPCrxXIgBKpnontKRjihTfQHjJZik7SbG7y2nYxXmYLUKWrit3JyCHrrG/lA/n8lH
 Xzjgb7yh8uwYPxYnKYocYxvthpipAjQRCeZ45EWQr74yIQUKI6E5aVG4LIEcMCgPgcEX Yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bbau50w5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 13:45:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2FAB710002A;
        Mon, 27 Sep 2021 13:45:55 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CCA32221784;
        Mon, 27 Sep 2021 13:45:55 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 27 Sep 2021 13:45:55
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
Subject: [PATCH 1/1] ARM: dts: stm32: fix AV96 board SAI2B pin muxing on stm32mp15
Date:   Mon, 27 Sep 2021 13:45:53 +0200
Message-ID: <20210927114553.21843-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_04,2021-09-24_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix SAI2B pin muxing for AV96 board on STM32MP15.
The label "sai2a-4" is defined twice. Change redundant label to "sai2b-4".

Fixes: dcf185ca8175 ("ARM: dts: stm32: Add alternate pinmux for SAI2 pins on stm32mp15")

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index 5b60ecbd718f..b9cc9e0dd4fc 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1235,7 +1235,7 @@
 		};
 	};
 
-	sai2b_pins_c: sai2a-4 {
+	sai2b_pins_c: sai2b-4 {
 		pins1 {
 			pinmux = <STM32_PINMUX('F', 11, AF10)>; /* SAI2_SD_B */
 			bias-disable;
-- 
2.17.1

