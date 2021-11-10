Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B8244C1E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 14:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhKJNJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 08:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhKJNJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 08:09:25 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE87C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 05:06:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t30so3882563wra.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 05:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cA5Bx+I+AGs2RfGY4hpgrqrPI8r6zTFIuO5ZwQf2Zak=;
        b=fdGqVZ8C9sj0YrVbLfS4xU1lFVmL0RgzIYcDRVdbsvtXLOI0qdM91nPNn/4pf9sSVK
         Fzt5m+d8l8EJw7GX5O995sZcKmqcEJOikc/+kZG7NAfA2NBmvJiE5XOl84xdkJJFI850
         WY5O+AptZj/+SufH1qlSGqJsrrAA2VXi5pZGezYvUw9sNtXWSoZr0nmc2RzIWKD5BlZ2
         eXw9gJ+D75YZ6P5Rsry9eXEZ0gsb6KCKLNIqJF/F3RhnJU73/a9M5wjsf1jWS6368RLZ
         +WgeKT9olnJGVQxYYZ5HhkoDQvMa0c1SKYM3d5h/7pB/Dte1ftxMhzgMVEOn3R3R+Ssd
         CDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cA5Bx+I+AGs2RfGY4hpgrqrPI8r6zTFIuO5ZwQf2Zak=;
        b=GtpeugB6Yc3gBTvIQxeSEirTjCqZP7vmtXc/RGRrzdZH2LiBhdHsauFvFiYjbxTUEC
         dWu60hsZDya7Hb9KXFdYSmuDTNvsZWxdalTiW4pPMjKEzRaXNtDdM2pClL8oWZYoAUTx
         7SyKdLw9Wm2q71g5XHmOm4AdmgWOvtntRgEopAbiWyXHVLtdI5s3OPVTpreajFQ5BkHV
         SwH/wR+xcRvPxUTDeoi69Ke1wVVfyruhG0MI/5LbzAZO+iwR5zbqlLWlwGylT54V+GCR
         XWKRD7XA0CNWB0aB5QGcq2SsIvOUiLce+wSuvu6yj4shh+DVtDOSUv+n/PqAqCTJOoV3
         UDaQ==
X-Gm-Message-State: AOAM532t1HIQdPWkRXTWVUKWi945eFD4pDcnV/UPQkA2eeAukxrVzskw
        FdPbZY0ek8f0ol5KYpwBCwHOSw==
X-Google-Smtp-Source: ABdhPJwXoWWM9ZafT/EZtRONxNpg+gfpTPXDrROqPVfAAiWeoayF8ip582addgnnS/1foYtrAwzV5w==
X-Received: by 2002:adf:d0c2:: with SMTP id z2mr19270769wrh.330.1636549595402;
        Wed, 10 Nov 2021 05:06:35 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-656-1-151-143.w92-154.abo.wanadoo.fr. [92.154.18.143])
        by smtp.gmail.com with ESMTPSA id i17sm5952175wmq.48.2021.11.10.05.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 05:06:34 -0800 (PST)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 2/7] dt-bindings: mediatek,dp: Add Display Port binding
Date:   Wed, 10 Nov 2021 14:06:18 +0100
Message-Id: <20211110130623.20553-3-granquet@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211110130623.20553-1-granquet@baylibre.com>
References: <20211110130623.20553-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Schneider-Pargmann <msp@baylibre.com>

This controller is present on several mediatek hardware. Currently
mt8195 and mt8395 have this controller without a functional difference,
so only one compatible field is added.

The controller can have two forms, as a normal display port and as an
embedded display port.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/mediatek/mediatek,dp.yaml         | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
new file mode 100644
index 0000000000000..068b11d766e21
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Display Port Controller
+
+maintainers:
+  - CK Hu <ck.hu@mediatek.com>
+  - Jitao shi <jitao.shi@mediatek.com>
+
+description: |
+  Device tree bindings for the Mediatek (embedded) Display Port controller
+  present on some Mediatek SoCs.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-dp-tx
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: faxi clock
+
+  clock-names:
+    items:
+      - const: faxi
+
+  power-domains:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Input endpoint of the controller, usually dp_intf
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Output endpoint of the controller
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/mt8195-power.h>
+    edp_tx: edp_tx@1c500000 {
+        compatible = "mediatek,mt8195-dp-tx";
+        reg = <0 0x1c500000 0 0x8000>;
+        interrupts = <GIC_SPI 676 IRQ_TYPE_LEVEL_HIGH 0>;
+        power-domains = <&spm MT8195_POWER_DOMAIN_EPD_TX>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&edp_pin>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                edp_in: endpoint {
+                    remote-endpoint = <&dp_intf0_out>;
+                };
+            };
+            port@1 {
+                reg = <1>;
+                edp_out: endpoint {
+                	remote-endpoint = <&panel_in>;
+                };
+            };
+        };
+    };
-- 
2.32.0

