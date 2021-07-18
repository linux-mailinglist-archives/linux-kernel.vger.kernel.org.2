Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0C73CC711
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 02:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhGRAot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 20:44:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54358 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhGRAos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 20:44:48 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16I0fVOg068128;
        Sat, 17 Jul 2021 19:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626568891;
        bh=PiqmPCh8Le/+a2lKDpBMpR+4Ut+G4awxjwCJtRnmK5E=;
        h=From:To:CC:Subject:Date;
        b=K1k82Cex/RiKNWYOnJntgl++ZbNBWeZMMbxK7/u3336HMFYgpktTW4Pyltl20yGyi
         sg4hxH5RMaS1WEiN8yka1nTXNxhfCtrr1hpDQItvfjq09FpE92m9LiGJdbZ16Q0ij2
         OVwmiXCdOaZ0zxcL9raTUkAcGhlmNqpqpoQMy3b0=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16I0fVl2004765
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 17 Jul 2021 19:41:31 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 17
 Jul 2021 19:41:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Sat, 17 Jul 2021 19:41:31 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16I0fQW1038673;
        Sat, 17 Jul 2021 19:41:27 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Michael Walle <michael@walle.cc>,
        Apurva Nandan <a-nandan@ti.com>
Subject: [PATCH] dt-bindings: mtd: spi-nand: Convert to DT schema format
Date:   Sun, 18 Jul 2021 00:41:25 +0000
Message-ID: <20210718004125.733-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.31.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert spi-nand.txt binding to YAML format with an added example.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 .../devicetree/bindings/mtd/spi-nand.txt      |  5 --
 .../devicetree/bindings/mtd/spi-nand.yaml     | 74 +++++++++++++++++++
 2 files changed, 74 insertions(+), 5 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml

diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.txt b/Documentation/devicetree/bindings/mtd/spi-nand.txt
deleted file mode 100644
index 8b51f3b6d55c..000000000000
--- a/Documentation/devicetree/bindings/mtd/spi-nand.txt
+++ /dev/null
@@ -1,5 +0,0 @@
-SPI NAND flash
-
-Required properties:
-- compatible: should be "spi-nand"
-- reg: should encode the chip-select line used to access the NAND chip
diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.yaml b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
new file mode 100644
index 000000000000..366b86e1b19c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/spi-nand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI NAND flash
+
+maintainers:
+  - Apurva Nandan <a-nandan@ti.com>
+
+allOf:
+  - $ref: "mtd.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - const: spi-nand
+
+  reg:
+    items:
+      description:
+        should encode the chip-select line used to access the NAND chip
+
+  spi-max-frequency: true
+  spi-rx-bus-width: true
+  spi-tx-bus-width: true
+
+  partitions:
+    type: object
+
+  '#address-cells': true
+  '#size-cells': true
+
+patternProperties:
+  # Note: use 'partitions' node for new users
+  '^partition@':
+    type: object
+
+  "^otp(-[0-9]+)?$":
+    type: object
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@6 {
+            #address-cells = <1>;
+            #size-cells = <1>;
+            compatible = "spi-nand";
+            reg = <0x6>;
+            spi-max-frequency = <42000000>;
+
+            partitions {
+                compatible = "fixed-partitions";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                partition@0 {
+                    label = "boot";
+                    reg = <0 0x200000>;
+                };
+
+                partition@200000 {
+                    label = "rootfs";
+                    reg = <0x200000 0xce0000>;
+                };
+            };
+        };
+    };
-- 
2.17.1

