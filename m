Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B393E3D7A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhG0QLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhG0QLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:11:51 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7785C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:11:51 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:b0a9:7e88:5ca4:551a])
        by michel.telenet-ops.be with bizsmtp
        id aGBq250021fSPfK06GBqeU; Tue, 27 Jul 2021 18:11:50 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m8PgL-001S8F-Jt; Tue, 27 Jul 2021 18:11:49 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m8PgK-00FrAy-TW; Tue, 27 Jul 2021 18:11:48 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dt-bindings: auxdisplay: arm-charlcd: Convert to json-schema
Date:   Tue, 27 Jul 2021 18:11:41 +0200
Message-Id: <4a63caa4136e8a31e82c7d75bb6f273498e8cccf.1627402256.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ARM Versatile Character LCD Device Tree binding documentation
to json-schema.

Correct compatible value.
Document missing properties.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 .../auxdisplay/arm,versatile-lcd.yaml         | 44 +++++++++++++++++++
 .../bindings/auxdisplay/arm-charlcd.txt       | 18 --------
 MAINTAINERS                                   |  2 +-
 3 files changed, 45 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/arm,versatile-lcd.yaml
 delete mode 100644 Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt

diff --git a/Documentation/devicetree/bindings/auxdisplay/arm,versatile-lcd.yaml b/Documentation/devicetree/bindings/auxdisplay/arm,versatile-lcd.yaml
new file mode 100644
index 0000000000000000..5d02bd032a85fe61
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/arm,versatile-lcd.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/auxdisplay/arm,versatile-lcd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Versatile Character LCD
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+  - Rob Herring <robh@kernel.org>
+
+description:
+  This binding defines the character LCD interface found on ARM Versatile AB
+  and PB reference platforms.
+
+properties:
+  compatible:
+    const: arm,versatile-lcd
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    lcd@10008000 {
+            compatible = "arm,versatile-lcd";
+            reg = <0x10008000 0x1000>;
+    };
diff --git a/Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt b/Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt
deleted file mode 100644
index e28e2aac47f156c6..0000000000000000
--- a/Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-ARM Versatile Character LCD
------------------------------------------------------
-This binding defines the character LCD interface found on ARM Versatile AB
-and PB reference platforms.
-
-Required properties:
-- compatible : "arm,versatile-clcd"
-- reg : Location and size of character LCD registers
-
-Optional properties:
-- interrupts - single interrupt for character LCD. The character LCD can
-  operate in polled mode without an interrupt.
-
-Example:
-	lcd@10008000 {
-		compatible = "arm,versatile-lcd";
-		reg = <0x10008000 0x1000>;
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index a8afc9238fd8e164..25901ecab560e3bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1382,7 +1382,7 @@ F:	Documentation/devicetree/bindings/arm/arm,integrator.yaml
 F:	Documentation/devicetree/bindings/arm/arm,realview.yaml
 F:	Documentation/devicetree/bindings/arm/arm,versatile.yaml
 F:	Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
-F:	Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt
+F:	Documentation/devicetree/bindings/auxdisplay/arm,versatile-lcd.yaml
 F:	Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
 F:	Documentation/devicetree/bindings/i2c/i2c-versatile.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt
-- 
2.25.1

