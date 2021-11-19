Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16476457103
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbhKSOuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:50:04 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34554 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234402AbhKSOt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:49:56 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AJ9TghH001983;
        Fri, 19 Nov 2021 15:46:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=/exZE7P/JbL4L1/Mlq2CYYwal/dTmekSv8AXxXUeVKU=;
 b=fa7oWXMjX+DqVaTKZ+RTJpM2BAWUClJ2YS6HBs+eblvBX2behhsAmsjrV7LALCilRyzv
 XWktg5xWJPH21+ocyA1LCOVESijDifNHp5efeOQMLKp3DudQUaoDlptiWgPWZ+vuu6Bw
 ZGYJtvJSJguymoLhKfyMii/s7LhNAqBiMqBc698dyn3555KeL/2PqFGNOn9tFDEiwee+
 ihmMz0/ZuitumEiV27R3cPR6S5DJiSDl2L53kOgIz6ogZ1YhwouHL7PF5w3N1pBLD3V7
 XE8WH55LMJaO6CmcBUjmO4VCQKz6spdR5V2Ys/yZTUfgXEFOHnFE9NPzKNZG//mhVoLv 0A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ce1knc8jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 15:46:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 53699100034;
        Fri, 19 Nov 2021 15:46:42 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4C2EA231DF0;
        Fri, 19 Nov 2021 15:46:42 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 19 Nov 2021 15:46:41
 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <arnaud.pouliquen@foss.st.com>, <fabrice.gasnier@foss.st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
Subject: [PATCH 1/9] ASoC: dt-bindings: stm32: i2s: update example
Date:   Fri, 19 Nov 2021 15:45:43 +0100
Message-ID: <20211119144551.7577-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119144551.7577-1-olivier.moysan@foss.st.com>
References: <20211119144551.7577-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_09,2021-11-17_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some STM32 SPI peripheral instances support I2S for audio.
SPI and I2S features were initially described through two separated
nodes in the SoC Device Tree. In the next SoC Device Trees
a single node is used to describe SPI peripheral, leading
to a change in node name for I2S.
Change example in STM32 DT binding example to match this change.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
index 6feb5a09c184..ae41fa80bdb7 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
@@ -74,7 +74,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/stm32mp1-clks.h>
-    i2s2: audio-controller@4000b000 {
+    spi2s2: spi@4000b000 {
         compatible = "st,stm32h7-i2s";
         #sound-dai-cells = <0>;
         reg = <0x4000b000 0x400>;
-- 
2.17.1

