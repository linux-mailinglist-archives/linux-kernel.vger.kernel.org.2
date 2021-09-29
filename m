Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1393C41C52B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 15:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344036AbhI2NGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 09:06:39 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46364 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343954AbhI2NGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 09:06:37 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 18TD4KjP4014979, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 18TD4KjP4014979
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Sep 2021 21:04:20 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 29 Sep 2021 21:04:20 +0800
Received: from localhost.localdomain (172.22.234.227) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 29 Sep 2021 21:04:18 +0800
From:   <derek.fang@realtek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <lars@metafoo.de>, <flove@realtek.com>, <oder_chiou@realtek.com>,
        <jack.yu@realtek.com>, <shumingf@realtek.com>,
        Derek Fang <derek.fang@realtek.com>
Subject: [PATCH] ASoC: dt-bindings: rt5682s: fix the device-tree schema errors
Date:   Wed, 29 Sep 2021 21:04:06 +0800
Message-ID: <20210929130406.24325-1-derek.fang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.234.227]
X-ClientProxiedBy: RTEXH36503.realtek.com.tw (172.21.6.25) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/29/2021 12:47:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzkvMjkgpFekyCAxMTowNjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Derek Fang <derek.fang@realtek.com>

Fix the device-tree schema errors that be reported by using 'make
dt_binding_check'.

Signed-off-by: Derek Fang <derek.fang@realtek.com>
---
 .../devicetree/bindings/sound/realtek,rt5682s.yaml   | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
index 7a5f1d0fd3e2..2b8b7b51fe55 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
@@ -29,6 +29,8 @@ properties:
       - 0 # dmic1 data is not used
       - 1 # using GPIO2 pin as dmic1 data pin
       - 2 # using GPIO5 pin as dmic1 data pin
+    description: |
+      Specify which GPIO pin be used as DMIC1 data pin.
 
   realtek,dmic1-clk-pin:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -36,12 +38,16 @@ properties:
       - 0 # dmic1 clk is not used
       - 1 # using GPIO1 pin as dmic1 clock pin
       - 2 # using GPIO3 pin as dmic1 clock pin
+    description: |
+      Specify which GPIO pin be used as DMIC1 clk pin.
 
   realtek,jd-src:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum:
       - 0 # No JD is used
       - 1 # using JD1 as JD source
+    description: |
+      Specify which JD source be used.
 
   realtek,ldo1-en-gpios:
     description: |
@@ -72,9 +78,9 @@ properties:
     const: 1
 
   clock-output-names:
-    items:
-      - description: Name given for DAI word clock output.
-      - description: Name given for DAI bit clock output.
+    minItems: 2
+    maxItems: 2
+    description: Name given for DAI word clock and bit clock outputs.
 
 additionalProperties: false
 
-- 
2.17.1

