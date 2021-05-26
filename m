Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6655391023
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 07:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhEZFtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 01:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhEZFta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 01:49:30 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40CEC061574;
        Tue, 25 May 2021 22:47:58 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id f22so163799pfn.0;
        Tue, 25 May 2021 22:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rD8EmGvVLCHRY6rnYywd87VdaZhsWJHUm0MbRk+LcQA=;
        b=LZbiMs6hLo48teKP4yvLOLP9TWZX9qaM47Dgqj1ID3U5usdd81ukB2cUTzYWzsiWt/
         vLRet8xkdWop/pwH9jjNldQLNa+MoXwlJOEI8PtTz222f0sHRJ7x8gwwDAgPZ1VDMX3A
         w0M2Fz0Nwm/BMVxd+CfeS0kU0/rufXKU2U1IKJGYQvSX1cCr51W9EjaGmnSIkqLLkNQj
         N53+iY3pCXnTj79gz3LgEibuWf41B+wkkM3DUgs0EbhPA2s3JrGDrveYJyLG7TAXXCoM
         5UvvsuBypFB86dI6qkmFazqQ8bsAfFUNWOiK1Y31eid3jhLVlu697w3VcuI7FBDzH3yw
         npFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rD8EmGvVLCHRY6rnYywd87VdaZhsWJHUm0MbRk+LcQA=;
        b=Ya3K0RJGGIDPLxKKQwUnnSJ2mZKpCyFCvzR81nQfN8dUPI/4nHhHpyBPDGr6slABRO
         EbR2l15KskR8vDHcokddP5sX+H1h4cUDCHJw4Y0D3MGVi4VCzOqaeHZBJBsd5GfZ58n3
         xC3f+8JSdO/2SRaC3K9kUjIZHA5Qg18eSL3hbRiXHMYuAfizBLlvo+ukUsdqAMgmMoKp
         ME8t+AicebSDgSJa5c1+3KXWJtJNu8tRE8xO7xMRk5830kaEeI05MtPDmIIidxrf/Y9s
         tWHcNHQwHNqGtGhpoKV3Vh7QSX1UoZZcG47bpaFs9eKIA7RujSl48zHoXbV5oZhr87wY
         zhcg==
X-Gm-Message-State: AOAM530s4qWwXGwsti7/4EzWRI83HGRDdBXDsYAMK+I3yaRA5AOesUFi
        ZvghfWWRVY7LTUZFPHOU1aE=
X-Google-Smtp-Source: ABdhPJzVEmTNuelfgnmrM3n+i2iD7OFjQlunrBz6pOF9FYuZqdYkSeS+AaQz+yuKneTY+u73lr0hvQ==
X-Received: by 2002:a63:6207:: with SMTP id w7mr23403927pgb.260.1622008077874;
        Tue, 25 May 2021 22:47:57 -0700 (PDT)
Received: from localhost.localdomain (1-171-3-30.dynamic-ip.hinet.net. [1.171.3.30])
        by smtp.gmail.com with ESMTPSA id l64sm16446444pgd.20.2021.05.25.22.47.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 May 2021 22:47:57 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org
Subject: [PATCH v4 1/2] regulator: rt6160: Add DT binding document for Richtek RT6160
Date:   Wed, 26 May 2021 13:47:47 +0800
Message-Id: <1622008068-13474-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add DT binding document for Richtek RT6160 voltage regulator.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
since v4
- Add Reviewed-by.

since v3
- Move all regulator related properties to the upper node.

since v2
- Move buckboost node from patternProperties to Properties.
---
 .../regulator/richtek,rt6160-regulator.yaml        | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml
new file mode 100644
index 00000000..0534b0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt6160-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT6160 BuckBoost converter
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT6160 is a high-efficiency buck-boost converter that can provide
+  up to 3A output current from 2025mV to 5200mV. And it support the wide
+  input voltage range from 2200mV to 5500mV.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT6160A/DS6160A-00.pdf
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt6160
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: A connection of the 'enable' gpio line.
+    maxItems: 1
+
+  richtek,vsel-active-low:
+    description: |
+      Used to indicate the 'vsel' pin active level. if not specified, use
+      high active level as the default.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rt6160@75 {
+        compatible = "richtek,rt6160";
+        reg = <0x75>;
+        enable-gpios = <&gpio26 2 0>;
+        regulator-name = "rt6160-buckboost";
+        regulator-min-microvolt = <2025000>;
+        regulator-max-microvolt = <5200000>;
+      };
+    };
-- 
2.7.4

