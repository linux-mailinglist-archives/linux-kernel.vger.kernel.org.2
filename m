Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4D0439282
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhJYJh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbhJYJhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:37:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934D9C061745;
        Mon, 25 Oct 2021 02:35:26 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id t184so10221676pfd.0;
        Mon, 25 Oct 2021 02:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k3VX3I7y9xb7wsw2EFMUi2KX7EoFTuOAW4MR3tKQ32Y=;
        b=Vmcu4Az0I9FR2ZZGKOzztPA7QQ+4yo4Y6w25mmAUD7cg82oT3n8O3nTiayNeQDXQzC
         WpcMtf/X74wjNgMlfgQi8p/3PXFHLv5oOeFiJnjzbjLHcLkJT7sD8DRLgP6Dj9gSkBJG
         S8FruKDK5qYZg7FUeUurgtZ71rzsW8fEteOQFEEE8mq45t+jNGRyF9uBNkKMq7zY3HLx
         Cq82uEDRZ1gXQWde534LeLiNhrsB9X7gREXCXUGke4lioNBvtGcBaKi4U/VFxVPCApMQ
         4CqM5ZwIdIxqCA7Fk2LCESyt3ZEliFxGAm1OLRa8hI/mfp294TfxONstuYmcoxb1LWRL
         HhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k3VX3I7y9xb7wsw2EFMUi2KX7EoFTuOAW4MR3tKQ32Y=;
        b=q3hnayUWnDY848a+rcqI9TYT+8Zt023GVDyv8sVGFK89CML36oN7ESOUAMos4RiwHb
         OahzPwN0Bijv99iO6vm8fV7v5JXnVsdK22KKtzLkU6csS0SiGBXSFgrDEG1SSiwEmj3B
         JLpHRSgCB65QuKKkPoERyv1/zp1rVcw+RjuEZDfKBqGZuYR3EQxwd7BsIw3L+Uta6vuV
         Vx3ud8CSoIkYcnN8IV0sqHrItW1kg4YnAnxSeDdn8dsw6zdmPXimDOKMyJq2kb5pOBa5
         lH3wJ/I/lBjSYWvGmtYUcHPhs8p89ywmWL2ANdBg54ZiYPWpg0C8s2cM5xHYMkLE4/Yd
         Iw0g==
X-Gm-Message-State: AOAM530++yk8coif4tbHGuHvHpyRUwn2qNk1og7SOi0+5De8uL4XzYXR
        0G4DuyZsffv6Dh+WaCqRZZA=
X-Google-Smtp-Source: ABdhPJwi5kemHSSmk3zuYfGYuSIGBaIhEdA3n0Zfwe7jGo6a8HRkfjZ1C/bXvRBITc7K92ViEQX0EQ==
X-Received: by 2002:a63:7f0f:: with SMTP id a15mr9354923pgd.9.1635154526201;
        Mon, 25 Oct 2021 02:35:26 -0700 (PDT)
Received: from nj08008nbu.spreadtrum.com ([240e:47a:878:6a2:e0f0:8dca:6977:afd5])
        by smtp.gmail.com with ESMTPSA id c9sm15446100pgq.58.2021.10.25.02.35.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 02:35:25 -0700 (PDT)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com,
        pony1.wu@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 3/6] dt-bindings: display: add Unisoc's dpu bindings
Date:   Mon, 25 Oct 2021 17:34:15 +0800
Message-Id: <20211025093418.20545-4-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211025093418.20545-1-kevin3.tang@gmail.com>
References: <20211025093418.20545-1-kevin3.tang@gmail.com>
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

