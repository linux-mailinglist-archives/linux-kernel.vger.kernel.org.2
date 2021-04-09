Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4556935A266
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhDIPyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:54:20 -0400
Received: from router.aksignal.cz ([62.44.4.214]:36874 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhDIPyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:54:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id A35454120F;
        Fri,  9 Apr 2021 17:47:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 3TNc_6uVMz8A; Fri,  9 Apr 2021 17:47:26 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 5F65141212;
        Fri,  9 Apr 2021 17:47:25 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH 3/3] nvmem: eeprom: add documentation for FRAM
Date:   Fri,  9 Apr 2021 17:47:20 +0200
Message-Id: <20210409154720.130902-4-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409154720.130902-1-jiri.prchal@aksignal.cz>
References: <20210409154720.130902-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added dt binding documentation.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 Documentation/devicetree/bindings/eeprom/at25.yaml | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom/at25.yaml b/Documentation/devicetree/bindings/eeprom/at25.yaml
index 121a601db22e..f9191b67080d 100644
--- a/Documentation/devicetree/bindings/eeprom/at25.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at25.yaml
@@ -4,7 +4,7 @@
 $id: "http://devicetree.org/schemas/eeprom/at25.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: SPI EEPROMs compatible with Atmel's AT25
+title: SPI EEPROMs or FRAMs compatible with Atmel's AT25
 
 maintainers:
   - Christian Eggers <ceggers@arri.de>
@@ -31,6 +31,7 @@ properties:
               - microchip,25lc040
               - st,m95m02
               - st,m95256
+              - cypress,fm25
 
           - const: atmel,at25
 
@@ -48,7 +49,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072]
     description:
-      Size of the eeprom page.
+      Size of the eeprom page. FRAMs don't have pages.
 
   size:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -101,6 +102,7 @@ required:
   - compatible
   - reg
   - spi-max-frequency
+  # these are for eeproms only
   - pagesize
   - size
   - address-width
@@ -127,3 +129,9 @@ examples:
             address-width = <16>;
         };
     };
+
+        fram@1 {
+            compatible = "cypress,fm25";
+            reg = <1>;
+            spi-max-frequency = <40000000>;
+        };
-- 
2.25.1

