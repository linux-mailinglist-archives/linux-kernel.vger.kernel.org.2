Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E16430072
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 07:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239563AbhJPFpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 01:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239417AbhJPFpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 01:45:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506F2C061570;
        Fri, 15 Oct 2021 22:43:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o20so30087158wro.3;
        Fri, 15 Oct 2021 22:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZ+rYmGOBzCE86+JmpxAv9FKEFvXz9uGD24tn9fITkw=;
        b=Y78ma8E6KABYw4iqrfLdtQJBddHIhHp5j2gkJANFISFwx5JCMxuBtWUryfImjuGmGf
         Wo5/cQ8GAz986eZmk+d+gkwgXlg47cmU6xJ0rhI3SDzJYyZp/IcnyeKUYIUQZpod+uX4
         egnt3qlP4Aw6XJTI18PWDk++eVczcq1GJNFyiSmiujb+HHAjovsQR8IcC4fgI11Qbj0Z
         Rp7QQPH0yRF8Ae63BlnSg8W+NFFR1cqiVNQoYXfZs+q5Tok4N35OFoTlqX4jYoTGsT6E
         m7t+ACXUimy7mkTZTrtFrRSgrVBc1SWyxR0muGqGX84Kangx5UnT6T/kOJ/qjYiWodXK
         GAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZ+rYmGOBzCE86+JmpxAv9FKEFvXz9uGD24tn9fITkw=;
        b=3ipL/N4l9AyTlgILUhnFrHRw/PCfwyAR6XdvZ6BFHs0KZQROzwZCUqgjBbDhzttIgJ
         1ffhEZgWo7hXQZA4SMAOEzdE7J1dQsN6Ld4oZBBG7M7P5/xtndWR802Tn7FX/bKlQAE0
         8gykVxCnsfITqFXJz16khAOjdPgMYI2FqmA5iCzscCaav+oT8IDOIhrdkDEl+GHXUZ2U
         wZo8/z9Tyi9lrK8bVbmZKlJyUzxI72f4Knc0jRXhfAeF7sW3zK6ohNwNjHQHbcq6ODyW
         jln8L8alaX1GpZFnJxVJ4PH0zkh6ut9swc5turlrTT/5jJeAMpzZJSDr5wEM5BCVpsVL
         2eew==
X-Gm-Message-State: AOAM532KOnGQS4P/0kTANVpNwmOYa2HXzNpYu9AGsl9blAjqWHtI42VI
        Vq9/vYANrd2z6NApBTXQTupOow8r75g=
X-Google-Smtp-Source: ABdhPJw0BYUa1g3Ko+oZOglsKO935oDH2b71zKTgW/C5ozgXzPwgqwJqD+/PFHwrE8PtzpNuDN2s2g==
X-Received: by 2002:a5d:64aa:: with SMTP id m10mr19477124wrp.196.1634363001674;
        Fri, 15 Oct 2021 22:43:21 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id z2sm6632663wrn.89.2021.10.15.22.43.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Oct 2021 22:43:21 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     robh@kernel.org, john@phrozen.org, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: bus: add palmbus device tree bindings
Date:   Sat, 16 Oct 2021 07:43:19 +0200
Message-Id: <20211016054319.31156-1-sergio.paracuellos@gmail.com>
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
Changes in v3: change sample to use child node which its bindings are
               already in YAML format to make dtschema happier.
Changes in v2: fixed missing semicolon in example.
 .../devicetree/bindings/bus/palmbus.yaml      | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/palmbus.yaml

diff --git a/Documentation/devicetree/bindings/bus/palmbus.yaml b/Documentation/devicetree/bindings/bus/palmbus.yaml
new file mode 100644
index 000000000000..4f6352eff050
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/palmbus.yaml
@@ -0,0 +1,79 @@
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
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    palmbus@1e000000 {
+        compatible = "palmbus";
+        reg = <0x1e000000 0x100000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x1e000000 0x0fffff>;
+
+        gpio@600 {
+            #gpio-cells = <2>;
+            #interrupt-cells = <2>;
+            compatible = "mediatek,mt7621-gpio";
+            gpio-controller;
+            gpio-ranges = <&pinctrl 0 0 95>;
+            interrupt-controller;
+            reg = <0x600 0x100>;
+            interrupt-parent = <&gic>;
+            interrupts = <GIC_SHARED 12 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+
+...
-- 
2.33.0

