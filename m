Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2158B4103B3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 06:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbhIREw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 00:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbhIREw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 00:52:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47D5C061574;
        Fri, 17 Sep 2021 21:51:33 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id bb10so7521331plb.2;
        Fri, 17 Sep 2021 21:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7WOJy5i/LN3pBi3ceQMRfn87CAJ6e8JSN4AxagrrAzs=;
        b=S3fuaQoSCVMLmW94+d8kty8cArFx+axMDU+uxiMfDQhjuZrbaTBUHfnHUG/PpTgoU0
         cCu76ruuFRDlYDg/LBv+17asXj2mZie1clIY/RhV03RmFYGCRR9LUT2oFjig2O5BKf9h
         FN9L/kPj0isq8W/CqCBRyFTamCFUwpUao4ffBuisQWS16r+39hgFPLY7Qkl3XQIM6tDq
         4qAJ/LgBkLtIIZZQUg3s7JxvqvzZjxTG5u866QG40q0TNTKGwcbWnJeNtl6s8tk+AELq
         q8Y0R3tK8GmfxdmqSB3iYiYTwEKTLGj3v4BX5bZYRKCxnYDiTElhFKxQyLWDcsZpdtBt
         yXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7WOJy5i/LN3pBi3ceQMRfn87CAJ6e8JSN4AxagrrAzs=;
        b=p8hufbSQ57RmOZ1v9dYCGL70ucUNzcfsZEW56ukN8lYnnXdN/lXPm/8nBaT3MEasrg
         xyC1Zs3XDvngR+NOFAhXRocO9K1Sr+SUfNi1G7DSNF3TM7FMxyGpMvksEel+9BuVQcau
         76eyDPUuzhSUOyY6sFz/b9xZyI6vK+5tfBDZ2nRTSoMVg20QEd72rtcn1VxNwdOFHjWC
         4o2A9KJQbxs2dSDgkoD6hEPtCjI0fxx4s4Rn6P5F77nljIeFNkE0XlPq9JZmESEI7T5v
         oIKAdrwLP4k7ooVBGARa7GcazlPQTeb9V7uY9y4Gggit1URgcVtdFHnqNer2fzsOCkc6
         oPrw==
X-Gm-Message-State: AOAM533M8k3Dq+iLu4iOVhx6CTo8BnVi2Bqd73xXp11BZ00ccSkJ39E6
        25P8vymqn/bcmsT0ddbpnUw=
X-Google-Smtp-Source: ABdhPJztibIaGgdqxQrgAf5xYaeMu98BIyLd4cKwiFVB7ltlbD2dj9R/nMwMYpnwLbD1i5LA53sHgA==
X-Received: by 2002:a17:903:4094:b0:13c:86b0:3050 with SMTP id z20-20020a170903409400b0013c86b03050mr12693337plc.58.1631940693288;
        Fri, 17 Sep 2021 21:51:33 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id p5sm7663101pfp.218.2021.09.17.21.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 21:51:33 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: clk: sprd: Add bindings for ums512 clock controller
Date:   Sat, 18 Sep 2021 12:51:11 +0800
Message-Id: <20210918045114.387005-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210918045114.387005-1-zhang.lyra@gmail.com>
References: <20210918045114.387005-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add a new bindings to describe ums512 clock compatible strings.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../bindings/clock/sprd,ums512-clk.yaml       | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
new file mode 100644
index 000000000000..4431767c84bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
@@ -0,0 +1,88 @@
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
+...
-- 
2.25.1

