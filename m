Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595F436B63E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbhDZP4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:56:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53080 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhDZPz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:55:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13QFt6Xu122074;
        Mon, 26 Apr 2021 10:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619452506;
        bh=cC92DB6AUAgjy3+3K+NqOlg8Ug3/Zd+OhbNhKVUlGD8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EzbbPeVzqJ3FmB6Kcn67k3yCRFHARf5vlJO642Su1XCEHBQWDFfBUbO7R6eXezEcG
         KDnJrFtRrRpt/OofbuC+84n/LWEcGbOMtAysO+7X3Wze9bqfERDkrnyCaWJnGHJDD2
         X+aitqtUY1SgA3+E4dz47Yitqs3jT2trMKOp6WUQ=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13QFt5gW121488
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Apr 2021 10:55:05 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 26
 Apr 2021 10:55:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 26 Apr 2021 10:55:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13QFt5p2024691;
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
Subject: [PATCH V2 1/4] dt-bindings: reset: Convert ti,sci-reset to json schema
Date:   Mon, 26 Apr 2021 10:54:54 -0500
Message-ID: <20210426155457.21221-2-nm@ti.com>
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

Convert the ti,sci-reset to json schema for better checks and documentation.

Differences being:
 - Drop consumer example as they are documented in the corresponding
   bindings themselves.
 - Drop phandle description for reset consumer or cell definition as it is
   redundant.

Signed-off-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Tero Kristo <kristo@kernel.org>
---

Changes since V1:
 * reviewed by from Tero and Rob
    https://lore.kernel.org/linux-arm-kernel/20210421223254.GA1734415@robh.at.kernel.org/
    https://lore.kernel.org/linux-arm-kernel/56388707-c8d3-ebdf-77a2-c5a983856b4d@kernel.org/
 * Updated commit message to drop the 'checkpatch warning'

v1: https://lore.kernel.org/linux-arm-kernel/20210416063721.20538-2-nm@ti.com/

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

