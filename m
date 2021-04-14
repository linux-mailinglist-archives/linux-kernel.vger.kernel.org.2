Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CF935E9FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 02:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348252AbhDNA1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 20:27:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55470 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237029AbhDNA1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 20:27:47 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13E0RNID069350;
        Tue, 13 Apr 2021 19:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618360043;
        bh=8B7/458hroNL10JXEQwHmtq+ENc6/m8u+y+7uLgXATY=;
        h=From:To:CC:Subject:Date;
        b=XZXgm91u7PcSrIJakEoEDTFighynJUAtjniggNp4gejlBqL+R7kzuUewxG6AxQBOq
         e3z9zElvBbuktKjUH6Vesj1LO5McPF5bXhtCBd5ZO96Z3LfKXxlSNjBpN5FsS3Ekua
         S3o28GjFcvLrAHt3O7HWg4O5YSJUzma8Oa3HCHL0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13E0RMup033154
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Apr 2021 19:27:23 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 13
 Apr 2021 19:27:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 13 Apr 2021 19:27:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13E0RMVD113196;
        Tue, 13 Apr 2021 19:27:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Santosh Shilimkar <ssantosh@kernel.org>, <s-anna@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] dt-bindings: mailbox: ti,message-manager: Convert to yaml
Date:   Tue, 13 Apr 2021 19:27:21 -0500
Message-ID: <20210414002721.23638-1-nm@ti.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ti,secure-proxy to yaml for better checks and documentation.
Differences being mostly in the examples:
- I've dropped the example usage of mailbox client, it is better done in
  tisci node definition
- included header in example for buildable example

NOTE: The following checkpatch warning is generated since we do include
the header
in the example, but this is a false positive warning.
  WARNING: DT binding docs and includes should be a separate patch. See:
  Documentation/devicetree/bindings/submitting-patches.rst

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Depending on how [1] turns out in discussion, we might want to queue [2]
appropriately.

[1] https://lore.kernel.org/linux-arm-kernel/CAK8P3a1L8rWpR5b66v6Su8-m7-scA0wZQr_g_4KnV4dnrky6ZA@mail.gmail.com/
[2] https://lore.kernel.org/linux-arm-kernel/20210414001926.20002-1-nm@ti.com/
 .../bindings/mailbox/ti,message-manager.txt   | 50 -------------
 .../bindings/mailbox/ti,message-manager.yaml  | 75 +++++++++++++++++++
 2 files changed, 75 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/ti,message-manager.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt b/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
deleted file mode 100644
index ebf0e3710cee..000000000000
--- a/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-Texas Instruments' Message Manager Driver
-========================================
-
-The Texas Instruments' Message Manager is a mailbox controller that has
-configurable queues selectable at SoC(System on Chip) integration. The Message
-manager is broken up into queues in different address regions that are called
-"proxies" - each instance is unidirectional and is instantiated at SoC
-integration level to indicate receive or transmit path.
-
-Message Manager Device Node:
-===========================
-Required properties:
---------------------
-- compatible:		Shall be: "ti,k2g-message-manager"
-- reg-names 		queue_proxy_region - Map the queue proxy region.
-			queue_state_debug_region - Map the queue state debug
-			region.
-- reg:			Contains the register map per reg-names.
-- #mbox-cells		Shall be 2. Contains the queue ID and proxy ID in that
-		        order referring to the transfer path.
-- interrupt-names:	Contains interrupt names matching the rx transfer path
-			for a given SoC. Receive interrupts shall be of the
-			format: "rx_<QID>".
-			For ti,k2g-message-manager, this shall contain:
-				"rx_005", "rx_057"
-- interrupts:		Contains the interrupt information corresponding to
-			interrupt-names property.
-
-Example(K2G):
-------------
-
-	msgmgr: msgmgr@2a00000 {
-		compatible = "ti,k2g-message-manager";
-		#mbox-cells = <2>;
-		reg-names = "queue_proxy_region", "queue_state_debug_region";
-		reg = <0x02a00000 0x400000>, <0x028c3400 0x400>;
-		interrupt-names = "rx_005", "rx_057";
-		interrupts = <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	pmmc: pmmc {
-		[...]
-		mbox-names = "rx", "tx";
-		# RX queue ID is 5, proxy ID is 2
-		# TX queue ID is 0, proxy ID is 0
-		mboxes= <&msgmgr 5 2>,
-			<&msgmgr 0 0>;
-		[...]
-	};
diff --git a/Documentation/devicetree/bindings/mailbox/ti,message-manager.yaml b/Documentation/devicetree/bindings/mailbox/ti,message-manager.yaml
new file mode 100644
index 000000000000..4987e803ac37
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/ti,message-manager.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/ti,message-manager.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments' Message Manager Driver
+
+maintainers:
+  - Nishanth Menon <nm@ti.com>
+
+description: |
+  The Texas Instruments' Message Manager is a mailbox controller that has
+  configurable queues selectable at SoC(System on Chip) integration. The Message
+  manager is broken up into queues in different address regions that are called
+  "proxies" - each instance is unidirectional and is instantiated at SoC
+  integration level to indicate receive or transmit path.
+
+properties:
+  $nodename:
+    pattern: "^mailbox@[0-9a-f]+$"
+
+  compatible:
+    const: ti,k2g-message-manager
+
+  "#mbox-cells":
+    const: 2
+    description:
+      Contains the queue ID and proxy ID in that order referring to the
+      transfer path.
+
+  reg-names:
+    items:
+      - const: queue_proxy_region
+      - const: queue_state_debug_region
+
+  reg:
+    minItems: 2
+
+  interrupt-names:
+    items:
+      - const: rx_005
+      - const: rx_057
+    description:
+      Contains interrupt names matching the Rx transfer path for a given SoC.
+      Receive interrupts shall be of the format "rx_<QID>".
+
+  interrupts:
+    minItems: 2
+    description:
+      Contains the interrupt information for the Rx interrupt paths for message
+      manager corresponding to the interrupt-names.
+
+required:
+  - compatible
+  - reg-names
+  - reg
+  - interrupt-names
+  - interrupts
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    msgmgr: mailbox@2a00000 {
+          compatible = "ti,k2g-message-manager";
+          #mbox-cells = <2>;
+          reg-names = "queue_proxy_region", "queue_state_debug_region";
+          reg = <0x02a00000 0x400000>, <0x028c3400 0x400>;
+          interrupt-names = "rx_005", "rx_057";
+          interrupts = <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.31.0

