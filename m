Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C4D36A749
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 14:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhDYMhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 08:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhDYMhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 08:37:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD79C061756;
        Sun, 25 Apr 2021 05:36:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id g16so10632850plq.3;
        Sun, 25 Apr 2021 05:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/nNkUI+dH8AtxQEgxzy9cBX4XHXv2DfxTs/bgyz0Ark=;
        b=CcDD4GHu6bcUiF1CvFUCDOLDFlqyzU5L+z5GR5PQwUwdEWLYhsaBJrOuPfcwOPEsHI
         1/MZVHd7BxswbjBEREiBMZk7BRlluNt2sJVF2cKvNZZfcONduQpDu24+BCmXls92ZuZ4
         UfA+AjXlKSYB3cqXxYc7BRjzChrV9276srU50YxyeSekTijbPyjyyFl1QGgx+MQEGNPa
         728u5dWb2XSReBiGjR/Avqx1EZYktIq+InKKgGjpK3gBKMzONn/Zgsai3b61YKcc0jVI
         NfmATbU+TUmjRo0/vOatSQR88AdKFL0Ql9CQAwb5iFLy71YeTKL2PTplI+DIGx6WJygJ
         S7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nNkUI+dH8AtxQEgxzy9cBX4XHXv2DfxTs/bgyz0Ark=;
        b=IEVpyton+Z2qtJlf7UMQ+DaHN+itjBg8C2xOlaoswrtn4BFdsb5Grxk2+Kk7B9c3nu
         Ah+p4aptnD6J4HfqpoVGGF0KlYcDoJo7JBsD5VqAIMfv5N/ajNlwiqYz8lYIO4rBiyT1
         3g86Nf2safGSDEerBr0dNiUVoaNxwzz/cGuKgNCqMr0W83yLcS8wAzAkghMRqhwK+jiZ
         8NKmQHcVMKKABwjSCsHuXYqDZry7/E8zuiwLDTz9H+P2NGovOfi6xA2StexgxCnSvz4s
         M8wh5EzZZw4sgnPTqbHf0VKFY+x2HCOAh8YLIbacoZb5GWNjAq0ETNeayBv3FWm6idsF
         d3JA==
X-Gm-Message-State: AOAM531We5lNJixAik1ccO4ndchVrpz0UBtbfGSjgeoESbM3v7evzwtb
        LDk2VdXnjNRCUQgWD/xD1ho=
X-Google-Smtp-Source: ABdhPJyfFi6kJaQb24Yiy0rCknrxCmAIOfyO24yFtaiijnbJNKoILp0oYHwrSR5bUTbU44uKsFasNg==
X-Received: by 2002:a17:90a:f2c7:: with SMTP id gt7mr17056709pjb.157.1619354192592;
        Sun, 25 Apr 2021 05:36:32 -0700 (PDT)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id f135sm8767808pfa.102.2021.04.25.05.36.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Apr 2021 05:36:32 -0700 (PDT)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 5/6] dt-bindings: display: add Unisoc's mipi dsi controller bindings
Date:   Sun, 25 Apr 2021 20:36:06 +0800
Message-Id: <20210425123607.26537-6-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210425123607.26537-1-kevin3.tang@gmail.com>
References: <20210425123607.26537-1-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

Adds MIPI DSI Controller
support for Unisoc's display subsystem.

v5:
  - Remove panel_in port for dsi node.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/sprd/sprd,sharkl3-dsi-host.yaml   | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
new file mode 100644
index 000000000..bc5594d18
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sprd/sprd,sharkl3-dsi-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc MIPI DSI Controller
+
+maintainers:
+  - Kevin Tang <kevin.tang@unisoc.com>
+
+properties:
+  compatible:
+    const: sprd,sharkl3-dsi-host
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 2
+
+  clocks:
+    minItems: 1
+
+  clock-names:
+    items:
+      - const: clk_src_96m
+
+  power-domains:
+    maxItems: 1
+
+  ports:
+    type: object
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+      port@0:
+        type: object
+        description:
+          A port node with endpoint definitions as defined in
+          Documentation/devicetree/bindings/media/video-interfaces.txt.
+          That port should be the input endpoint, usually coming from
+          the associated DPU.
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+      - port@0
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sprd,sc9860-clk.h>
+    dsi: dsi@63100000 {
+        compatible = "sprd,sharkl3-dsi-host";
+        reg = <0x63100000 0x1000>;
+        interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+          <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+        clock-names = "clk_src_96m";
+        clocks = <&pll CLK_TWPLL_96M>;
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            port@0 {
+                reg = <0>;
+                dsi_in: endpoint {
+                    remote-endpoint = <&dpu_out>;
+                };
+            };
+        };
+    };
-- 
2.29.0

