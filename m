Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5124D366E28
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbhDUO1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:27:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:36460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237893AbhDUO0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:26:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7AFB8B4D0;
        Wed, 21 Apr 2021 14:26:08 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: interrupt-controller: Add IDT 79RC3243x Interrupt Controller
Date:   Wed, 21 Apr 2021 16:26:05 +0200
Message-Id: <20210421142606.23188-2-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210421142606.23188-1-tsbogend@alpha.franken.de>
References: <20210421142606.23188-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document DT bindings for IDT 79RC3243x Interrupt Controller.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
Changes in v3:
  - fixed compatible string in example

Changes in v2:
  - added dt binding doc

 .../interrupt-controller/idt,3243x-pic.yaml   | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/idt,3243x-pic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/idt,3243x-pic.yaml b/Documentation/devicetree/bindings/interrupt-controller/idt,3243x-pic.yaml
new file mode 100644
index 000000000000..2d7dd34872bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/idt,3243x-pic.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/idt,3243x-pic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IDT 79RC3243x Interrupt Controller Device Tree Bindings
+
+maintainers:
+  - Thomas Bogendoerfer <tsbogend@alpha.franken.de>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  "#interrupt-cells":
+    const: 1
+
+  compatible:
+    const: idt,3243x-pci
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+required:
+  - "#interrupt-cells"
+  - compatible
+  - reg
+  - interrupt-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    idtpic3: interrupt-controller@3800c {
+        compatible = "idt,3243x-pic";
+        reg = <0x3800c 0x0c>;
+
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        interrupt-parent = <&cpuintc>;
+        interrupts = <3>;
+    };
+
+...
-- 
2.29.2

