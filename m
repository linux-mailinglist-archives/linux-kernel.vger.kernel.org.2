Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46C938200F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 18:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhEPQr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 12:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhEPQr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 12:47:28 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5D1C061573;
        Sun, 16 May 2021 09:46:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id a11so1887845plh.3;
        Sun, 16 May 2021 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=i9VMKyfm4Fjf1fQzyeLuIctLDz7Yny9gYgAaFqniSkU=;
        b=serRT77UgzJEm5LP13U5uhpGOK/WnPPnSV5wKKbeAb+z/IfSXOA9OENPhLYfHMshiU
         RWEKDQdyGRw0E9b7iHcJcknl6sQmmUwT4FuN9srETYx9qeLy2GfSS9lJNhqR7r8kjUaY
         Ss2ztvZPv+Hf7ryEmp3lewZzMxFFotI3xHICBJmJ1umO7iuCF/IP6ww+FoZgbm/wi5Sk
         hzjf8Gi4x0ch1w9aO1yB7XnKNVRUgb6+2oBcgnvvV4LYT3ZVQZHBgqDsBWU5kBma77mB
         a3CbfcdMc4e9Xkts/AJXUK9g2Y51mfgOMqddTGtm5Ze9+kOTr7UZc+obXlnPvVu80vSi
         0pFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i9VMKyfm4Fjf1fQzyeLuIctLDz7Yny9gYgAaFqniSkU=;
        b=VKpMm3zy1KguXACMzpQ63RrgzVqsQ67O8tD+NS5qLBe0OP1ZqoYa9PZo60alkJ5wlZ
         KJq1jZF9oSs/nIBZezTF6VYMecFIlUtCnrBkmo5FXeeQqo37XPKlEa0BlzhKduf69VXR
         I8CvqNWJ++xL38nCkgGpgvvMq5neS8fR1b4Xr9YyhvOGmWd8s934/3M0aRZHXk/rqTOA
         N32RTdOYIlLcEuesH1+A+XM2EASMRjuxFJtZ2W2oD1i+jrTBhyQSe2oyi586cAUq7ANq
         enHlSA55+kZdm+ykd8bcOy9Pi7u9lQN4a8MU45i2ex7T5xK2GV6lyyScNTUv/gjx0Kiv
         7zmA==
X-Gm-Message-State: AOAM533c/nsO5vWeTSYeChiOhlJc8/gsZcmpZceNPt+pBvUGj1V9Lvl3
        nSgyn+E0wUu/H+/w/ThBJF8=
X-Google-Smtp-Source: ABdhPJw+UjydEHKkVtPhKLxzI/64ZgeWOsXrEOx2laxxCpxtKPVSbAmI3tG+gNuliZYYADPHiyd7kw==
X-Received: by 2002:a17:903:18b:b029:ee:d430:6c4d with SMTP id z11-20020a170903018bb02900eed4306c4dmr56517056plg.34.1621183571962;
        Sun, 16 May 2021 09:46:11 -0700 (PDT)
Received: from localhost.localdomain (1-171-3-209.dynamic-ip.hinet.net. [1.171.3.209])
        by smtp.gmail.com with ESMTPSA id s16sm8625128pga.5.2021.05.16.09.46.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 May 2021 09:46:11 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] regulator: rt6160: Add DT binding document for Richtek RT6160
Date:   Mon, 17 May 2021 00:45:59 +0800
Message-Id: <1621183560-6668-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add DT binding document for Richtek RT6160 voltage regulator.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
since v2
- Move buckboost node from patternProperties to Properties.
---
 .../regulator/richtek,rt6160-regulator.yaml        | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml
new file mode 100644
index 00000000..4ce1f7c
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml
@@ -0,0 +1,67 @@
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
+  richtek,vsel_active_low:
+    description: |
+      Used to indicate the 'vsel' pin active level. if not specified, use
+      high active level as the default.
+    type: boolean
+
+  buckboost:
+    description: BuckBoost converter regulator description.
+    type: object
+    $ref: regulator.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
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
+
+        buckboost {
+          regulator-name = "rt6160-buckboost";
+          regulator-min-microvolt = <2025000>;
+          regulator-max-microvolt = <5200000>;
+          regulator-allowed-modes = <0 1>;
+        };
+      };
+    };
-- 
2.7.4

