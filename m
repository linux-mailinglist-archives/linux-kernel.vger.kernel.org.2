Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430E73235C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 03:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhBXCdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 21:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhBXCcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 21:32:08 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF77C06178C;
        Tue, 23 Feb 2021 18:31:28 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id b14so901546qkk.0;
        Tue, 23 Feb 2021 18:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MuMjbMprp+Bw9LEw8td5Yoyyayc1sM1whmj4n8ou/d0=;
        b=mDLKBUTM6IqATV8ghXEmhfNtSsXxXZwm6/zwoxNMrEmGPLG9qu1CFo6cQo1u7UZu6r
         QAJD48/Kb4RBef7UZZ2EAnCP7ADdKOpDJTN4KZGKo4PBm9BzvDsDLUdobsVh2pVzufxQ
         sEjyR9dufngzn+kohxmZGRy1bqhtZuKrdQpb2ddxIdmDpZpfhOQt3ZqaRHcDR5Z+NJ2x
         NSYMtwZYodxHkSfmBn/d/OqVqKhnsmu6D6sQHau1QtxdTbS/ClfylPkjldSvziHhQ40F
         hmU1lKyCndqFS/7O9wXlkMboh+8O2fx9MzaZ5uBOhGUgRsnPKzoZEL7jd+HdKehb9SuX
         v/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MuMjbMprp+Bw9LEw8td5Yoyyayc1sM1whmj4n8ou/d0=;
        b=lHEf6o67cgQlCDrO+3Q1+wxVEq9ylzAX+JbSjQCKYXR8jY7AHJ5bUKuPUyCdAQCPdJ
         e2RO5auJY+u9lyVnBkA5y56lt33meRYTFGn8LE7jddSGiou5r+MfR6oVQIiAWHrRNNDL
         zN/xOPyIRgFK+OYFae/BUuLDx5gGQtiULLNQxD27eRFBER0YkXpNHm4UeAgopdnSz62e
         kUmgGko8iNKkDWoM+JDTMTMfDfYQTpdv/920SBXnOpbGu7jpOw73Y9Mke2E/wgTkkanJ
         wtod9uCVoMXnX+Pq4WboKgrFF4njVjfwu/COQQH5DOQzkinCKKd88IBE64MsSQ1GVuhh
         9HcA==
X-Gm-Message-State: AOAM533OqWYMEqZaVBfdGy0YEpp8ROf2kxoWuDKV73e0RxcdWrAt04Wk
        M4/rTyButfNbBWS9X8unIX4=
X-Google-Smtp-Source: ABdhPJyQx+CwbLw26Hx2gJtARm+DbBue/6az9wFFP2tytXsMv1Ey7wVAvJy4aSnRbwLsahKhrPyB9w==
X-Received: by 2002:a37:7747:: with SMTP id s68mr3970523qkc.198.1614133887235;
        Tue, 23 Feb 2021 18:31:27 -0800 (PST)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id p25sm529500qkh.79.2021.02.23.18.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 18:31:26 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 3/3] dt-bindings: clock: add ti,lmk04832 bindings
Date:   Tue, 23 Feb 2021 21:31:16 -0500
Message-Id: <20210224023116.571718-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210224023116.571718-1-liambeguin@gmail.com>
References: <20210224023116.571718-1-liambeguin@gmail.com>
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
 .../bindings/clock/ti,lmk04832.yaml           | 198 ++++++++++++++++++
 1 file changed, 198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,lmk04832.yaml

diff --git a/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml b/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
new file mode 100644
index 000000000000..c0d9ab650e80
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
@@ -0,0 +1,198 @@
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
+  '#clock-cells':
+    const: 1
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

