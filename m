Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447EC41AAE9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbhI1IsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239563AbhI1IsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:48:05 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A69FC061575;
        Tue, 28 Sep 2021 01:46:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y8so18322365pfa.7;
        Tue, 28 Sep 2021 01:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KCrtZ+TidfNSoChItBdVF5KQYxEipped+12uAWz/GJE=;
        b=N36Vn1uz9KJYZ2uc6LFCalXm4eewh2Oi6Jq/00b891L7fOqH0VfRh2zyadzezpjwbQ
         +DPNTGX+VwNP0mhFu3PZu5U1tWXqAYYIHvwYplVIGRnXpJpcaRmIRpmpC8BZaUM0btgO
         TGbODRJX4in/KxZiiuHmRgOxCO0fX4jCzQ3hZXxcdkcH9ri51kIYZ1pIqvxaGBbs4fz3
         hiUojRbFCmuG/Q6JN01sgZ16dvYAgt2NFxaPUVOWdL2wzU5PmLV6QEp5CX3eszBe3Gjx
         DR8u9ZIIkJzsKZNTkszYZ+hzCJthzR5rGevPwGWp0XnpVjJg9K85FWUaUvztoWEMGXSC
         3uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KCrtZ+TidfNSoChItBdVF5KQYxEipped+12uAWz/GJE=;
        b=tTpq7YBmaYagXVn4oY4Byxl/eow8ZmCAGaSJTi/nC/0/ISK9y0L3FywEHHA72AnCmY
         rZRvi3EqXXSJShADCPcCgY9ht+u4wJGM7fXtAWrq8s7mwDxLVxbZDxv4sRpYSLTQtRuT
         IfVXJr1eSqaqCYVDhMIiJUKS6iQQt8MRBMI1YB+ghEWjCgjao9Qi8ANcJAel7fH07SG7
         OH4n+0lX53Y8p2fwqiQh+LpDVDdtVbt84syaxhvOe/XkMzv0Now9cmnSN7kQdmF8ESce
         255CujeinBJXhHd6AYlvNF/rE3NeKagAa6nDZOomEBMaK7NCt4xyh8BfBqrLXHoMsh1A
         2fnw==
X-Gm-Message-State: AOAM531qiaHJ9zJ0GAolQEDMp3ODJnZNANQ9M7vAEfileetyDjfnL4NX
        xdXRo6CO+8hDaxOug9zXm0U=
X-Google-Smtp-Source: ABdhPJy6zQLw8giNM+YYOoWFe5VeHVvvm2VmCrvx/72m3qAQ+kGbL4DRR2MAx0Dbodnd7XirniQdcQ==
X-Received: by 2002:aa7:989e:0:b0:44b:2d81:8510 with SMTP id r30-20020aa7989e000000b0044b2d818510mr4447741pfl.55.1632818785895;
        Tue, 28 Sep 2021 01:46:25 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e5sm19930820pfj.181.2021.09.28.01.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 01:46:25 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] dt-bindings: regulator: Add bindings for Unisoc's SC2730 regulator
Date:   Tue, 28 Sep 2021 16:46:07 +0800
Message-Id: <20210928084607.220457-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210928073609.198975-2-zhang.lyra@gmail.com>
References: <20210928073609.198975-2-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

SC2730 is used on Unisoc's UMS512 SoC, it integrates low-voltage and low
quiescent current DCDC/LDO.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../regulator/sprd,sc2730-regulator.yaml      | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/sprd,sc2730-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/sprd,sc2730-regulator.yaml b/Documentation/devicetree/bindings/regulator/sprd,sc2730-regulator.yaml
new file mode 100644
index 000000000000..6d1bec03eb52
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/sprd,sc2730-regulator.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2019-2021 Unisoc Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/regulator/sprd,sc2730-regulator.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Unisoc SC2730 Voltage Regulators Device Tree Bindings
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    const: sprd,sc2730-regulator
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^(DCDC|BUCK|LDO)_.+":
+    # Child node
+    type: object
+    description: dcdc/buck/ldo regulator nodes(s).
+    $ref: "regulator.yaml#"
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      regulators@1800 {
+        compatible = "sprd,sc2730-regulator";
+        reg = <0x1800>;
+
+        DCDC_CPU {
+          regulator-name = "vddcpu";
+          regulator-min-microvolt = <200000>;
+          regulator-max-microvolt = <1596875>;
+          regulator-ramp-delay = <25000>;
+          regulator-always-on;
+        };
+
+        LDO_VDDWCN {
+          regulator-name = "vddwcn";
+          regulator-min-microvolt = <900000>;
+          regulator-max-microvolt = <1845000>;
+          regulator-ramp-delay = <25000>;
+        };
+      };
+    };
+...
-- 
2.25.1

