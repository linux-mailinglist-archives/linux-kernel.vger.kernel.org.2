Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9423F02C1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 13:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbhHRLc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 07:32:56 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:38720
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233798AbhHRLcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 07:32:54 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 1EBDF40CD1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629286339;
        bh=z1lwE7fvFQ0zk0zS1QadsjjuA/2iL/Y84eH5Hk9IVmc=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=ToyNKVeRFs7Ttfqp3pG9eGIA05e/mVF9M0VFSwoaIcVhQUME6E3WbLCsLsgVgcRIr
         cDNrVLpSEZJU6eSlM3nrUF2NCbllTTC9s3miKgO1p1Th1ZdzC75R47eZLxOMEaQ7Jv
         i9yk+t0OkMBOtkG0xXleRzEuQ5GrcNh2PDcCacWJPAI5L1HHP7bs6IaAvuckJCkPY7
         RQnFrdrafOw/40tqTyWTaB4AWx6tMNiQLN8UlMLTqtdJ/lK9QJxC61nJ6UHgd3oaRS
         eVsgNXAGSh9aI03jKlnkGXod22NrhSN62rvwWF3sZ6Z5eUQRpEPJVcW/9Fjj5JQIX/
         p7t3HCGslSN4g==
Received: by mail-ej1-f72.google.com with SMTP id j10-20020a17090686cab02905b86933b59dso744232ejy.18
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 04:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z1lwE7fvFQ0zk0zS1QadsjjuA/2iL/Y84eH5Hk9IVmc=;
        b=WMavX6OLV/CsqO1oaphlbqbsW6dwiME5x8Nw15H7qa7XNFaZOxVTd1wR36wkvRM+XU
         QIpthlTW7sc95Rhda9g0J1zsJPBdPqJSycOkxwnbqOxctcylxyr3/VFoTtTgCMNmJNo+
         B9bOzCVdSSJ8P51ErhyiNbtEHq/P6UchnJ/xUjyaUYwxOJO4fECwnzC7OXRhQW1vCitu
         QFtxlY/kJCL++iSMLgbWm/dcDUOam5bOTZ3ql770EG0TTs0170282K+0RPQiLxJrK7qz
         PNMcYQDeav998Bm8+OAv7A3d0Ij63cbS2R/HvVV8WOad1d4x30MEMnAFC86U+Iha3czs
         XTtQ==
X-Gm-Message-State: AOAM5311U06cNSgDplwTyMxgISEt9iRlZ9lgkJg3kMvXONXwyBxu3niU
        UhpzKn0zPcFcWMHwhUbiRRaPPieDx5LMa/RPb00TDiXpgiYkf+DtGUtOGocWUrmygmZAcVpnS17
        dSxoKsMAjum7aN494C55saH9bdAknfsHBBu96P4Nu0Q==
X-Received: by 2002:a17:906:53d3:: with SMTP id p19mr9327450ejo.509.1629286338829;
        Wed, 18 Aug 2021 04:32:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+03MoJFRg67NTzlscB7g3tDz8Ii/SWwTz4RtDzE9uKmYBmOM/VeQS3dXRHellgm0Wk9rt3w==
X-Received: by 2002:a17:906:53d3:: with SMTP id p19mr9327424ejo.509.1629286338602;
        Wed, 18 Aug 2021 04:32:18 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id kz15sm1945241ejc.103.2021.08.18.04.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 04:32:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: memory: convert Synopsys IntelliDDR memory controller to dtschema
Date:   Wed, 18 Aug 2021 13:31:39 +0200
Message-Id: <20210818113139.84869-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Synopsys IntelliDDR Multi Protocol memory controller (present in
Xilinx Zynq and ZynqMP) bindings to DT schema format using json-schema.

New binding contains copied parts of description from previous binding
document, therefore the license is set as GPL-2.0-only.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../memory-controllers/synopsys,ddrc-ecc.yaml | 73 +++++++++++++++++++
 .../bindings/memory-controllers/synopsys.txt  | 32 --------
 2 files changed, 73 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/synopsys.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml b/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
new file mode 100644
index 000000000000..a24588474625
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/synopsys,ddrc-ecc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys IntelliDDR Multi Protocol memory controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Manish Narani <manish.narani@xilinx.com>
+  - Michal Simek <michal.simek@xilinx.com>
+
+description: |
+  The ZynqMP DDR ECC controller has an optional ECC support in 64-bit and
+  32-bit bus width configurations.
+
+  The Zynq DDR ECC controller has an optional ECC support in half-bus width
+  (16-bit) configuration.
+
+  These both ECC controllers correct single bit ECC errors and detect double bit
+  ECC errors.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,zynq-ddrc-a05
+      - xlnx,zynqmp-ddrc-2.40a
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: xlnx,zynqmp-ddrc-2.40a
+    then:
+      required:
+        - interrupts
+    else:
+      properties:
+        interrupts: false
+
+additionalProperties: false
+
+examples:
+  - |
+    memory-controller@f8006000 {
+        compatible = "xlnx,zynq-ddrc-a05";
+        reg = <0xf8006000 0x1000>;
+    };
+
+  - |
+    axi {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        memory-controller@fd070000 {
+            compatible = "xlnx,zynqmp-ddrc-2.40a";
+            reg = <0x0 0xfd070000 0x0 0x30000>;
+            interrupt-parent = <&gic>;
+            interrupts = <0 112 4>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
deleted file mode 100644
index 9d32762c47e1..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Binding for Synopsys IntelliDDR Multi Protocol Memory Controller
-
-The ZynqMP DDR ECC controller has an optional ECC support in 64-bit and 32-bit
-bus width configurations.
-
-The Zynq DDR ECC controller has an optional ECC support in half-bus width
-(16-bit) configuration.
-
-These both ECC controllers correct single bit ECC errors and detect double bit
-ECC errors.
-
-Required properties:
- - compatible: One of:
-	- 'xlnx,zynq-ddrc-a05' : Zynq DDR ECC controller
-	- 'xlnx,zynqmp-ddrc-2.40a' : ZynqMP DDR ECC controller
- - reg: Should contain DDR controller registers location and length.
-
-Required properties for "xlnx,zynqmp-ddrc-2.40a":
- - interrupts: Property with a value describing the interrupt number.
-
-Example:
-	memory-controller@f8006000 {
-		compatible = "xlnx,zynq-ddrc-a05";
-		reg = <0xf8006000 0x1000>;
-	};
-
-	mc: memory-controller@fd070000 {
-		compatible = "xlnx,zynqmp-ddrc-2.40a";
-		reg = <0x0 0xfd070000 0x0 0x30000>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 112 4>;
-	};
-- 
2.30.2

