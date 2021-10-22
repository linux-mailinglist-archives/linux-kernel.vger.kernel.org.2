Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20BB4371AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 08:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhJVGW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 02:22:57 -0400
Received: from [113.204.237.245] ([113.204.237.245]:45650 "EHLO
        test.cqplus1.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230379AbhJVGWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 02:22:54 -0400
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.28.114.216
        by cqmailgates with MailGates ESMTP Server V5.0(10980:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 22 Oct 2021 14:08:10 +0800 (CST)
From:   qinjian <qinjian@cqplus1.com>
To:     tglx@linutronix.de
Cc:     maz@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, qinjian <qinjian@cqplus1.com>
Subject: [PATCH 2/4] dt-bindings: interrupt-controller: Add bindings for SP7021 interrupt controller
Date:   Fri, 22 Oct 2021 14:07:37 +0800
Message-Id: <20211022060737.281116-1-qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Sunplus SP7021 interrupt controller bindings.

Signed-off-by: qinjian <qinjian@cqplus1.com>
---
 .../sunplus,sp7021-intc.yaml                  | 69 +++++++++++++++++++
 MAINTAINERS                                   |  2 +
 .../interrupt-controller/sp7021-intc.h        | 24 +++++++
 3 files changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
 create mode 100644 include/dt-bindings/interrupt-controller/sp7021-intc.h

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
new file mode 100644
index 000000000..73719f65b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/sunplus,sp7021-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SP7021 SoC Interrupt Controller Device Tree Bindings
+
+maintainers:
+  - Qin Jian <qinjian@cqplus1.com>
+
+properties:
+  compatible:
+    items:
+      - const: sunplus,sp7021-intc
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupts references to primary interrupt controller
+
+  ext0-mask:
+    description:
+      cpu affinity of EXT_INT0.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 1
+    maximum: 16
+
+  ext1-mask:
+    description:
+      cpu affinity of EXT_INT1.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 1
+    maximum: 16
+
+required:
+  - compatible
+  - interrupt-controller
+  - "#interrupt-cells"
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    intc: interrupt-controller@9c000780 {
+        compatible = "sunplus,sp7021-intc";
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        reg = <0x9c000780 0x80>, <0x9c000a80 0x80>;
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>, /* EXT_INT0 */
+                    <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>; /* EXT_INT1 */
+        ext0-mask = <0xf>; /* core0-3 */
+        ext1-mask = <0xe>; /* core1-3 */
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 7a78b1bbe..065da0846 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2660,6 +2660,8 @@ M:	Qin Jian <qinjian@cqplus1.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for mon-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
+F:	include/dt-bindings/interrupt-controller/sp7021-intc.h
 
 ARM/Synaptics SoC support
 M:	Jisheng Zhang <Jisheng.Zhang@synaptics.com>
diff --git a/include/dt-bindings/interrupt-controller/sp7021-intc.h b/include/dt-bindings/interrupt-controller/sp7021-intc.h
new file mode 100644
index 000000000..8f36e262e
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/sp7021-intc.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Sunplus Technology Co., Ltd.
+ *       All rights reserved.
+ *
+ *
+ * This header provides constants for the SP7021 INTC
+ */
+
+#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_SP7021_INTC_H
+#define _DT_BINDINGS_INTERRUPT_CONTROLLER_SP7021_INTC_H
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/*
+ * Interrupt specifier cell 1.
+ * The flags in irq.h are valid, plus those below.
+ */
+#define SP_INTC_EXT_INT0		0x00000
+#define SP_INTC_EXT_INT1		0x01000
+#define SP_INTC_EXT_INT_MASK	0xff000
+#define SP_INTC_EXT_INT_SHFIT	12
+
+#endif
-- 
2.33.1

