Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B863EEAAF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbhHQKNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbhHQKNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:13:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2843BC061764;
        Tue, 17 Aug 2021 03:12:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b7so30878344edu.3;
        Tue, 17 Aug 2021 03:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NAZ3iHRhwDa0VlHkXe1bEIQ5yvY78DPN6f7/EwPF9pU=;
        b=ERgDuTUBHyA06UX4V6nQdVQ1RRdLdu5ViHA9SN3iAOnoJ5TxnKpVdkMqSihOCl6YOp
         drNLp8Qi1wwNoVXQDPtaCJfXgOCbJt3j8W8kgF9oYNjrfQkgLaHt+pFQKFGsHhBcyLUX
         +I+6ZKBd5xU+2k1v7OlD7pmbrSqUMpmIlSEnN8Wwh3PwAVCFULw5gywPjZLppu8WA7MC
         7XFh+TFhOyjqtYy9hBSW8y5xtqA5/HOHJ0TkeQbj+Th3z/Vdq0sjaCqrGaCr2TSJgVB5
         w684guCIgpwXdTTbpGb7PKj95Q74WEiY6i35HAuloDdkbQh5+f0PdU270Qv8+sI09sHp
         wy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NAZ3iHRhwDa0VlHkXe1bEIQ5yvY78DPN6f7/EwPF9pU=;
        b=TDd5va4Gqj3zX4gpRH6WG5Qqw9X18nlZpryDUAh7uBnB+EnYyB1nS3255WpBhiCAeD
         8pjRpotjEGKLgfejZdo1VRg6PPZIXTOmxSVr1wkJHNDqkkQsLaGX/5f/2VcmKMennQhU
         kMvRsJoQO1y4+N9N4BbEQSZUq2QKs5m3bxQCshFRQT7tvHndWbw7XkDDYIDS/Dem7m0E
         FhssHBRyH3wVutx5+9EqTtCpG5SoHAQERkwqGAl581LFeQauRxyCtZX9wGd+CypOzLqU
         pMEmt3xxf5q0vi84nBQfqzs8vgYXR+WnlZtDdigwfSlI3R6DFORJVP9pmXaLdmGbgX02
         l7YA==
X-Gm-Message-State: AOAM530ithy6ztfaDD34alooYap7QACZSXm50OjAVRprTId82Jt3w+AT
        Dmu74ufLhlnVfB6FG5+IvSI=
X-Google-Smtp-Source: ABdhPJxYz8f+mVFJRA/q2G+Cscc5uGswKuR6xxueeR30RVFhGSloF2s+aA6GlfdsmJfDhSZfrhgzeA==
X-Received: by 2002:a05:6402:b7a:: with SMTP id cb26mr3297856edb.33.1629195151747;
        Tue, 17 Aug 2021 03:12:31 -0700 (PDT)
Received: from localhost.localdomain ([185.213.155.232])
        by smtp.gmail.com with ESMTPSA id m6sm822920edq.22.2021.08.17.03.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 03:12:31 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
Date:   Tue, 17 Aug 2021 12:11:17 +0200
Message-Id: <20210817101119.423853-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817101119.423853-1-frattaroli.nicolas@gmail.com>
References: <20210817101119.423853-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the YAML bindings for the Rockchip I2S/TDM audio driver.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 .../bindings/sound/rockchip,i2s-tdm.yaml      | 221 ++++++++++++++++++
 include/dt-bindings/sound/rockchip,i2s-tdm.h  |   9 +
 2 files changed, 230 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
 create mode 100644 include/dt-bindings/sound/rockchip,i2s-tdm.h

diff --git a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
new file mode 100644
index 000000000000..c3022620b47f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
@@ -0,0 +1,221 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/rockchip,i2s-tdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip I2S/TDM Controller
+
+description:
+  The Rockchip I2S/TDM Controller is a Time Division Multiplexed
+  audio interface found in various Rockchip SoCs, allowing up
+  to 8 channels of audio over a serial interface.
+
+maintainers:
+  - Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,px30-i2s-tdm
+      - rockchip,rk1808-i2s-tdm
+      - rockchip,rk3308-i2s-tdm
+      - rockchip,rk3568-i2s-tdm
+      - rockchip,rv1126-i2s-tdm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    minItems: 1
+    maxItems: 2
+
+  dma-names:
+    oneOf:
+      - const: rx
+      - items:
+          - const: tx
+          - const: rx
+
+  clocks:
+    items:
+      - description: clock for TX
+      - description: clock for RX
+      - description: clock for I2S bus
+
+  clock-names:
+    items:
+      - const: mclk_tx
+      - const: mclk_rx
+      - const: hclk
+
+  rockchip,frame-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 64
+    minimum: 32
+    maximum: 512
+    description:
+      Width of a frame, usually slot width multiplied by number of slots.
+      Must be even.
+
+  resets:
+    items:
+      - description: reset for TX
+      - description: reset for RX
+
+  reset-names:
+    items:
+      - const: tx-m
+      - const: rx-m
+
+  rockchip,cru:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle of the cru.
+      Required if both playback and capture are used, i.e. if rockchip,clk-trcm
+      is 0.
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle of the syscon node for the GRF register.
+
+  rockchip,mclk-calibrate:
+    description:
+      Enable mclk source calibration.
+    type: boolean
+
+  rockchip,trcm-sync:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Which lrck/bclk clocks each direction will sync to. You should use the
+      constants in <dt-bindings/sound/rockchip,i2s-tdm.h>
+    oneOf:
+      - const: 0
+        description:
+          RK_TRCM_TXRX. Use both the TX and the RX clock for TX and RX.
+      - const: 1
+        description:
+          RK_TRCM_TX. Use only the TX clock for TX and RX.
+      - const: 2
+        description:
+          RK_TRCM_RX. Use only the RX clock for TX and RX.
+
+  "#sound-dai-cells":
+    const: 0
+
+  rockchip,no-dmaengine:
+    description:
+      If present, driver will not register a pcm dmaengine, only the dai.
+      If the dai is part of multi-dais, the property should be present.
+    type: boolean
+
+  rockchip,playback-only:
+    description: Specify that the controller only has playback capability.
+    type: boolean
+
+  rockchip,capture-only:
+    description: Specify that the controller only has capture capability.
+    type: boolean
+
+  rockchip,i2s-rx-route:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines the mapping of I2S RX sdis to I2S data bus lines.
+      By default, they are mapped one-to-one.
+    items:
+      - description: which sdi to connect to data line 0
+      - description: which sdi to connect to data line 1
+      - description: which sdi to connect to data line 2
+      - description: which sdi to connect to data line 3
+
+  rockchip,i2s-tx-route:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines the mapping of I2S TX sdos to I2S data bus lines.
+      By default, they are mapped one-to-one.
+    items:
+      - description: which sdo to connect to data line 0
+      - description: which sdo to connect to data line 1
+      - description: which sdo to connect to data line 2
+      - description: which sdo to connect to data line 3
+
+  rockchip,tdm-fsync-half-frame:
+    description: Whether to use half frame fsync.
+    type: boolean
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - dmas
+  - dma-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - rockchip,grf
+  - "#sound-dai-cells"
+  - rockchip,trcm-sync
+
+allOf:
+  - if:
+      properties:
+        rockchip,clk-trcm:
+          contains:
+            enum: [0]
+    then:
+      required:
+        - rockchip,cru
+
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3568-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/pinctrl/rockchip.h>
+    #include <dt-bindings/sound/rockchip,i2s-tdm.h>
+
+
+    foo {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        i2s@fe410000 {
+            compatible = "rockchip,rk3568-i2s-tdm";
+            reg = <0x0 0xfe410000 0x0 0x1000>;
+            interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cru MCLK_I2S1_8CH_TX>, <&cru MCLK_I2S1_8CH_RX>,
+                     <&cru HCLK_I2S1_8CH>;
+            clock-names = "mclk_tx", "mclk_rx", "hclk";
+            dmas = <&dmac1 2>, <&dmac1 3>;
+            dma-names = "tx", "rx";
+            resets = <&cru SRST_M_I2S1_8CH_TX>, <&cru SRST_M_I2S1_8CH_RX>;
+            reset-names = "tx-m", "rx-m";
+            rockchip,trcm-sync = <RK_TRCM_TX>;
+            rockchip,cru = <&cru>;
+            rockchip,grf = <&grf>;
+            #sound-dai-cells = <0>;
+            pinctrl-names = "default";
+            pinctrl-0 =
+                <&i2s1m0_sclktx
+                &i2s1m0_sclkrx
+                &i2s1m0_lrcktx
+                &i2s1m0_lrckrx
+                &i2s1m0_sdi0
+                &i2s1m0_sdi1
+                &i2s1m0_sdi2
+                &i2s1m0_sdi3
+                &i2s1m0_sdo0
+                &i2s1m0_sdo1
+                &i2s1m0_sdo2
+                &i2s1m0_sdo3>;
+            status = "disabled";
+        };
+    };
diff --git a/include/dt-bindings/sound/rockchip,i2s-tdm.h b/include/dt-bindings/sound/rockchip,i2s-tdm.h
new file mode 100644
index 000000000000..32494d64cf33
--- /dev/null
+++ b/include/dt-bindings/sound/rockchip,i2s-tdm.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DT_BINDINGS_ROCKCHIP_I2S_TDM_H
+#define _DT_BINDINGS_ROCKCHIP_I2S_TDM_H
+
+#define RK_TRCM_TXRX 0
+#define RK_TRCM_TX 1
+#define RK_TRCM_RX 2
+
+#endif /* _DT_BINDINGS_ROCKCHIP_I2S_TDM_H */
-- 
2.32.0

