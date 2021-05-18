Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5157387BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244194AbhEROy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbhEROyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:54:55 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3D3C061756
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:53:36 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id v8so9605635lft.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9BrS57AFtqSjxIH0E9ojUZbMm+idOxPAdJsxmeQ9Pw=;
        b=uqpoeGj6CkbjWt5Ld+DDTa4vIiGfeyMUmcMrKx5iqvz7ErAKyQ1ER1HqucNZJlv6Yz
         IVvYSi6zcqTNJG7DEK818lqv+1M7/HBjfppXMXZoAIzhwBRclNNDMrK6Y8qvZ/W+Ym3Q
         +9QdRi7PaRUay/u9A1swutfoeSd5aNJdmEfLXXFFBCGsBtFwOd8vqEmgf9iI2jAuFRZk
         M8rgp1ABthgjOp8TpCaJ+zfaeu8l0uYdaPmm7Ivd61JzKSSbxlRi943YnTYorzMsibSy
         e6VHV9X9HQz0FoFCQFiSwXBQ8Pa++hq/73kuJCRfLZOKa2AjMU4RYgN7Hurw7Nb7fZwK
         EQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9BrS57AFtqSjxIH0E9ojUZbMm+idOxPAdJsxmeQ9Pw=;
        b=Wz7mMuRvi/0uqjDNU25J0eCtTn6Gu1VhZcSwZEE4uxLVoO7xYx0cfVQk8lB5CJA8i/
         UMsjAsNzIXk4jEYNCQLobyN9n/ORGPLyZQLTlvS4NCHLW7BRcTU7E+VEepXAb7M7Bm5s
         gV67vtnhi4EE6ByurjhKces9fWVa3lZQ6HcOFiUE0ZFkVQ04jgzRUZxCx+mhVnhoMzK4
         H0z2UC55ymZfGecYWvAEiSJ/CEkpE7OhncMEphRK5gjYjrGjY6H1OQCyCO3GKGk+TRyh
         7SZ/l13GXOo4YvgF18Wz+PRETqeiEFKo3p3heeHs+mXrneoRWr6rpf4VMjqtYYiOkJve
         mfBg==
X-Gm-Message-State: AOAM533vHOAsd0qaMJxkzW1GVK6ASMs4dOp1dQbRxNVSk5n8NJzCv/6J
        8UhyvajEXtzL1h/Xo1j0o8nlAQ==
X-Google-Smtp-Source: ABdhPJwfc6Jp2yzstWLrYd+2iWIpMgUt+oWOWHykkxIF5q1y9u/a544InrICKH56/Wjccpb2x1x3Sw==
X-Received: by 2002:ac2:44a7:: with SMTP id c7mr4422393lfm.332.1621349614530;
        Tue, 18 May 2021 07:53:34 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d7sm2307805lfg.253.2021.05.18.07.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:53:34 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v3] mfd: db8500-prcmu: Add devicetree bindings
Date:   Tue, 18 May 2021 16:51:32 +0200
Message-Id: <20210518145132.428340-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver was merged in the early days of device tree
on Arm in 2012 and somehow we failed to provide bindings
for it. Fix it up with some YAML bindings.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Enforce unit name on the DT node, 'prcmu@'
- Remove overspecified unit names for prcmu-timer and thermal and
  use patternProperties to match this to a regexp instead.
- Drop dependency interrupt-controller: [ interrupts ] instead make
  interrupts required. Make interrupts required instead since
  interrupt-controller is already required.
ChangeLog v1->v2:
- Make the main PRCMU node name more generic instead of
  hammering it down to a specific address.
---
 .../bindings/mfd/stericsson,db8500-prcmu.yaml | 278 ++++++++++++++++++
 1 file changed, 278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml

diff --git a/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml b/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
new file mode 100644
index 000000000000..a0d4bad5dc81
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
@@ -0,0 +1,278 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/stericsson,db8500-prcmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST-Ericsson DB8500 PRCMU - Power Reset and Control Management Unit
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  The DB8500 Power Reset and Control Management Unit is an XP70 8-bit
+  microprocessor that is embedded in the always-on power domain of the
+  DB8500 SoCs to manage the low power states, powering up and down parts
+  of the silicon, and controlling reset of different IP blocks.
+
+properties:
+  $nodename:
+    pattern: '^prcmu@[0-9a-f]+$'
+
+  compatible:
+    description: The device is compatible both to the device-specific
+      compatible "stericsson,db8500-prcmu" and "syscon". The latter
+      compatible is needed for the device to be exposed as a system
+      controller so that arbitrary registers can be access by
+      different operating system components.
+    items:
+      - const: stericsson,db8500-prcmu
+      - const: syscon
+
+  reg:
+    items:
+      - description: Main PRCMU register area
+      - description: PRCMU TCPM register area
+      - description: PRCMU TCDM register area
+
+  reg-names:
+    items:
+      - const: prcmu
+      - const: prcmu-tcpm
+      - const: prcmu-tcdm
+
+  interrupts:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  db8500-prcmu-regulators:
+    description: Node describing the DB8500 regulators. These are mainly
+      power rails inside the silicon but some of those are also routed
+      out to external pins.
+    type: object
+
+    properties:
+      compatible:
+        const: stericsson,db8500-prcmu-regulator
+
+      db8500_vape:
+        description: The voltage for the application processor, the
+          main voltage domain for the chip.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_varm:
+        description: The voltage for the ARM Cortex A-9 CPU.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_vmodem:
+        description: The voltage for the modem subsystem.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_vpll:
+        description: The voltage for the phase locked loop clocks.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_vsmps1:
+        description: Also known as VIO12, is a step-down voltage regulator
+          for 1.2V I/O. SMPS means System Management Power Source.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_vsmps2:
+        description: Also known as VIO18, is a step-down voltage regulator
+          for 1.8V I/O. SMPS means System Management Power Source.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_vsmps3:
+        description: This is a step-down voltage regulator
+          for 0.87 thru 1.875V I/O. SMPS means System Management Power Source.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_vrf1:
+        description: RF transciever voltage regulator.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_sva_mmdsp:
+        description: Smart Video Accelerator (SVA) multimedia DSP (MMDSP)
+          voltage regulator. This is the voltage for the accelerator DSP
+          for video encoding and decoding.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_sva_mmdsp_ret:
+        description: Smart Video Accelerator (SVA) multimedia DSP (MMDSP)
+          voltage regulator for retention mode.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_sva_pipe:
+        description: Smart Video Accelerator (SVA) multimedia DSP (MMDSP)
+          voltage regulator for the data pipe.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_sia_mmdsp:
+        description: Smart Image Accelerator (SIA) multimedia DSP (MMDSP)
+          voltage regulator. This is the voltage for the accelerator DSP
+          for image encoding and decoding.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_sia_mmdsp_ret:
+        description: Smart Image Accelerator (SIA) multimedia DSP (MMDSP)
+          voltage regulator for retention mode.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_sia_pipe:
+        description: Smart Image Accelerator (SIA) multimedia DSP (MMDSP)
+          voltage regulator for the data pipe.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_sga:
+        description: Smart Graphics Accelerator (SGA) voltage regulator.
+          This is in effect controlling the power to the MALI400 3D
+          accelerator block.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_b2r2_mcde:
+        description: Blit Blend Rotate and Rescale (B2R2), and Multi-Channel
+          Display Engine (MCDE) voltage regulator. These are two graphics
+          blocks.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_esram12:
+        description: Embedded Static RAM (ESRAM) 1 and 2 voltage regulator.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_esram12_ret:
+        description: Embedded Static RAM (ESRAM) 1 and 2 voltage regulator for
+          retention mode.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_esram34:
+        description: Embedded Static RAM (ESRAM) 3 and 4 voltage regulator.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_esram34_ret:
+        description: Embedded Static RAM (ESRAM) 3 and 4 voltage regulator for
+          retention mode.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+    required:
+      - compatible
+      - db8500_vape
+      - db8500_varm
+      - db8500_vmodem
+      - db8500_vpll
+      - db8500_vsmps1
+      - db8500_vsmps2
+      - db8500_vsmps3
+      - db8500_vrf1
+      - db8500_sva_mmdsp
+      - db8500_sva_mmdsp_ret
+      - db8500_sva_pipe
+      - db8500_sia_mmdsp
+      - db8500_sia_mmdsp_ret
+      - db8500_sia_pipe
+      - db8500_sga
+      - db8500_b2r2_mcde
+      - db8500_esram12
+      - db8500_esram12_ret
+      - db8500_esram34
+      - db8500_esram34_ret
+
+    additionalProperties: false
+
+patternProperties:
+  "^thermal@[0-9a-f]+$":
+    description: Node describing the DB8500 thermal control functions.
+      This binds to an operating system driver that monitors the
+      temperature of the SoC.
+    type: object
+
+    properties:
+      compatible:
+        const: stericsson,db8500-thermal
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        items:
+          - description: Hotmon low interrupt (falling temperature)
+          - description: Hotmon high interrupt (rising temperature)
+
+      interrupt-names:
+        items:
+          - const: IRQ_HOTMON_LOW
+          - const: IRQ_HOTMON_HIGH
+
+      '#thermal-sensor-cells':
+        const: 0
+
+    additionalProperties: false
+
+  "^prcmu-timer-4@[0-9a-f]+$":
+    description: Node describing the externally visible timer 4 in the
+      PRCMU block. This timer is interesting to the operating system
+      since even thought it has a very low resolution (32768 Hz) it is
+      always on, and thus provides a consistent monotonic timeline for
+      the system.
+    type: object
+
+    properties:
+      compatible:
+        const: stericsson,db8500-prcmu-timer-4
+
+      reg:
+        maxItems: 1
+
+    additionalProperties: false
+
+  "^ab850[05]$":
+    description: Node describing the Analog Baseband 8500 mixed-signals
+      ASIC AB8500 and subcomponents. The AB8500 is accessed through the
+      PRCMU and hence it appears here. This component has a separate
+      set of devicetree bindings. The AB8505 is a newer version of the
+      same ASIC.
+    type: object
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+  - ranges
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+  - db8500-prcmu-regulators
+
+additionalProperties: false
-- 
2.31.1

