Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1460538B3F0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhETQDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:03:31 -0400
Received: from router.aksignal.cz ([62.44.4.214]:57560 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbhETQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:03:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 083AC491C0;
        Thu, 20 May 2021 18:01:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 35gswrYL4i2Y; Thu, 20 May 2021 18:01:32 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 9CB90491BE;
        Thu, 20 May 2021 18:01:32 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 3/5] nvmem: eeprom: add documentation for FRAM
Date:   Thu, 20 May 2021 18:01:25 +0200
Message-Id: <20210520160127.51394-4-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520160127.51394-1-jiri.prchal@aksignal.cz>
References: <20210520160127.51394-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added dt binding documentation.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v2: fixed dt_binding_check warnings thanks to Rob Herring
v3: resend and added more recipients
v4: resend
v5: no change here
---
 .../devicetree/bindings/eeprom/at25.yaml      | 31 +++++++++++++++----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom/at25.yaml b/Documentation/devicetree/bindings/eeprom/at25.yaml
index 121a601db22e..840ee7a83a14 100644
--- a/Documentation/devicetree/bindings/eeprom/at25.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at25.yaml
@@ -4,14 +4,16 @@
 $id: "http://devicetree.org/schemas/eeprom/at25.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: SPI EEPROMs compatible with Atmel's AT25
+title: SPI EEPROMs or FRAMs compatible with Atmel's AT25
 
 maintainers:
   - Christian Eggers <ceggers@arri.de>
 
 properties:
   $nodename:
-    pattern: "^eeprom@[0-9a-f]{1,2}$"
+    anyOf:
+      - pattern: "^eeprom@[0-9a-f]{1,2}$"
+      - pattern: "^fram@[0-9a-f]{1,2}$"
 
   # There are multiple known vendors who manufacture EEPROM chips compatible
   # with Atmel's AT25. The compatible string requires two items where the
@@ -31,6 +33,7 @@ properties:
               - microchip,25lc040
               - st,m95m02
               - st,m95256
+              - cypress,fm25
 
           - const: atmel,at25
 
@@ -48,7 +51,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072]
     description:
-      Size of the eeprom page.
+      Size of the eeprom page. FRAMs don't have pages.
 
   size:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -101,9 +104,19 @@ required:
   - compatible
   - reg
   - spi-max-frequency
-  - pagesize
-  - size
-  - address-width
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: cypress,fm25
+    then:
+      required:
+        - pagesize
+        - size
+        - address-width
 
 additionalProperties: false
 
@@ -126,4 +139,10 @@ examples:
             size = <32768>;
             address-width = <16>;
         };
+
+        fram@1 {
+            compatible = "cypress,fm25", "atmel,at25";
+            reg = <1>;
+            spi-max-frequency = <40000000>;
+        };
     };
-- 
2.25.1

