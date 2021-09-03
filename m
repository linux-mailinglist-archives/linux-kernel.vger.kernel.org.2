Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D82040082F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 01:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350712AbhICXR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 19:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350682AbhICXR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 19:17:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28523C061575;
        Fri,  3 Sep 2021 16:16:26 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i21so1110558ejd.2;
        Fri, 03 Sep 2021 16:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WulM8eNZLKuhXd9mwLv6uv8mQIKAxy1IdRr6VBOr1Kk=;
        b=HRyoltkQE2kR7ok3YNyUWSE6CzYaPHIzcQLv5FhlG9ZEZ5RO1XF2JP77A/uPRiIDuj
         kSKz/3r8bCoeZ9WxTAUVubbliW3KpkQJMrn3ATaJQHlOq46JoR+UY1rD1aGtoxMmMBs7
         hixD+J56qx77up94p129uWMn0olP0gEnvK8PuVKUtO2Kxzdw3gPZZeefHjaAFH9TWN84
         426KZcs7StgtYjJ8pT9obKwWp+cUW4lTjVXR5SduyowZ90a7vwoR/Jxu5A6/6PffcEn4
         Ctp3INlgWuUHq9Q7i/H37DgnQLP9mB8HzibboZZiCGhguPYMJoEsblyGFoCGmfMDh+sU
         QbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WulM8eNZLKuhXd9mwLv6uv8mQIKAxy1IdRr6VBOr1Kk=;
        b=JXHpnCGnnroQlJm/ZkSvEH+IsLBIjckDHXLH6+u3T5KuwxZK9k044rr3YXfa/0a5cw
         +6JO0uISkdfLAtv/q+qjjqON1all5g0NlOufbs6yEjswXM/0STaqr0EY3SpUMTLSr14e
         hnlHLqfzKGa/HcII/W65mVCxi7fSc+1QBoGZIMOYP5Pca2XhNPS7gILf9wunY9MWfMlk
         Ydoi+86LAb8lSqVrC9ZHcoaindvUJiEnhPh0uGpepAh8xD/dtNRn6aqDq8ZdRWx/WKRt
         bFasigXSnRhb8oQU3vkz5JiUrbJEe5qF2Vl4cmqFKoOB2knswwK25pi4jlImr22WUrSF
         igSQ==
X-Gm-Message-State: AOAM531cQRIUCSZ1VlDMwHD6cIqeG9lVPiWdlvirby6plBIm1xkdMrxB
        DPa45y+sakljiMzMHUg8j/I=
X-Google-Smtp-Source: ABdhPJxRtF+Ffonlcf/y5Q7y3zU3TGFtsTmn3HdmITAmk5DJQr6Z6GW3yCmOKYcrcBwlxK8mxke8QA==
X-Received: by 2002:a17:907:77c5:: with SMTP id kz5mr1311529ejc.175.1630710984713;
        Fri, 03 Sep 2021 16:16:24 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id r11sm214068ejy.71.2021.09.03.16.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 16:16:24 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
Date:   Sat,  4 Sep 2021 01:15:34 +0200
Message-Id: <20210903231536.225540-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903231536.225540-1-frattaroli.nicolas@gmail.com>
References: <20210903231536.225540-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the YAML bindings for the Rockchip I2S/TDM audio driver.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 .../bindings/sound/rockchip,i2s-tdm.yaml      | 218 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 219 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml

diff --git a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
new file mode 100644
index 000000000000..a04267ccb0f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
@@ -0,0 +1,218 @@
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
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - rx
+        - tx
+
+  clocks:
+    minItems: 3
+    items:
+      - description: clock for TX
+      - description: clock for RX
+      - description: AHB clock driving the interface
+      - description:
+          Parent clock for mclk_tx (only required when using mclk-calibrate)
+      - description:
+          Parent clock for mclk_rx (only required when using mclk-calibrate)
+      - description:
+          Clock for sample rates that are an integer multiple of 8000
+          (only required when using mclk-calibrate)
+      - description:
+          Clock for sample rates that are an integer multiple of 11025
+          (only required when using mclk-calibrate)
+
+  clock-names:
+    minItems: 3
+    items:
+      - const: mclk_tx
+      - const: mclk_rx
+      - const: hclk
+      - const: mclk_tx_src
+      - const: mclk_rx_src
+      - const: mclk_root0
+      - const: mclk_root1
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
+    minItems: 1
+    maxItems: 2
+    description: resets for the tx and rx directions
+
+  reset-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - tx-m
+        - rx-m
+
+  rockchip,cru:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle of the cru.
+      Required if neither trcm-sync-tx-only nor trcm-sync-rx-only are specified.
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle of the syscon node for the GRF register.
+
+  rockchip,mclk-calibrate:
+    description:
+      Switch between two root clocks depending on the audio sample rate.
+      For integer multiples of 8000 (e.g. 48000 Hz), mclk_root0 is used.
+      For integer multiples of 11025 (e.g. 44100 Hz), mclk_root1 is used.
+    type: boolean
+
+  rockchip,trcm-sync-tx-only:
+    type: boolean
+    description: Use TX BCLK/LRCK for both TX and RX.
+
+  rockchip,trcm-sync-rx-only:
+    type: boolean
+    description: Use RX BCLK/LRCK for both TX and RX.
+
+  "#sound-dai-cells":
+    const: 0
+
+  rockchip,i2s-rx-route:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Defines the mapping of I2S RX sdis to I2S data bus lines.
+      By default, they are mapped one-to-one.
+      rockchip,i2s-rx-route = <3> would mean sdi3 is receiving from data0.
+    maxItems: 4
+    items:
+      - enum: [0, 1, 2, 3]
+
+  rockchip,i2s-tx-route:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Defines the mapping of I2S TX sdos to I2S data bus lines.
+      By default, they are mapped one-to-one.
+      rockchip,i2s-tx-route = <3> would mean sdo3 is sending to data0.
+    maxItems: 4
+    items:
+      - enum: [0, 1, 2, 3]
+
+  rockchip,tdm-fsync-half-frame:
+    description: Whether to use half frame fsync.
+    type: boolean
+
+  rockchip,io-multiplex:
+    description:
+      Specify that the GPIO lines on the I2S bus are multiplexed such that
+      the direction (input/output) needs to be dynamically adjusted.
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
+
+allOf:
+  - if:
+      properties:
+        rockchip,trcm-sync-tx-only: false
+        rockchip,trcm-sync-rx-only: false
+    then:
+      required:
+        - rockchip,cru
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3568-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/pinctrl/rockchip.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        i2s@fe410000 {
+            compatible = "rockchip,rk3568-i2s-tdm";
+            reg = <0x0 0xfe410000 0x0 0x1000>;
+            interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cru MCLK_I2S1_8CH_TX>, <&cru MCLK_I2S1_8CH_RX>,
+                     <&cru HCLK_I2S1_8CH>;
+            clock-names = "mclk_tx", "mclk_rx", "hclk";
+            dmas = <&dmac1 3>, <&dmac1 2>;
+            dma-names = "rx", "tx";
+            resets = <&cru SRST_M_I2S1_8CH_TX>, <&cru SRST_M_I2S1_8CH_RX>;
+            reset-names = "tx-m", "rx-m";
+            rockchip,trcm-sync-tx-only;
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
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 106d448e660d..e2cc0357e2b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16119,6 +16119,7 @@ ROCKCHIP I2S TDM DRIVER
 M:	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
 L:	linux-rockchip@lists.infradead.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
 F:	sound/soc/rockchip/rockchip_i2s_tdm.*
 
 ROCKCHIP ISP V1 DRIVER
-- 
2.33.0

