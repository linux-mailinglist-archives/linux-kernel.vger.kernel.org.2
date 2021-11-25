Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D7045DC9D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 15:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355873AbhKYOuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 09:50:01 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35598 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1355802AbhKYOrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 09:47:53 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1APCh3ZM016506;
        Thu, 25 Nov 2021 15:44:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=0Sc7MpkQ4w7bhIf6WOu/6TD/ofcTkd3wIkQ/r5c2lng=;
 b=1qcEXKxHypV6r7CBf8ng3nCny6zbqXnJwlbpcw+hCGSCBDGP53Eb1J9eBx13sqEiG5G2
 7FE45z90NqRJ3SgzjhwMk43xn9egrF0kRZ2AulEq1HJo6GIJsVaUv6LlvT/oWAaBuR0O
 rjLqH8MsqVz2Tpt9Fu8Efctz3wndt8DcsUFXoSutpdwBFImyjpH/abHU2jbHW5WF/C8G
 HjkJwHwhf3wnIhkTSXG9pTUJglXbTU48+SnJQxUDXYVgozoY/cvyKsW9atCLO+d93xaV
 JHDH9xLHCc46SFLQxHnMSUQhrTxI6vBOBTKA5uL32jURf92I4xfSVhBWlzsJBIxe5Z3G ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cjar3gq35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 15:44:23 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0FEBA10002A;
        Thu, 25 Nov 2021 15:44:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 081E7237D97;
        Thu, 25 Nov 2021 15:44:23 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 25 Nov 2021 15:44:22
 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        "Rob Herring" <robh+dt@kernel.org>, <arnaud.pouliquen@foss.st.com>,
        <amelie.delaunay@foss.st.com>, <alain.volmat@foss.st.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
Subject: [PATCH v2 3/4] ASoC: dt-bindings: stm32: i2s: update example
Date:   Thu, 25 Nov 2021 15:40:52 +0100
Message-ID: <20211125144053.774-4-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211125144053.774-1-olivier.moysan@foss.st.com>
References: <20211125144053.774-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-25_06,2021-11-25_01,2020-04-07_01
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
index 33ba15363c0f..591f9c941f54 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
@@ -79,7 +79,7 @@ examples:
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

