Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6355C3E53DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 08:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbhHJGt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 02:49:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47850 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhHJGtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:49:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17A6nAh2050275;
        Tue, 10 Aug 2021 01:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628578150;
        bh=MYLJFCwahrTEm7bq5Zb4TWOzVKjmV67QXu9jFv0GK8E=;
        h=From:To:CC:Subject:Date;
        b=ssbBEZHx3MfvFarhhd8xsVqo4svJ6kk9hLvHBGeFQxkm4Sl8unsXo1drZ32gCbOD/
         7WIZcBUsRqnRCVTiVHn4vULoBl4v2SGurs5C8QhURKlNOwan4kO+pTS7/N137MBqIh
         83SzLiP2PvT49tSoDwdq1ddi0krPLOqzDlBZY+C8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17A6nAv7087737
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Aug 2021 01:49:10 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 10
 Aug 2021 01:49:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 10 Aug 2021 01:49:10 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17A6n6qx011042;
        Tue, 10 Aug 2021 01:49:07 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: eeprom-93xx46: Convert to json schema\
Date:   Tue, 10 Aug 2021 12:18:59 +0530
Message-ID: <20210810064904.10846-1-a-govindraju@ti.com>
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

Device tree fixes required are posted in the following patch,
https://lore.kernel.org/patchwork/project/lkml/list/?series=511477


 .../bindings/misc/eeprom-93xx46.txt           | 29 --------
 .../bindings/misc/eeprom-93xx46.yaml          | 72 +++++++++++++++++++
 2 files changed, 72 insertions(+), 29 deletions(-)
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
index 000000000000..4254a7be5a70
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml
@@ -0,0 +1,72 @@
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
+  $nodename:
+    pattern: "@[0-9]+$"
+
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
+    spi0 {
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

