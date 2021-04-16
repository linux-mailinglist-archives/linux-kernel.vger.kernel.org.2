Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8557F361700
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 03:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhDPBAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 21:00:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42568 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbhDPBAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 21:00:30 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13G0xw99124309;
        Thu, 15 Apr 2021 19:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618534798;
        bh=KAihnKoeU/5rUjrQ30nc7anWJ4xIo5WwXVhZYbXxFbc=;
        h=From:To:CC:Subject:Date;
        b=XkGoiD5IgtVo6txqw45bdtpczRQ0qqMpiwy3jJYFIJ6/3rUpx/A5ykeiQ+jUs8fPY
         aLyu9JzYqqjvjUFmXytf6Gu4sZEnbYRV+0iXnM6NJjLXhE5/5SN44g7kfm1LEJmHkN
         x8kEVfKUl+fpo2KAls3s+edb748fPJuVaxMSI9CU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13G0xw9L011807
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Apr 2021 19:59:58 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 15
 Apr 2021 19:59:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 15 Apr 2021 19:59:58 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13G0xwcF102788;
        Thu, 15 Apr 2021 19:59:58 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <s-anna@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V3] dt-bindings: mailbox: ti,secure-proxy: Convert to json schema
Date:   Thu, 15 Apr 2021 19:59:53 -0500
Message-ID: <20210416005953.17147-1-nm@ti.com>
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
- Dropped the example usage of mailbox client, it is better done in
  tisci node definition.
- Switched reg usage for address-cells and size-cells 1 - aligned with
  schema checks as well.
- included header in example for a buildable example.

While at this, lets make sure to support upto 100 rx threads even though
typically upto 1 threads is practically in use.

NOTE: The following checkpatch warning is generated since we do include the header
in the example, but this is a false positive warning.
  WARNING: DT binding docs and includes should be a separate patch. See:
  Documentation/devicetree/bindings/submitting-patches.rst

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Changes since v2:
 - Subject line rewording to indicate json schema rather than yaml
 - Review comment: Dropped "-" in interrupt-names pattern so that it will match all
   entries
 - Minor commit message formatting changes

V2: https://lore.kernel.org/linux-arm-kernel/20210413224535.30910-1-nm@ti.com/
V1: https://lore.kernel.org/linux-arm-kernel/20210413171230.5872-1-nm@ti.com/

 .../bindings/mailbox/ti,secure-proxy.txt      | 50 ------------
 .../bindings/mailbox/ti,secure-proxy.yaml     | 79 +++++++++++++++++++
 2 files changed, 79 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/ti,secure-proxy.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt b/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
deleted file mode 100644
index 6c9c7daf0f5c..000000000000
--- a/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-Texas Instruments' Secure Proxy
-========================================
-
-The Texas Instruments' secure proxy is a mailbox controller that has
-configurable queues selectable at SoC(System on Chip) integration. The
-Message manager is broken up into different address regions that are
-called "threads" or "proxies" - each instance is unidirectional and is
-instantiated at SoC integration level by system controller to indicate
-receive or transmit path.
-
-Message Manager Device Node:
-===========================
-Required properties:
---------------------
-- compatible:		Shall be "ti,am654-secure-proxy"
-- reg-names 		target_data - Map the proxy data region
-			rt - Map the realtime status region
-			scfg - Map the configuration region
-- reg:			Contains the register map per reg-names.
-- #mbox-cells		Shall be 1 and shall refer to the transfer path
-			called thread.
-- interrupt-names:	Contains interrupt names matching the rx transfer path
-			for a given SoC. Receive interrupts shall be of the
-			format: "rx_<PID>".
-- interrupts:		Contains the interrupt information corresponding to
-			interrupt-names property.
-
-Example(AM654):
-------------
-
-	secure_proxy: mailbox@32c00000 {
-		compatible = "ti,am654-secure-proxy";
-		#mbox-cells = <1>;
-		reg-names = "target_data", "rt", "scfg";
-		reg = <0x0 0x32c00000 0x0 0x100000>,
-		      <0x0 0x32400000 0x0 0x100000>,
-		      <0x0 0x32800000 0x0 0x100000>;
-		interrupt-names = "rx_011";
-		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	dmsc: dmsc {
-		[...]
-		mbox-names = "rx", "tx";
-		# RX Thread ID is 11
-		# TX Thread ID is 13
-		mboxes= <&secure_proxy 11>,
-			<&secure_proxy 13>;
-		[...]
-	};
diff --git a/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.yaml b/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.yaml
new file mode 100644
index 000000000000..eea822861804
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/ti,secure-proxy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments' Secure Proxy
+
+maintainers:
+  - Nishanth Menon <nm@ti.com>
+
+description: |
+  The Texas Instruments' secure proxy is a mailbox controller that has
+  configurable queues selectable at SoC(System on Chip) integration. The
+  Message manager is broken up into different address regions that are
+  called "threads" or "proxies" - each instance is unidirectional and is
+  instantiated at SoC integration level by system controller to indicate
+  receive or transmit path.
+
+properties:
+  $nodename:
+    pattern: "^mailbox@[0-9a-f]+$"
+
+  compatible:
+    const: ti,am654-secure-proxy
+
+  "#mbox-cells":
+    const: 1
+    description:
+      Contains the secure proxy thread ID used for the specific transfer path.
+
+  reg-names:
+    items:
+      - const: target_data
+      - const: rt
+      - const: scfg
+
+  reg:
+    minItems: 3
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 100
+    items:
+      pattern: "^rx_[0-9]{3}$"
+    description:
+      Contains the interrupt name information for the Rx interrupt path for
+      secure proxy thread in the form 'rx_<PID>'.
+
+  interrupts:
+    minItems: 1
+    maxItems: 100
+    description:
+      Contains the interrupt information for the Rx interrupt path for secure
+      proxy.
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
+    secure_proxy: mailbox@32c00000 {
+          compatible = "ti,am654-secure-proxy";
+          #mbox-cells = <1>;
+          reg-names = "target_data", "rt", "scfg";
+          reg = <0x32c00000 0x100000>,
+                <0x32400000 0x100000>,
+                <0x32800000 0x100000>;
+          interrupt-names = "rx_011";
+          interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.31.0

