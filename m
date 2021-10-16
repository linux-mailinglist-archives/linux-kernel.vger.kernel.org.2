Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2C74304E6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 22:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244601AbhJPUZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 16:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhJPUZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 16:25:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D81CC061765;
        Sat, 16 Oct 2021 13:23:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g39so990016wmp.3;
        Sat, 16 Oct 2021 13:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGwCKkKntuz2wAmXcQT+5/s3ZGPk/CPd9kUXaHPNVLQ=;
        b=MM2GQKAHg6rvRPdHseP1F9D9WF3FtbwGLpr0MA5XPUTxqjpvs+b6UlGMLawheBwmn1
         uXd9rw8669OZIiYNQ48U40xH4/jgpmCQfzxOtjK1fOXS4ijqTnXTx408dUJ2VoKCwfif
         JOwEpXy42f02rxq67/VliXBoMaPscEji0nPgIQymuFZ6Xh7NJJJE6ukLw2ObWihFGTpD
         bIGh+HykFdmN+mb860BW2q3BFAcEqCfJXA/7fDG2qH/6unLG+AxGo2TS/kLDXfTFkMN3
         y3SRDT4eafrgTmCUfGrORDYOREfZGvfbTXSBg97ci4dCjGH0n0ZmrgbnZgnz0/5rjJst
         YZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGwCKkKntuz2wAmXcQT+5/s3ZGPk/CPd9kUXaHPNVLQ=;
        b=5qIbE8uIuurBNgAj/ZzXKO1L4DT11EHLG3Gx8RAELBE0Z/4tLpqnCo9pmxZPtLRKyl
         m70FGbDkG0HftvW2i6ywrUj86gsm3yPmkYkA7uQGLvcPN10u+lkYXuEWehOscQGFPaT0
         yuCL9+7SEY736xIOAieKPO/lds0sWPSxiUbgGNtlkdlSqv982pIshp8oHht+6rnU02kp
         pcZ/L/MYLhYZSSk2XQgQ3BV3V/NdAichVITL+S2EFT95TnNhMRatzZZlaDs++IE6wJUv
         i8erdq8PPkrS+3bAiFVgl5WPrcGQas1Ru6FSIv0cUEVBK2ImkB8cGCDuoIvowAWQ9DNd
         zzFw==
X-Gm-Message-State: AOAM531na7xzxMuE6IOXe60pPvoWec/4Hlw06HsEosuXM5o5bpDbQdzx
        9MnNOH+RGV78Cp6ojBpJt9rmGrMlFPc=
X-Google-Smtp-Source: ABdhPJyk6c5cua60bnhAe6BzwONSX698teVV3P8gTwrj4P/OW4USjmBd+50gg/6mxmhpRxa4Z0P3mg==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr19662393wmb.150.1634415814878;
        Sat, 16 Oct 2021 13:23:34 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id f15sm8162777wrt.38.2021.10.16.13.23.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Oct 2021 13:23:34 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     robh@kernel.org, john@phrozen.org, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] dt-bindings: bus: add palmbus device tree bindings
Date:   Sat, 16 Oct 2021 22:23:32 +0200
Message-Id: <20211016202332.8154-1-sergio.paracuellos@gmail.com>
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
changes in v4: The node name pattern is already checked elsewhere. There is only need to
               define the unit-address part which should be lowercase hex. 
Changes in v3: change sample to use child node which its bindings are
               already in YAML format to make dtschema happier.
Changes in v2: fixed missing semicolon in example.
 .../devicetree/bindings/bus/palmbus.yaml      | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/palmbus.yaml

diff --git a/Documentation/devicetree/bindings/bus/palmbus.yaml b/Documentation/devicetree/bindings/bus/palmbus.yaml
new file mode 100644
index 000000000000..4f6352eff050
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
+  "^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+$":
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

