Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C48D3927CC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 08:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhE0GlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 02:41:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:11441 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233847AbhE0GlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 02:41:01 -0400
IronPort-SDR: 8P2qYlqmYv5LvHVlYRNquZEqhKniSMi2rzIfTU/Cf42+rwwzHNDZ2nw3kCuZQu3DcJw5E2MXQi
 prEL9X18KbqA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202696291"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="202696291"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 23:39:14 -0700
IronPort-SDR: uv7aJivqylP3zBY7i0ZpWj9vQcx0XwGzv5Y2brrulyEuJ4u9M+YtJlGmym+dOfo0LWBA2D2+Mg
 TjDsPZ6hveYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="615265858"
Received: from bspteam04.iind.intel.com ([10.106.46.142])
  by orsmga005.jf.intel.com with ESMTP; 26 May 2021 23:39:10 -0700
From:   shruthi.sanil@intel.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, kris.pan@linux.intel.com,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH v3 1/2] dt-bindings: timer: Add bindings for Intel Keem Bay SoC Timer
Date:   Thu, 27 May 2021 12:09:05 +0530
Message-Id: <20210527063906.18592-2-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527063906.18592-1-shruthi.sanil@intel.com>
References: <20210527063906.18592-1-shruthi.sanil@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shruthi Sanil <shruthi.sanil@intel.com>

Add Device Tree bindings for the Timer IP, which can be used as
clocksource and clockevent device in the Intel Keem Bay SoC.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
---
 .../bindings/timer/intel,keembay-timer.yaml   | 180 ++++++++++++++++++
 1 file changed, 180 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
new file mode 100644
index 000000000000..e0152e19208f
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
@@ -0,0 +1,180 @@
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
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
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
+            #address-cells = <0x2>;
+            #size-cells = <0x2>;
+            ranges;
+
+            counter@203300e8 {
+                compatible = "intel,keembay-counter";
+                reg = <0x0 0x203300e8 0x0 0x8>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+                status = "okay";
+            };
+
+            timer@20330010 {
+                compatible = "intel,keembay-timer";
+                reg = <0x0 0x20330010 0x0 0xc>;
+                interrupts = <GIC_SPI 0x3 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+                status = "okay";
+            };
+
+            timer@20330020 {
+                compatible = "intel,keembay-timer";
+                reg = <0x0 0x20330020 0x0 0xc>;
+                interrupts = <GIC_SPI 0x4 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+                status = "okay";
+            };
+
+            timer@20330030 {
+                compatible = "intel,keembay-timer";
+                reg = <0x0 0x20330030 0x0 0xc>;
+                interrupts = <GIC_SPI 0x5 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+                status = "okay";
+            };
+
+            timer@20330040 {
+                compatible = "intel,keembay-timer";
+                reg = <0x0 0x20330040 0x0 0xc>;
+                interrupts = <GIC_SPI 0x6 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+                status = "okay";
+            };
+
+            timer@20330050 {
+                compatible = "intel,keembay-timer";
+                reg = <0x0 0x20330050 0x0 0xc>;
+                interrupts = <GIC_SPI 0x7 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+                status = "okay";
+            };
+
+            timer@20330060 {
+                compatible = "intel,keembay-timer";
+                reg = <0x0 0x20330060 0x0 0xc>;
+                interrupts = <GIC_SPI 0x8 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+                status = "okay";
+            };
+
+            timer@20330070 {
+                compatible = "intel,keembay-timer";
+                reg = <0x0 0x20330070 0x0 0xc>;
+                interrupts = <GIC_SPI 0x9 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+                status = "okay";
+            };
+
+            timer@20330080 {
+                compatible = "intel,keembay-timer";
+                reg = <0x0 0x20330080 0x0 0xc>;
+                interrupts = <GIC_SPI 0xa IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+                status = "okay";
+            };
+        };
+    };
+
+...
-- 
2.17.1

