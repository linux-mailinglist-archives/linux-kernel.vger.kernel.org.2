Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EF43D3B80
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 15:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbhGWNPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 09:15:31 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:49029 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbhGWNP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 09:15:26 -0400
Received: (Authenticated sender: clement.leger@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D7B7D1BF211;
        Fri, 23 Jul 2021 13:55:57 +0000 (UTC)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/3] dt-bindings: mfd: add "syscon-smc" YAML description
Date:   Fri, 23 Jul 2021 15:52:39 +0200
Message-Id: <20210723135239.388325-4-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723135239.388325-1-clement.leger@bootlin.com>
References: <20210723135239.388325-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation for the "syscon-smc" compatible which describes
a syscon using a SMC regmap instead of a MMIO one. This allows accessing system
controllers that are set as secure by using SMC handled by the secure monitor.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 .../devicetree/bindings/mfd/syscon-smc.yaml   | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/syscon-smc.yaml

diff --git a/Documentation/devicetree/bindings/mfd/syscon-smc.yaml b/Documentation/devicetree/bindings/mfd/syscon-smc.yaml
new file mode 100644
index 000000000000..6ce1392c5e7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/syscon-smc.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/syscon-smc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: System Controller Registers R/W via SMC Device Tree Bindings
+
+description: |
+  System controller SMC node represents a register region containing a set
+  of miscellaneous registers accessed through a secure monitor.
+  The typical use-case is the same as the syscon one but when running with a
+  secure monitor.
+
+maintainers:
+  - Lee Jones <lee.jones@linaro.org>
+
+properties:
+  compatible:
+    anyOf:
+      - items:
+          - enum:
+              - atmel,sama5d2-sfr
+
+          - const: syscon-smc
+
+      - contains:
+          const: syscon-smc
+        minItems: 2
+        maxItems: 4  # Should be enough
+
+  arm,smc-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The ATF smc function id used by the firmware.
+
+  reg-io-width:
+    description: |
+      The size (in bytes) of the IO accesses that should be performed
+      on the device.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8]
+
+required:
+  - compatible
+  - arm,smc-id
+
+additionalProperties: false
+
+examples:
+  - |
+    sfr {
+        compatible = "atmel,sama5d2-sfr", "syscon-smc";
+        arm,smc-id = <0x02000300>;
+    };
+
+...
-- 
2.32.0

