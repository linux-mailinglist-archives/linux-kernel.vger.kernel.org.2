Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E519401FC6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244524AbhIFShf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:37:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:47238 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244290AbhIFShe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:37:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="219714184"
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; 
   d="scan'208";a="219714184"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 11:36:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; 
   d="scan'208";a="579716457"
Received: from bspteam04.iind.intel.com ([10.106.46.142])
  by orsmga004.jf.intel.com with ESMTP; 06 Sep 2021 11:36:25 -0700
From:   shruthi.sanil@intel.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, kris.pan@linux.intel.com,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH v6 1/2] dt-bindings: timer: Add bindings for Intel Keem Bay SoC Timer
Date:   Tue,  7 Sep 2021 00:06:20 +0530
Message-Id: <20210906183621.21075-2-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210906183621.21075-1-shruthi.sanil@intel.com>
References: <20210906183621.21075-1-shruthi.sanil@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shruthi Sanil <shruthi.sanil@intel.com>

Add Device Tree bindings for the Timer IP, which can be used as
clocksource and clockevent device in the Intel Keem Bay SoC.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
---
 .../bindings/timer/intel,keembay-timer.yaml   | 173 ++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
new file mode 100644
index 000000000000..f40b23e47e75
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
@@ -0,0 +1,173 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/intel,keembay-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Keem Bay SoC Timers
+
+maintainers:
+  - Shruthi Sanil <shruthi.sanil@intel.com>
+
+description: |
+  The Intel Keem Bay timer driver supports 1 free running counter and 8 timers.
+  Each timer is capable of generating inividual interrupt.
+  Both the features are enabled through the timer general config register.
+
+  The parent node represents the common general configuration details and
+  the child nodes represents the counter and timers.
+
+properties:
+  compatible:
+    enum:
+      - simple-mfd
+      - intel, keembay-gpt-creg
+
+  reg:
+    description: General configuration register address and length.
+    maxItems: 1
+
+  ranges: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - "#address-cells"
+  - "#size-cells"
+
+patternProperties:
+  "^counter@[0-9a-f]+$":
+    type: object
+    description: Properties for Intel Keem Bay counter
+
+    properties:
+      compatible:
+        enum:
+          - intel,keembay-counter
+
+      reg:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+      - clocks
+
+  "^timer@[0-9a-f]+$":
+    type: object
+    description: Properties for Intel Keem Bay timer
+
+    properties:
+      compatible:
+        enum:
+          - intel,keembay-timer
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+      - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #define KEEM_BAY_A53_TIM
+
+    soc {
+        #address-cells = <0x2>;
+        #size-cells = <0x2>;
+
+        gpt@20331000 {
+            compatible = "intel,keembay-gpt-creg", "simple-mfd";
+            reg = <0x0 0x20331000 0x0 0xc>;
+            ranges = <0x0 0x0 0x20330000 0xF0>;
+            #address-cells = <0x1>;
+            #size-cells = <0x1>;
+
+            counter@e8 {
+                compatible = "intel,keembay-counter";
+                reg = <0xe8 0x8>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+
+            timer@10 {
+                compatible = "intel,keembay-timer";
+                reg = <0x10 0xc>;
+                interrupts = <GIC_SPI 0x3 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+
+            timer@20 {
+                compatible = "intel,keembay-timer";
+                reg = <0x20 0xc>;
+                interrupts = <GIC_SPI 0x4 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+
+            timer@30 {
+                compatible = "intel,keembay-timer";
+                reg = <0x30 0xc>;
+                interrupts = <GIC_SPI 0x5 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+
+            timer@40 {
+                compatible = "intel,keembay-timer";
+                reg = <0x40 0xc>;
+                interrupts = <GIC_SPI 0x6 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+
+            timer@50 {
+                compatible = "intel,keembay-timer";
+                reg = <0x50 0xc>;
+                interrupts = <GIC_SPI 0x7 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+
+            timer@60 {
+                compatible = "intel,keembay-timer";
+                reg = <0x60 0xc>;
+                interrupts = <GIC_SPI 0x8 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+
+            timer@70 {
+                compatible = "intel,keembay-timer";
+                reg = <0x70 0xc>;
+                interrupts = <GIC_SPI 0x9 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+
+            timer@80 {
+                compatible = "intel,keembay-timer";
+                reg = <0x80 0xc>;
+                interrupts = <GIC_SPI 0xa IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+        };
+    };
+
+...
-- 
2.17.1

