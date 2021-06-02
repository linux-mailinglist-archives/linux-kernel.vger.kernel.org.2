Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E12F3980AD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 07:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhFBFdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 01:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhFBFdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 01:33:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070E0C061574;
        Tue,  1 Jun 2021 22:31:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mq2-20020a17090b3802b0290162428291f5so1045290pjb.4;
        Tue, 01 Jun 2021 22:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rD8EmGvVLCHRY6rnYywd87VdaZhsWJHUm0MbRk+LcQA=;
        b=KzqJVF2DECQAU9MGBps+2PqcD41dMHgI0BMjOSFyWg8QL4EAxeAWIc/uuHf8d86ONg
         5UJiykP0BKoJAB0jcht23FwKf2of2kLdyweWcBygnVhSb0b44TKdGJ0IUlYVNeN4YI4V
         5mkkq0Cn5pRHlmTLbFl2g03Oy5GwYyeXz2N0af6SZS1qmPg2+HUbxdmHM0I0o5pqomOy
         RxKdXMaZDGE59q2ZTRis7jKlXE6XQLVGrKlYXUSfzumpmHCTyKRJWSkfTMGw4oiK6Zox
         xoibR6nC9h6EImmfQHfCw6MAv4PAzXQoITV9hkFvzDQ58uW2PpRUhRFnH1QC5p6ja4Fl
         TVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rD8EmGvVLCHRY6rnYywd87VdaZhsWJHUm0MbRk+LcQA=;
        b=B3gMJdYMU4emuyAqOaTVo6hnDzBZ3HLzQbTG0+5pQ+G8xsZ/X6jWVkeRg9qPB4i0Dk
         sxEcyDnuYiFIWEAE5LAlSlnAh5VbUlS08TIiz8SOOlT4JEa5cai1iSt36cROfiFNzSs4
         cFEUdv6iJZMBsY8+AbV3Jfs/uAUPkWnaMIRY/h21qBCn4RxjXZuQSZRUXfARkgSZ//IA
         omxfEJdEswMpFvoRe6H2+qHYE4SieYQ/QU3F+PYp+MKdenYyFZnTImBprd4kzj9tAYGG
         sXWl8KDXqZAS00ywG+rW4Dp1m+RRx1imecAv6BJMYj1vc28U0lWQymXauYjG/iL38YPt
         gNeQ==
X-Gm-Message-State: AOAM530Luah4o26uOjXJn75FB0jIWwpwPFua6cz+Igr/cR34sdDu3KaV
        EXrX5a7z7RvS/oPxu3e2UPk+sE6Gn48=
X-Google-Smtp-Source: ABdhPJw/wDqLBwU/PQ8MrT0RYCpyoQCMTEcy42M4LYKOBGwi+/T/14b+xzpbvmnKNTzwllZrQEAl7A==
X-Received: by 2002:a17:90a:fa88:: with SMTP id cu8mr4518028pjb.86.1622611913365;
        Tue, 01 Jun 2021 22:31:53 -0700 (PDT)
Received: from localhost.localdomain (1-171-13-27.dynamic-ip.hinet.net. [1.171.13.27])
        by smtp.gmail.com with ESMTPSA id w8sm16821060pgf.81.2021.06.01.22.31.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 22:31:52 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 1/2] regulator: rt6160: Add DT binding document for Richtek RT6160
Date:   Wed,  2 Jun 2021 13:31:45 +0800
Message-Id: <1622611906-2403-1-git-send-email-u0084500@gmail.com>
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

