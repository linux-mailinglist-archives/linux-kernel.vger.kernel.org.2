Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CF93AC316
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhFRGJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhFRGJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:09:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01A0C061574;
        Thu, 17 Jun 2021 23:06:51 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v13so4127369ple.9;
        Thu, 17 Jun 2021 23:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5hfOEVHeqp/F96H8QwGZO/5tf7mEcB8EA6gsOtfXfaM=;
        b=TFUr3dRc/3aZWb+Uxh1AmlwZHsequWgjNcy04MyvFn9uFODpQSc88GQ4NbXI8iLZmX
         Tu5HHxielGH7Bsy2ZC8N6moC9jvmHg5jiI57fvH3UD50LLXkzl7mGsYB9kiiCUd7DYx9
         fTrB1gaQk8IpTXBeqvtzpVzUdweSMAvFgf0hfwWL4TDW5H7iGwh3CKu8owFUQ6ybK5TK
         azFdyV92GTJRpEqztceeVWq3xrCPvmtt+1ru4C7APYgrQFN2YA1WfVnkP1luZC7AGwiP
         9P9jeKrDQbmoVtF7kQkVshfP+OgBj2BqYWDXSHO7+0+3SFwtKQsCcW8RMmSXmtxpo7Yf
         cw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5hfOEVHeqp/F96H8QwGZO/5tf7mEcB8EA6gsOtfXfaM=;
        b=tGeAYg4cxvwJyJ+DCx6HA6h3IznygvhF9NbJfJL03iZodrJJauPBLU2FapBiPHYKg2
         0zEJlT9V7OxsxR4UAMRFH7qo6S+6Y5GEXG58rozHFG9Lqb0Y8CS2p1vsz9KzCzA7lAJ4
         SYIVvbkRNLjoU7ypEzr1dla4fe0bwsdGGfqvFEzGqI16Dn9sRCxWTs/OIPU+jvm4cbT0
         +UwyJq5hQLRUVSeStHaRJh3gf1YR1LIeaniKQX/JHPtwbzeetEsOB14yqF0QEVI/DJuK
         TrMtojhw/lEy7GqmZdgGaueWgH7QLG8/nhehKYU2F4paDFskiVA/42Ab8ofhLUp5WTYc
         OElg==
X-Gm-Message-State: AOAM533hqtwwTwhFdKEbZ/i62DrI+FJJRa+TTxLQ+QC+0O0msO41zBU3
        LAqSzk9rC8nRqCzZN3WkaPJ3apLUaaf5
X-Google-Smtp-Source: ABdhPJxo2Rn9xs4aEtaHUWG7j/ziHyoqCT2P1sDRe2eiMH7wVHihb3upu70yewa+CiB10lnog1D02g==
X-Received: by 2002:a17:90b:4f81:: with SMTP id qe1mr9355789pjb.9.1623996411207;
        Thu, 17 Jun 2021 23:06:51 -0700 (PDT)
Received: from INTERNET-129.allwinnertech.com ([223.197.233.48])
        by smtp.gmail.com with ESMTPSA id l201sm6975082pfd.183.2021.06.17.23.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jun 2021 23:06:50 -0700 (PDT)
From:   Ban Tao <fengzheng923@gmail.com>
To:     fengzheng923@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings for DMIC controller
Date:   Fri, 18 Jun 2021 14:06:44 +0800
Message-Id: <20210618060644.2830-1-fengzheng923@gmail.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT binding documentation for this new ASoC driver.

Signed-off-by: Ban Tao <fengzheng923@gmail.com>

---
v1->v2:
1.Fix some build errors.
---
v2->v3:
1.Fix some build errors.
---
 .../sound/allwinner,sun50i-h6-dmic.yaml       | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
new file mode 100644
index 000000000000..d9107685b78d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
@@ -0,0 +1,68 @@
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
+    dmic: dmic@5095000 {
+      #sound-dai-cells = <0>;
+      compatible = "allwinner,sun50i-h6-dmic";
+      reg = <0x05095000 0x400>;
+      clocks = <&ccu 101>, <&ccu 100>;
+      clock-names = "bus", "mod";
+      dmas = <&dma 7>;
+      dma-names = "rx";
+      resets = <&ccu 42>;
+    };
+
+...
-- 
2.29.0

