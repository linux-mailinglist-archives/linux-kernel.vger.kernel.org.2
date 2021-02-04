Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4616630FEB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBDUoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhBDUlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:41:55 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60679C06178C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 12:41:09 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 48E7442860;
        Thu,  4 Feb 2021 20:40:52 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Hector Martin <marcan@marcan.st>, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH 14/18] dt-bindings: interrupt-controller: Add DT bindings for apple-aic
Date:   Fri,  5 Feb 2021 05:39:47 +0900
Message-Id: <20210204203951.52105-15-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204203951.52105-1-marcan@marcan.st>
References: <20210204203951.52105-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AIC is the Apple Interrupt Controller found on Apple ARM SoCs, such as
the M1.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../interrupt-controller/AAPL,aic.yaml        | 88 +++++++++++++++++++
 MAINTAINERS                                   |  2 +
 .../interrupt-controller/apple-aic.h          | 14 +++
 3 files changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/AAPL,aic.yaml
 create mode 100644 include/dt-bindings/interrupt-controller/apple-aic.h

diff --git a/Documentation/devicetree/bindings/interrupt-controller/AAPL,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/AAPL,aic.yaml
new file mode 100644
index 000000000000..7e119614275a
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/AAPL,aic.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/AAPL,aic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Interrupt Controller
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+
+description: |
+  The Apple Interrupt Controller is a simple interrupt controller present on
+  Apple ARM SoC platforms, including various iPhone and iPad devices and the
+  "Apple Silicon" M1 Macs.
+
+  It provides the following features:
+
+  - Level-triggered hardware IRQs wired to SoC blocks
+    - Single mask bit per IRQ
+    - Per-IRQ affinity setting
+    - Automatic masking on event delivery (auto-ack)
+    - Software triggering (ORed with hw line)
+  - 2 per-CPU IPIs (meant as "self" and "other", but they are interchangeable
+    if not symmetric)
+  - Automatic prioritization (single event/ack register per CPU, lower IRQs =
+    higher priority)
+  - Automatic masking on ack
+  - Default "this CPU" register view and explicit per-CPU views
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    contains:
+      enum:
+        - AAPL,aic
+        - AAPL,m1-aic
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 3
+    description: |
+      The 1st cell contains the interrupt type:
+        - 0: Hardware IRQ
+        - 1: FIQ
+        - 2: IPI
+
+      The 2nd cell contains the interrupt number.
+        - HW IRQs: interrupt number
+        - FIQs:
+          - 0: physical timer
+          - 1: virtual timer
+        - IPIs:
+          - 0: normal/"other" IPI (used interanlly for virtual IPIs)
+          - 1: self IPI (normally unused)
+
+      The 3rd cell contains the interrupt flags. This is normally
+      IRQ_TYPE_LEVEL_HIGH (4).
+
+  reg:
+    description: |
+      Specifies base physical address and size of the AIC registers.
+    maxItems: 1
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        aic: interrupt-controller@23b100000 {
+            compatible = "AAPL,m1-aic", "AAPL,aic";
+            #interrupt-cells = <3>;
+            interrupt-controller;
+            reg = <0x2 0x3b100000 0x0 0x8000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 91a7b33834ac..f3d4661731c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1634,6 +1634,8 @@ B:	https://github.com/AsahiLinux/linux/issues
 C:	irc://chat.freenode.net/asahi-dev
 T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/AAPL.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/AAPL,aic.yaml
+F:	include/dt-bindings/interrupt-controller/apple-aic.h
 
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
diff --git a/include/dt-bindings/interrupt-controller/apple-aic.h b/include/dt-bindings/interrupt-controller/apple-aic.h
new file mode 100644
index 000000000000..f54dc0cd6e9a
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/apple-aic.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_APPLE_AIC_H
+#define _DT_BINDINGS_INTERRUPT_CONTROLLER_APPLE_AIC_H
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#define AIC_IRQ 0
+#define AIC_FIQ 1
+#define AIC_IPI 2
+
+#define AIC_TMR_PHYS 0
+#define AIC_TMR_VIRT 1
+
+#endif
-- 
2.30.0

