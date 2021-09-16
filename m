Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753AC40D4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbhIPItL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbhIPIs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:48:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704C2C061764;
        Thu, 16 Sep 2021 01:47:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so4201131pjb.5;
        Thu, 16 Sep 2021 01:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ewd86Tu7EYKc0s4JDCu4AHTKnB7FCyLBN6liGbMRRRY=;
        b=kTQDl8JiTjUq1DXGc9QO+m2hAEexZgAN+nAf5DGiAU5IXxkQVVw3wb1uiqYCnjBKAx
         ml50e/SZmhj2fveam046PdjBCxJA4BqFetKcPGF1uHswcMXaBkXy7CiusxIcEnvfhFAl
         71mfgGau8rhpooV/gyC6ieS8BpHvcMqoqApnDNY8A4I7wPs1SA3Ga0hZXcUiWE1Fq+Wk
         ZFGeKFxlUf7Hrfmy7/DoMmIaDGtruiAuufdJoXaClfRQPCCBvnz8c0HDsH6vfOF+mx5H
         lFdkRGHIZZdxh/lZKnfJE6mGwJW9cAE58T3/mgc28wIIn4Gg7dsWgrcK7GLxdCmLjYcs
         H8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ewd86Tu7EYKc0s4JDCu4AHTKnB7FCyLBN6liGbMRRRY=;
        b=3sX0NQObDYvMfX0onx1c7QYJGPt6tBaiifeern0WovIxW+aU0zsoHSkUEPYwgOQFE2
         oL3rKqS6uU5S4+BBN4IBfRIor3Ler6a7Y7YPU/EJN8kGXDLb4dQHqa28pk2w3HD8EyEF
         wNkBTwH/gLl2pGHxhP8XJhay/+8pXk345AAsA/7YQl13FpKPbF0Vc/qO+o+lzy5Bo+HS
         RuW2MgQ2Ifenzu5ALffbTYJ1qFj+unWESqjkL0NBfuKwL9DWmrtUGLofyU25v6GpfUVE
         pSHWr3orQH7YQb//jRKVln6utgKCI/HXUv3HiNLtSZZexPgoj5RRnxsRlyefdA734dvX
         VcSg==
X-Gm-Message-State: AOAM53309ui4iLsd/kh7303Y06ybW1KFFx4xUmaACY50W+AHwWoBNJv6
        W27oY/sxsdV2HZRmCwIILw0AA3veQ7C3ig==
X-Google-Smtp-Source: ABdhPJw2P2wtGcP29ptiuHF4X1AdUvCRiggVfgFEYUrvcZeIRwUbbNr2MSkPlPOeyizBF8buDNfeew==
X-Received: by 2002:a17:90a:a791:: with SMTP id f17mr4751343pjq.225.1631782059002;
        Thu, 16 Sep 2021 01:47:39 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l12sm2187621pff.182.2021.09.16.01.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:47:38 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] dt-bindings: clk: sprd: Add bindings for ums512 clock controller
Date:   Thu, 16 Sep 2021 16:47:12 +0800
Message-Id: <20210916084714.311048-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916084714.311048-1-zhang.lyra@gmail.com>
References: <20210916084714.311048-1-zhang.lyra@gmail.com>
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
index 000000000000..be3c37180279
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
+        - sprd,ums512-ap-clk
+        - sprd,ums512-aonapb-clk
+        - sprd,ums512-mm-clk
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
+      apahb_gate: clock-controller@0 {
+        compatible = "sprd,ums512-apahb-gate";
+        reg = <0x0 0x2000>;
+        #clock-cells = <1>;
+      };
+    };
+...
-- 
2.25.1

