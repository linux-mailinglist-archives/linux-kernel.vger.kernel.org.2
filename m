Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABBC4262D9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 05:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbhJHDWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 23:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbhJHDWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 23:22:15 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6D6C061570;
        Thu,  7 Oct 2021 20:20:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l6so5226101plh.9;
        Thu, 07 Oct 2021 20:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNTFuoOTdTSriuFlhN2E9CYCWTvD0eqA/1pjGS9porc=;
        b=mrJ0ulCn1T90TLE6C099uJQOb9Z1VTAStcnbSzZMwyp9XoLeHMZQrB4kjyeIAobUN1
         VC99hdl3aJcKwYu7Zc//mqL5tjZR52Hbn1aCn69SVXeSNweaKdwL7tmC1hPMyMNQRaCP
         kcTKt9dyQ4f8CexVwG9t8wsHj9AvZHT/NxLDznRnKhJM3aIkg1Gg520P9tCe+HN7MNgd
         5IyFxnMC+L8N2ym34nRwy5kpyESzJSNurRVwFwQvl9nXlC1oJRX7GlQ8cYer9rqY2irr
         ex9WLmGskEzrZ4M22yGLyZ633wHnD2ZNj1/j2onEyCtOKurUQzgjxZe57vEtL5uq4mNI
         Z3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNTFuoOTdTSriuFlhN2E9CYCWTvD0eqA/1pjGS9porc=;
        b=PZG83gd4Xkkdzn5gzWQEdmO+hpHS3i8/J6nOPRnFjOZZ3WHWgw4D0JTm4vutEe3VjI
         rKL2iUuwoTy5AllUY0vIu318/54yA1LkuMus6l7ZqhiG9JrTh+2QYHM/owabp6Kzq1l5
         QtlujLmpc+8fFW0ekjG2SjmwV8y999Wohwf5KrErNkUUAQeKUvyt/sEhUg4v8AXBe2sJ
         4sR+8I2SX94A6zXym+vEQ52JVlXPFwgQodxrlchuV26oasEpAQM9ruk6HCGyAPw9OBIw
         uhINnmqznRwQ+3OI32mvQMChW1EO3ixjB4K9xHcp+Da7i9WKli5VRXZqIOWWtWFFoLOf
         ocsQ==
X-Gm-Message-State: AOAM531jHbOFHqoW0HNx+2JqoV/W+dasmjFjnUSPnJBjtCXcpfZGcS0s
        ym1ph5cRdyNBoVfxh9jcn10=
X-Google-Smtp-Source: ABdhPJzzctrr+0nAVGBgbgXWxWxftvSElXLxR2E8XtZjfXZoLWUMLO1OU12olUur085zUGpE94TO2Q==
X-Received: by 2002:a17:90a:c982:: with SMTP id w2mr8901415pjt.30.1633663220359;
        Thu, 07 Oct 2021 20:20:20 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j198sm713943pgc.4.2021.10.07.20.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 20:20:20 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: regulator: Add bindings for Unisoc's SC2730 regulator
Date:   Fri,  8 Oct 2021 11:19:53 +0800
Message-Id: <20211008031953.339461-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008031953.339461-1-zhang.lyra@gmail.com>
References: <20211008031953.339461-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

SC2730 is used on Unisoc's UMS512 SoC, it integrates low-voltage and low
quiescent current DCDC/LDO.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

