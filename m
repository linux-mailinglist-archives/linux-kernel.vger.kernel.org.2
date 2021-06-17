Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF133AB457
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhFQNMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhFQNMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:12:20 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF17C061574;
        Thu, 17 Jun 2021 06:10:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id z26so4969736pfj.5;
        Thu, 17 Jun 2021 06:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UOFgVdq99sW7T1eG1SUViNQCGmp0W3yjcis3mlNBZoU=;
        b=skyBd/9Dm0thru78YAtGmq+L1MBQ0RUmLGkFEkX1EZEbMRT/LDpNvljdVdFxpsTn3N
         FHZVRTubNZfKAO7tbCe3n0D1zA6EJyKbbpfuTVHMUC7RKW2NBMf/N0Jj7WkK3L2Hr5cy
         npad/1H5s8g8JJ8HJ5WUwDBuy9Rr25DSbjnhmRWdjEwtwLjagbLbRu/SkC6YXcyvcihz
         H9hmpaI6FoS60/ak5RirHYtQGd6m67pQT+/c8xXGCrMVcd8VlCEWrFcw4hmx/xToku2k
         H5QpPJNf0++ZFzYfZv4HihmbzG32Fs4cN3tj92SioJAg+zjT5BsEEfP0YYCBmI2zK0CS
         zarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UOFgVdq99sW7T1eG1SUViNQCGmp0W3yjcis3mlNBZoU=;
        b=f4qjx69EVhH5lEVmPZ4Hi87UpCE3cu1uEKwVs1zjBYKeD7y7xY6+gLrHabzVxwCw2k
         1cq0eLQejCAf+IPV2cCUuyDZ+SP0JsHVv0fTSV5NJwMJrdn5O9kY1zVzl73y8F5nhH4o
         7pXOWAZ71Uzr3ukmDeJV0p4JijPZ3NgwecvczbeEAbDbhR3uYBKVdWjZ+aaAisfPWIS6
         n2xDvjfNnSrI+FK/UdyrgKCKhdkyg9IpJeqtyRMFD5jlLbKpvgSClI5Q4xblGzY6A80h
         4rbKvA3y0kKbwBqAN4oCxwgkYiD8uf0asNIERmwhqM453KaHoWnGxBa5pndQ+BFlP+74
         Wf/Q==
X-Gm-Message-State: AOAM533oyzz8Xqs8b1VpulDk5ENR4Lk/6+/3/q6sz5Z/zbXhZjJPUaIu
        hrUwX6l3sHBsMpt/69R5gg==
X-Google-Smtp-Source: ABdhPJzSgU/A5ZxjBlB9fG4bdYO+g/gurotFxuMeO7UShx88LpKXdA45n8aWt8qOFxjac6QNRWmcCQ==
X-Received: by 2002:a05:6a00:1994:b029:2fe:c076:8359 with SMTP id d20-20020a056a001994b02902fec0768359mr2941921pfl.24.1623935411872;
        Thu, 17 Jun 2021 06:10:11 -0700 (PDT)
Received: from INTERNET-129.allwinnertech.com ([223.197.233.48])
        by smtp.gmail.com with ESMTPSA id a15sm5426754pfl.100.2021.06.17.06.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jun 2021 06:10:11 -0700 (PDT)
From:   Ban Tao <fengzheng923@gmail.com>
To:     fengzheng923@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings for DMIC controller
Date:   Thu, 17 Jun 2021 21:10:05 +0800
Message-Id: <20210617131005.2416-1-fengzheng923@gmail.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT binding documentation for this new ASoC driver.

Signed-off-by: Ban Tao <fengzheng923@gmail.com>
---
 .../sound/allwinner,sun50i-h6-dmic.yaml       | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
new file mode 100644
index 000000000000..d7af66775e86
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
+      #sound-dai-cells = <1>;
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

