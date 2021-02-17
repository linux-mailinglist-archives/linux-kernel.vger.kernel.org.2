Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAF431D8C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhBQLtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:49:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:33442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231491AbhBQLtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:49:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1934B7DB;
        Wed, 17 Feb 2021 11:48:22 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        wahrenst@gmx.net, mripard@kernel.org, eric@anholt.net,
        robh@kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 01/15] dt-bindings: soc: bcm: bcm2835-pm: Convert bindings to DT schema
Date:   Wed, 17 Feb 2021 12:47:56 +0100
Message-Id: <20210217114811.22069-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217114811.22069-1-nsaenzjulienne@suse.de>
References: <20210217114811.22069-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the brcm,bcm2835-pm bindings from text to proper schema.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

Changes since v2:
 - Slightly change things to make it less dependent on next commits

 .../bindings/soc/bcm/brcm,bcm2835-pm.txt      | 46 -----------
 .../bindings/soc/bcm/brcm,bcm2835-pm.yaml     | 79 +++++++++++++++++++
 2 files changed, 79 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
deleted file mode 100644
index 72ff033565e5..000000000000
--- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-BCM2835 PM (Power domains, watchdog)
-
-The PM block controls power domains and some reset lines, and includes
-a watchdog timer.  This binding supersedes the brcm,bcm2835-pm-wdt
-binding which covered some of PM's register range and functionality.
-
-Required properties:
-
-- compatible:		Should be "brcm,bcm2835-pm"
-- reg:			Specifies base physical address and size of the two
-			  register ranges ("PM" and "ASYNC_BRIDGE" in that
-			  order)
-- clocks:		a) v3d: The V3D clock from CPRMAN
-			b) peri_image: The PERI_IMAGE clock from CPRMAN
-			c) h264: The H264 clock from CPRMAN
-			d) isp: The ISP clock from CPRMAN
-- #reset-cells: 	Should be 1.  This property follows the reset controller
-			  bindings[1].
-- #power-domain-cells:	Should be 1.  This property follows the power domain
-			  bindings[2].
-
-Optional properties:
-
-- timeout-sec:		Contains the watchdog timeout in seconds
-- system-power-controller: Whether the watchdog is controlling the
-    system power.  This node follows the power controller bindings[3].
-
-[1] Documentation/devicetree/bindings/reset/reset.txt
-[2] Documentation/devicetree/bindings/power/power-domain.yaml
-[3] Documentation/devicetree/bindings/power/power-controller.txt
-
-Example:
-
-pm {
-	compatible = "brcm,bcm2835-pm", "brcm,bcm2835-pm-wdt";
-	#power-domain-cells = <1>;
-	#reset-cells = <1>;
-	reg = <0x7e100000 0x114>,
-	      <0x7e00a000 0x24>;
-	clocks = <&clocks BCM2835_CLOCK_V3D>,
-		 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
-		 <&clocks BCM2835_CLOCK_H264>,
-		 <&clocks BCM2835_CLOCK_ISP>;
-	clock-names = "v3d", "peri_image", "h264", "isp";
-	system-power-controller;
-};
diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
new file mode 100644
index 000000000000..47b9c266ddd1
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/bcm/brcm,bcm2835-pm.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: BCM2835 PM (Power domains, watchdog)
+
+description: |
+  The PM block controls power domains and some reset lines, and includes a
+  watchdog timer.
+
+maintainers:
+  - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+
+allOf:
+  - $ref: ../../watchdog/watchdog.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: brcm,bcm2835-pm
+      - const: brcm,bcm2835-pm-wdt
+
+  reg:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: PM registers
+      - description: ASB registers
+
+  "#power-domain-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+  clocks:
+    minItems: 4
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: v3d
+      - const: peri_image
+      - const: h264
+      - const: isp
+
+  system-power-controller:
+    type: boolean
+
+  timeout-sec: true
+
+required:
+  - compatible
+  - reg
+  - "#power-domain-cells"
+  - "#reset-cells"
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/bcm2835.h>
+
+    watchdog@7e100000 {
+        compatible = "brcm,bcm2835-pm", "brcm,bcm2835-pm-wdt";
+        #power-domain-cells = <1>;
+        #reset-cells = <1>;
+        reg = <0x7e100000 0x114>,
+              <0x7e00a000 0x24>;
+        clocks = <&clocks BCM2835_CLOCK_V3D>,
+        	 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
+        	 <&clocks BCM2835_CLOCK_H264>,
+        	 <&clocks BCM2835_CLOCK_ISP>;
+        clock-names = "v3d", "peri_image", "h264", "isp";
+        system-power-controller;
+    };
-- 
2.30.0

