Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C7941F2DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355122AbhJARS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355237AbhJARSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:18:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66927C061775;
        Fri,  1 Oct 2021 10:16:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id p13so9101635edw.0;
        Fri, 01 Oct 2021 10:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F568Gn3J5GLDHKRAuOyoe7A7OPAzKT6uHqR/DpSNQ4w=;
        b=kq/5FsFYx6VtCFgXvP5Rqc8+/E6ofdSM3PEYJ3dQnlkd4/VV5EvGPIYQVRq1qXNrxw
         HId6bAqus0K8/+Hzaa7rP690o1U/YjZnMP1+/zFQ5Rrr2m+9pTuyrqKbHgqVXUz05Sxn
         qZSfL2g4GdHAWEJbGVbsJMHaouZJd5KOmj2nEsO4LiQIPXc/PHx6Ji5xeFW5K0fEsfOA
         CAEI62wVkKEUmgFD90Xt5wzPhKds7DLtRRHbRzksx9xtw+WakMH/EESC1hahO4PlCj64
         aHuVnL0J+Ncn4Cjjr8MYBZwCD95UVMX5QhLLenuPY1oiCckiAZYjFme3LnzRdNNBQWTe
         uM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F568Gn3J5GLDHKRAuOyoe7A7OPAzKT6uHqR/DpSNQ4w=;
        b=JZZ4bRUnJNMHc2E5P+i4WdnJfvgN4KAJbfQw+wBl4OutXT6dJs9UzwAZ/zxB7WV5OD
         rn1RGRQQ3WyPoCW9ohSm5+8t7xBHT0GKNzfEvYsSVSR9aBU1Z5FMiefpN3ASZ/tCO1b4
         t7GB5hDWpRWdchaO3odq3c+4sfqjHB4K/kV3OCJPWU0SOLn+rtMjTn4XIF91cp0gqHFQ
         QHmR/WZI6gfOIsjP1tNa1h2BySOcJ6cz8Q9+UR6pv7LOq06Nkac0+hpUHsfU+M2kcBh/
         wGZXPSYqp2PhshlBB5CqFbgfR7kmTZd7VGRzy7KUeZu6ZY3Am1bI4YnWPqKupGBvtryY
         ewBA==
X-Gm-Message-State: AOAM532v0qllQS7ZjW8z1nhIZncSbeh2uV97O11vKJ23qgpRdUdwVX0q
        h1TwRbHQldfLDuAVUMxpmJs=
X-Google-Smtp-Source: ABdhPJwBS9hL/4fjx72VPX/Of7FSh/dpoYePNRX3YUrWyFRjB0HzWh06rapb07sYwezJkTqHA3aC4w==
X-Received: by 2002:a17:906:11d4:: with SMTP id o20mr2776229eja.15.1633108594927;
        Fri, 01 Oct 2021 10:16:34 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id h10sm3588130edf.85.2021.10.01.10.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 10:16:34 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>, linux-rockchip@lists.infradead.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] ASoC: dt-bindings: rockchip: add i2s-tdm bindings
Date:   Fri,  1 Oct 2021 19:15:29 +0200
Message-Id: <20211001171531.178775-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211001171531.178775-1-frattaroli.nicolas@gmail.com>
References: <20211001171531.178775-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the YAML bindings for the Rockchip I2S/TDM audio driver.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/rockchip,i2s-tdm.yaml      | 198 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 199 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml

diff --git a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
new file mode 100644
index 000000000000..dce8b4136ec6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
@@ -0,0 +1,198 @@
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

