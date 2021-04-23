Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59113689F8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 02:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbhDWAmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 20:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbhDWAlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 20:41:55 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168C1C061574;
        Thu, 22 Apr 2021 17:41:19 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id z25so12602441qtn.8;
        Thu, 22 Apr 2021 17:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nz9im1KWF9d9obNlXKQvHrwAyoo0lwnAxd4M5RbZT60=;
        b=etmDDtNFj4W00UBn+NLSkqnC0XC6Kxb9tgovPv2UXUgLJ6mQ1Ge8xz8MsBt/d586oQ
         B8jf/+i/hnhfAfA8l3d5axXDDDKp4FSEabggCmNXdkEuyK53EjWWjZbbwja90rex8VMd
         N4le7FE7fMdHBSbdYi2bwQJHm8DgOSRFqicJjkIpTwCCur7feXYC3pxabJVbgIi0uwZA
         jAQWi13uW86JyLIYoWjoClT3G5bsrhXn+QINtK1+0qz7cNkBgP3RYtjWPnuOrAMs/XiV
         dPwrXkeX2UiJPumg3fKTcnppu+bGIZRUV4WO3s6KcFiYYU5DJ1MgVk/r5nPFCumFRyrz
         2Asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nz9im1KWF9d9obNlXKQvHrwAyoo0lwnAxd4M5RbZT60=;
        b=kLIVHJnDQsSsm/UWtYe0yop4RnO/3ot2aokEnq4XXkGb3lOE5zOMAwP5QhWkyb4J1G
         wAx1qVUNr3VarJeQeJ0EOklE0jftAi6g51BXpmARTGEx2k6WV2h4/h88lLQuzj18sK+I
         XVpBX0OB6+EX4SWgVWB+8e1yhFZLysr5B/VzhksHmQnDfixlWyJVYztRmZS+GJxYXwXq
         /C+SUOjv5XdI5E/2tY1lN6Zof7vZ7uvHVO6vvDz2ksH29erf8h6aMvkkywpD9yaIGP3c
         sJvtqiwFC1DlvWIQ6OJxxUJ6P6RwSd9BPd0jmGMwq4/+cWsF4lZNM1542yWcEQn3Zqm4
         fo4g==
X-Gm-Message-State: AOAM533r5OV3e/FXQVGETqOREK8MR6LDz1bqurOugtRK4yaGxd3Vnr+g
        EAs4ZfxKQE7Wz0d0CUGzbZw2cSO0fGknEgp4
X-Google-Smtp-Source: ABdhPJwtv7EbGS1vIBMmDab7DnyLwuNNzoM7V7mmrpHCkR2YVmAzIyjr8UJcLZCRh65KSugluehSNA==
X-Received: by 2002:a05:622a:14c9:: with SMTP id u9mr1179594qtx.313.1619138478326;
        Thu, 22 Apr 2021 17:41:18 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n15sm3241586qkk.109.2021.04.22.17.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 17:41:17 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, mturquette@baylibre.com, sboyd@kernel.org
Cc:     julia.lawall@inria.fr, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: [PATCH v5 3/3] dt-bindings: clock: add ti,lmk04832 bindings
Date:   Thu, 22 Apr 2021 20:40:57 -0400
Message-Id: <20210423004057.283926-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210423004057.283926-1-liambeguin@gmail.com>
References: <20210423004057.283926-1-liambeguin@gmail.com>
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
index 000000000000..bd8173848253
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
+    maximum: 5000000
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
+    additionalProperties: false
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

