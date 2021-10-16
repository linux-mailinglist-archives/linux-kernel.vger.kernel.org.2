Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55224304EB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 22:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244618AbhJPU2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 16:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244611AbhJPU2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 16:28:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916C5C061765;
        Sat, 16 Oct 2021 13:26:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y3so32991183wrl.1;
        Sat, 16 Oct 2021 13:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fY5vUzD6KMxSI0lz5xTBbc8a7TLb2YtsRF/0pt37Up8=;
        b=U8aK8nq2xTVNye0OfMhx4nremMck2k8EOvWd+g/MQDhf9tCk0CZqtLFO6MaePsrTO4
         cj4r7k3yif43P/cFQQ1PpHYZ6Ukgivkxjeyku/9defOBXoy3vZLY4Ti+/ffHdcPkxXZ6
         1HdjRNAaVp+Z3qATIEUX5pJNG/HpnSSLNxhE3rX9WDNDrOH8nVsYIBsJu9NJ+4GqXZ5Y
         J3fgxeFvPF74/sWpojwhPNXgvEJri1Q4Majda2d8UT9ANoHvKx4P3ldCOzYFXSxGCOcm
         ZIwMg+kNix1GJIu+F36ao+xF40rJDXmD0J+0YGYwp2uMDkobv3HxNJj417nC4lkbzaPP
         rSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fY5vUzD6KMxSI0lz5xTBbc8a7TLb2YtsRF/0pt37Up8=;
        b=dxwb5ATHdN1NW0p5Uo4a8GGCNuPqaABm/ujLygqCdSoRviF/f4zMjqprky3pYYt5Tu
         ZikzVYqzStuwHbogQAlTR2CjPCA54+n5cNADvglRhtAbZ2yMaFBOWmmWAAtpA2VoslTT
         FIdJ5jY4QFRVLH9i2yunIaJ3hY5h34HN8A7dq08oPqgiHJVR++SxVL2puxMnhNgzNZFl
         4vodsxjZJBH//SJfSI59vfqXYqiyCzhFPg9iVKrWal2RVgT5LNWhp/Y7+r8videjK0XC
         aHfh12Nwx/57u2ar5IxWQuptPncKIR6UyEYK8SioNI/dSLRLIUPvLdyVIcoMd6wliqec
         54UQ==
X-Gm-Message-State: AOAM530jIagw+ubOOW3exq6k5JNF7mHGtKfIJ3jAOd/sBr8B6ayFV+XD
        Smdz5gK2WL80H4CAMmRCx9wYkfuLa+c=
X-Google-Smtp-Source: ABdhPJyogBmPpLEC/pWyBJa83NFjMTy9T/xISx0KESJ67+NPcm7hEeiqhn+P6oxNqBcY3vGY7sVqWA==
X-Received: by 2002:a05:6000:18a4:: with SMTP id b4mr24261440wri.394.1634415996972;
        Sat, 16 Oct 2021 13:26:36 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id d7sm2138387wrx.22.2021.10.16.13.26.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Oct 2021 13:26:36 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     robh@kernel.org, john@phrozen.org, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] dt-bindings: bus: add palmbus device tree bindings
Date:   Sat, 16 Oct 2021 22:26:35 +0200
Message-Id: <20211016202635.8266-1-sergio.paracuellos@gmail.com>
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

