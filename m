Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EB93619E8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbhDPGiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 02:38:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43992 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbhDPGh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:37:59 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13G6bNO2128103;
        Fri, 16 Apr 2021 01:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618555043;
        bh=DipwmHbqLP2+dryu86fEn14z5uhIk3ScCytktaypS/E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=R72+mjNMOPoDqEjt+ns45nN8/+olUu8IUIjMKtmikTme5/yfRatFak+oS2/pZ7dmq
         UiNJPSnpICEh38k7izgsDoe9Xe4oyjaSS2D4q8+iXd2CYqMTbWtIO47MzHw9g9/Lgi
         iWsmaIjUo9+l7Qy57kuI0zfQALX0XqV2oPByopyY=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13G6bNMR073142
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Apr 2021 01:37:23 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Apr 2021 01:37:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 16 Apr 2021 01:37:23 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13G6bNrT040500;
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
Subject: [PATCH 2/4] dt-bindings: clock: Convert ti,sci-clk to json schema
Date:   Fri, 16 Apr 2021 01:37:19 -0500
Message-ID: <20210416063721.20538-3-nm@ti.com>
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

Convert the ti,sci-clk to json schema for better checks and documentation.

Differences being:
 - Drop consumer example as they are documented in the corresponding
   bindings themselves.
 - Standardize the node name as clock-controller rather than clocks as
   it is more appropriate.
 - Drop phandle description for clock-cells as it is redundant.

NOTE: we do have false positive checkpatch warning with this patch:
"DT binding docs and includes should be a separate patch"

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../devicetree/bindings/clock/ti,sci-clk.txt  | 36 -------------
 .../devicetree/bindings/clock/ti,sci-clk.yaml | 52 +++++++++++++++++++
 2 files changed, 52 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/ti,sci-clk.txt b/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
deleted file mode 100644
index 4e59dc6b1778..000000000000
--- a/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Texas Instruments TI-SCI Clocks
-===============================
-
-All clocks on Texas Instruments' SoCs that contain a System Controller,
-are only controlled by this entity. Communication between a host processor
-running an OS and the System Controller happens through a protocol known
-as TI-SCI[1]. This clock implementation plugs into the common clock
-framework and makes use of the TI-SCI protocol on clock API requests.
-
-[1] Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
-
-Required properties:
--------------------
-- compatible: Must be "ti,k2g-sci-clk"
-- #clock-cells: Shall be 2.
-  In clock consumers, this cell represents the device ID and clock ID
-  exposed by the PM firmware. The list of valid values for the device IDs
-  and clocks IDs for 66AK2G SoC are documented at
-  http://processors.wiki.ti.com/index.php/TISCI#66AK2G02_Data
-
-Examples:
---------
-
-pmmc: pmmc {
-	compatible = "ti,k2g-sci";
-
-	k2g_clks: clocks {
-		compatible = "ti,k2g-sci-clk";
-		#clock-cells = <2>;
-	};
-};
-
-uart0: serial@2530c00 {
-	compatible = "ns16550a";
-	clocks = <&k2g_clks 0x2c 0>;
-};
diff --git a/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml b/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
new file mode 100644
index 000000000000..72633651f0c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/ti,sci-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI-SCI clock controller node bindings
+
+maintainers:
+  - Nishanth Menon <nm@ti.com>
+
+allOf:
+  - $ref: /schemas/clock/clock.yaml#
+
+description: |
+  Some TI SoCs contain a system controller (like the Power Management Micro
+  Controller (PMMC) on Keystone 66AK2G SoC) that are responsible for controlling
+  the state of the various hardware modules present on the SoC. Communication
+  between the host processor running an OS and the system controller happens
+  through a protocol called TI System Control Interface (TI-SCI protocol).
+
+  This clock controller node uses the TI SCI protocol to perform various clock
+  management of various hardware modules (devices) present on the SoC. This
+  node must be a child node of the associated TI-SCI system controller node.
+
+properties:
+  $nodename:
+    pattern: "^clock-controller$"
+
+  compatible:
+    const: ti,k2g-sci-clk
+
+  "#clock-cells":
+    const: 2
+    description:
+      The two cells represent values that the TI-SCI controller defines.
+
+      The first cell should contain the device ID.
+
+      The second cell should contain the clock ID.
+
+      Please see  http://processors.wiki.ti.com/index.php/TISCI for
+      protocol documentation for the values to be used for different devices.
+
+additionalProperties: false
+
+examples:
+  - |
+    k3_clks: clock-controller {
+        compatible = "ti,k2g-sci-clk";
+        #clock-cells = <2>;
+    };
-- 
2.31.0

