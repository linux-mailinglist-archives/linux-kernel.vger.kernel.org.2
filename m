Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9383B400B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhFYJKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhFYJKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:10:20 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6FFC061574;
        Fri, 25 Jun 2021 02:08:00 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id u190so7066910pgd.8;
        Fri, 25 Jun 2021 02:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DgY/uA2fSmwxzscKqJL9b58zNu3n2nv6yZ9uNShIrNs=;
        b=gUKyO9dV8cptaXVWZlyd0CU3fRLnVW+pv0gJgJTU79nzWpC8B1BZLpwxryEwKqcuGu
         nP4vXT9rNO0wQAZYK7rCQlHMh/IDIhkl1qXpxWbWJrjSAoDHkyTu2W+/Z4Vwq/EHIEaq
         Z/sN9hmHln4OotyxLYgMpqgqKacEuKtXMAX2W0G1nkuHnilw1vTCh7Z6JaFYX2JMYse0
         lSlzFP6H6jUb9dmhygX9+UBL68YK6DDCZ+l5oz8dOIrEI2ToR6hr0jl8VgBwyJ4+FiVt
         iPzHYawZNyyUm/X1AocoCUhvX0PfBHXezBMs7reZtKQEJBR92O4YR/hvUtnrjSISCrk9
         5Ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DgY/uA2fSmwxzscKqJL9b58zNu3n2nv6yZ9uNShIrNs=;
        b=RsKLmRFd/UtLLnVbSpz3w3jQOwSc2QJIGtHiOhhnR5tb7AVazy196PLv4HpYNl309A
         sVcGckzIcRE9cnZkLIAEoL+K4PGvHpJH78UUbWr45L1wQCmivRNiE5z2yTFBLU399462
         L1vgiA6P7z5MmNDj8VV0q+yq23U5PVadPz31pC9+Uz0uRjaqNW+oVAo5naRcSsmijghg
         xBjwvuKdZrUe3WxdrGXLKzlmWy9Xp4DDe0vVDyYZYY8BVlQZbhdW03UwPjbCY4X9Wc+v
         QWv9ywyFv+9vv361qKZxxdD9poudkmtQnzMRf/QS8/RDjjL/2gyfs8BkNNgf9YkGMOhr
         umSA==
X-Gm-Message-State: AOAM530azvzJXTmD392LXOAHaYnSFE8QpOaWzCz3F6c6RtYqN83CGmV2
        OqH10qj4zgrp4eL6lCORXA==
X-Google-Smtp-Source: ABdhPJxYeAIkRsA7qJaQpgBPopWQ6ZDT4WqnjdXVrD19KKTC7j3DhKE1WfmeaZp+sLUSj1CPkDsXEw==
X-Received: by 2002:a63:e04c:: with SMTP id n12mr8705624pgj.239.1624612079925;
        Fri, 25 Jun 2021 02:07:59 -0700 (PDT)
Received: from localhost.localdomain ([61.144.175.119])
        by smtp.gmail.com with ESMTPSA id m4sm10279142pjv.41.2021.06.25.02.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 02:07:59 -0700 (PDT)
From:   fengzheng923@gmail.com
To:     fengzheng923@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings for DMIC controller
Date:   Fri, 25 Jun 2021 05:07:21 -0400
Message-Id: <20210625090721.6183-1-fengzheng923@gmail.com>
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
2.17.1

