Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D400B43F97A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 11:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhJ2JNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 05:13:52 -0400
Received: from [113.204.237.245] ([113.204.237.245]:55512 "EHLO
        test.cqplus1.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231418AbhJ2JNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 05:13:04 -0400
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.28.114.216
        by cqmailgates with MailGates ESMTP Server V5.0(10981:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 29 Oct 2021 16:46:00 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        wells.lu@sunplus.com, Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v2 7/8] dt-bindings: interrupt-controller: Add bindings for SP7021 interrupt controller
Date:   Fri, 29 Oct 2021 16:44:33 +0800
Message-Id: <f3215c63729c7d717074dc5823d45acc0f89b39a.1635496594.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1635496594.git.qinjian@cqplus1.com>
References: <cover.1635496594.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Sunplus SP7021 interrupt controller bindings.

Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
 .../sunplus,sp7021-intc.yaml                  | 59 +++++++++++++++++++
 MAINTAINERS                                   |  2 +
 .../interrupt-controller/sp7021-intc.h        | 24 ++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
 create mode 100644 include/dt-bindings/interrupt-controller/sp7021-intc.h

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
new file mode 100644
index 000000000..185c99b5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
@@ -0,0 +1,59 @@
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
+    description:
+      The first cell is the IRQ number, the second cell the trigger
+      type as defined in interrupt.txt in this directory.
+      The MSB of second cell also indicate route to which EXT_INT.
+
+  reg:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 2
+    description:
+      EXT_INT0 & EXT_INT1, 2 interrupts references to primary interrupt
+      controller.
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
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 5069f552f..be0334d6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2662,10 +2662,12 @@ S:	Maintained
 W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
 F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
 F:	drivers/clk/clk-sp7021.c
 F:	drivers/reset/reset-sunplus.c
 F:	include/dt-bindings/clock/sp-sp7021.h
+F:	include/dt-bindings/interrupt-controller/sp7021-intc.h
 F:	include/dt-bindings/reset/sp-sp7021.h
 
 ARM/Synaptics SoC support
diff --git a/include/dt-bindings/interrupt-controller/sp7021-intc.h b/include/dt-bindings/interrupt-controller/sp7021-intc.h
new file mode 100644
index 000000000..fa2eb8100
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/sp7021-intc.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
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

