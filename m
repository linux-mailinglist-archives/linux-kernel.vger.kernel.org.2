Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE84457104
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbhKSOuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:50:09 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:54082 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236007AbhKSOt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:49:57 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AJBfcYA028223;
        Fri, 19 Nov 2021 15:46:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=YgTsiNpn/O0bA8EBoSD/l5Ei3zU2iWgOI8SBO4glG8g=;
 b=nYVimgC+1hJ3pr3057DlBf1/lHKlXzHq1Nc3TnasV0SXKFpoyz2xh71QT9VOcx9AtHEe
 GdeC7XiOPZ29q6p3aV+E59cu/i0AyIUWPmCg+tBNTmSZFvZRpj1amnzRvP3bDKVH32rS
 o3knzL91Kfc/S5fChLncxvScmrDQ/YZATzsUGXAN2iqgiW+jTkBEYI96v1KJtegi9Q8h
 8ugkgFX/BJXew5/clUwCgCUlTD7WaanroFOJ3eUpyBtns/jfDj7Kfm864eKC3qKkUwLQ
 wYZats3n22K3XW7oCTvSeVNSKAJhR17fvcznQ/GGONdVOwIkAt4oLOVZ70PfKOQ1ewDm sQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ce6b1k0e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 15:46:43 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 16CF210002A;
        Fri, 19 Nov 2021 15:46:43 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0FF5D231DF0;
        Fri, 19 Nov 2021 15:46:43 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 19 Nov 2021 15:46:42
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
Subject: [PATCH 2/9] ASoC: dt-bindings: stm32: i2s: add audio-graph-card port
Date:   Fri, 19 Nov 2021 15:45:44 +0100
Message-ID: <20211119144551.7577-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119144551.7577-1-olivier.moysan@foss.st.com>
References: <20211119144551.7577-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_09,2021-11-17_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STM2 I2S DAI can be connected via the audio-graph-card.
Add port entry into the bindings.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
index ae41fa80bdb7..52e3368d34dc 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
@@ -58,6 +58,11 @@ properties:
     description: Configure the I2S device as MCLK clock provider.
     const: 0
 
+patternProperties:
+  '^port@[0-9]':
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - "#sound-dai-cells"
-- 
2.17.1

