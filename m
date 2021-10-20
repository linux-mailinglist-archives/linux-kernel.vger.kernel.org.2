Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB38434E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhJTPFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 11:05:24 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:56780 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229570AbhJTPFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:05:22 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KD3Z97008294;
        Wed, 20 Oct 2021 17:02:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=mtOAELMMg2FfpdI+Q7BA2qRARYKxutpR06ajPBwwq9Y=;
 b=yQQSQXJ542OSxFmsRHyGX9DTkSXeW3qYEXUypRzpJAigAUdasdc19knryijFmr72fxBX
 LMzO45yBMizMP2Fps3/NA1mU9bhy5ZoHM5XaiMNE4IZymllzKZiBfaci5VTIuRkqQUwP
 X62mdhrQTeyDfg/1xKblJoCnM8FMlPBM2p34U8oNGbZBEg1+52e2S1eiJElW8L/4JgL2
 I4T2DhtksiUDYk/sor3is9KUTKNa1O5+wWfoz57X29v1vXxLGtiIP3Bf1W4EqlTbr67M
 +KW7tvdcQrnJXcxd6m8XorfhrzdL4vrqIdK+dGunS6/wAo1zZyjG7EFh/Rd/whG7z/rP 7g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3btknp8pjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 17:02:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5136B10002A;
        Wed, 20 Oct 2021 17:02:52 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 48D7922A6E6;
        Wed, 20 Oct 2021 17:02:52 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 20 Oct 2021 17:02:52
 +0200
From:   Erwan Le Ray <erwan.leray@foss.st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 1/1] ARM: dts: stm32: clean useless spaces in uart4_idle_pins_a node
Date:   Wed, 20 Oct 2021 17:02:30 +0200
Message-ID: <20211020150230.9939-1-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_05,2021-10-20_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean useless spaces in uart4_idle_pins_a node.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index 5b60ecbd718f..e13c2a9762b8 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1737,20 +1737,20 @@
 	};
 
 	uart4_idle_pins_a: uart4-idle-0 {
-		   pins1 {
-			 pinmux = <STM32_PINMUX('G', 11, ANALOG)>; /* UART4_TX */
-		   };
-		   pins2 {
-			 pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
-			 bias-disable;
-		   };
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 11, ANALOG)>; /* UART4_TX */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
+			bias-disable;
+		};
 	};
 
 	uart4_sleep_pins_a: uart4-sleep-0 {
-		   pins {
+		pins {
 			pinmux = <STM32_PINMUX('G', 11, ANALOG)>, /* UART4_TX */
 				 <STM32_PINMUX('B', 2, ANALOG)>; /* UART4_RX */
-		    };
+		};
 	};
 
 	uart4_pins_b: uart4-1 {
-- 
2.17.1

