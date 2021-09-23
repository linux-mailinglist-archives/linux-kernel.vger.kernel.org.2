Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A298415858
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 08:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbhIWGnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 02:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbhIWGn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 02:43:27 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB72C061756;
        Wed, 22 Sep 2021 23:41:55 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c1so4784436pfp.10;
        Wed, 22 Sep 2021 23:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LmI4rBLW4DdQKh27fNTgEnoHIhNIx3sgFVDXLzQEW2k=;
        b=ZFMlfqOIqqW6YZSocPEesJ3DGWlex5io+ClA6dJ8rbuXBK8lA+RzYjMHTcGPgGg/vd
         HtSpyvjgaKZw3pHsLTJ+j5MsGV+4doEbxRhv75uAyLGxoXmCbhbZlqz7JGTZbvKOOBXU
         HUDNER3SmapwT2pXPe6TnjD8ctoKQWTV4cMBMnu9MoqCE0Cxu5FSxGtom0w9Ju7aODgt
         or30noGS7hyt0RVL5u3mv2wHDbWzSHPDLFX1qJKULs7ylGYIxo9yekrJqXGqtS+Y8WxI
         vSOHURCAYBuR7MNvXi94n6WUPaPtcjvlGUy6a57d+Is8EAq3W3TN+hGwmptadISz4mvv
         YNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LmI4rBLW4DdQKh27fNTgEnoHIhNIx3sgFVDXLzQEW2k=;
        b=1aD1sqnjGs13h8q/IKFSmdmj2mnZDg8C5t/g+m1jtvsE0OBAeRE56zNRUCF+4/5EEY
         6JwMlbo+KDhW9/lfhqV+Ow3QZzPhXwuqc5DkiT/g8YI1DRNnQMG6CLFAbF9Yv0XO6J9k
         evFBVTqJB3rc/f7Zc0Wb1QA/XWVoLzgLD7H30CarNEsIiZVu5wZ9iIr1c6Upea+vMlVM
         nZ1DJgmokFP7b2v/OYkdoKJi5sg2uow+uYOtCTY0nQfpo8yMiWTzcSYgtmBkTKA8dXBJ
         0RfcS3PQXWhWsFgkdDEQkZSKVB43qD1fBwv/LFDQH8W7ImTv5HCPH+oc3M0iOcA5NhNF
         bYUA==
X-Gm-Message-State: AOAM530TvIxtYijlg7LD2KQeIOSpmucJ9VTLmAG5gWQ45nQrxDSkDMm3
        1BBrrFlaxdPBumlePd1zxto=
X-Google-Smtp-Source: ABdhPJzhJnp3sOg/BVwKoKEUsLqmiSflKv8QgaEcEfJy3zlyuVqz2/MELsYr7GLltclb/3H789vetw==
X-Received: by 2002:a63:f410:: with SMTP id g16mr2707924pgi.201.1632379315275;
        Wed, 22 Sep 2021 23:41:55 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w11sm4779474pgf.5.2021.09.22.23.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 23:41:54 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: clk: sprd: Add bindings for ums512 clock controller
Date:   Thu, 23 Sep 2021 14:41:34 +0800
Message-Id: <20210923064137.60722-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210923064137.60722-1-zhang.lyra@gmail.com>
References: <20210923064137.60722-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add a new bindings to describe ums512 clock compatible strings.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../bindings/clock/sprd,ums512-clk.yaml       | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
new file mode 100644
index 000000000000..992a5c150c7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
@@ -0,0 +1,72 @@
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
+  - reg
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

