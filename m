Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D923619F0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbhDPGiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 02:38:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38612 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbhDPGiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:38:00 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13G6bN9o125771;
        Fri, 16 Apr 2021 01:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618555043;
        bh=+Sup0ypjxIcvc4NEFGB6h7kW3aLLqy5KxhpOtjnaQ+I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GKyQfdWCCiFSRojiYJbjhrHFOkuTIbTlk6B/A4jVlQB1ecfNWMR0hILIrkPJx0a90
         MjFa2/YQ9zAZSNYVH2X7tUt5k4ape4YgWr66SWHNG/uprccepxQcmpTPSx26Pnu2b5
         8g2f+V2pIH3HFf/bkdWq40UdPaIso2RFYQI+ZRXY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13G6bNvv073145
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Apr 2021 01:37:23 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Apr 2021 01:37:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 16 Apr 2021 01:37:23 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13G6bN65015701;
        Fri, 16 Apr 2021 01:37:23 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 4/4] dt-bindings: arm: keystone: Convert ti,sci to json schema
Date:   Fri, 16 Apr 2021 01:37:21 -0500
Message-ID: <20210416063721.20538-5-nm@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210416063721.20538-1-nm@ti.com>
References: <20210416063721.20538-1-nm@ti.com>
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

NOTE: we do have false positive checkpatch warning with this patch:
"DT binding docs and includes should be a separate patch"

Signed-off-by: Nishanth Menon <nm@ti.com>
---
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
index 000000000000..3e835ad84dc2
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
+allOf:
+  - $ref: /schemas/mbox/mbox-consumer.yaml#
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
+      - const: debug_messages
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
+required:
+  - compatible
+  - mbox-names
+  - mboxes
+
+additionalProperties: false
+
+patternProperties:
+  # All other properties should be a power, clock or reset controller
+  "^(power-controller|clock-controller|reset-controller)$":
+    type: object
+    oneOf:
+      - $ref: /schemas/soc/ti/sci-pm-domain.yaml#
+      - $ref: /schemas/clock/ti,sci-clk.yaml#
+      - $ref: /schemas/reset/ti,sci-reset.yaml#
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

