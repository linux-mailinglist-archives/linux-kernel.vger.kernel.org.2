Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30290396D5E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 08:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhFAGfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 02:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhFAGfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:35:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A011C061574;
        Mon, 31 May 2021 23:33:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y15so6668985pfl.4;
        Mon, 31 May 2021 23:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rD8EmGvVLCHRY6rnYywd87VdaZhsWJHUm0MbRk+LcQA=;
        b=Q9bMkDN0zym7toQx1eVx7k2pr0kn+SDcctMTH45q01uNqQUC/tIBLcOR8453UiWPVF
         8QkhSFOCX2s1MAl+0afYx2L2iy3hk7oMOCh7tyQnW36A+9HKes/RLJVhnqInIqrsEdZb
         mCLpEwF0RDs9fls63IRTjU5e+YZ7jWH1qsZvJmuKMslPKi/+rB0zqaUEuFYhZGXDQm6s
         BQDegzm12DzzHM3Ch7C+bguKslHk3LnIXdByZZlRKi/JMxGdtn8ksxaGr0ZAuVsVJmxF
         p8zMMOriSXpH7P+to4lIurlBpqR3yTR33ECioLZ4BgGDSvCX1EaDWgbKnoSB6gAWi/tO
         cUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rD8EmGvVLCHRY6rnYywd87VdaZhsWJHUm0MbRk+LcQA=;
        b=QBmhaxq1hhMX4py6dzejtWDaHiHF3AIq/VZ3kygH9R/QuPVbA1Z0+5eitaSeVWN/MI
         Yv+jb5Q03Fk7GRvXWZzu2lqctVJ+yBNWTGuX9hoJ/8PO+TyboLnnvmaARLwBUSHq9YXa
         J8FBuEUhT23bOs70u+muHBNDtyOWa+8gRCvzcumcSm8wHoCwMUgRQi/0nch2u5oJGESb
         qW/pg/vIvKf9r32ZpJxE3CMIe9HYadwK61lNixxg7PGbiWzdnuWQt5khuz490UBHrbJ1
         MShvmIdImAzZJbTPyqhwHzopdGc2yt3V123qpjCh7a/PF/n1RM2KDcQ9QJpih/PEVeNt
         9exA==
X-Gm-Message-State: AOAM5303UeQj1+2W5xoEuriT/9H1nW5WOsLFPMoX3r83LODlFy3RvLZO
        WEu3fR7ouFe3iA7/2wS3ikc=
X-Google-Smtp-Source: ABdhPJw3sCPrYiqaonigcopaVcbE7RK0SisDPproosl/KP6/N9tBlXvnPomsEkSjaP1hhodqEIvk2A==
X-Received: by 2002:a05:6a00:2b5:b029:2ea:a29:a117 with SMTP id q21-20020a056a0002b5b02902ea0a29a117mr306718pfs.35.1622529205239;
        Mon, 31 May 2021 23:33:25 -0700 (PDT)
Received: from localhost.localdomain (1-171-14-152.dynamic-ip.hinet.net. [1.171.14.152])
        by smtp.gmail.com with ESMTPSA id x22sm4982747pfn.10.2021.05.31.23.33.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 May 2021 23:33:24 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 1/2] regulator: rt6160: Add DT binding document for Richtek RT6160
Date:   Tue,  1 Jun 2021 14:32:46 +0800
Message-Id: <1622529167-25852-1-git-send-email-u0084500@gmail.com>
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

