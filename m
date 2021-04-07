Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780D6356081
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 02:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347624AbhDGAyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 20:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347611AbhDGAyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 20:54:01 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C00C061756;
        Tue,  6 Apr 2021 17:53:52 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id v70so17067598qkb.8;
        Tue, 06 Apr 2021 17:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uqirrx4SPmJmI/2P13aaHk5XOPHnCkFm9Zu8TIQzgnA=;
        b=dDmpGeOFyQuHHTjpOP+0Nn6fSqB1Hh2Zw64Iif+etLDWTpLZ3Zo40EeQNKCcCqhmOi
         zZRllMrbqkjsa8dnFKErkcyZH4w63SBPLSnO1RrVmyCeyMWoAVZhwpirP0xDFJMmWjGP
         DtdJedLbxPwMXaR0ZbZexrcgj6j9yei03bybM7TK3Au6qyefOQQpaSqwPBmQk6jIOkGh
         P5BgSZsoUc5pdvwmoWO9SmycoZFLhaDJ4Kc2RCB1b8+jwaoEE5komAWIuftBKW/gECC1
         FtGfTI735lPTogFwGlz4Lm4YseBOuejV60j4z2sQqEICQ7X6x0P4C7T+YUT2O+LVC5Ad
         EX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uqirrx4SPmJmI/2P13aaHk5XOPHnCkFm9Zu8TIQzgnA=;
        b=WRtEU8WGPATfcMj7ho08CvLzfmFpbq9Q3/JdtvRl742EOTRy+7cFIC6kE9YM80r1+Z
         QKedujVeQi4/MSNfFbDC36VyLfSgmexa1EmqIBgipX6aS3EXOpKBbBW1/SG1AiETEVc6
         mWsbAMfuHvZ7XJdE4WBuVK6ze2/CW6KI3qvsuIVd6xeZj+CkJuCHKnY3T+559aL679/T
         z6XoU6jbUlmCHCeIgh9fLDjyKYKjWh/lDqJGLn44qRWb2+JDyd37/qDTt1aNgTqeA80T
         kXPJ+/UThQ8TtPmqAL6fnKFB4Py32wB+iaddf+TWUGYJTUwxIfhbYvvLgvOORmYjz+yC
         iN8g==
X-Gm-Message-State: AOAM533zVuh/w9Rp0mgno3KGE8T5WSb3umQfjwwH2jSKBuFG5qKb6IFX
        N3jCfZIlynYU7zdoF3ocbVUcaDjneeE3JHiX
X-Google-Smtp-Source: ABdhPJzzGGfCp5SmXl5L4JcSIjQX1k2NWRxgxwQHC57ehhICYcRxhLTPTKhsHVjQltqTSceS7ojrjA==
X-Received: by 2002:a37:ad0a:: with SMTP id f10mr709314qkm.384.1617756832136;
        Tue, 06 Apr 2021 17:53:52 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l9sm15776728qtv.65.2021.04.06.17.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 17:53:51 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 3/3] dt-bindings: clock: add ti,lmk04832 bindings
Date:   Tue,  6 Apr 2021 20:53:30 -0400
Message-Id: <20210407005330.2890430-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210407005330.2890430-1-liambeguin@gmail.com>
References: <20210407005330.2890430-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Document devicetree bindings for Texas Instruments' LMK04832.
The LMK04208 is a high performance clock conditioner with superior clock
jitter cleaning, generation, and distribution with JEDEC JESD204B
support.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 .../bindings/clock/ti,lmk04832.yaml           | 209 ++++++++++++++++++
 1 file changed, 209 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,lmk04832.yaml

diff --git a/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml b/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
new file mode 100644
index 000000000000..a9f8b9b720fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
@@ -0,0 +1,209 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/ti,lmk04832.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for the Texas Instruments LMK04832
+
+maintainers:
+  - Liam Beguin <liambeguin@gmail.com>
+
+description: |
+  Devicetree binding for the LMK04832, a clock conditioner with JEDEC JESD204B
+  support. The LMK04832 is pin compatible with the LMK0482x family.
+
+  Link to datasheet, https://www.ti.com/lit/ds/symlink/lmk04832.pdf
+
+properties:
+  compatible:
+    enum:
+      - ti,lmk04832
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  '#clock-cells':
+    const: 1
+
+  spi-max-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Maximum SPI clocking speed of the device in Hz.
+
+  clocks:
+    items:
+      - description: PLL2 reference clock.
+
+  clock-names:
+    items:
+      - const: oscin
+
+  reset-gpios:
+    maxItems: 1
+
+  ti,spi-4wire-rdbk:
+    description: |
+      Select SPI 4wire readback pin configuration.
+      Available readback pins are,
+        CLKin_SEL0 0
+        CLKin_SEL1 1
+        RESET 2
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    default: 1
+
+  ti,vco-hz:
+    description: Optional to set VCO frequency of the PLL in Hertz.
+
+  ti,sysref-ddly:
+    description: SYSREF digital delay value.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 8
+    maximum: 8191
+    default: 8
+
+  ti,sysref-mux:
+    description: |
+      SYSREF Mux configuration.
+      Available options are,
+        Normal SYNC 0
+        Re-clocked 1
+        SYSREF Pulser 2
+        SYSREF Continuous 3
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 3
+
+  ti,sync-mode:
+    description: SYNC pin configuration.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    default: 1
+
+  ti,sysref-pulse-count:
+    description:
+      Number of SYSREF pulses to send when SYSREF is not in continuous mode.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8]
+    default: 4
+
+patternProperties:
+  "@[0-9a-d]+$":
+    type: object
+    description:
+      Child nodes used to configure output clocks.
+
+    properties:
+      reg:
+        description:
+          clock output identifier.
+        minimum: 0
+        maximum: 13
+
+      ti,clkout-fmt:
+        description:
+          Clock output format.
+          Available options are,
+            Powerdown 0x00
+            LVDS 0x01
+            HSDS 6 mA 0x02
+            HSDS 8 mA 0x03
+            LVPECL 1600 mV 0x04
+            LVPECL 2000 mV 0x05
+            LCPECL 0x06
+            CML 16 mA 0x07
+            CML 24 mA 0x08
+            CML 32 mA 0x09
+            CMOS (Off/Inverted) 0x0a
+            CMOS (Normal/Off) 0x0b
+            CMOS (Inverted/Inverted) 0x0c
+            CMOS (Inverted/Normal) 0x0d
+            CMOS (Normal/Inverted) 0x0e
+            CMOS (Normal/Normal) 0x0f
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 15
+
+      ti,clkout-sysref:
+        description:
+          Select SYSREF clock path for output clock.
+        type: boolean
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    clocks {
+        lmk04832_oscin: oscin {
+            compatible = "fixed-clock";
+
+            #clock-cells = <0>;
+            clock-frequency = <122880000>;
+            clock-output-names = "lmk04832-oscin";
+        };
+    };
+
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        lmk04832: clock-controller@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            reg = <0>;
+
+            compatible = "ti,lmk04832";
+            spi-max-frequency = <781250>;
+
+            reset-gpios = <&gpio_lmk 0 0 0>;
+
+            #clock-cells = <1>;
+            clocks = <&lmk04832_oscin>;
+            clock-names = "oscin";
+
+            ti,spi-4wire-rdbk = <0>;
+            ti,vco-hz = <2457600000>;
+
+            assigned-clocks =
+                <&lmk04832 0>, <&lmk04832 1>,
+                <&lmk04832 2>, <&lmk04832 3>,
+                <&lmk04832 4>,
+                <&lmk04832 6>, <&lmk04832 7>,
+                <&lmk04832 10>, <&lmk04832 11>;
+            assigned-clock-rates =
+                <122880000>, <384000>,
+                <122880000>, <384000>,
+                <122880000>,
+                <153600000>, <384000>,
+                <614400000>, <384000>;
+
+            clkout0@0 {
+                reg = <0>;
+                ti,clkout-fmt = <0x01>; // LVDS
+            };
+
+            clkout1@1 {
+                reg = <1>;
+                ti,clkout-fmt = <0x01>; // LVDS
+                ti,clkout-sysref;
+            };
+        };
+    };
-- 
2.30.1.489.g328c10930387

