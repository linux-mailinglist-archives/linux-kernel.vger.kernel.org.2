Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C816B3EB6D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240841AbhHMOgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:36:48 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:38274
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240698AbhHMOgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:36:47 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 061DB3F04E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 14:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628865380;
        bh=x9UCZvVc7jU0CntSkbEGlw9mwi/YjTVnEbLIpC6FvVI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=L8IM+no85s9zX0AJjtwcrZoJAaGbc9VW5qLkG1yerZYIfxcNI/4613bfUk0X+caf7
         uQ/dHqO7yWtiJOpkPLkTrd0IbjBKktl92XYOdC09UhZDCzfSjW8O7uASOm8trqJWzr
         +fEGRjcNa+OazrGrdjTKw599R+zhNXu2D1e8m6vHT1kAxC1urW0CClTw03kraBf9DG
         Htbhm6EiRedT9njEQ8h99UnqkjnylANylMf+nQdY9lVZmlBkFGCkjJotUy9cDOuiY7
         GiGD/LMHZLbwXeicr4PvT3uavWY2aln9JXgOyR2CchvxnP+d7K9WhbakB7EfyN54Yv
         670BrvyOfNcYQ==
Received: by mail-ed1-f71.google.com with SMTP id dh21-20020a0564021d35b02903be0aa37025so4990532edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 07:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x9UCZvVc7jU0CntSkbEGlw9mwi/YjTVnEbLIpC6FvVI=;
        b=OpVnTHveSzs8G3kALtmm1q5vMzVXVKOdFP9h3JV1ELrFmTHHDYjxgrvTKPZQ72orSC
         8o3lcO2YJUpNOxrV/DZmiCKZjnI9jXGrMR2eE3L8P0FVCYlYi5WDnYNtO3y1WWl9Y4EV
         CuRm6Fb/3LC+HjjXF6mI8qmpa3tfaojSI7d7lA8gqfqnjRpypeImaF9siPOUGTifaM9G
         QRigbmlH/Bdtzz+CHVUCXuOzpyyrxLkGN+6Ik0MGRtcxvmZkh8qjrx3wYFn+aXlds+3T
         LYXPVmZfMvPevR9smcCHkZZiwM/u4PIAXdQtlQnByu5VAMVjqjZ9FW2OXoucUkYrUPU0
         n4Zw==
X-Gm-Message-State: AOAM530u73+LdanWo9E838aNdRjtbAr94LeROFKvNGKyPACCS5Rg908+
        bNl1+s6RZTRnJk1i/MC3XQu/ymjTHbCm3mtJd5q0macijllyt5iUZxMa1up9+dt7bzfzyQFC7Yz
        Vd7IZ8zcNOeOwBslACOrlmTK1/Jn8bnC/1u6RzdcDpA==
X-Received: by 2002:a05:6402:d5c:: with SMTP id ec28mr3565077edb.3.1628865379502;
        Fri, 13 Aug 2021 07:36:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuMoY4+XcabAYYpTGyWYyBxRg6Csmgkh9iJI2Xs9pb8x6z6Xqx0ACIqM/rZBFia4ZB4i5W9w==
X-Received: by 2002:a05:6402:d5c:: with SMTP id ec28mr3565051edb.3.1628865379337;
        Fri, 13 Aug 2021 07:36:19 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id d26sm989219edp.90.2021.08.13.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 07:36:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Alban Bedel <albeu@free.fr>, Paul Burton <paul.burton@mips.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] dt-bindings: memory: convert Qualcomm Atheros DDR to dtschema
Date:   Fri, 13 Aug 2021 16:35:37 +0200
Message-Id: <20210813143537.130310-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm Atheros AR7xxx/AR9xxx DDR controller to DT schema
format using json-schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../ath79-ddr-controller.txt                  | 35 -----------
 .../qca,ath79-ddr-controller.yaml             | 61 +++++++++++++++++++
 2 files changed, 61 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/qca,ath79-ddr-controller.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt b/Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt
deleted file mode 100644
index c81af75bcd88..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Binding for Qualcomm  Atheros AR7xxx/AR9xxx DDR controller
-
-The DDR controller of the AR7xxx and AR9xxx families provides an interface
-to flush the FIFO between various devices and the DDR. This is mainly used
-by the IRQ controller to flush the FIFO before running the interrupt handler
-of such devices.
-
-Required properties:
-
-- compatible: has to be "qca,<soc-type>-ddr-controller",
-  "qca,[ar7100|ar7240]-ddr-controller" as fallback.
-  On SoC with PCI support "qca,ar7100-ddr-controller" should be used as
-  fallback, otherwise "qca,ar7240-ddr-controller" should be used.
-- reg: Base address and size of the controller's memory area
-- #qca,ddr-wb-channel-cells: Specifies the number of cells needed to encode
-			     the write buffer channel index, should be 1.
-
-Example:
-
-	ddr_ctrl: memory-controller@18000000 {
-		compatible = "qca,ar9132-ddr-controller",
-				"qca,ar7240-ddr-controller";
-		reg = <0x18000000 0x100>;
-
-		#qca,ddr-wb-channel-cells = <1>;
-	};
-
-	...
-
-	interrupt-controller {
-		...
-		qca,ddr-wb-channel-interrupts = <2>, <3>, <4>, <5>;
-		qca,ddr-wb-channels = <&ddr_ctrl 3>, <&ddr_ctrl 2>,
-					<&ddr_ctrl 0>, <&ddr_ctrl 1>;
-	};
diff --git a/Documentation/devicetree/bindings/memory-controllers/qca,ath79-ddr-controller.yaml b/Documentation/devicetree/bindings/memory-controllers/qca,ath79-ddr-controller.yaml
new file mode 100644
index 000000000000..9566b3421f03
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/qca,ath79-ddr-controller.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/qca,ath79-ddr-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Atheros AR7xxx/AR9xxx DDR controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  The DDR controller of the AR7xxx and AR9xxx families provides an interface to
+  flush the FIFO between various devices and the DDR. This is mainly used by
+  the IRQ controller to flush the FIFO before running the interrupt handler of
+  such devices.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: qca,ar9132-ddr-controller
+          - const: qca,ar7240-ddr-controller
+      - items:
+          - enum:
+              - qca,ar7100-ddr-controller
+              - qca,ar7240-ddr-controller
+
+  "#qca,ddr-wb-channel-cells":
+    description: |
+      Specifies the number of cells needed to encode the write buffer channel
+      index.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#qca,ddr-wb-channel-cells"
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    ddr_ctrl: memory-controller@18000000 {
+        compatible = "qca,ar9132-ddr-controller",
+                     "qca,ar7240-ddr-controller";
+        reg = <0x18000000 0x100>;
+
+        #qca,ddr-wb-channel-cells = <1>;
+    };
+
+    interrupt-controller {
+        // ...
+        qca,ddr-wb-channel-interrupts = <2>, <3>, <4>, <5>;
+        qca,ddr-wb-channels = <&ddr_ctrl 3>, <&ddr_ctrl 2>,
+                              <&ddr_ctrl 0>, <&ddr_ctrl 1>;
+    };
-- 
2.30.2

