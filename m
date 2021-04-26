Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6F236B643
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhDZP4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:56:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44792 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbhDZP4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:56:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13QFt63b090813;
        Mon, 26 Apr 2021 10:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619452506;
        bh=dZEBOCb8zkzyKphePgQJZoFUsMXeLrk9vzCjyHPgLgA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lROL9DeSnlvVZtrEAtQHeGNzHBPdbAm1DdYMzvPggoQEXhcKlKFSTrdDEbtgqG37O
         oPokWySEnVFGaOLPm0u4SRd0Th1nKiaGXeGEwffDOhPuZAUg2M6CGDyoZORXn72zKE
         bSMHA21K/2MxAz9vfodgaQ6vn8q4wcCUxwxhd26A=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13QFt5Sa096590
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Apr 2021 10:55:06 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 26
 Apr 2021 10:55:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 26 Apr 2021 10:55:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13QFt54R104457;
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
Subject: [PATCH V2 3/4] dt-bindings: soc: ti: Convert ti,sci-pm-domain to json schema
Date:   Mon, 26 Apr 2021 10:54:56 -0500
Message-ID: <20210426155457.21221-4-nm@ti.com>
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

Convert the ti,sci-pm-domain to json schema for better checks and
documentation.

Differences being:
 - Drop consumer example as they are documented in the corresponding
   bindings themselves.
 - Drop phandle description for reset consumer or cell definition as it
   is redundant.

Signed-off-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Tero Kristo <kristo@kernel.org>
---

Changes since V1:
 * reviewed by from Tero and Rob
    https://lore.kernel.org/linux-arm-kernel/20210421223627.GA1740013@robh.at.kernel.org/
    https://lore.kernel.org/linux-arm-kernel/56388707-c8d3-ebdf-77a2-c5a983856b4d@kernel.org/
 * Updated commit message to drop the 'checkpatch warning'

v1: https://lore.kernel.org/linux-arm-kernel/20210416063721.20538-4-nm@ti.com/

 .../bindings/soc/ti/sci-pm-domain.txt         | 65 -------------------
 .../bindings/soc/ti/sci-pm-domain.yaml        | 59 +++++++++++++++++
 2 files changed, 59 insertions(+), 65 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml

diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
deleted file mode 100644
index 6217e64309de..000000000000
--- a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-Texas Instruments TI-SCI Generic Power Domain
----------------------------------------------
-
-Some TI SoCs contain a system controller (like the PMMC, etc...) that is
-responsible for controlling the state of the IPs that are present.
-Communication between the host processor running an OS and the system
-controller happens through a protocol known as TI-SCI [1].
-
-[1] Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
-
-PM Domain Node
-==============
-The PM domain node represents the global PM domain managed by the PMMC, which
-in this case is the implementation as documented by the generic PM domain
-bindings in Documentation/devicetree/bindings/power/power-domain.yaml.  Because
-this relies on the TI SCI protocol to communicate with the PMMC it must be a
-child of the pmmc node.
-
-Required Properties:
---------------------
-- compatible: should be "ti,sci-pm-domain"
-- #power-domain-cells: Can be one of the following:
-			1: Containing the device id of each node
-			2: First entry should be device id
-			   Second entry should be one of the floowing:
-			   TI_SCI_PD_EXCLUSIVE: To allow device to be
-						exclusively controlled by
-						the requesting hosts.
-			   TI_SCI_PD_SHARED: To allow device to be shared
-					     by multiple hosts.
-
-Example (K2G):
--------------
-	pmmc: pmmc {
-		compatible = "ti,k2g-sci";
-		...
-
-		k2g_pds: power-controller {
-			compatible = "ti,sci-pm-domain";
-			#power-domain-cells = <1>;
-		};
-	};
-
-PM Domain Consumers
-===================
-Hardware blocks belonging to a PM domain should contain a "power-domains"
-property that is a phandle pointing to the corresponding PM domain node
-along with an index representing the device id to be passed to the PMMC
-for device control.
-
-Required Properties:
---------------------
-- power-domains: phandle pointing to the corresponding PM domain node
-		 and an ID representing the device.
-
-See http://processors.wiki.ti.com/index.php/TISCI#66AK2G02_Data for the list
-of valid identifiers for k2g.
-
-Example (K2G):
---------------------
-	uart0: serial@2530c00 {
-		compatible = "ns16550a";
-		...
-		power-domains = <&k2g_pds 0x002c>;
-	};
diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
new file mode 100644
index 000000000000..9e6cb4ee9755
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/ti/sci-pm-domain.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI-SCI generic power domain node bindings
+
+maintainers:
+  - Nishanth Menon <nm@ti.com>
+
+allOf:
+  - $ref: /schemas/power/power-domain.yaml#
+
+description: |
+  Some TI SoCs contain a system controller (like the Power Management Micro
+  Controller (PMMC) on Keystone 66AK2G SoC) that are responsible for controlling
+  the state of the various hardware modules present on the SoC. Communication
+  between the host processor running an OS and the system controller happens
+  through a protocol called TI System Control Interface (TI-SCI protocol).
+
+  This PM domain node represents the global PM domain managed by the TI-SCI
+  controller. Since this relies on the TI SCI protocol to communicate with
+  the TI-SCI controller, it must be a child of the TI-SCI controller node.
+
+properties:
+  compatible:
+    const: ti,sci-pm-domain
+
+  "#power-domain-cells":
+    enum: [1, 2]
+    description:
+      The two cells represent values that the TI-SCI controller defines.
+
+      The first cell should contain the device ID.
+
+      The second cell, if cell-value is 2, should be one of the following
+      TI_SCI_PD_EXCLUSIVE - Allows the device to be exclusively controlled
+      or
+      TI_SCI_PD_SHARED - Allows the device to be shared by multiple hosts.
+      Please refer to dt-bindings/soc/ti,sci_pm_domain.h for the definitions.
+
+      Please see  http://processors.wiki.ti.com/index.php/TISCI for
+      protocol documentation for the values to be used for different devices.
+
+additionalProperties: false
+
+examples:
+  - |
+    k2g_pds: power-controller {
+        compatible = "ti,sci-pm-domain";
+        #power-domain-cells = <1>;
+    };
+
+  - |
+    k3_pds: power-controller {
+        compatible = "ti,sci-pm-domain";
+        #power-domain-cells = <2>;
+    };
-- 
2.31.0

