Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB2E3EB718
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbhHMOx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240940AbhHMOxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:53:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F48CC061756;
        Fri, 13 Aug 2021 07:53:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id w14so15595321pjh.5;
        Fri, 13 Aug 2021 07:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/nNkUI+dH8AtxQEgxzy9cBX4XHXv2DfxTs/bgyz0Ark=;
        b=WTARyxxJ7QZX8wxUUsNeqmSr2vEUF8pxewCO1yUaBUQZywo9+703bI3aXylRZ8kHwB
         2xyZJshObXvrke6thViLath8/D5d1u6nAWDw2licrPGre1GYNmsvevhowMF0vim+1cXg
         og3vcVASlJxcdRZ+KU4wuqM7rSxsEfhkSF2YlD4PM7OEfla1oTSm6BW+QIOS3pjMtUiP
         u/w9yLx1Ee+lCQOfrGY1c8rbITQqLekxsP3SgAjlU63pI91iu0rcijbnyoPVvUt21s9z
         gjEmFznMCpArMr1OResDwHaYqYSm4f4zAry9f2g0iH8hMYsjWMMMPG2aHr8DnxlZx09C
         0xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nNkUI+dH8AtxQEgxzy9cBX4XHXv2DfxTs/bgyz0Ark=;
        b=h/ZXJuWtS/W5+JURkmPHRVkmT0botapUQpayii/zwA0EnVbB3kwKQT1CQM9YhTQHQ4
         9gxWLHTs0L5bP1dxlXt07YTcMny+SIRuwhxIQ6y5f2WOd4UxC331DvkzLoXqluzO/8p+
         AsdznBfa+MbY81hz1q5DXbV10oM7nJX10cMp8O9A8TaP0GUWnIGuxsfKulDq5oPxXuoI
         Dh+u9TLoc0HufczDkJkZRGW+4GCpxVN5uRzzA8hG6fFpVswvOPj7pGTp5dymgkax/V6R
         cze+nN+qHCx0TOUV3gffsAodzYoAWqnIAlWXMbFEVTWMHrY7sIP0g9iSsSrVKD/+0JWz
         3G/w==
X-Gm-Message-State: AOAM5307BwTvZZKYUcZJXKmD7a50jSfBwlc3ExPaql3aKyBtBjt+1apR
        fhF8dKpdu/Ez1Y5aj+FiAYs=
X-Google-Smtp-Source: ABdhPJyfYSlEql4EsaxPNbDDj27kRY5RZwZYrbwZoz0nlerHGOyYtsRq71pr726En6PR3S1+pVgW9A==
X-Received: by 2002:a17:90a:bb8c:: with SMTP id v12mr2991321pjr.72.1628866407889;
        Fri, 13 Aug 2021 07:53:27 -0700 (PDT)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e12sm2524787pfc.214.2021.08.13.07.53.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 07:53:27 -0700 (PDT)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com,
        pony1.wu@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 5/6] dt-bindings: display: add Unisoc's mipi dsi controller bindings
Date:   Fri, 13 Aug 2021 22:53:01 +0800
Message-Id: <20210813145302.3933-6-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210813145302.3933-1-kevin3.tang@gmail.com>
References: <20210813145302.3933-1-kevin3.tang@gmail.com>
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

