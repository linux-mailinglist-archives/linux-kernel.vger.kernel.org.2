Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECF13FA626
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 16:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhH1OD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 10:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbhH1ODY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 10:03:24 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231E5C061756;
        Sat, 28 Aug 2021 07:02:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id dm15so14262484edb.10;
        Sat, 28 Aug 2021 07:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/HwvasmqWTeaBN7HIdpoZgoqAcwnUTfnLYi+w6FCWyc=;
        b=LiBbEEI49LqvFweuIGCWs+mxPZLxlpGk4gcL0Lt0mj4+xLGCzNBhqO90Mn2sp8O8dE
         B3562wA0y0ddaoqc7nLkEVE3g0xTz144MhYgfApp6QIJf9Nm8rjEe75W1YsFgNoOfhKm
         ti85tkUk6+1C6ADu1F19urVsrUm11rV6B0gXy54XtW5MSnsgXaXPVaycRMv+WO4hU4I7
         d3UzCpcKbYZ3jXiMWUlzijoA7r0UYOki8CVX+4VOqZnBRwlPvYoSvUksNCejfVvavAKP
         +XpdeTSSPXDOZxJ59kvNoUSWsh/SfKemLX0VixN10GKYzhitxU+jbXlWvPrYo5B2pX73
         hZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/HwvasmqWTeaBN7HIdpoZgoqAcwnUTfnLYi+w6FCWyc=;
        b=hvVOv7LOmexnorknZp649rERnyBMlhFstJWpQv12gA4J2S3tSt1f2CnWQ4Jv0LB7xn
         jgoiP+AEKidp3EqvGd+8cy+aPqKVWudLHyq9qQ5hKBEEW9kPjS/Lxxpi7OWT9DdK8V3a
         PBDqToq9ssEMpGxZZzcqNorQ8/KbGGcjoU0VvlmwG+5Xd14aPhTpJ3x58Ta8Pt9WEJ1c
         +CBjubD3y2qi53p4HXmSD18cyy1iK5PgErvoSCAB0ychNL/9wwLtmFLqQh7QPbgP0EDd
         u8hMDzj9TVcRjRIjvWBxqxpQmbodzs10sweWZxjeoPnX7ssHpM3b8dAGhH+zOJPg4st8
         XIsA==
X-Gm-Message-State: AOAM533O7uhlnhneS4W+WhAkpH6ANoy7xVg1qT22Ymczb8LNC/x3wP2T
        qGWvtayR1tJzbBY0DfrGCes=
X-Google-Smtp-Source: ABdhPJzH3S+Y3NHfuXZM5Ir87DyKg2zfCCWNg5KaxMNUIgRuMqbXx3RlYDhall/te3ioSxFZCUUVSQ==
X-Received: by 2002:a50:eb95:: with SMTP id y21mr3138318edr.139.1630159352639;
        Sat, 28 Aug 2021 07:02:32 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id cn16sm4953982edb.87.2021.08.28.07.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 07:02:32 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
Date:   Sat, 28 Aug 2021 16:02:02 +0200
Message-Id: <20210828140205.21973-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210828140205.21973-1-frattaroli.nicolas@gmail.com>
References: <20210828140205.21973-1-frattaroli.nicolas@gmail.com>
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
index 000000000000..ab8731779805
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
+    items:
+      - description: which sdi to connect to data line 0
+      - description: which sdi to connect to data line 1
+      - description: which sdi to connect to data line 2
+      - description: which sdi to connect to data line 3
+
+  rockchip,i2s-tx-route:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
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
+            status = "okay";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 5d459d42672c..d2be16a85009 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16053,6 +16053,7 @@ ROCKCHIP I2S TDM DRIVER
 M:	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
 L:	linux-rockchip@lists.infradead.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
 F:	sound/soc/rockchip/rockchip_i2s_tdm.*
 
 ROCKCHIP ISP V1 DRIVER
-- 
2.33.0

