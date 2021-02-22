Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496DC3219E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhBVOM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhBVN32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:29:28 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0910C061797;
        Mon, 22 Feb 2021 05:28:47 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id e9so9061051pjj.0;
        Mon, 22 Feb 2021 05:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UtmQmD63MumL54aGIHWxpTmuXa3kxeJzRTqHsLYTlYE=;
        b=iJsfWsyz7wlcbH0X1BIRSYuxCTSl568M1VZujAlJHLUVJL9ynxFhXctE1nZJ8ZxEyH
         6alPaIoaCKBEpIfWAZn5SUoNJMvEuA0kwsrg2DxkqSrYBOxhEyKZVxO/9gPstRLY95gE
         wPcLZcQejJ9Eza1G0CGugrn429/UXWEHYt+yDxzEVy4UtYX/zq3lGdQZNoVB0iooqJvf
         QFJUlb+2sdaRwalPsop4jaTgH+UCVADeFDBPBsWs9ahBF6hoArbUfulBEkF8NH6ZVfOy
         ImgdI1rdCpQyUrcqE7E7ELSn7uo0tzrZaYZxrDqRVGY3CJMp4bdYi/oqkkFnzY7FpBWh
         9vkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UtmQmD63MumL54aGIHWxpTmuXa3kxeJzRTqHsLYTlYE=;
        b=IxusyI3X+6S0m1jMpA5ElOYVCRaYpYcRpd30x5gD14zpdapYjIC1vthf6JuW1bFWCg
         laR23CjEDvWPdnDsyblZ1kJ36PiYOwxRmktEdEX9Omtb+Rp00oChLQ71frQIrQfWgfTE
         Qn5fiigqiyTMd+Xs3C0bzi0GKrJItOwKK5Db/eKBC073CIHFrQ+kkIp12agId9HfelJf
         ccQOu8TT66MJmfX2COVxnXDrjRdLaE2mk+gV4dYTC5VdAD2k179vMiDUQVyEKdJp9evU
         nJakHueOoyln3UEMOUWX/K+js6qceX/jsB5jOtFm7r7nYcPHR6lSkDnDYERe7u2s6DJu
         2hRw==
X-Gm-Message-State: AOAM532hnxtpGjU973g0ODi27B2EL5ubQAG9HU6ACP0w0eHbEMeFYqlU
        kXUOPlVa5s1MXkBw4VsE+80=
X-Google-Smtp-Source: ABdhPJze9EAVEIFrwSg4I7G7upPd9XoZFdOmrn+TGNI5iU0dU+fbOJI9vPPQqsoU0S2dQxVh5hlyEQ==
X-Received: by 2002:a17:902:8643:b029:da:d5f9:28f6 with SMTP id y3-20020a1709028643b02900dad5f928f6mr15047211plt.8.1614000527434;
        Mon, 22 Feb 2021 05:28:47 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 141sm19585334pfa.65.2021.02.22.05.28.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2021 05:28:47 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 5/6] dt-bindings: display: add Unisoc's mipi dsi controller bindings
Date:   Mon, 22 Feb 2021 21:28:21 +0800
Message-Id: <20210222132822.7830-6-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210222132822.7830-1-kevin3.tang@gmail.com>
References: <20210222132822.7830-1-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

Adds MIPI DSI Controller
support for Unisoc's display subsystem.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/sprd/sprd,sharkl3-dsi-host.yaml   | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
new file mode 100644
index 000000000..d439f688f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
@@ -0,0 +1,102 @@
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
+      port@1:
+        type: object
+        description:
+          A port node with endpoint definitions as defined in
+          Documentation/devicetree/bindings/media/video-interfaces.txt.
+          That port should be the output endpoint, usually output to
+          the associated panel.
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+      - port@0
+      - port@1
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
+            port@1 {
+                reg = <1>;
+                dsi_out: endpoint {
+                    remote-endpoint = <&panel_in>;
+                };
+            };
+        };
+    };
-- 
2.29.0

