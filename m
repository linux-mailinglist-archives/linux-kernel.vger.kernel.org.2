Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFEB411370
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhITLWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:22:41 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34158
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236664AbhITLWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:22:39 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DC7CE3F31E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632136870;
        bh=I2Bl07vONbEfi9yEVzej1wYQPepaUboDztwjIRW5t6c=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=lk5VAaJPKUVU/saksmecmXNTBzXFLxfgVm6qVmu89g6oAX8RRvj9lrKleSlBtK6MJ
         9eA2zFs4GGwxY9aLP/2QoeRe5/NlTOu29WueIl4aC2ZaztRT6RtoRwSKcKVkJPcVpX
         ZXDtwPx6FLmSCAFT1fLLocFh3wEOOzX9ipdhTeKSPcPnF+Cft46t8Q8PqK98rLemKS
         U+yeosYxnG9ADuRwSpGnG19FU0DIUNanuiRbSD6BGuw65Wtn12PalJpGaEihF9BUu6
         httj/NXiLmRokInL7m443UsV4ASMZJX6/mxvAzMpdrzqQp3fxydUrAtQLIk52R/Dyc
         N/9l1heIhilkw==
Received: by mail-wr1-f71.google.com with SMTP id r7-20020a5d6947000000b0015e0f68a63bso5811983wrw.22
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 04:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2Bl07vONbEfi9yEVzej1wYQPepaUboDztwjIRW5t6c=;
        b=7v0SW8s1j+vW7JaVy5hDpe+NxpaDKT5nTkq+E//aHc/3shdbKTMe7S/+2z42HQAN8L
         +Y785y2bpgYUMlwYDAKH0s5Z12NdFmLrqAVNIw1paSZfUid6gI5/X35wOvrCfKrHIxBP
         P2ENMfWj+cl+Qw3SnrXIOHYfJ7dM+KCVCmxmHMAKMXI6l0ovYw0B7k3tq/q01z70dRma
         X4nswfFHj35WRycAZrAHW5jxvRNTuuWipSBmhg0Sol4xXawHr3lLYvrXtB+85/bpEd7Y
         ZIL30ZumJMcmhkyGlqdZKjR0QlNvHzQnRPJ1eV0aaUon/7Ln4CLU6hSAWDeKz6BeZXck
         6JJQ==
X-Gm-Message-State: AOAM531ECYQuLWPqg8TN3w5rLDdbxyT1xk7rjohpQqYTHurx85W+zgbQ
        d13yHTH3aW5Kb3w8zN+4LjyZDQJnfJc8tEuwXs15tb5caVwEO8t1pwcNdn/ojvYJb1E0zwaj/M5
        gTqeSD0Q+xmOvwQqkOymmutJD27B6L0EBF1pgDc+l6Q==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr20697846wml.187.1632136870504;
        Mon, 20 Sep 2021 04:21:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKn0jNRJmIN+QLyVPFE4JlcLmEfhs0lY57DrjExIxaCNsxu3GXc7ms5w5ZEe76lcszwT1Ntw==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr20697831wml.187.1632136870345;
        Mon, 20 Sep 2021 04:21:10 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id u25sm17199453wmm.5.2021.09.20.04.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 04:21:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Derek Fang <derek.fang@realtek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] ASoC: dt-bindings: rt5682s: correct several errors
Date:   Mon, 20 Sep 2021 13:21:06 +0200
Message-Id: <20210920112106.140918-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct several errors in rt5682s dtschema:
1. The examples should be under "examples":
    'example' is not one of ['$id', '$schema', 'title', 'description', 'examples', ...

2. Missing type for vendor properties

3. clock-names should be an array:
    properties:clock-names:items: {'const': 'mclk'} is not of type 'array'

4. Example DTS should include headers:
    [scripts/Makefile.lib:386: Documentation/devicetree/bindings/sound/realtek,rt5682s.example.dt.yaml] Error 1

5. Node name in example DTS misses unit address and does not match DT
   convention (generic name):
    Warning (reg_format): /example-0/rt5682s:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)

6. Node address should be in size-cells:0 block in example DTS:
    Warning (reg_format): /example-0/codec@1a:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)

Fixes: 50159fdb144b ("ASoC: dt-bindings: rt5682s: add bindings for rt5682s")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/sound/realtek,rt5682s.yaml       | 47 ++++++++++++-------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
index fbf23696f1a7..7a5f1d0fd3e2 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
@@ -24,18 +24,21 @@ properties:
     description: The CODEC's interrupt output.
 
   realtek,dmic1-data-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
     enum:
       - 0 # dmic1 data is not used
       - 1 # using GPIO2 pin as dmic1 data pin
       - 2 # using GPIO5 pin as dmic1 data pin
 
   realtek,dmic1-clk-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
     enum:
       - 0 # dmic1 clk is not used
       - 1 # using GPIO1 pin as dmic1 clock pin
       - 2 # using GPIO3 pin as dmic1 clock pin
 
   realtek,jd-src:
+    $ref: /schemas/types.yaml#/definitions/uint32
     enum:
       - 0 # No JD is used
       - 1 # using JD1 as JD source
@@ -63,7 +66,7 @@ properties:
 
   clock-names:
     items:
-      const: mclk
+      - const: mclk
 
   "#clock-cells":
     const: 1
@@ -79,22 +82,30 @@ required:
   - compatible
   - reg
 
-example:
+examples:
   - |
-    rt5682s {
-        compatible = "realtek,rt5682s";
-        reg = <0x1a>;
-        interrupt-parent = <&gpio>;
-        interrupts = <TEGRA_GPIO(U, 6) IRQ_TYPE_LEVEL_HIGH>;
-        realtek,ldo1-en-gpios =
-            <&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_HIGH>;
-        realtek,dmic1-data-pin = <1>;
-        realtek,dmic1-clk-pin = <1>;
-        realtek,jd-src = <1>;
-
-        #clock-cells = <1>;
-        clock-output-names = "rt5682-dai-wclk", "rt5682-dai-bclk";
-
-        clocks = <&osc>;
-        clock-names = "mclk";
+    #include <dt-bindings/gpio/tegra-gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@1a {
+            compatible = "realtek,rt5682s";
+            reg = <0x1a>;
+            interrupt-parent = <&gpio>;
+            interrupts = <TEGRA_GPIO(U, 6) IRQ_TYPE_LEVEL_HIGH>;
+            realtek,ldo1-en-gpios =
+                <&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_HIGH>;
+            realtek,dmic1-data-pin = <1>;
+            realtek,dmic1-clk-pin = <1>;
+            realtek,jd-src = <1>;
+
+            #clock-cells = <1>;
+            clock-output-names = "rt5682-dai-wclk", "rt5682-dai-bclk";
+
+            clocks = <&osc>;
+            clock-names = "mclk";
+        };
     };
-- 
2.30.2

