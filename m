Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249C83219DB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhBVOLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhBVN3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:29:25 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE594C06178C;
        Mon, 22 Feb 2021 05:28:40 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id a24so7716528plm.11;
        Mon, 22 Feb 2021 05:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k3VX3I7y9xb7wsw2EFMUi2KX7EoFTuOAW4MR3tKQ32Y=;
        b=er7QipuzV1kGXLJbt0WnSPoGBLoc+dy8hIf61be+yRHqSqJBtcVzqjyUSFHvF5vzH7
         1vq58w42MuUeHrrTAB8sDSaSt3wC0ZWTlgT5l8q8EyGVBY1A/TCFnWalL4so6Wdxb0Pv
         ZXr/E3GhCBsVte6AuoMnCsUGqIRx7gvkEXTzpffSy3BwmHsDg1OvSAX/dKe0iPRKQ6nq
         BYl9EyOe2FdzPfUjv7pK5E4yMuA57PL9Hm2XDGn81Ta6EevZoEr8ACzbSlAlDx3wV7L3
         yRcwof0TgsjH/sHo9Ifxo+vkhKr1E4YNulz6BnCSZ89EdopxF+AqlB1+AMc6kgWqrnU/
         ZYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k3VX3I7y9xb7wsw2EFMUi2KX7EoFTuOAW4MR3tKQ32Y=;
        b=bW+6p20FwsIzqqZMghqyy5vKX3eAsVmCXGWN8nYcpMTn/XLfVBEIX2caVhfLIIhk1a
         L+xpzCvaKiuRndEensNJbYFhTQInTd1QEKynsUnYN1vEQtlyTi0xJGPIKh0fg4oVVfya
         HUGd2Pqii0X0LQ7w2L25JAp8gvPHmkFuLACY40x1mPth12A9/KVtwBaI6zDDcfs93XC6
         SoX8xy7H8s6i29DcIu2DZt8KYk1KDPV/jaPJjRpSb7MhufVgeAJmdEWCyz8RhL6zzHQE
         n8YbMSP6LushM6hNK9IX6JXKiw2DQfCUQli4KCW8huiMlXCkLeEtj5EJD1bH4MI3sflS
         OJMw==
X-Gm-Message-State: AOAM531eBWueuPQ4/qt2aBIMgnLcdwZAI+bsRDcjw1ndb3wFLRSARBGo
        zG0tcT3RcTSAu/O8/Jg6qdg=
X-Google-Smtp-Source: ABdhPJyKRSTjmK3XgYgSlQ+qupc0eNrTdETYjXZ0ltDYsNTXu5mpDCFpFOhfvBkQ7AmNeeAHBoQmMA==
X-Received: by 2002:a17:902:7847:b029:df:d889:252c with SMTP id e7-20020a1709027847b02900dfd889252cmr22176067pln.76.1614000520020;
        Mon, 22 Feb 2021 05:28:40 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 141sm19585334pfa.65.2021.02.22.05.28.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2021 05:28:39 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 3/6] dt-bindings: display: add Unisoc's dpu bindings
Date:   Mon, 22 Feb 2021 21:28:19 +0800
Message-Id: <20210222132822.7830-4-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210222132822.7830-1-kevin3.tang@gmail.com>
References: <20210222132822.7830-1-kevin3.tang@gmail.com>
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

