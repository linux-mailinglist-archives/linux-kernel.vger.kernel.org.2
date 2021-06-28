Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D57B3B5903
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhF1GQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:16:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:60982 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhF1GQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:16:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="271751104"
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="271751104"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 23:14:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="407607360"
Received: from bspteam04.iind.intel.com ([10.106.46.142])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2021 23:14:14 -0700
From:   shruthi.sanil@intel.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, kris.pan@linux.intel.com,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH v4 1/2] dt-bindings: timer: Add bindings for Intel Keem Bay SoC Timer
Date:   Mon, 28 Jun 2021 11:44:09 +0530
Message-Id: <20210628061410.8009-2-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210628061410.8009-1-shruthi.sanil@intel.com>
References: <20210628061410.8009-1-shruthi.sanil@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shruthi Sanil <shruthi.sanil@intel.com>

Add Device Tree bindings for the Timer IP, which can be used as
clocksource and clockevent device in the Intel Keem Bay SoC.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
---
 .../bindings/timer/intel,keembay-timer.yaml   | 170 ++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
new file mode 100644
index 000000000000..24c149a4d220
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
@@ -0,0 +1,170 @@
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
+  The Intel Keem Bay timer driver supports clocksource and clockevent
+  features for the timer IP used in Intel Keembay SoC.
+  The timer block supports 1 free running counter and 8 timers.
+  The free running counter can be used as a clocksouce and
+  the timers can be used as clockevent. Each timer is capable of
+  generating inividual interrupt.
+  Both the features are enabled through the timer general config register.
+
+  The parent node represents the common general configuration details and
+  the child nodes represents the counter and timers.
+
+properties:
+  reg:
+    description: General configuration register address and length.
+    maxItems: 1
+
+  ranges: true
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+required:
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
+            reg = <0x0 0x20331000 0x0 0xc>;
+            ranges = <0x0 0x0 0x20330000 0xF0>;
+            #address-cells = <0x1>;
+            #size-cells = <0x1>;
+
+            counter@203300e8 {
+                compatible = "intel,keembay-counter";
+                reg = <0xe8 0x8>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+
+            timer@20330010 {
+                compatible = "intel,keembay-timer";
+                reg = <0x10 0xc>;
+                interrupts = <GIC_SPI 0x3 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+
+            timer@20330020 {
+                compatible = "intel,keembay-timer";
+                reg = <0x20 0xc>;
+                interrupts = <GIC_SPI 0x4 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+
+            timer@20330030 {
+                compatible = "intel,keembay-timer";
+                reg = <0x30 0xc>;
+                interrupts = <GIC_SPI 0x5 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+
+            timer@20330040 {
+                compatible = "intel,keembay-timer";
+                reg = <0x40 0xc>;
+                interrupts = <GIC_SPI 0x6 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+
+            timer@20330050 {
+                compatible = "intel,keembay-timer";
+                reg = <0x50 0xc>;
+                interrupts = <GIC_SPI 0x7 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+
+            timer@20330060 {
+                compatible = "intel,keembay-timer";
+                reg = <0x60 0xc>;
+                interrupts = <GIC_SPI 0x8 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+
+            timer@20330070 {
+                compatible = "intel,keembay-timer";
+                reg = <0x70 0xc>;
+                interrupts = <GIC_SPI 0x9 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+
+            timer@20330080 {
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

