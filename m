Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B103619F1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbhDPGiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 02:38:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38610 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbhDPGiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:38:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13G6bNjF125763;
        Fri, 16 Apr 2021 01:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618555043;
        bh=E06Ov0k5VaiMqX2TAE7fti9XHuSYAFCaFc5lwhzNgJY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oxsEgI9e22RbmXRBMEP9k73SN1L85ZKU9Lle00n1GxBWpRkDau+0P8g6BU9uNelEW
         rm5ThkRDOlpWKoXhWSHK91m2chR6eQpz9dm3dl6Y9fWXRz5IzS4ZLPbivzhOXCvMgY
         t00RSioV/i8/z+nlzMCGBaEHUlpx6YJZ1yT5r404=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13G6bNa6083442
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Apr 2021 01:37:23 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Apr 2021 01:37:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 16 Apr 2021 01:37:23 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13G6bNSF063623;
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
Subject: [PATCH 3/4] dt-bindings: soc: ti: Convert ti,sci-pm-domain to json schema
Date:   Fri, 16 Apr 2021 01:37:20 -0500
Message-ID: <20210416063721.20538-4-nm@ti.com>
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

Convert the ti,sci-pm-domain to json schema for better checks and
documentation.

Differences being:
 - Drop consumer example as they are documented in the corresponding
   bindings themselves.
 - Drop phandle description for reset consumer or cell definition as it
   is redundant.

NOTE: we do have false positive checkpatch warning with this patch:
"DT binding docs and includes should be a separate patch"

Signed-off-by: Nishanth Menon <nm@ti.com>
---
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

