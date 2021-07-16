Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEAA3CB3B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbhGPIHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236704AbhGPIG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:06:58 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DA9C06175F;
        Fri, 16 Jul 2021 01:04:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t9so9203598pgn.4;
        Fri, 16 Jul 2021 01:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=suoWtZA88K5gTbVEFEx0S4DWf12QByCbeiLKbZyLzH4=;
        b=NwLgOfjbXd130gMCeWmje0b2vIzwCh7i0GEk8yOHf7K993+bSFPJYjR8lO7cO6LHlg
         7CMHAslCu0AT3bCJiRYHDvF7Yqho4u1nyLjQ6rQA2h7IJFMH9QDaI/5KcBm9Din57T8S
         QVKycDeuj4vZsaGUx/BEyv77hvX3ZuRGIglaQ2Vkvwfk2cbdN6In7iQf8sFpAvuglXkr
         Cx6ApOtNcCTFZMuYJnbwi7+wWFpnFHXWvVMGqF2xXwkZeEAZiPTaI0E5HhkJchyUWbrR
         dppZ5a/XzB/Rtm1U6oWqZ/WYyC2lluVWVADa26Le1EmR0UH858idSEypGiIh5WsEIUPL
         mSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=suoWtZA88K5gTbVEFEx0S4DWf12QByCbeiLKbZyLzH4=;
        b=Ts6bI5S/j5tsOeFrfziG2AYP5UIZxIlMyESMKTVVOTfkiLPQka1/BgWFSL87/j9Yjz
         egbFVzZoyiYTw1pQZOZAj07nf60rkp1mz/+j8Yp9Sla9IfQnz9AUEcWidMUxd7MNz/mF
         xjSV3F+vZzXYkca4woV+5BvzpLntOovXT1ASrKYnklDnH8WJejWYIXVH6xqIJbMXdWtD
         pMFoQPJWbkhafSMlC2vvck8hbeHFyaVyQ7vJIGyMpaX++TxU7ij5/ak+G2BVGs8RUpbQ
         DxWABX4NZoeC5JUAjqvRcTMVSdPHtL9qMbr79T0Lkb3a+MkOvBZfG3eCtnOGcfcKsSRV
         0XmQ==
X-Gm-Message-State: AOAM531iDZz+4aPIBjlcuoqZDbuxspiFu6mGQ/fOB83hfHmBqbY/qEeH
        c9utRwHJr46unT3OvXnSJCg=
X-Google-Smtp-Source: ABdhPJzbHkLhP6Ix1lnWS6OP5WZOaiiel5+daoV7zPYth/lquPhwevaiJBGkc0c995FRjT2jpaCoxg==
X-Received: by 2002:a62:804b:0:b029:328:db41:1f47 with SMTP id j72-20020a62804b0000b0290328db411f47mr9010828pfd.43.1626422642887;
        Fri, 16 Jul 2021 01:04:02 -0700 (PDT)
Received: from localhost.localdomain (1-171-2-23.dynamic-ip.hinet.net. [1.171.2.23])
        by smtp.gmail.com with ESMTPSA id t17sm9292636pfg.93.2021.07.16.01.03.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jul 2021 01:04:02 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] regulator: rtq2134: Add binding document for Richtek RTQ2134 SubPMIC
Date:   Fri, 16 Jul 2021 16:03:55 +0800
Message-Id: <1626422636-29458-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add binding document for Richtek RTQ2134 SubPMIC.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../regulator/richtek,rtq2134-regulator.yaml       | 106 +++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtq2134-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2134-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2134-regulator.yaml
new file mode 100644
index 00000000..3f47e8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtq2134-regulator.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rtq2134-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RTQ2134 SubPMIC Regulator
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RTQ2134 is a multi-phase, programmable power management IC that
+  integrates with four high efficient, synchronous step-down converter cores.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RTQ2134-QA/DSQ2134-QA-01.pdf
+
+properties:
+  compatible:
+    enum:
+      - richtek,rtq2134
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+
+    patternProperties:
+      "^buck[1-3]$":
+        type: object
+        $ref: regulator.yaml#
+        description: |
+          regulator description for buck[1-3].
+
+        properties:
+          richtek,use-vsel-dvs:
+            type: boolean
+            description: |
+              If specified, buck will listen to 'vsel' pin for dvs config.
+              Else, use dvs0 voltage by default.
+
+          richtek,uv-shutdown:
+            type: boolean
+            description: |
+              If specified, use shutdown as UV action. Else, hiccup by default.
+
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rtq2134@18 {
+        compatible = "richtek,rtq2134";
+        reg = <0x18>;
+
+        regulators {
+          buck1 {
+            regulator-name = "rtq2134-buck1";
+            regulator-min-microvolt = <300000>;
+            regulator-max-microvolt = <1850000>;
+            regulator-always-on;
+            richtek,use-vsel-dvs;
+            regulator-state-mem {
+              regulator-suspend-min-microvolt = <550000>;
+              regulator-suspend-max-microvolt = <550000>;
+            };
+          };
+          buck2 {
+            regulator-name = "rtq2134-buck2";
+            regulator-min-microvolt = <1120000>;
+            regulator-max-microvolt = <1120000>;
+            regulator-always-on;
+            richtek,use-vsel-dvs;
+            regulator-state-mem {
+              regulator-suspend-min-microvolt = <1120000>;
+              regulator-suspend-max-microvolt = <1120000>;
+            };
+          };
+          buck3 {
+            regulator-name = "rtq2134-buck3";
+            regulator-min-microvolt = <600000>;
+            regulator-max-microvolt = <600000>;
+            regulator-always-on;
+            richtek,use-vsel-dvs;
+            regulator-state-mem {
+              regulator-suspend-min-microvolt = <600000>;
+              regulator-suspend-max-microvolt = <600000>;
+            };
+          };
+        };
+      };
+    };
-- 
2.7.4

