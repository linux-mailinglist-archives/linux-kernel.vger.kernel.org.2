Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A000536B642
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbhDZP4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:56:11 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53088 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbhDZPz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:55:59 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13QFt6VF122086;
        Mon, 26 Apr 2021 10:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619452506;
        bh=pAHHUUV8Ph5vaSoYuKgzBQNs3rojgbohFxbMCXhVhEg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dnde68+lUJql2TVjSrxnn4mRv+iZmYrWmffKtvBJmXAEET/YSOo11F2y4pUuf41w6
         nL/WIYaAb35u3UYmT1muIsUqTqFyK+JAZQvpF1UjMjcGBVl2tv4sIMnDwMQG/973/9
         tyoB67LH6HjD8QEfjLTQgW/qsvxvYEkeCGoQhG5w=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13QFt5E5096585
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Apr 2021 10:55:06 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 26
 Apr 2021 10:55:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 26 Apr 2021 10:55:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13QFt575010397;
        Mon, 26 Apr 2021 10:55:05 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 4/4] dt-bindings: arm: keystone: Convert ti,sci to json schema
Date:   Mon, 26 Apr 2021 10:54:57 -0500
Message-ID: <20210426155457.21221-5-nm@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426155457.21221-1-nm@ti.com>
References: <20210426155457.21221-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ti,sci to json schema for better checks and documentation.

NOTE: This change does introduce a stricter naming convention for
TI-SCI controller nodes.

Signed-off-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Tero Kristo <kristo@kernel.org>
---

Changes since V1:
 * reviewed by from Tero
    https://lore.kernel.org/linux-arm-kernel/56388707-c8d3-ebdf-77a2-c5a983856b4d@kernel.org/
 * Updated commit message to drop the 'checkpatch warning'
 * Inclusion of mbox-consumer.yaml dropped
 * debug_messages is a const
 * power-controller, clock-controller, reset-controller subnodes are
   explicit subnode properties

v1: https://lore.kernel.org/linux-arm-kernel/20210416063721.20538-5-nm@ti.com/

 .../bindings/arm/keystone/ti,sci.txt          |  86 ------------
 .../bindings/arm/keystone/ti,sci.yaml         | 129 ++++++++++++++++++
 2 files changed, 129 insertions(+), 86 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
 create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
deleted file mode 100644
index 6f0cd31c1520..000000000000
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+++ /dev/null
@@ -1,86 +0,0 @@
-Texas Instruments System Control Interface (TI-SCI) Message Protocol
---------------------------------------------------------------------
-
-Texas Instrument's processors including those belonging to Keystone generation
-of processors have separate hardware entity which is now responsible for the
-management of the System on Chip (SoC) system. These include various system
-level functions as well.
-
-An example of such an SoC is K2G, which contains the system control hardware
-block called Power Management Micro Controller (PMMC). This hardware block is
-initialized early into boot process and provides services to Operating Systems
-on multiple processors including ones running Linux.
-
-See http://processors.wiki.ti.com/index.php/TISCI for protocol definition.
-
-TI-SCI controller Device Node:
-=============================
-
-The TI-SCI node describes the Texas Instrument's System Controller entity node.
-This parent node may optionally have additional children nodes which describe
-specific functionality such as clocks, power domain, reset or additional
-functionality as may be required for the SoC. This hierarchy also describes the
-relationship between the TI-SCI parent node to the child node.
-
-Required properties:
--------------------
-- compatible:	should be "ti,k2g-sci" for TI 66AK2G SoC
-		should be "ti,am654-sci" for for TI AM654 SoC
-- mbox-names:
-	"rx" - Mailbox corresponding to receive path
-	"tx" - Mailbox corresponding to transmit path
-
-- mboxes: Mailboxes corresponding to the mbox-names. Each value of the mboxes
-	  property should contain a phandle to the mailbox controller device
-	  node and an args specifier that will be the phandle to the intended
-	  sub-mailbox child node to be used for communication.
-
-See Documentation/devicetree/bindings/mailbox/mailbox.txt for more details
-about the generic mailbox controller and client driver bindings. Also see
-Documentation/devicetree/bindings/mailbox/ti,message-manager.txt for typical
-controller that is used to communicate with this System controllers.
-
-Optional Properties:
--------------------
-- reg-names:
-	debug_messages - Map the Debug message region
-- reg:  register space corresponding to the debug_messages
-- ti,system-reboot-controller: If system reboot can be triggered by SoC reboot
-- ti,host-id: Integer value corresponding to the host ID assigned by Firmware
-	for identification of host processing entities such as virtual
-	machines
-
-Example (K2G):
--------------
-	pmmc: pmmc {
-		compatible = "ti,k2g-sci";
-		ti,host-id = <2>;
-		mbox-names = "rx", "tx";
-		mboxes= <&msgmgr &msgmgr_proxy_pmmc_rx>,
-			<&msgmgr &msgmgr_proxy_pmmc_tx>;
-		reg-names = "debug_messages";
-		reg = <0x02921800 0x800>;
-	};
-
-
-TI-SCI Client Device Node:
-=========================
-
-Client nodes are maintained as children of the relevant TI-SCI device node.
-
-Example (K2G):
--------------
-	pmmc: pmmc {
-		compatible = "ti,k2g-sci";
-		...
-
-		my_clk_node: clk_node {
-			...
-			...
-		};
-
-		my_pd_node: pd_node {
-			...
-			...
-		};
-	};
diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
new file mode 100644
index 000000000000..34f5f877d444
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/keystone/ti,sci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI-SCI controller device node bindings
+
+maintainers:
+  - Nishanth Menon <nm@ti.com>
+
+description: |
+  Texas Instrument's processors including those belonging to Keystone generation
+  of processors have separate hardware entity which is now responsible for the
+  management of the System on Chip (SoC) system. These include various system
+  level functions as well.
+
+  An example of such an SoC is K2G, which contains the system control hardware
+  block called Power Management Micro Controller (PMMC). This hardware block is
+  initialized early into boot process and provides services to Operating Systems
+  on multiple processors including ones running Linux.
+
+  See http://processors.wiki.ti.com/index.php/TISCI for protocol definition.
+
+  The TI-SCI node describes the Texas Instrument's System Controller entity node.
+  This parent node may optionally have additional children nodes which describe
+  specific functionality such as clocks, power domain, reset or additional
+  functionality as may be required for the SoC. This hierarchy also describes the
+  relationship between the TI-SCI parent node to the child node.
+
+properties:
+  $nodename:
+    pattern: "^system-controller@[0-9a-f]+$"
+
+  compatible:
+    oneOf:
+      - description: System controller on TI 66AK2G SoC and other K3 SoCs
+        items:
+          - const: ti,k2g-sci
+      - description: System controller on TI AM654 SoC
+        items:
+          - const: ti,am654-sci
+
+  reg-names:
+    description: |
+      Specifies the debug messages memory mapped region that is optionally
+      made available from TI-SCI controller.
+    const: debug_messages
+
+  reg:
+    minItems: 1
+
+  mbox-names:
+    description: |
+      Specifies the mailboxes used to communicate with TI-SCI Controller
+      made available from TI-SCI controller.
+    items:
+      - const: rx
+      - const: tx
+
+  mboxes:
+    minItems: 2
+
+  ti,system-reboot-controller:
+    description: Determines If system reboot can be triggered by SoC reboot
+    type: boolean
+
+  ti,host-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Value corresponding to the host ID assigned by Firmware
+      for identification of host processing entities such as virtual machines.
+
+  power-controller:
+    type: object
+    $ref: /schemas/soc/ti/sci-pm-domain.yaml#
+
+  clock-controller:
+    type: object
+    $ref: /schemas/clock/ti,sci-clk.yaml#
+
+  reset-controller:
+    type: object
+    $ref: /schemas/reset/ti,sci-reset.yaml#
+
+required:
+  - compatible
+  - mbox-names
+  - mboxes
+
+additionalProperties: false
+
+examples:
+  - |
+    pmmc: system-controller@2921800 {
+      compatible = "ti,k2g-sci";
+      ti,system-reboot-controller;
+      mbox-names = "rx", "tx";
+      mboxes= <&msgmgr 5 2>,
+              <&msgmgr 0 0>;
+      reg-names = "debug_messages";
+      reg = <0x02921800 0x800>;
+    };
+
+  - |
+    dmsc: system-controller@44083000 {
+      compatible = "ti,k2g-sci";
+      ti,host-id = <12>;
+      mbox-names = "rx", "tx";
+      mboxes= <&secure_proxy_main 11>,
+              <&secure_proxy_main 13>;
+      reg-names = "debug_messages";
+      reg = <0x44083000 0x1000>;
+
+      k3_pds: power-controller {
+        compatible = "ti,sci-pm-domain";
+        #power-domain-cells = <2>;
+      };
+
+      k3_clks: clock-controller {
+        compatible = "ti,k2g-sci-clk";
+        #clock-cells = <2>;
+      };
+
+      k3_reset: reset-controller {
+        compatible = "ti,sci-reset";
+        #reset-cells = <2>;
+      };
+    };
-- 
2.31.0

