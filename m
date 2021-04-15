Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C86E3606CC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhDOKLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:11:47 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:49560 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232387AbhDOKL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:11:26 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FAAhgb025278;
        Thu, 15 Apr 2021 12:10:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=dgT2ZwyZ8256uUTBJSe4CtsB5Fasf+nqj/cQAxVbWVc=;
 b=nH4lnb1ILN9FUQnPQyTOsvB5JoRnNRuz+yFsFAqxegu+CwTASmImLaXHKIhR0JoxpteB
 0OTHNi9NuC1iYHETPA4dVWH3+TA1NQfLc/nds5aYKvgIl6yP1ozGXpvMLjAkc0XkQ+VD
 WBz/6/c0tChOEQfuOYgH0TluGiKVqM1YyfRP+5PQoQsI/QmdshkcK0l5W+jtDn5AdCJU
 2YQEjhJmUbVeB4rvZXv8chrsYOAiFSNnbHIWblIX+3CfKLLQzPehO4hTS9B/6NHguQJZ
 vvbxdXjZqp04SHYFPtMJ/NhQEZBe5gBrUG3kScrYIV95BjHUDpjajdsDPv+jA6Y4n5Is sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37xes0t601-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 12:10:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 68F3B10002A;
        Thu, 15 Apr 2021 12:10:46 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5A425226377;
        Thu, 15 Apr 2021 12:10:46 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Apr 2021 12:10:46
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
Subject: [PATCH 08/13] dt-bindings: net: document ptp_ref clk in dwmac
Date:   Thu, 15 Apr 2021 12:10:32 +0200
Message-ID: <20210415101037.1465-9-alexandre.torgue@foss.st.com>
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

ptp_ref clk has been added in DT but not documented which makes yaml
validation failed:

ethernet@5800a000: clocks: [[6, 105], [6, 103], [6, 104], [6, 123],
[6, 169], [6, 112]] is too long
ethernet@5800a000: clock-names: ['stmmaceth', 'mac-clk-tx', 'mac-clk-rx',
'eth-ck', 'ptp_ref', 'ethstp'] is too long

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 0642b0f59491..0201a879399f 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -89,7 +89,7 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 5
+    maxItems: 6
     additionalItems: true
     items:
       - description: GMAC main clock
@@ -101,7 +101,7 @@ properties:
 
   clock-names:
     minItems: 1
-    maxItems: 5
+    maxItems: 6
     additionalItems: true
     contains:
       enum:
diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
index 27eb6066793f..a1c490f3af02 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
@@ -46,17 +46,18 @@ properties:
 
   clocks:
     minItems: 3
-    maxItems: 5
+    maxItems: 6
     items:
       - description: GMAC main clock
       - description: MAC TX clock
       - description: MAC RX clock
       - description: For MPU family, used for power mode
       - description: For MPU family, used for PHY without quartz
+      - description: PTP clock
 
   clock-names:
     minItems: 3
-    maxItems: 5
+    maxItems: 6
     contains:
       enum:
         - stmmaceth
@@ -64,6 +65,7 @@ properties:
         - mac-clk-rx
         - ethstp
         - eth-ck
+        - ptp_ref
 
   st,syscon:
     $ref: "/schemas/types.yaml#/definitions/phandle-array"
-- 
2.17.1

