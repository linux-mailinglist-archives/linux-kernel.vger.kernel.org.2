Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2148843928A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhJYJiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhJYJiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:38:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C12C061745;
        Mon, 25 Oct 2021 02:35:51 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r28so6009392pga.0;
        Mon, 25 Oct 2021 02:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/nNkUI+dH8AtxQEgxzy9cBX4XHXv2DfxTs/bgyz0Ark=;
        b=Fy5NEGvmU3fy0LiiuoeyfH1kJNbMCByHStrRAMR2tsqJvXyfciZ8otKVCtYc+WWcFy
         gCu6MyUnzwtZHrftEWxICon0VnhdVBVigAA7W+bQGmPRFZGLPScyaDdpM5NojZ8jupdh
         MfZowZZZhvtdmjO2i1NIkfLXUZX6xjwRVlGPWq3QI4dlMOisODpi5kTR03t6QGHBHYrx
         /BrvZkQlDpFFUJUWZs7Kjo9XynLVvvCGIofoiJIkH8/OUGj0hiZB257V3Vb5VH4GtazA
         CLFbfVO5pIiAaJ+9uBFIFHeCzFG2E/u7PFGRVMgub1Ji80jTPPe10r3aiUVnWA1F52/g
         A5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nNkUI+dH8AtxQEgxzy9cBX4XHXv2DfxTs/bgyz0Ark=;
        b=m5bXjtVLb9qwG0SDKp9Yc2UG7MUVhCo9Bb8qz9NmUIctlPQT/Nji8uiqJ6G2xrQAo/
         0CB1TRhErSG1svPAvhpSsVssDsN77CrXLvk7AeaMDfH3LdWrZ0QHqvkwkjcUn4TERG1Y
         7MlqyDjuaSitd3kSCaXfc5A7Chu+6LHm3l5/BK4KrSsgyt3wVPzBhDNwf81FBokXtgig
         69hK+0yCrCvuC2I8h4tfUE9xjs/6WaXZMjhrhqqzKYCOBDIHy3pqPUJeCVLdbUNFIU3e
         MyC4rK5kOe8s1EgjEWAZhKLJl7N7JHhoVLssDlufQuvCzN0CRZuemR2zLxRS1tbSrtGP
         KRIA==
X-Gm-Message-State: AOAM533bhgVYSORvTFMnzH7hyioJYtGA0WX/d9GreyJyfU68NIbQbLyr
        SUZZAaOvX3Ioe/AT/Ncv7GA=
X-Google-Smtp-Source: ABdhPJwTTQLbHNEU1t5sZnE3tQc5DKE4YaX45mpMwRnCwGar4pU6PUEywEMi69Ra+ringECKxbWaRw==
X-Received: by 2002:a05:6a00:1488:b0:44d:25b2:f80b with SMTP id v8-20020a056a00148800b0044d25b2f80bmr17492261pfu.20.1635154551087;
        Mon, 25 Oct 2021 02:35:51 -0700 (PDT)
Received: from nj08008nbu.spreadtrum.com ([240e:47a:878:6a2:e0f0:8dca:6977:afd5])
        by smtp.gmail.com with ESMTPSA id c9sm15446100pgq.58.2021.10.25.02.35.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 02:35:50 -0700 (PDT)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com,
        pony1.wu@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 5/6] dt-bindings: display: add Unisoc's mipi dsi controller bindings
Date:   Mon, 25 Oct 2021 17:34:17 +0800
Message-Id: <20211025093418.20545-6-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211025093418.20545-1-kevin3.tang@gmail.com>
References: <20211025093418.20545-1-kevin3.tang@gmail.com>
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

