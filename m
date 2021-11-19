Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB33457105
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhKSOuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:50:11 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:54080 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235994AbhKSOt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:49:56 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AJBRpcw028236;
        Fri, 19 Nov 2021 15:46:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=avY3kzoZ7JYqNnSmFlhBr8PO96T/UAj7xI/KkJNSdyc=;
 b=EnN5lT32hbF1SnsrymDgKIN7cpY7iJEkaa/7bnkg1Cn9lln2G4G7AvMVNhTvabPx9yon
 8XOGh9Gi19mM0BJF8GIARotz9VpNGXCwDyzDzEv4kiiiEAkAOegVcb+SdN98lcq/E7Ed
 1NIZYOQqAt3M/B/DhvrpOmK6tY327XiIdu5amDsfo3VEcyqu+Bz1UGEcIThBH9nm5ut+
 vfscYKr+ZwwA38rXoEqy1yOSIZCCvIrwAbs5Pt57PCQ2HOqwxgA3LRKTvYaQK8LxC1m3
 i64p2W47g9I9Kc8zFA5Bo9aaMyIE/MCaANZZ7ci4J/UtpZhAkqv4MwF8cDVKKZaQ9TlI Iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ce6b1k0e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 15:46:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DD405100034;
        Fri, 19 Nov 2021 15:46:43 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D47AC231DF1;
        Fri, 19 Nov 2021 15:46:43 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 19 Nov 2021 15:46:43
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
Subject: [PATCH 3/9] ASoC: dt-bindings: stm32: i2s: allow additional properties.
Date:   Fri, 19 Nov 2021 15:45:45 +0100
Message-ID: <20211119144551.7577-4-olivier.moysan@foss.st.com>
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

The STM32 SPI peripheral supports both SPI and I2S protocols.
In the SoC device tree the node describes the peripheral as an
SPI peripheral by default. This default configuration can be
overwritten in board device tree to use the IP as an I2S peripheral.
In this case the address-cells and size-cells properties from
SoC DT SPI node should not be checked against STM32 I2S bindings.
Set additionalProperties to "true" to allow these extra properties.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
index 52e3368d34dc..591f9c941f54 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
@@ -73,7 +73,7 @@ required:
   - dmas
   - dma-names
 
-additionalProperties: false
+additionalProperties: true
 
 examples:
   - |
-- 
2.17.1

