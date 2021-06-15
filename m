Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E0D3A7EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFONJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhFONJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:09:49 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A662C061574;
        Tue, 15 Jun 2021 06:07:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id k6so1932987pfk.12;
        Tue, 15 Jun 2021 06:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6awZixPEBIc1khaAEYvB0eLqjgA3TvS8zRyCjLVg8M=;
        b=n7x038lnwlPdOc1w4l4gFub8lJPwPclJPWsYqMy1Wc8MbjD/zVwvxANPeRHHjVosGh
         0dVfYRasW68lEiiA7i0f/fdIigTDl9Nj/D3O8zZ7E6W76uH3SXj0bMB2tYcFEAA/yWPl
         1L7C6HpLQJ5Rj80ZWdANpc+nccdfD9Ai8XIxrp2+w/2rHFZ1UVbiMLeAA6oEV7QluYWl
         CziCGByCjnhSp4pNfuZ+8TLMh4AHd+JPzFXYYR7pIsNd8QxzlBhBK/K/NDuYByReGWZq
         ha21WkCl0P8csN/DrnXO4QNBXtIJpsj4C6+tQB/txwpBD3vxXnKt9xvxoBMGuPK3liu8
         YZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6awZixPEBIc1khaAEYvB0eLqjgA3TvS8zRyCjLVg8M=;
        b=WKX00KiQNYuo3DKLRqMRRhX31CHLvxeFhzI777DOIAYMLakasooc+Cun89DLPXvsxc
         rKaFXA+NCJv3Nkw/c/38BsZ/ZjiPEHWQQmNi5EuvtuokQxe68S9DgDRW/hThH00n6wf5
         gYt9eJ/Z5w01y12u0Br9MUdWeSJ2aJLseAUZOlsCCbSJqUNPZ4eNRb9XXOhcmJZMpWkT
         WuhSnk8FAtSf1cQITg7qfcJNAOv0rQ375Ot2tUWdaPkzCFbzbA4kBgPwwo4PB0KFfQ7y
         Afc9uZ9IblSUbF8iVF/xgY0GQIti8wqziZyNUzAlUyfASZYuS9KaoDWbFLGC8b6r7ki1
         wJmg==
X-Gm-Message-State: AOAM532w+/QghUSRWHZRH7PxVew58KQyOaCLrxc4GHTsmKwm884iP9ag
        6TCN/ykQDATcjFxq/tIWjA==
X-Google-Smtp-Source: ABdhPJybqEKw7feR8dYi/lWxFb3O2c8qqo8a+8pYqsq3Gq2My0PZ0nz16HwDobhs4XvfWtt4mW2bYw==
X-Received: by 2002:a05:6a00:1a41:b029:2ef:9721:879e with SMTP id h1-20020a056a001a41b02902ef9721879emr4352418pfv.74.1623762463956;
        Tue, 15 Jun 2021 06:07:43 -0700 (PDT)
Received: from INTERNET-129.allwinnertech.com ([223.197.233.48])
        by smtp.gmail.com with ESMTPSA id s4sm15218877pjn.31.2021.06.15.06.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 06:07:43 -0700 (PDT)
From:   Ban Tao <fengzheng923@gmail.com>
To:     fengzheng923@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings for DMIC controller
Date:   Tue, 15 Jun 2021 21:07:37 +0800
Message-Id: <20210615130737.2098-1-fengzheng923@gmail.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner SoCs feature an I2S controller across multiple SoC
generations.

Signed-off-by: Ban Tao <fengzheng923@gmail.com>
---
 .../sound/allwinner,sun50i-h6-dmic.yaml       | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
new file mode 100644
index 000000000000..81d40c374e44
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/allwinner,sun50i-h6-dmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner H6 DMIC Controller Device Tree Bindings
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
+      - const: apb
+      - const: dmic
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx
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
+    spdif: spdif@5095000 {
+        #sound-dai-cells = <0>;
+        compatible = "allwinner,sun50i-h6-dmic";
+        reg = <0x05095000 0x400>;
+        clocks = <&ccu CLK_BUS_DMIC>, <&ccu CLK_DMIC>;
+        clock-names = "apb", "dmic";
+        dmas = <&dma 7>;
+        dma-names = "rx";
+        resets = <&ccu RST_BUS_DMIC>;
+    };
+
+...
-- 
2.29.0

