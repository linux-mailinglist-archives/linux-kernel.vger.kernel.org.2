Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDC5363EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbhDSJkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:40:13 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:28308 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238733AbhDSJj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:39:58 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13J9RIWq027864;
        Mon, 19 Apr 2021 11:39:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=4T6Qz2/JmceHcxFve+YnEKkureSv6YCau+hALUO8xJQ=;
 b=Yu2W64cYtqLQJYD3M7nqghoMy56xUhZJ6A+9r7lRD2pyyQbdOcKo2eFJe4GqdmC92rkE
 UitqG4UPgii84VJKa+otoSjCIejgJoZVhsQ3wwWS/TXPbpIPxOrTyZp7xanaQy2dpgsl
 DwQrExp0Po2dUPTFJ9cPe1Api9ebJRPHrXwsY1PWN2K71yw9PK1zgeHSuRZOMLhz0bk4
 jWF0F9RW4SU+5+WHC/5mK5D9WPIHXbcPHH2Suv0SFrECfAr5Bb4rLkxnI/OZtDlSY5XG
 UXb4IDY9Efb5Va+zajfFzxzT+qTOmezxw4fH9lznmC0TQ74NdtMoN+LTc9MfJ9K20sDp Vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 380s8c3bgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 11:39:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4A1F4100038;
        Mon, 19 Apr 2021 11:39:12 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3A4BA20A07F;
        Mon, 19 Apr 2021 11:39:12 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Apr 2021 11:39:11
 +0200
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne Carriere <etienne.carriere@st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        <marex@denx.de>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v3 08/11] dt-bindings: reset: add IDs for SCMI reset domains on stm32mp15
Date:   Mon, 19 Apr 2021 11:38:49 +0200
Message-ID: <20210419093852.14978-9-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210419093852.14978-1-gabriel.fernandez@foss.st.com>
References: <20210419093852.14978-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_05:2021-04-16,2021-04-19 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

stm32mp15 TZ secure firmware provides SCMI reset domains for
secure resources. This change defines the SCMI reset domain
identifiers used by SCMI agents and servers.

Stm32mp15 TZ secure firmware provides SCMI clocks for oscillators, some
PLL output and few secure aware interfaces. This change defines the
SCMI clock identifiers used by SCMI agents and servers.

Server SCMI0 exposes reset controllers for resources under RCC[TZEN]
configuration control.

Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/reset/stm32mp1-resets.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/dt-bindings/reset/stm32mp1-resets.h b/include/dt-bindings/reset/stm32mp1-resets.h
index f0c3aaef67a0..bc71924faa54 100644
--- a/include/dt-bindings/reset/stm32mp1-resets.h
+++ b/include/dt-bindings/reset/stm32mp1-resets.h
@@ -105,4 +105,17 @@
 #define GPIOJ_R		19785
 #define GPIOK_R		19786
 
+/* SCMI reset domain identifiers */
+#define RST_SCMI0_SPI6		0
+#define RST_SCMI0_I2C4		1
+#define RST_SCMI0_I2C6		2
+#define RST_SCMI0_USART1	3
+#define RST_SCMI0_STGEN		4
+#define RST_SCMI0_GPIOZ		5
+#define RST_SCMI0_CRYP1		6
+#define RST_SCMI0_HASH1		7
+#define RST_SCMI0_RNG1		8
+#define RST_SCMI0_MDMA		9
+#define RST_SCMI0_MCU		10
+
 #endif /* _DT_BINDINGS_STM32MP1_RESET_H_ */
-- 
2.17.1

