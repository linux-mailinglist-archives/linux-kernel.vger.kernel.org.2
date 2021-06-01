Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671073975A2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhFAOlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhFAOlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:41:04 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8335C061574;
        Tue,  1 Jun 2021 07:39:20 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 27so10872285pgy.3;
        Tue, 01 Jun 2021 07:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rD8EmGvVLCHRY6rnYywd87VdaZhsWJHUm0MbRk+LcQA=;
        b=sbS/w27JwUEYH9autQLyFq3xs0z/G6exRcX0CsZtWk5VjmB1CH/joRwd+mGPzrzEAP
         Xy3RZUkFb9Ml6YdZbySUIVZyg78vNSSdye6WwEqgWgouDrrDcm+Pur0K05yGQ6hwSQFr
         MndAMfi1YeB3/ByEYcH06Cjowzbnd6iHkcfoFY8pbYMzeXriAD6u0D4VjCYmt87ZsUp/
         tiMEByyv47mLqYSCV30DLIkDeG/omQlYetiD/eerZAEa5EFRxsqRzH5AMPdJ+Cbqf3IS
         +ZgqxWbdRpgSMfUr/IvaTYqqdxEuuKMcActZ/bj/ADJZEqbKVcwdUUeEFQRyQ5JPih6C
         pxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rD8EmGvVLCHRY6rnYywd87VdaZhsWJHUm0MbRk+LcQA=;
        b=fMKWkXaR+KE6LqmtljM4rLS6zm4kQ85BBE2AnnWZF4FBUf8sl4kPbA7e2EvTfI/Lf/
         ujYRnqCknL0aDXITUHF6qw9oguK5wk8/rPRqoiDJqMrZeg5ytka5S8OcwIXvsOQF2uQb
         tgO/f1pfQwq/oDrc3IJe7AaqEtn9FSueeps18fI/RS2TSSfpICeob+Aovnl3t4INviEy
         ZYBvZK5/TIGNWyUY62YHD+B5oxrHCMMlCrEvuNfB/n7sWCR5BDjVb3eOIyPnI2ERittB
         WwuGJ5PvPEbdp5rIWU6t/o9iaUIChzirMvLj3CiCLC4u6n6QQgtQM1ZPo/uwRSUT5qTm
         Rx1g==
X-Gm-Message-State: AOAM530UVey6Jj53ggzSjYsawMG8WnxMTXzSWtvC1r6/c8URfVDBF1d8
        67oTZmUBJ5gr+lbUhrz7TyBxFhlhiVg=
X-Google-Smtp-Source: ABdhPJxIQVex1Q4YptuvERaDUI4EcdABE4sQGGtFtZEm1+OFfuqfFbgEgAVn76KgJZ1mkcNp6AeQ5A==
X-Received: by 2002:a63:da46:: with SMTP id l6mr5558694pgj.436.1622558360126;
        Tue, 01 Jun 2021 07:39:20 -0700 (PDT)
Received: from localhost.localdomain (1-171-14-152.dynamic-ip.hinet.net. [1.171.14.152])
        by smtp.gmail.com with ESMTPSA id q4sm7309693pgg.0.2021.06.01.07.39.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 07:39:19 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 1/2] regulator: rt6160: Add DT binding document for Richtek RT6160
Date:   Tue,  1 Jun 2021 22:39:11 +0800
Message-Id: <1622558352-19750-1-git-send-email-u0084500@gmail.com>
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

