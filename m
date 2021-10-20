Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C385D434E83
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhJTPFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 11:05:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47216 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230355AbhJTPFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:05:40 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KE4S9J029447;
        Wed, 20 Oct 2021 17:03:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=nJXuhyQXitFXtPIaUWe8n59j2UiZ2FPRgTXRkj7zWl8=;
 b=ZdcKgVHNu9yk/H5h1Qcx/aFzEgBOR2FdkMonbXXwMtEGepiAn/n94+nErEV5IErzoJa4
 5PKb8gu0l0IF+2EtC+Wu8udIBtaLytGVIUvdpatRs9TDvG9BPaVNXvqY3+NuPwuIwAC0
 /2yEacD+r/5im+iqFV9JQBOFTwSAnxynPTmlgEZICw7AjLZMiLU95ZfOTKB4Sne8/cwb
 FJljuI/qCrxi3Agw68yk6wGg83edD7rqOknhMnSk1mvpt1VWks5h4sVY7W+wvoVqAbrR
 ND2RT+vlsDNO367HtAAnIP2OJ8Y4PA8SBafcS+GzuFE51n7WK2iKcVf5eW7MbfUcZhYj Gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3btfvstbkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 17:03:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ED175100034;
        Wed, 20 Oct 2021 17:03:14 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E603622A6E6;
        Wed, 20 Oct 2021 17:03:14 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 20 Oct 2021 17:03:14
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
Subject: [PATCH 1/1] ARM: dts: stm32: add pull-up to USART3 and UART7 RX pins on DKx boards
Date:   Wed, 20 Oct 2021 17:03:11 +0200
Message-ID: <20211020150311.10101-1-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_05,2021-10-20_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pull-up to USART3 and UART7 RX pins to allow loop tests between USART3
and UART7 on stm32mp15 DKx boards.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index e13c2a9762b8..fe6e6f50151d 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1816,7 +1816,7 @@
 		};
 		pins2 {
 			pinmux = <STM32_PINMUX('E', 7, AF7)>; /* UART7_RX */
-			bias-disable;
+			bias-pull-up;
 		};
 	};
 
@@ -1826,7 +1826,7 @@
 		};
 		pins2 {
 			pinmux = <STM32_PINMUX('E', 7, AF7)>; /* UART7_RX */
-			bias-disable;
+			bias-pull-up;
 		};
 	};
 
@@ -1971,7 +1971,7 @@
 		pins2 {
 			pinmux = <STM32_PINMUX('B', 12, AF8)>, /* USART3_RX */
 				 <STM32_PINMUX('I', 10, AF8)>; /* USART3_CTS_NSS */
-			bias-disable;
+			bias-pull-up;
 		};
 	};
 
@@ -1988,7 +1988,7 @@
 		};
 		pins3 {
 			pinmux = <STM32_PINMUX('B', 12, AF8)>; /* USART3_RX */
-			bias-disable;
+			bias-pull-up;
 		};
 	};
 
@@ -2012,7 +2012,7 @@
 		pins2 {
 			pinmux = <STM32_PINMUX('B', 12, AF8)>, /* USART3_RX */
 				 <STM32_PINMUX('B', 13, AF7)>; /* USART3_CTS_NSS */
-			bias-disable;
+			bias-pull-up;
 		};
 	};
 
@@ -2029,7 +2029,7 @@
 		};
 		pins3 {
 			pinmux = <STM32_PINMUX('B', 12, AF8)>; /* USART3_RX */
-			bias-disable;
+			bias-pull-up;
 		};
 	};
 
-- 
2.17.1

