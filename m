Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9EE3F020F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 12:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhHRK52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 06:57:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38944 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhHRK51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 06:57:27 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17IAuV8O096276;
        Wed, 18 Aug 2021 05:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629284191;
        bh=WNpR75t2NZhGv8HYINeGTm45pK+Jn6MrZ2/ZDO9dxZM=;
        h=From:To:CC:Subject:Date;
        b=t/ZsxIzgfTGC9O6WqZATpzaaG21VBnPb4ozD0RaE/t+VARh7gct6WQLtM6gq+x5EG
         a8MBm/6P7J8kiyEVkEQyGAvOqspadf7TQ3n4z5Z3ND0fFoA5rs6hxgxohrL+uBJ0WQ
         UEi69fZ0Iec/f3ddqgzxFpaQa9P2HMeqpatuRfzg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17IAuVV8009554
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Aug 2021 05:56:31 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 18
 Aug 2021 05:56:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 18 Aug 2021 05:56:30 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17IAuRKu104323;
        Wed, 18 Aug 2021 05:56:28 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: eeprom-93xx46: Convert to json schema
Date:   Wed, 18 Aug 2021 16:26:21 +0530
Message-ID: <20210818105626.31800-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert eeprom-93xx46 binding documentation from txt to yaml format

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

Changes since v1:
- removed unnecessary '\' from the subject line
- removed nodename property
- added type as boolean for read-only property
- corrected the node name of spi in example

 .../bindings/misc/eeprom-93xx46.txt           | 29 --------
 .../bindings/misc/eeprom-93xx46.yaml          | 70 +++++++++++++++++++
 2 files changed, 70 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
 create mode 100644 Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml

diff --git a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
deleted file mode 100644
index 72ea0af368d4..000000000000
--- a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-EEPROMs (SPI) compatible with Microchip Technology 93xx46 family.
-
-Required properties:
-- compatible : shall be one of:
-    "atmel,at93c46"
-    "atmel,at93c46d"
-    "atmel,at93c56"
-    "atmel,at93c66"
-    "eeprom-93xx46"
-    "microchip,93lc46b"
-- data-size : number of data bits per word (either 8 or 16)
-
-Optional properties:
-- read-only : parameter-less property which disables writes to the EEPROM
-- select-gpios : if present, specifies the GPIO that will be asserted prior to
-  each access to the EEPROM (e.g. for SPI bus multiplexing)
-
-Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
-apply.  In particular, "reg" and "spi-max-frequency" properties must be given.
-
-Example:
-	eeprom@0 {
-		compatible = "eeprom-93xx46";
-		reg = <0>;
-		spi-max-frequency = <1000000>;
-		spi-cs-high;
-		data-size = <8>;
-		select-gpios = <&gpio4 4 GPIO_ACTIVE_HIGH>;
-	};
diff --git a/Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml b/Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml
new file mode 100644
index 000000000000..44fd2f6f0d8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/eeprom-93xx46.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip 93xx46 SPI compatible EEPROM family dt bindings
+
+maintainers:
+  - Cory Tusar <cory.tusar@pid1solutions.com>
+
+properties:
+  compatible:
+    enum:
+      - atmel,at93c46
+      - atmel,at93c46d
+      - atmel,at93c56
+      - atmel,at93c66
+      - eeprom-93xx46
+      - microchip,93lc46b
+
+  data-size:
+    description: number of data bits per word
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [8, 16]
+
+  reg:
+    description: chip select of EEPROM
+    maxItems: 1
+
+  spi-max-frequency: true
+  spi-cs-high: true
+
+  read-only:
+    description:
+      parameter-less property which disables writes to the EEPROM
+    type: boolean
+
+  select-gpios:
+    description:
+      specifies the GPIO that needs to be asserted prior to each access
+      of EEPROM (e.g. for SPI bus multiplexing)
+    maxItems: 1
+
+
+required:
+  - compatible
+  - reg
+  - data-size
+  - spi-max-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      eeprom@0 {
+        compatible = "eeprom-93xx46";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        spi-cs-high;
+        data-size = <8>;
+        select-gpios = <&gpio4 4 GPIO_ACTIVE_HIGH>;
+      };
+    };
-- 
2.17.1

