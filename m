Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D269A3619F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbhDPGiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 02:38:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38614 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbhDPGiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:38:01 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13G6bNQq125765;
        Fri, 16 Apr 2021 01:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618555043;
        bh=zmLDKti0Fwv26bitJG2/F0NGKoPPVKLXrRnsXEk7UlM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kw1Ok0uoz9apcYrRDm3P9ze6JbJmCyWz5Lzmw7fTMpHchBxrPOdcDaNB+pE9d+CiL
         kIwt0d0oNMYm48LweYg+RlMWFnPUZv0yKM8mxsApHcAbBwTVa+eflgLOq5QnafKwhB
         mwFStzpUWiPnLl/e2abATLJCdkRI1wKYPlL8NExw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13G6bN66083441
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Apr 2021 01:37:23 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Apr 2021 01:37:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 16 Apr 2021 01:37:23 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13G6bNQ8015690;
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
Subject: [PATCH 1/4] dt-bindings: reset: Convert ti,sci-reset to json schema
Date:   Fri, 16 Apr 2021 01:37:18 -0500
Message-ID: <20210416063721.20538-2-nm@ti.com>
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

Convert the ti,sci-reset to json schema for better checks and documentation.

Differences being:
 - Drop consumer example as they are documented in the corresponding
   bindings themselves.
 - Drop phandle description for reset consumer or cell definition as it is
   redundant.

NOTE: we do have false positive checkpatch warning with this patch:
"DT binding docs and includes should be a separate patch"

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../bindings/reset/ti,sci-reset.txt           | 62 -------------------
 .../bindings/reset/ti,sci-reset.yaml          | 51 +++++++++++++++
 2 files changed, 51 insertions(+), 62 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/ti,sci-reset.txt b/Documentation/devicetree/bindings/reset/ti,sci-reset.txt
deleted file mode 100644
index 8b1cf022f18a..000000000000
--- a/Documentation/devicetree/bindings/reset/ti,sci-reset.txt
+++ /dev/null
@@ -1,62 +0,0 @@
-Texas Instruments System Control Interface (TI-SCI) Reset Controller
-=====================================================================
-
-Some TI SoCs contain a system controller (like the Power Management Micro
-Controller (PMMC) on Keystone 66AK2G SoC) that are responsible for controlling
-the state of the various hardware modules present on the SoC. Communication
-between the host processor running an OS and the system controller happens
-through a protocol called TI System Control Interface (TI-SCI protocol).
-For TI SCI details, please refer to the document,
-Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
-
-TI-SCI Reset Controller Node
-============================
-This reset controller node uses the TI SCI protocol to perform the reset
-management of various hardware modules present on the SoC. Must be a child
-node of the associated TI-SCI system controller node.
-
-Required properties:
---------------------
- - compatible	: Should be "ti,sci-reset"
- - #reset-cells	: Should be 2. Please see the reset consumer node below for
-		  usage details.
-
-TI-SCI Reset Consumer Nodes
-===========================
-Each of the reset consumer nodes should have the following properties,
-in addition to their own properties.
-
-Required properties:
---------------------
- - resets	: A phandle and reset specifier pair, one pair for each reset
-		  signal that affects the device, or that the device manages.
-		  The phandle should point to the TI-SCI reset controller node,
-		  and the reset specifier should have 2 cell-values. The first
-		  cell should contain the device ID. The second cell should
-		  contain the reset mask value used by system controller.
-		  Please refer to the protocol documentation for these values
-		  to be used for different devices,
-		  http://processors.wiki.ti.com/index.php/TISCI#66AK2G02_Data
-
-Please also refer to Documentation/devicetree/bindings/reset/reset.txt for
-common reset controller usage by consumers.
-
-Example:
---------
-The following example demonstrates both a TI-SCI reset controller node and a
-consumer (a DSP device) on the 66AK2G SoC.
-
-pmmc: pmmc {
-	compatible = "ti,k2g-sci";
-
-	k2g_reset: reset-controller {
-		compatible = "ti,sci-reset";
-		#reset-cells = <2>;
-	};
-};
-
-dsp0: dsp@10800000 {
-	...
-	resets = <&k2g_reset 0x0046 0x1>;
-	...
-};
diff --git a/Documentation/devicetree/bindings/reset/ti,sci-reset.yaml b/Documentation/devicetree/bindings/reset/ti,sci-reset.yaml
new file mode 100644
index 000000000000..4639d2cec557
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/ti,sci-reset.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/ti,sci-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI-SCI reset controller node bindings
+
+maintainers:
+  - Nishanth Menon <nm@ti.com>
+
+description: |
+  Some TI SoCs contain a system controller (like the Power Management Micro
+  Controller (PMMC) on Keystone 66AK2G SoC) that are responsible for controlling
+  the state of the various hardware modules present on the SoC. Communication
+  between the host processor running an OS and the system controller happens
+  through a protocol called TI System Control Interface (TI-SCI protocol).
+
+  This reset controller node uses the TI SCI protocol to perform the reset
+  management of various hardware modules present on the SoC. Must be a child
+  node of the associated TI-SCI system controller node.
+
+properties:
+  $nodename:
+    pattern: "^reset-controller$"
+
+  compatible:
+    const: ti,sci-reset
+
+  "#reset-cells":
+    const: 2
+    description:
+      The two cells represent values that the TI-SCI controller defines.
+
+      The first cell should contain the device ID.
+
+      The second cell should contain the reset mask corresponding to the device
+      used by system controller.
+
+      Please see  http://processors.wiki.ti.com/index.php/TISCI for
+      protocol documentation for the values to be used for different devices.
+
+
+additionalProperties: false
+
+examples:
+  - |
+    k3_reset: reset-controller {
+        compatible = "ti,sci-reset";
+        #reset-cells = <2>;
+    };
-- 
2.31.0

