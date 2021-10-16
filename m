Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B69430059
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 07:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242514AbhJPFEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 01:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbhJPFEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 01:04:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED032C061570;
        Fri, 15 Oct 2021 22:02:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 3-20020a1c0403000000b00322f53b9bbfso36324wme.3;
        Fri, 15 Oct 2021 22:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H2YpgdFm0Pz93C09F9l0CF1iCIS/YHWEQgIt5JTwmsw=;
        b=g4dLJvN6Joy98QFn76/y2O2nkh+HCTmbdfWbXOMGFyKksfqNH7x+KcI8Rry3ef1fpE
         C4AahTnrFdE0M1iKZ7J4IoCJ8Sj3f8jeQfhSpRuimGsdN6uoUhbkD9uMGrMkAwsF8PAe
         FIGZFezWrEL/x05LUVfW/uNmUy+CKT2QcQ0LRSc1Uc3x80v/H6bdobnsYz2SroEARKvw
         lH37q8OAB04uTChfvAWNv8kSZ6UIaqC68D0kBBbsK/t3g/NAfX71ZmllQFxJ8/gJeSST
         x+8GeF8OiX8iGL0Qif4gDJx9rbiyeC1uHknZ/hPBhp0AUMTKsjw5rZJKnCq319pcGNpv
         DpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H2YpgdFm0Pz93C09F9l0CF1iCIS/YHWEQgIt5JTwmsw=;
        b=Qb7AsoAhPHNGGXcXE1nLMX2PVEYWFlF0VMmjdQnxRi4nmhRRvLBVvG9rpDGUuZudXp
         CBaohbHdgAiSh3AmhaLVqlJCkywDGBrdncufBaR6K5cjDpTAg5JzhZ388NkGSWoy4jZC
         h5LDlA/U6EqcziprDXo9LT/Rm48RU5aE0EocNp83UeCV2TrImS8EOYTplppPO7IwYzFc
         mqguAMLQBudPwhoAepR5u7QPEhE6ffEzDS03cSUdK0rp0ddpO6H9NenZk7NFcNoSjPS5
         SYraH2nBTTNLRc3VbZ4C3yV1NrCtNaxnWwZjNA/hQsKjq5HyYt6hv+Q2cPngg3G/5r01
         WQEA==
X-Gm-Message-State: AOAM533YI8sVxuYGxp7S6PW0dTqo8os5aW4ezn4zWJYjEiNO/RwC0vMO
        CI6JuVkcFpW9ht7s5ulGFS3l2U6DxjM=
X-Google-Smtp-Source: ABdhPJyocPIO1T7bGz2XcQX2ju6TiQW+AopYHJBam0YgJddZnJjuKlvX/D0HlQtG94XL2Wh5aprVog==
X-Received: by 2002:a1c:1b4a:: with SMTP id b71mr17092029wmb.33.1634360544307;
        Fri, 15 Oct 2021 22:02:24 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id t18sm7216484wrm.81.2021.10.15.22.02.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Oct 2021 22:02:23 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     robh@kernel.org, john@phrozen.org, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: bus: add palmbus device tree bindings
Date:   Sat, 16 Oct 2021 07:02:22 +0200
Message-Id: <20211016050222.29143-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for palmbus controller present in all the MIPS
ralink based SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
Changes in v2: fixed missing semicolon in example.

 .../devicetree/bindings/bus/palmbus.yaml      | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/palmbus.yaml

diff --git a/Documentation/devicetree/bindings/bus/palmbus.yaml b/Documentation/devicetree/bindings/bus/palmbus.yaml
new file mode 100644
index 000000000000..bbff9bfd8db2
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/palmbus.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/palmbus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ralink PalmBus Device Tree Bindings
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description: |
+  The ralink palmbus controller can be found in all ralink MIPS
+  SoCs. It provides an external bus for connecting multiple
+  external devices to the SoC.
+
+properties:
+  $nodename:
+    pattern: "^palmbus(@[0-9a-f]+)?$"
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  compatible:
+    const: palmbus
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+
+patternProperties:
+  # All other properties should be child nodes with unit-address and 'reg'
+  "^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+$":
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    palmbus@1e000000 {
+        compatible = "palmbus";
+        reg = <0x1e000000 0x100000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x1e000000 0x0fffff>;
+
+        syscon@0 {
+            compatible = "mediatek,mt7621-sysc", "syscon";
+            reg = <0x0 0x100>;
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+            ralink,memctl = <&memc>;
+            clock-output-names = "xtal", "cpu", "bus",
+                                 "50m", "125m", "150m",
+                                 "250m", "270m";
+        };
+
+        wdt@100 {
+            compatible = "mediatek,mt7621-wdt";
+            reg = <0x100 0x100>;
+        };
+    };
+
+...
-- 
2.33.0

