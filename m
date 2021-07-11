Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B830E3C3C8D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 14:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhGKMwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 08:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKMwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 08:52:07 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29189C0613DD;
        Sun, 11 Jul 2021 05:49:21 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id j3so5655796plx.7;
        Sun, 11 Jul 2021 05:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mIxSmufWuDTKwlxgFXvm/s5Rjq6omybGQ7A5dLknTx4=;
        b=B1hyEQpkq0+TBnqVNyJV0dgFXD20LT36fA/k3KQPRS3hUE/zFKjBiCGUuGL6mzypy3
         hVqvKg6k7Kxh4uLv7XllrVeMs6/ZW9mmVFINbSGM2lAwUCQT7279OIen1pVwVymJvow/
         nuV6+Hah+K5vel9DXkerdfpirZnewPI68CKv7OoMFIb6VOAA7L+t73HvRjbS5I4YHROZ
         /N88JZBxtJG6ZS5CLw9kirsAEj0MGHT8dwucIdCfZtrUqZIAGXzLcXOgJZn/EUZnStEH
         iYrOoOyV2tNrNvmJjb9Y/A8NTCdGZP7elTZr+1y9CYiK32J1NfZA8ZNyMIQz4MRHsTWX
         hLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mIxSmufWuDTKwlxgFXvm/s5Rjq6omybGQ7A5dLknTx4=;
        b=oOLe3N6FTkvUdKEQFt7L06Xn4IptI0hAgtMnnCLExlGL8rzkBAySkm6aqNY4SEl4jf
         xi1nKdXdY6cubt9XJ9tVW6c8wP5zNhCLYB5hCXIaMBhkwabk97P2iFb8wS+6+nPRN1BS
         zmVXnIkIv57GMNUfaVW17pg5JnU0Wt8AsoRoNPOyc/+cKGzNfwpcoxdrpl6hk7m1f8d/
         JDo9yhmu9EZi4BvB8QFUuPUCDXurWhwWsbr77cWlPMSIsgo/VXyon7STXAokNhf9RiDN
         CHuDMeeW+5WTLwAhAPfRZlN3502appU4DYMBgP7uvxsK/OWvwueigAQ/g3S/TSRw9rCW
         Bi+g==
X-Gm-Message-State: AOAM530Uarz2kgWtluE1qxoZ3FKFplnA0MRw+f8NMknwV2AGNewKbp3G
        r5ZN5+t2UDPhHkVGNJjzmYg4/cxNxa/A
X-Google-Smtp-Source: ABdhPJxvFbvViX+F8Vrs22jIs658qzk0Elx92cNANGF4OQD9QFj1l6fZgMamKh9cIhVwhNlshf2Jew==
X-Received: by 2002:a17:902:a50f:b029:11a:cd45:9009 with SMTP id s15-20020a170902a50fb029011acd459009mr39227014plq.38.1626007760610;
        Sun, 11 Jul 2021 05:49:20 -0700 (PDT)
Received: from localhost.localdomain ([113.104.213.237])
        by smtp.gmail.com with ESMTPSA id pj4sm17717343pjb.18.2021.07.11.05.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 05:49:20 -0700 (PDT)
From:   fengzheng923@gmail.com
To:     fengzheng923@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings for DMIC controller
Date:   Sun, 11 Jul 2021 08:48:26 -0400
Message-Id: <20210711124826.5376-1-fengzheng923@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ban Tao <fengzheng923@gmail.com>

DT binding documentation for this new ASoC driver.

Signed-off-by: Ban Tao <fengzheng923@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---
v1->v2:
1.Fix some build errors.
---
v2->v3:
1.Fix some build errors.
---
v3->v4:
1.None.
---
v4->v5:
1.Add interrupt.
2.Keep clock and reset index.
---
v5->v6:
1.None.
---
 .../sound/allwinner,sun50i-h6-dmic.yaml       | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
new file mode 100644
index 000000000000..0cfc07f369bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/allwinner,sun50i-h6-dmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner H6 DMIC Device Tree Bindings
+
+maintainers:
+  - Ban Tao <fengzheng923@gmail.com>
+
+properties:
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    const: allwinner,sun50i-h6-dmic
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: mod
+
+  dmas:
+    items:
+      - description: RX DMA Channel
+
+  dma-names:
+    items:
+      - const: rx
+
+  resets:
+    maxItems: 1
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    #include <dt-bindings/clock/sun50i-h6-ccu.h>
+    #include <dt-bindings/reset/sun50i-h6-ccu.h>
+
+    dmic: dmic@5095000 {
+      #sound-dai-cells = <0>;
+      compatible = "allwinner,sun50i-h6-dmic";
+      reg = <0x05095000 0x400>;
+      interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&ccu CLK_BUS_DMIC>, <&ccu CLK_DMIC>;
+      clock-names = "bus", "mod";
+      dmas = <&dma 7>;
+      dma-names = "rx";
+      resets = <&ccu RST_BUS_DMIC>;
+    };
+
+...
-- 
2.17.1

