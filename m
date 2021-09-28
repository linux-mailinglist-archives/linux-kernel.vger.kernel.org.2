Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB641A9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbhI1HjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239430AbhI1HiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:38:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE237C061575;
        Tue, 28 Sep 2021 00:36:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id y186so8922849pgd.0;
        Tue, 28 Sep 2021 00:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7g81QSa3D0tQhjk66OrM7GF1xlv+mziAOE2qaES6bso=;
        b=VQscXdAtntegGriESQFLxM/Nv7HywqfLpHNB3kmTWSPvCz9ZJ9pxtxOrhM7mR57E0U
         TVgDFyT5V/eU0ZmfAq08YpBddJA3Yya0lp/ffbrtY0v0BMvwJGBqz9MUaiFf/Rm3Tvop
         Dzo7pLXVTnCgzd0IMqls9EXmbfiiSSht7Eb/53tQMbPZh8DpIjuO+ReStml06DEzw0Ji
         A6sb+EFdAQzodYh9IrM+ndXmeebxMPUCBqkCWkPzskJWTwSRGEb1AM4R0q9K+quHy1Rv
         dAlxsGEu95AlH7YbJHesohULmdswwBOCcD6jmfxatGs9y7mvwi2a5JbXLHFK10FkdzHv
         +m2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7g81QSa3D0tQhjk66OrM7GF1xlv+mziAOE2qaES6bso=;
        b=cnRgGBbS7BIf4O3lVICtSCFg8kr33EiApUl2kuEx8yKhPw+CmPA/zHZFMnGj+CmqiC
         NBIs4pKDxzoUdFIYqmWFPyYKkMQ5SbPKMo3LoWGuwLbHfmw8BMsTymfd5PbBWIcfbvmB
         N3Rw/6Evv//LG/IjuRaWhjelpB8CfMB2SOI9JzCNpGiAleoTwyEfn/EretKSbD1Uk26c
         5NhMOcfsfn9UT3DuZdKIBdP9+UgdJrbPz18kJxcj4d2v3rhV7tAWi+YmNlKVw0EYXcUZ
         eJdFIxOxtJOr7LqlzK9VeKO0ReNeq4axl31MHhZ3uNK6YU/kvpcZldekEi3t7Xyqt3N6
         xOZQ==
X-Gm-Message-State: AOAM5325NCIgsTdj4WJL/A0c20WYqWfOVw/A7Unjg1+McQxvPz2MBLEg
        uDXi14EVgH5lGp0BYY1A2pk=
X-Google-Smtp-Source: ABdhPJxMtPiJKKl69XzLNr/ROT1gsopZAzW+QjMcfGcl6/H/yUDHPnALa2BwNpl3YaqzoMq0Cv78+A==
X-Received: by 2002:a65:6389:: with SMTP id h9mr3364653pgv.83.1632814592274;
        Tue, 28 Sep 2021 00:36:32 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g3sm1495757pjm.22.2021.09.28.00.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 00:36:31 -0700 (PDT)
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
Date:   Tue, 28 Sep 2021 15:36:09 +0800
Message-Id: <20210928073609.198975-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210928073609.198975-1-zhang.lyra@gmail.com>
References: <20210928073609.198975-1-zhang.lyra@gmail.com>
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
index 000000000000..04e504418e35
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
+  "^(dcdc|buck|ldo)_.+":
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
+        dcdc_cpu {
+          regulator-name = "vddcpu";
+          regulator-min-microvolt = <200000>;
+          regulator-max-microvolt = <1596875>;
+          regulator-ramp-delay = <25000>;
+          regulator-always-on;
+        };
+
+        ldo_vddwcn {
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

