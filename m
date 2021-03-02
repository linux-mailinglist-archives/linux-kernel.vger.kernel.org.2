Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F293C32AD89
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1840034AbhCBV77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:59:59 -0500
Received: from ms9.eaxlabs.cz ([147.135.177.209]:50526 "EHLO ms9.eaxlabs.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835363AbhCBTED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 14:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eaxlabs.cz; s=mail;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=65e45oHZO+BxFf5UqN9fVtID/K010U91Mz2QcQ/swdo=;
        b=EDAtFQZ9mVFD65Wff/a94mHlD9FCA6zVKQueKKYilfU3rhnQR4/xuDvTEry+n7OtG5lR54ychj7JxOF2ANKxGfpGjZgsSY0uoYSHBF/LvtumbmdaaRxMbYsXU5+wcfT2VffoR89NzyhIFtMWmSSw7QtQ+RHAIqQaOqQrJqUIZd8=;
Received: from [82.99.129.6] (helo=localhost.localdomain)
        by ms9.eaxlabs.cz with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <devik@eaxlabs.cz>)
        id 1lHAIX-000335-MD; Tue, 02 Mar 2021 20:03:11 +0100
From:   Martin Devera <devik@eaxlabs.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Martin Devera <devik@eaxlabs.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jiri Slaby <jirislaby@kernel.org>, Le Ray <erwan.leray@st.com>,
        fabrice.gasnier@foss.st.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/2] dt-bindings: serial: Add rx-tx-swap to stm32-usart
Date:   Tue,  2 Mar 2021 20:03:02 +0100
Message-Id: <20210302190303.28630-1-devik@eaxlabs.cz>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <aeefa74e-fa19-6c31-5240-0f14fca89298@foss.st.com>
References: <aeefa74e-fa19-6c31-5240-0f14fca89298@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new rx-tx-swap property to allow for RX & TX pin swapping.

Signed-off-by: Martin Devera <devik@eaxlabs.cz>
---
 .../devicetree/bindings/serial/st,stm32-uart.yaml  | 32 +++++++++++++++-------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 8631678283f9..6eab2debebb5 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -9,9 +9,6 @@ maintainers:
 
 title: STMicroelectronics STM32 USART bindings
 
-allOf:
-  - $ref: rs485.yaml
-
 properties:
   compatible:
     enum:
@@ -40,6 +37,10 @@ properties:
 
   uart-has-rtscts: true
 
+  rx-tx-swap:
+    type: boolean
+    maxItems: 1
+
   dmas:
     minItems: 1
     maxItems: 2
@@ -66,13 +67,24 @@ properties:
   linux,rs485-enabled-at-boot-time: true
   rs485-rx-during-tx: true
 
-if:
-  required:
-    - st,hw-flow-ctrl
-then:
-  properties:
-    cts-gpios: false
-    rts-gpios: false
+allOf:
+  - $ref: rs485.yaml
+  - if:
+      required:
+        - st,hw-flow-ctrl
+    then:
+      properties:
+        cts-gpios: false
+        rts-gpios: false
+  - if:
+      required:
+        - rx-tx-swap
+    then:
+      properties:
+        compatible:
+          enum:
+            - st,stm32f7-uart
+            - st,stm32h7-uart
 
 required:
   - compatible
-- 
2.11.0

