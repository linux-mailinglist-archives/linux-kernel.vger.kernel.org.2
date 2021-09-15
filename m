Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C6D40C268
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbhIOJLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhIOJLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:11:22 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBF8C061574;
        Wed, 15 Sep 2021 02:10:04 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s11so2037489pgr.11;
        Wed, 15 Sep 2021 02:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tXiY4oUE6y/D3jNqbB7LZ6RtNWi0+dj+GmUj1LoLdtc=;
        b=TJtqZ7w6XRvxtAW2EHVJ+4/Hav8w1IwyD33rx0TewNnaiapybXnt9DdjU7f88Eciz6
         WSXPIbrZfwFaXGuaiLjQ6CR7FALdYN+4w2fNYAgaAue3+MsRZGPbWo4c62acGiCPzBq2
         d3LLOzYvdTMKGFMq9PLzt7gZSg6gYhHR+SmvkNWnIcIDt9GaNyyzpc//2Kqxv7ol5rVk
         kQkRlAprm+HqsFJp0Ck3IOSxwRGd7LhWFtoyJNLglyePA6xL0/GImKDE8h4Fm7R0IXeh
         /fFmcgS5HFOFRB9aQXUOtfBuXuLMn+qifzhaJXqlwWc9TiK30/V9lU1HG0RY4qYSEvdP
         rr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tXiY4oUE6y/D3jNqbB7LZ6RtNWi0+dj+GmUj1LoLdtc=;
        b=ddc51YtZQg1MT49+mLzFlnR/QQU7LDm7GGcCWYKnX87oGRbwh97QM3IkL8bKELEltl
         mhETIlvKmyvIflWAzF/Z2oHnC6B091tfXLCGVcJI0fAaq6vDv+Zn9FLzo4AirC34yInq
         jM8C/YfhJUTokACuQ4OSWwBI8nezg+xVvIdKbfPimZredJ2sBvDRGM/asH44uw0wha3j
         /XNUoEOH6bJ1PtYn7r/GaFtlRyOwwMmLQklMKowJ2oCbRuLJC/e2GTOWHW1XUb+p2wAR
         bGEjtgyOkz4ZRnuwpwCI0udgf6/hHxlhLXO3rZ3CltaXG7fjV1keWqBtxtVvdnPllMqS
         SNxg==
X-Gm-Message-State: AOAM533NS/c0INmBIM/JJuogwhmTBSmtvvenxPqc7uOC0o6RxXNZNIlA
        h/xij8Y+0cKCgtgWRzmYDg0=
X-Google-Smtp-Source: ABdhPJy0x1E1+xoEGSGgXFbrFIE4Y+hVmjKAMPOnXw8UkzdsuAHTEujkaspygCap75x2qQuhLYLj4Q==
X-Received: by 2002:a63:374e:: with SMTP id g14mr19484205pgn.170.1631697003795;
        Wed, 15 Sep 2021 02:10:03 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j6sm13597080pgh.17.2021.09.15.02.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 02:10:03 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: clk: sprd: Add bindings for ums512 clock controller
Date:   Wed, 15 Sep 2021 17:09:43 +0800
Message-Id: <20210915090945.250621-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add a new bindings to describe ums512 clock compatible strings.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../bindings/clock/sprd,ums512-clk.yaml       | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
new file mode 100644
index 000000000000..7e51b49b931c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2019-2021 Unisoc Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: UMS512 Clock Control Unit Device Tree Bindings
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  "#clock-cells":
+    const: 1
+
+  compatible:
+    enum:
+      - sprd,ums512-apahb-gate
+      - sprd,ums512-ap-clk
+      - sprd,ums512-aonapb-clk
+      - sprd,ums512-pmu-gate
+      - sprd,ums512-g0-pll
+      - sprd,ums512-g2-pll
+      - sprd,ums512-g3-pll
+      - sprd,ums512-gc-pll
+      - sprd,ums512-aon-gate
+      - sprd,ums512-audcpapb-gate
+      - sprd,ums512-audcpahb-gate
+      - sprd,ums512-gpu-clk
+      - sprd,ums512-mm-clk
+      - sprd,ums512-mm-gate-clk
+      - sprd,ums512-apapb-gate
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+    description: |
+      The input parent clock(s) phandle for this clock, only list fixed
+      clocks which are declared in devicetree.
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+    items:
+      - const: ext-26m
+      - const: ext-32k
+      - const: ext-4m
+      - const: rco-100m
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#clock-cells'
+
+if:
+  properties:
+    compatible:
+      enum:
+      - sprd,ums512-ap-clk
+      - sprd,ums512-aonapb-clk
+      - sprd,ums512-mm-clk
+then:
+  required:
+    - reg
+
+else:
+  description: |
+    Other UMS512 clock nodes should be the child of a syscon node in
+    which compatible string should be:
+            "sprd,ums512-glbregs", "syscon", "simple-mfd"
+
+    The 'reg' property for the clock node is also required if there is a sub
+    range of registers for the clocks.
+
+additionalProperties: false
+
+examples:
+  - |
+    ap_clk: clock-controller@20200000 {
+      compatible = "sprd,ums512-ap-clk";
+      reg = <0x20200000 0x1000>;
+      clocks = <&ext_26m>;
+      clock-names = "ext-26m";
+      #clock-cells = <1>;
+    };
+
+  - |
+    ap_apb_regs: syscon@71000000 {
+      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
+      reg = <0x71000000 0x3000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges = <0 0x71000000 0x3000>;
+
+      apahb_gate: apahb-gate@0 {
+        compatible = "sprd,ums512-apahb-gate";
+        reg = <0x0 0x2000>;
+        #clock-cells = <1>;
+      };
+    };
+...
-- 
2.25.1

