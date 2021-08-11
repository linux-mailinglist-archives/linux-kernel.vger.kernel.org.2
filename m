Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4107C3E8C26
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbhHKIom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:44:42 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:44056
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236255AbhHKIod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:44:33 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id CBB753F0A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 08:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628671449;
        bh=cHr3JrzRS+V5545Psrh2+V69DTcS+sKTW5R2LFL9CLw=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=u7bG+qmxLELmUAbvWYGaxKXc4QkF8HrlK0454NnB0gCUVaRFHxyrQUH3ihdPaUujr
         jXl77jVb9RBMXdRhAswx1GBSt4/dSsFZXDTfPVKdM8IlF4j1U950o45AFQF3dXhHi4
         r/FkllgujKLXQHNHGwJjmr4uywwQmejLYsXqX/6sMVw/HqO9lSxVXpxVhkLO95/Ntw
         jjcIg2nX5L9QztjH9vf2dY58az7ayH6Gf8bEJ3/mBwDlPsGM5nvtxvskeaBPX2i2gK
         5O2UOgCdmRCTGJFOBo/BAgXfYh3rqZjPNAJecIY0OekJsBWiVpXEUfYrk9tLFeZMw+
         zEbb4ZQARpgnQ==
Received: by mail-ej1-f72.google.com with SMTP id q19-20020a1709064cd3b02904c5f93c0124so395384ejt.14
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cHr3JrzRS+V5545Psrh2+V69DTcS+sKTW5R2LFL9CLw=;
        b=sr5Cy82rfShASb+DWMh8m7wIBDhMgpq4ER7Arse/QDR+iuHboLuQbfivSrOaJxrp6z
         ZwtANAT30kZObQgUeZBkTSek2fInX9FVUisfxj8Yvl4HLu+H0DTco0lFz9Etnbs6SKQM
         g71kl1REFUlo0FFxiwoJlAcx7Akmnb0J0juE4Wuojieg5S83L7EuIwfbG03vozQz3Ybl
         RoDNX1gs3wVYjDj7VQMUN7PZZ0CfmM45ExBqMeF1N9or9o2PupsH3frNTNBBGmOPM1co
         Yipgz7/8ntN1DZS+fMyKKyMXHSuEKMp+GTGFld7rA+esonHPTcqffej0VMIks9pX6I6s
         nypg==
X-Gm-Message-State: AOAM532j5o1iMUV9g1MD97ic19e2wtcOgQHfAnlvp0I9+KhdHJeS5KHQ
        zjZp1/dePze3w9UvcYxI7+czg34+bvQx59+tTyLIebHj5b5eHhnyjc4qx+qLhRPQs8maiTcPAsR
        KXNVGEy+WJ8VOXCSXEtl6TyaUhTiiBaARZFlguml/ig==
X-Received: by 2002:a17:906:c252:: with SMTP id bl18mr2576143ejb.519.1628671449540;
        Wed, 11 Aug 2021 01:44:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN0M005Kt6h3a02hccMdFKOXLA0/K49CFe+0FJWoFPEYNKvXyWwm92jayRVXcKDmy89NLWPA==
X-Received: by 2002:a17:906:c252:: with SMTP id bl18mr2576125ejb.519.1628671449349;
        Wed, 11 Aug 2021 01:44:09 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id kk14sm2429708ejc.29.2021.08.11.01.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 01:44:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: irqchip: convert Samsung Exynos IRQ combiner to dtschema
Date:   Wed, 11 Aug 2021 10:43:05 +0200
Message-Id: <20210811084306.28740-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung Exynos SoC Interrupt Combiner Controller bindings to DT
schema format using json-schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../samsung,exynos4210-combiner.txt           | 50 ----------
 .../samsung,exynos4210-combiner.yaml          | 96 +++++++++++++++++++
 2 files changed, 96 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/samsung,exynos4210-combiner.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/samsung,exynos4210-combiner.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/samsung,exynos4210-combiner.txt b/Documentation/devicetree/bindings/interrupt-controller/samsung,exynos4210-combiner.txt
deleted file mode 100644
index 19af687858a1..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/samsung,exynos4210-combiner.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-* Samsung Exynos Interrupt Combiner Controller
-
-Samsung's Exynos4 architecture includes a interrupt combiner controller which
-can combine interrupt sources as a group and provide a single interrupt request
-for the group. The interrupt request from each group are connected to a parent
-interrupt controller, such as GIC in case of Exynos4210.
-
-The interrupt combiner controller consists of multiple combiners. Up to eight
-interrupt sources can be connected to a combiner. The combiner outputs one
-combined interrupt for its eight interrupt sources. The combined interrupt
-is usually connected to a parent interrupt controller.
-
-A single node in the device tree is used to describe the interrupt combiner
-controller module (which includes multiple combiners). A combiner in the
-interrupt controller module shares config/control registers with other
-combiners. For example, a 32-bit interrupt enable/disable config register
-can accommodate up to 4 interrupt combiners (with each combiner supporting
-up to 8 interrupt sources).
-
-Required properties:
-- compatible: should be "samsung,exynos4210-combiner".
-- interrupt-controller: Identifies the node as an interrupt controller.
-- #interrupt-cells: should be <2>. The meaning of the cells are
-	* First Cell: Combiner Group Number.
-	* Second Cell: Interrupt number within the group.
-- reg: Base address and size of interrupt combiner registers.
-- interrupts: The list of interrupts generated by the combiners which are then
-    connected to a parent interrupt controller. The format of the interrupt
-    specifier depends in the interrupt parent controller.
-
-Optional properties:
-- samsung,combiner-nr: The number of interrupt combiners supported. If this
-  property is not specified, the default number of combiners is assumed
-  to be 16.
-
-
-Example:
-
-	The following is a an example from the Exynos4210 SoC dtsi file.
-
-	combiner:interrupt-controller@10440000 {
-		compatible = "samsung,exynos4210-combiner";
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		reg = <0x10440000 0x1000>;
-		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
-			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
-			     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
-			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
-	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/samsung,exynos4210-combiner.yaml b/Documentation/devicetree/bindings/interrupt-controller/samsung,exynos4210-combiner.yaml
new file mode 100644
index 000000000000..d631b7589d50
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/samsung,exynos4210-combiner.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/samsung,exynos4210-combiner.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC Interrupt Combiner Controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  Samsung's Exynos4 architecture includes a interrupt combiner controller which
+  can combine interrupt sources as a group and provide a single interrupt
+  request for the group. The interrupt request from each group are connected to
+  a parent interrupt controller, such as GIC in case of Exynos4210.
+
+  The interrupt combiner controller consists of multiple combiners. Up to eight
+  interrupt sources can be connected to a combiner. The combiner outputs one
+  combined interrupt for its eight interrupt sources. The combined interrupt is
+  usually connected to a parent interrupt controller.
+
+  A single node in the device tree is used to describe the interrupt combiner
+  controller module (which includes multiple combiners). A combiner in the
+  interrupt controller module shares config/control registers with other
+  combiners. For example, a 32-bit interrupt enable/disable config register can
+  accommodate up to 4 interrupt combiners (with each combiner supporting up to
+  8 interrupt sources).
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    const: samsung,exynos4210-combiner
+
+  interrupt-controller: true
+
+  interrupts:
+    minItems: 8
+    maxItems: 32
+
+  "#interrupt-cells":
+    description: |
+      The meaning of the cells are:
+        * First Cell: Combiner Group Number.
+        * Second Cell: Interrupt number within the group.
+    const: 2
+
+  reg:
+    maxItems: 1
+
+  samsung,combiner-nr:
+    description: |
+      The number of interrupt combiners supported.  Should match number
+      of interrupts set in "interrupts" property.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 8
+    maximum: 32
+    default: 16
+
+required:
+  - compatible
+  - interrupt-controller
+  - interrupts
+  - "#interrupt-cells"
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    interrupt-controller@10440000 {
+        compatible = "samsung,exynos4210-combiner";
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        reg = <0x10440000 0x1000>;
+        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.30.2

