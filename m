Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44923BAC71
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 11:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhGDJ04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 05:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGDJ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 05:26:55 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2F7C061762;
        Sun,  4 Jul 2021 02:24:20 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g22so15071105pgl.7;
        Sun, 04 Jul 2021 02:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ctPbpBSME4Wk2MPaV81CnmhuA+m0hProI1IntXJRC/o=;
        b=rFQn17qifWzHT2JAc5EbNAAM5gUKEO3zkypk6Ikt1di5LdTGaBOaYPKPvPYQKHCKvh
         y56kp4phrKzHPrRjNOFchg6oDbSLuucuLGnThcnPOBwnQLfmv5SxBbIdW+AOKPGHUKuS
         S4onIsh8ADY8K++Nutiq9F0MKhrqgtlkemT/9ZUBFprckKPxcrA4bHt6ooZ8qEgaDlf5
         2UcjMPB01bS74VVM4h/96TJLCBc9QyKAoAXziLm5PzWAX0AUtSx4GaKCboXToMcUu5Wh
         r8eKWkoUJt5NrPF+ndwy6gIOdtd/bF0gfwWCmSRfSus8Z4AcFv5KJlXF0mOcjQvdqavb
         19xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ctPbpBSME4Wk2MPaV81CnmhuA+m0hProI1IntXJRC/o=;
        b=S2Jw/mXQpHJAd/ozXbuNqPOPtAkDXkS1s75lFTR0QKbJJ9ERz7pQjlnk+gWw2PlKzG
         ISM4OJs7D2PmtoIrojOoPHr1EUkvIsve3d4Vm0AgWrwEG6clT3B7/AWJeqCbTl/36h+G
         mYKRWQKNy10F5DKLKqEmncQl6SuABpE9DPlZ4v/dJo7tqKlhf2mgGwa8Gq48gwguK3Np
         wYBl+8gsv8lOnllM+TaOxVnj5ZC6FRVgMAKuYWujXwmo6Rux0LKd6Zwg3Clxpz3GBoRF
         EtD9yelJky8Kk7xjarWU0TcxFtajIS8QUEdk02lvNw7pGkf3ZwtNj9JJDhM8QEkYSbKN
         1MNw==
X-Gm-Message-State: AOAM533/7hL/Bv4m+9Skxrc0e7MP8KF5BGQ5RZjg+NHkfBmqeaTBokKF
        HkgHUVtWYz+4S9V5HFNA5Q==
X-Google-Smtp-Source: ABdhPJw95OVUnYnd1Oz/CSbTSFEictKjldcOyF0a5XSptSRDTQuHsji/68y46TdnR9WhtN5yeiDMMA==
X-Received: by 2002:a65:6a01:: with SMTP id m1mr9640133pgu.201.1625390660296;
        Sun, 04 Jul 2021 02:24:20 -0700 (PDT)
Received: from localhost.localdomain ([121.35.181.130])
        by smtp.gmail.com with ESMTPSA id v13sm18136526pja.44.2021.07.04.02.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 02:24:20 -0700 (PDT)
From:   fengzheng923@gmail.com
To:     fengzheng923@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings for DMIC controller
Date:   Sun,  4 Jul 2021 05:22:51 -0400
Message-Id: <20210704092251.40734-1-fengzheng923@gmail.com>
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

