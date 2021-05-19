Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A973887C0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhESGpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 02:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhESGpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 02:45:46 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC4CC06175F;
        Tue, 18 May 2021 23:44:26 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id l70so8765491pga.1;
        Tue, 18 May 2021 23:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Dn2ZnNyuJvry6P0uiwHBiVp5f0XAzwhsMlJuOW6GD14=;
        b=la7VuDczzH7HuYSobGEpghR9f74VzTf9GrST1MLIujYr2iIcKMqveNVubAT1QtJI26
         ThOoV4VVrJ4ua8MrRzF6cdrlrUG8EysPLYQhZu0eq/k4yEzy/5Yv7do+uOANrXvTceUj
         NNFzZzDej9+X9WXsZhqYQlvLaPYbfpJcdsEF3ZX42uNWYhMJm4L+XTNlPoj/S2OYCzGp
         1pD5VLoP09r189AF+y8AljlMF3eZaTeNGt4JLU/FD4nSEldncFkmrBWEtSDcEujRH2Yi
         u3/jC6rPSK/+dccSODzcSwC41hitb17ICDStd4SddAKzF/oxv+R/VdDwiKJVFN1nKepR
         055g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dn2ZnNyuJvry6P0uiwHBiVp5f0XAzwhsMlJuOW6GD14=;
        b=ZFcNyZiPEaxiyGUg6U7N25lienEb8UOZUK1wGNKgdQW8daDb5aXnRilLSc9vKHVn8+
         skojSgmZo4PQHhcMENkAjXw4HFkrtCSQZzguvuxrmFg+wHIFhK7vrJsi41GFabllJWLb
         5fOAS6/nYCl9nNwU2fKLtN7GRqzSCbIaYMn2faNq/FDdfBPrcYXhOCuMOne25qtD0CbB
         ZjPd+pknFkfHONJxD/TH3QaftsG8D2FDT/6D333qJCt3H5T1RZFUaeHJyyCtE9HT3W1e
         3LU4ZuVaKJGijAoXz8nbmqh46uleilrddpMzZ8ax5HLziIrHuBPcDwjY0BO/3OoHtMxt
         6CcQ==
X-Gm-Message-State: AOAM533fTjWruyygJOzF0hbhcxdTtsdKbSNfwWU5NtrAqGIlZj3JPpN4
        UWedW8l5QXVRrAgol9E9dLU=
X-Google-Smtp-Source: ABdhPJygzmFUnbW5eV4hQPRASF5F2vQrxjWhuMRIxUZpiuLQMMThLb0kVfS8zMQcqJDImumr5YWg0Q==
X-Received: by 2002:a65:5a8f:: with SMTP id c15mr9487205pgt.0.1621406665661;
        Tue, 18 May 2021 23:44:25 -0700 (PDT)
Received: from localhost.localdomain (1-171-11-163.dynamic-ip.hinet.net. [1.171.11.163])
        by smtp.gmail.com with ESMTPSA id m14sm14085447pff.17.2021.05.18.23.44.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 May 2021 23:44:24 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] regulator: rt6160: Add DT binding document for Richtek RT6160
Date:   Wed, 19 May 2021 14:43:58 +0800
Message-Id: <1621406639-29911-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add DT binding document for Richtek RT6160 voltage regulator.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
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

