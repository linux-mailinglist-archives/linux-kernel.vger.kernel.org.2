Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F3C4304EF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 22:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244591AbhJPUfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 16:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbhJPUfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 16:35:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77281C061765;
        Sat, 16 Oct 2021 13:33:27 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o24-20020a05600c511800b0030d9da600aeso4923754wms.4;
        Sat, 16 Oct 2021 13:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L4cvggOdhnFkBXfDhz5ZZVHZhrlThVGw+xSx4xzlSAM=;
        b=LPgh6IDQCUK3vW/i6YlnhI9KeTVshzzq0zCzgujdTAsf3CLpyVXfwZsOOo+1Ieb1nv
         GX2TOEVQUCut0FhX/QF5wii0cNRVKSrC4ZXKC1vO9llR7uyUn06YMue5WA2jXobIEYvO
         XLMYIvrriD/3/V/Ol5C84NEqIAcTR+Q2k9th5sjnb7sS+w2mZNSfpw80WNdt8mRp95LB
         4SUHEbPB7n9fqCOzhHO97ez/9AUQyQlgTQR0/gjcNrszB0ArZpPwaUXnaG7LWsDct++e
         C0dzwi5rFy5TZKaDzoKz9KBhq9SA7FG/pcutYoAP7PfTC0hIWgkor5IYi2gKv7Gl/zRK
         LFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L4cvggOdhnFkBXfDhz5ZZVHZhrlThVGw+xSx4xzlSAM=;
        b=RsgKV4pRBKXLaSpWGxr2fgoSp71Caoi2Oybv7fppdLwGHrQW/fRqm/tPvgWn1VMJQ+
         ktYXiru0aYdVka6ZuDdx/3Dj8ouV9P1TrEtr754US4xFwgtEHqOtQV/oAMENPPLuQFpG
         Yj+BLmYoQ76NvP4TTmi3ZnBs78Wog8fyt9uF3MHvYWhkCiidldzOhXEZ56lo6KFAXVsw
         /OREOBAlU48ZVdfhGFSf3ABvYR0r+IhmQLZKJ1c2Raa0Mf9Pr0cpLvrx67UAW4f+WKKB
         NH5UpmCase48w+wkYQdA8hSHMLIuidVcPFVTER5iCCWA2Rch57wzFmHPfhH3sU9eG8WY
         K8sQ==
X-Gm-Message-State: AOAM530FHxh0CjafSYXe5ka1yR6XK7pouqs8dmSHLLQckWjmCnqIltyu
        0ril1Lm4laFKV6zhpbgB3NE2XMYnQXQ=
X-Google-Smtp-Source: ABdhPJzdnsk11pf0AKEyox8tiBm31fMK71Tki6VuG7ucDDD4jK/UTQ9MDKQHbD4UZnCrx6vGD7GEUg==
X-Received: by 2002:a7b:ca56:: with SMTP id m22mr20890546wml.34.1634416405786;
        Sat, 16 Oct 2021 13:33:25 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id w11sm7748826wmc.44.2021.10.16.13.33.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Oct 2021 13:33:25 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     robh@kernel.org, john@phrozen.org, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] dt-bindings: bus: add palmbus device tree bindings
Date:   Sat, 16 Oct 2021 22:33:23 +0200
Message-Id: <20211016203323.9165-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for palmbus controller present in all the MIPS
ralink based SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
changes in v5: Sent wrong patch in v4. Hence, properly sent it.
Changes in v4: The node name pattern is already checked elsewhere. There is only need to
               define the unit-address part which should be lowercase hex. 
Changes in v3: change sample to use child node which its bindings are
               already in YAML format to make dtschema happier.
Changes in v2: fixed missing semicolon in example.
 .../devicetree/bindings/bus/palmbus.yaml      | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 .../devicetree/bindings/bus/palmbus.yaml      | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/palmbus.yaml

diff --git a/Documentation/devicetree/bindings/bus/palmbus.yaml b/Documentation/devicetree/bindings/bus/palmbus.yaml
new file mode 100644
index 000000000000..f5cbfaf52d53
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/palmbus.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/palmbus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ralink PalmBus Device Tree Bindings
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description: |
+  The ralink palmbus controller can be found in all ralink MIPS
+  SoCs. It provides an external bus for connecting multiple
+  external devices to the SoC.
+
+properties:
+  $nodename:
+    pattern: "^palmbus(@[0-9a-f]+)?$"
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  compatible:
+    const: palmbus
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+
+patternProperties:
+  # All other properties should be child nodes with unit-address and 'reg'
+  "@[0-9a-f]+$":
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    palmbus@1e000000 {
+        compatible = "palmbus";
+        reg = <0x1e000000 0x100000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x1e000000 0x0fffff>;
+
+        gpio@600 {
+            #gpio-cells = <2>;
+            #interrupt-cells = <2>;
+            compatible = "mediatek,mt7621-gpio";
+            gpio-controller;
+            gpio-ranges = <&pinctrl 0 0 95>;
+            interrupt-controller;
+            reg = <0x600 0x100>;
+            interrupt-parent = <&gic>;
+            interrupts = <GIC_SHARED 12 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+
+...
-- 
2.33.0

