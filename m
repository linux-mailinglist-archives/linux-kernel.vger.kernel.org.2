Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D3C387BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244704AbhERO6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243818AbhERO6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:58:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AFFC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:57:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so1715895wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nnvJ8osbkowWmqtn9NFdggrDzHVnx44WWHnS4UTIDOM=;
        b=dqKKErEgkRlR/pYnicFKmswieuRIFj7bEca/bsTnapwvj2d7DrbFobFVAB/igJPDPH
         UfbaKjLSc4YwuLqpfz4YuA8+JSRGcf6B2IAiFPw803FOmrM5P1DKzXCEH90/QzwSx2dT
         BL2cO/+aNcxil+n6LKy4wjvEWD5eqlxSnlGqOAmk2QRQkcKq8hyalmI1x5F0CwW6to79
         xVjjpqTzopTJhSXfjNkSN0zuA9/0QS4+l4yZBudznhcwL+7GhrGE2E7819lc+BM5w8Ca
         GUBBgTjXeKrdBzX7XAwZOedzp0eRVerGZgUWpjwQeV3nBLYoIRyhklIZ6pb9fO1Vhz0q
         /0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nnvJ8osbkowWmqtn9NFdggrDzHVnx44WWHnS4UTIDOM=;
        b=IqcnnOyKPiup/TN/KFluFn6FCLOCIv+dx17Y34CvbdjwSjoA9p5Quwipx5xPqcPor2
         t55wY9VBGjzlYkEfATfhakUNQ/6ug5wFOnpwI9NbFBt4HEFEcDnTcOSGXLjniFHTPB3/
         3Nkvv9AGPlM26Iuh7ZlT5BsxpHG/BQZglUDpe81Sc2yLYp3vpqCujGEEKZITJviDwGPx
         p9TYMs6+1ONSq25omSABOhrBq4kPGYjThnyoqJ3nPKgjf9pKiQ9wB0cekjl/EjCgTMEe
         Cxrz38J/nDNM5XMWd3LxBxbR/GT31qxNAjJsM7e4Mj3z9bCmBnbLvdT1hx9CDHinm/Ko
         Wnxg==
X-Gm-Message-State: AOAM531BwBhABh0SXdbWO2SiCQhq/DqE8k9QOhKDP4hqpQmVU98UV5KK
        vf3bd82XxCHgY078qCLkcfr4sA==
X-Google-Smtp-Source: ABdhPJykHbrqVuGSot4jl0mtKbOsvhBcfbVcGuhfK+eptPr3NLTg0KErO+dWYOEgB6dOfCldaFg29g==
X-Received: by 2002:a1c:2507:: with SMTP id l7mr5969715wml.188.1621349841534;
        Tue, 18 May 2021 07:57:21 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id a18sm2928386wmb.13.2021.05.18.07.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:57:20 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Qii Wang <qii.wang@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: i2c: i2c-mt65xx: convert doc to yaml schema format
Date:   Tue, 18 May 2021 16:55:20 +0200
Message-Id: <20210518145522.2420135-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the binding documentation for i2c-mt65xx driver to the
YAML schema format.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../devicetree/bindings/i2c/i2c-mt65xx.txt    | 49 ----------
 .../devicetree/bindings/i2c/i2c-mt65xx.yaml   | 97 +++++++++++++++++++
 2 files changed, 97 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
deleted file mode 100644
index 7f0194fdd0cc..000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-* MediaTek's I2C controller
-
-The MediaTek's I2C controller is used to interface with I2C devices.
-
-Required properties:
-  - compatible: value should be either of the following.
-      "mediatek,mt2701-i2c", "mediatek,mt6577-i2c": for MediaTek MT2701
-      "mediatek,mt2712-i2c": for MediaTek MT2712
-      "mediatek,mt6577-i2c": for MediaTek MT6577
-      "mediatek,mt6589-i2c": for MediaTek MT6589
-      "mediatek,mt6797-i2c", "mediatek,mt6577-i2c": for MediaTek MT6797
-      "mediatek,mt7622-i2c": for MediaTek MT7622
-      "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
-      "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek MT7629
-      "mediatek,mt8173-i2c": for MediaTek MT8173
-      "mediatek,mt8183-i2c": for MediaTek MT8183
-      "mediatek,mt8192-i2c": for MediaTek MT8192
-      "mediatek,mt8516-i2c", "mediatek,mt2712-i2c": for MediaTek MT8516
-  - reg: physical base address of the controller and dma base, length of memory
-    mapped region.
-  - interrupts: interrupt number to the cpu.
-  - clock-div: the fixed value for frequency divider of clock source in i2c
-    module. Each IC may be different.
-  - clocks: clock name from clock manager
-  - clock-names: Must include "main" and "dma", "arb" is for multi-master that
-    one bus has more than two i2c controllers, if enable have-pmic need include
-    "pmic" extra.
-
-Optional properties:
-  - clock-frequency: Frequency in Hz of the bus when transfer, the default value
-    is 100000.
-  - mediatek,have-pmic: platform can control i2c form special pmic side.
-    Only mt6589 and mt8135 support this feature.
-  - mediatek,use-push-pull: IO config use push-pull mode.
-
-Example:
-
-	i2c0: i2c@1100d000 {
-			compatible = "mediatek,mt6577-i2c";
-			reg = <0x1100d000 0x70>,
-			      <0x11000300 0x80>;
-			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_LOW>;
-			clock-frequency = <400000>;
-			mediatek,have-pmic;
-			clock-div = <16>;
-			clocks = <&i2c0_ck>, <&ap_dma_ck>;
-			clock-names = "main", "dma";
-	};
-
diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
new file mode 100644
index 000000000000..0f445d2ab727
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/i2c/i2c-mt65xx.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediaTek I2C Controller
+
+maintainers:
+  - Qii Wang <qii.wang@mediatek.com>
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  $nodename:
+    pattern: "^i2c[0-9]*@[0-9a-f]+$"
+
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt2712-i2c
+          - mediatek,mt6577-i2c
+          - mediatek,mt6589-i2c
+          - mediatek,mt7622-i2c
+          - mediatek,mt8173-i2c
+          - mediatek,mt8183-i2c
+          - mediatek,mt8192-i2c
+      - items:
+          - const: mediatek,mt2701-i2c
+          - const: mediatek,mt6577-i2c
+      - items:
+          - const: mediatek,mt6797-i2c
+          - const: mediatek,mt6577-i2c
+      - items:
+          - const: mediatek,mt7623-i2c
+          - const: mediatek,mt6577-i2c
+      - items:
+          - const: mediatek,mt7629-i2c
+          - const: mediatek,mt2712-i2c
+      - items:
+          - const: mediatek,mt8516-i2c
+          - const: mediatek,mt2712-i2c
+
+  clocks:
+    minItems: 2
+    maxItems: 4
+    items:
+      - description: Controller clock
+      - description: DMA clock
+      - description: ARB clock for multi-master when a bus has more than
+          one i2c controllers
+      - description: PMIC clock. Only when mediatek,have-pmic is set.
+
+  clock-names:
+    minItems: 2
+    maxItems: 4
+    items:
+      - const: main
+      - const: dma
+      - const: arb
+      - const: pmic
+
+  mediatek,have-pmic:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Platform can control I2C from the PMIC
+
+  mediatek,use-push-pull:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: IO config use push-pull mode.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - clock-div
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    i2c0: i2c@1100d000 {
+            compatible = "mediatek,mt6577-i2c";
+            reg = <0x1100d000 0x70>,
+                  <0x11000300 0x80>;
+            interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_LOW>;
+            clock-frequency = <400000>;
+            mediatek,have-pmic;
+            clock-div = <16>;
+            clocks = <&i2c0_ck>, <&ap_dma_ck>;
+            clock-names = "main", "dma";
+    };
-- 
2.31.1

