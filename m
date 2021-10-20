Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A78434808
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJTJi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:38:29 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:50928
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhJTJi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:38:27 -0400
Received: from workstation5.fritz.box (ip-88-152-144-157.hsi03.unitymediagroup.de [88.152.144.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2E7F03FFE4;
        Wed, 20 Oct 2021 09:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634722572;
        bh=bAoP1FRiCuy1+/FURCUdf01qjwFj5kNYA9taKaOAcu4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=XnzyDxewYJGTGBxlg71DeHB66UWnfd82EVEm/zwRbcfvTQysIL70WtTnPhXBZzMwI
         UDbN5qUjEbN4FRJymfUrT9bN4oNycc5qA+tbo1SAiQUaMYfMFYwesMXDilH33Sz0hA
         nuTt07ydy5wJaXnTTyAFaVX6ftqtf2SqiUskyQuGKUHGk1zuP4V+g4FVQHLtfk+X5n
         AJJm4UCK9LbC0oQwF8z0t3df34VGmCR4W/ezI1/xQNFkJR9+3q5SI7ZanUEOnkrS/K
         7HoJ/ryvjMNmVjbjCv3SUMq2HKgdF6U1JBKYVX1VUuhLkqGY71Yc1yjhAnCSPh4EBG
         Ci+JwbFxeRTCA==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Guo Ren <guoren@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
        Xiang W <wxjstz@126.com>, Samuel Holland <samuel@sholland.org>,
        Atish Patra <atish.patra@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        opensbi@lists.infradead.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] dt-bindings: T-HEAD CLINT
Date:   Wed, 20 Oct 2021 11:36:03 +0200
Message-Id: <20211020093603.28653-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CLINT in the T-HEAD 9xx CPUs is similar to the SiFive CLINT but does
not support 64bit mmio access to the MTIMER device.

OpenSBI currently uses a property 'clint,has-no-64bit-mmio' to indicate the
restriction and the "sifive,cling0" compatible string. An OpenSBI
patch suggested to use "reg-io-width = <4>;" as the reg-io-width property
is generally used in the devicetree schema for such a condition.

As the design is not SiFive based it is preferable to apply a compatible
string identifying T-HEAD instead.

Add a new yaml file describing the T-HEAD CLINT.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
@Palmer, @Anup
I copied you as maintainers from sifive,clint.yaml. Please, indicate if
this should be changed.

For the prior discussion see:
https://lore.kernel.org/all/20211015100941.17621-1-heinrich.schuchardt@canonical.com/
https://lore.kernel.org/all/20211015120735.27972-1-heinrich.schuchardt@canonical.com/

A release candidate of the ACLINT specification is available at
https://github.com/riscv/riscv-aclint/releases
---
 .../bindings/timer/thead,clint.yaml           | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/thead,clint.yaml

diff --git a/Documentation/devicetree/bindings/timer/thead,clint.yaml b/Documentation/devicetree/bindings/timer/thead,clint.yaml
new file mode 100644
index 000000000000..02463fb2043a
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/thead,clint.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/thead,clint.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive Core Local Interruptor
+
+maintainers:
+  - Palmer Dabbelt <palmer@dabbelt.com>
+  - Anup Patel <anup.patel@wdc.com>
+
+description:
+  T-HEAD (and other RISC-V) SOCs include an implementation of the T-HEAD
+  Core Local Interruptor (CLINT) for M-mode timer and M-mode inter-processor
+  interrupts. It directly connects to the timer and inter-processor interrupt
+  lines of various HARTs (or CPUs) so RISC-V per-HART (or per-CPU) local
+  interrupt controller is the parent interrupt controller for CLINT device.
+  The clock frequency of the CLINT is specified via "timebase-frequency" DT
+  property of "/cpus" DT node. The "timebase-frequency" DT property is
+  described in Documentation/devicetree/bindings/riscv/cpus.yaml
+
+properties:
+  compatible:
+    items:
+      - const:
+          - allwinner,sun20i-d1-clint
+      - const:
+          - thead,clint0
+
+    description:
+      Should be "<vendor>,<chip>-clint" and "thead,clint<version>" for
+      the T-HEAD derived CLINTs.
+      Supported compatible strings are -
+      "allwinner,sun20i-d1-clint" for the CLINT in the Allwinner D1 SoC
+      and "thead,clint0" for the T-HEAD IP block with no chip
+      integration tweaks.
+
+  reg:
+    maxItems: 1
+
+  interrupts-extended:
+    minItems: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+
+examples:
+  - |
+    timer@2000000 {
+      compatible = "allwinner,sun20i-d1-clint", "thead,clint0";
+      interrupts-extended = <&cpu1intc 3 &cpu1intc 7
+                             &cpu2intc 3 &cpu2intc 7
+                             &cpu3intc 3 &cpu3intc 7
+                             &cpu4intc 3 &cpu4intc 7>;
+       reg = <0x2000000 0x10000>;
+    };
+...
-- 
2.32.0

