Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB14363EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbhDSJkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:40:43 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:16850 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238694AbhDSJkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:40:01 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13J9R3vj012064;
        Mon, 19 Apr 2021 11:39:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=3/oqZDlBuyqo9D4AkKZez8xlsjohLwpFOwDk6W5UpGU=;
 b=eHUegqfLoHji9HfMSm0s55EEAyYeZpYu0EP+u716GJANPvi6gcG3h1AHD4Yrthtx9NPq
 ZsjmgjgLcc78AbA3K+no9/+/trqTgycf28j7NvOshSEA1DUJ4z4ObW8a5EOvs5GWu+ri
 wg7L/xeG0TOw/dejOKDfqpEBJLVFhf26U8KK7+lrXqG2CmjTKfsItYVGgMS8dNrRHS3W
 XCoiqRj67CXaf5t+uC65NpvlZoWmWXeMLIfVAf2lvFSskZw5cUydGnX7DQRLW0KgBTde
 ZLHjT0XEylkExmGGKVc9oHLakpp0dSxmE584A9wREKLpDNfXnFXgaaHiQNrKloYLZe5J Ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 380rdgbh7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 11:39:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 065AA10002A;
        Mon, 19 Apr 2021 11:39:14 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D899020A07F;
        Mon, 19 Apr 2021 11:39:13 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Apr 2021 11:39:13
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
Subject: [PATCH v3 10/11] dt-bindings: clock: stm32mp1 new compatible for secure rcc
Date:   Mon, 19 Apr 2021 11:38:51 +0200
Message-ID: <20210419093852.14978-11-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210419093852.14978-1-gabriel.fernandez@foss.st.com>
References: <20210419093852.14978-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_05:2021-04-16,2021-04-19 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Introduce new compatible string "st,stm32mp1-rcc-secure" for
stm32mp1 clock driver when the device is configured with RCC
security support hardened.

Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 .../devicetree/bindings/clock/st,stm32mp1-rcc.yaml          | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
index 4e385508f516..8b1ecb2ecdd5 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
+++ b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
@@ -54,7 +54,9 @@ properties:
 
   compatible:
     items:
-      - const: st,stm32mp1-rcc
+      - enum:
+          - st,stm32mp1-rcc-secure
+          - st,stm32mp1-rcc
       - const: syscon
 
   reg:
@@ -71,7 +73,7 @@ additionalProperties: false
 examples:
   - |
     rcc: rcc@50000000 {
-        compatible = "st,stm32mp1-rcc", "syscon";
+        compatible = "st,stm32mp1-rcc-secure", "syscon";
         reg = <0x50000000 0x1000>;
         #clock-cells = <1>;
         #reset-cells = <1>;
-- 
2.17.1

