Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AFE36A743
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 14:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhDYMhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 08:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhDYMhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 08:37:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF63EC061574;
        Sun, 25 Apr 2021 05:36:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kb13-20020a17090ae7cdb02901503d67f0beso6451008pjb.0;
        Sun, 25 Apr 2021 05:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k3VX3I7y9xb7wsw2EFMUi2KX7EoFTuOAW4MR3tKQ32Y=;
        b=J1eQ8nH1ORk501mzaib/PcXyqKov0qELY+agpbkQ64nh60u3AgGcppWbQ472mpVyIr
         Xz7hyI7PCvFy29YXB+bxLkyrOaPcMAEqoh+PyVpAtnWi/QuypdL7/1+KhyEhRNGuJhiT
         5XmXrk4wIQFoNx2oDhNsCV6pb+UCP5ickXSEP0D1s7o8TZUe3WCw1LGbiNomlSk5rpJG
         WLMI3tWCv9U5CcZ2sHWoTgBqewbvY21fm+SJP6dtih04tzNlfrNi8WYgctK1AqVArsxN
         xl97QmX7xx/++By6mgJnzN+YJA+2cS6bACJE6B7AvJgW/aPIuSQNGJ2Ix9jvOd8y0vld
         crSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k3VX3I7y9xb7wsw2EFMUi2KX7EoFTuOAW4MR3tKQ32Y=;
        b=E8AwykpYOHDmS17JXrTlmR1aDogEEapfDB39+nO67ii2IdYAPINXU+r5gFIn/D5fDP
         l2nJr8IMFkAyRUYk01dDW+nVX0yG4NAvsYeU6lMlyGljNvU7OusN8/5BU9/ofKxk54Xf
         yCugyXtcGXiv38ndNgmwAoldS7a1/h5fzMsq8e4aa7g0eIPbXXs2y335kfQmtNAHgjgC
         0YbFQv77rt4P89vOa1Rl0V/BBWGGfbVhwX/QzoVGuMDID1UmW1udlqhc7VS8AI8PiTjb
         hG1hVKyghDX/KyHEOdtayB51/9wwnxS92gVmslzpK6QfO9a73nF+5m3MQeDqB99zsO6N
         hG6w==
X-Gm-Message-State: AOAM531h8v5emYLxluu/Sm+JhHDA7hEX2L1fmNx1qGBPwIwLtFDtG78I
        qZjBWM/mRz1kqSvdF4Jsoa8=
X-Google-Smtp-Source: ABdhPJzgvfs6oYwcg0RZnGWGeUgb7qjQ6oB9cpKavaWhpOO79vw0YxRMMhtOxkcDBcsqhKKMLF/bpA==
X-Received: by 2002:a17:903:1ca:b029:ea:fc69:b6ed with SMTP id e10-20020a17090301cab02900eafc69b6edmr13330631plh.80.1619354185341;
        Sun, 25 Apr 2021 05:36:25 -0700 (PDT)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id f135sm8767808pfa.102.2021.04.25.05.36.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Apr 2021 05:36:24 -0700 (PDT)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 3/6] dt-bindings: display: add Unisoc's dpu bindings
Date:   Sun, 25 Apr 2021 20:36:04 +0800
Message-Id: <20210425123607.26537-4-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210425123607.26537-1-kevin3.tang@gmail.com>
References: <20210425123607.26537-1-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

DPU (Display Processor Unit) is the Display Controller for the Unisoc SoCs
which transfers the image data from a video memory buffer to an internal
LCD interface.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/sprd/sprd,sharkl3-dpu.yaml        | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
new file mode 100644
index 000000000..4ebea60b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sprd/sprd,sharkl3-dpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc Sharkl3 Display Processor Unit (DPU)
+
+maintainers:
+  - Kevin Tang <kevin.tang@unisoc.com>
+
+description: |
+  DPU (Display Processor Unit) is the Display Controller for the Unisoc SoCs
+  which transfers the image data from a video memory buffer to an internal
+  LCD interface.
+
+properties:
+  compatible:
+    const: sprd,sharkl3-dpu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: clk_src_128m
+      - const: clk_src_384m
+
+  power-domains:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+  port:
+    type: object
+    description:
+      A port node with endpoint definitions as defined in
+      Documentation/devicetree/bindings/media/video-interfaces.txt.
+      That port should be the output endpoint, usually output to
+      the associated DSI.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sprd,sc9860-clk.h>
+    dpu: dpu@63000000 {
+        compatible = "sprd,sharkl3-dpu";
+        reg = <0x63000000 0x1000>;
+        interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+        clock-names = "clk_src_128m", "clk_src_384m";
+
+        clocks = <&pll CLK_TWPLL_128M>,
+          <&pll CLK_TWPLL_384M>;
+
+        dpu_port: port {
+            dpu_out: endpoint {
+                remote-endpoint = <&dsi_in>;
+            };
+        };
+    };
-- 
2.29.0

