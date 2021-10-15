Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1406442F033
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbhJOMJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:09:48 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:48818
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238617AbhJOMJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:09:47 -0400
Received: from workstation5.fritz.box (ip-88-152-144-157.hsi03.unitymediagroup.de [88.152.144.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 62B103F10B;
        Fri, 15 Oct 2021 12:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634299659;
        bh=2e9Gjwt5Cjo6AC9tkBVaY/EImJ9+xhZBLuu1MnFPT5Y=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=CSXsmqSPfeMtKRwmUskuONONORt5Yuo54jB2C/q6oseS9zDNprREI8hshq8SmhgvZ
         87MWTVnvSJUuZJK47kx8rTxiKAzLY17nEnMykdhS4y6yiGFvgrfwizXwi7sXp46yPS
         W2MXlW17oqrV/lt5Go4CIlCF4bMJtY1wBVT3N51Cwj52CW28WDrkEBvbUCq19O93+f
         06/hp9ih58OZn2ISgdemSzxhbFmqBORpfRD9bZfhaQxj2yedyJpjwxDkI2pIdhMYTC
         2uJ9ZzreVEbfaAMk6hNGGGghdBZpQL59szl0/f7VSuXOEoz+Mya+5K2q5dfJCeVFZ/
         P/co+9iqmL4Qw==
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
Subject: [PATCH v2 1/1] dt-bindings: reg-io-width for SiFive CLINT
Date:   Fri, 15 Oct 2021 14:07:35 +0200
Message-Id: <20211015120735.27972-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CLINT in the T-HEAD 9xx processors do not support 64bit mmio access to
the MTIMER device. The current schema does not allow to specify this.

OpenSBI currently uses a property 'clint,has-no-64bit-mmio' to indicate the
restriction. Samuael Holland suggested in
lib: utils/timer: Use standard property to specify 32-bit I/O
https://github.com/smaeul/opensbi/commit/b95e9cf7cf93b0af16fc89204378bc59ff30008e
to use "reg-io-width = <4>;" as the reg-io-width property is generally used
in the devicetree schema for such a condition.

A release candidate of the ACLINT specification is available at
https://github.com/riscv/riscv-aclint/releases

Add reg-io-width as optional property to the SiFive Core Local Interruptor.
Add a new compatible string "allwinner,sun20i-d1-clint" for the CLINT of
the Allwinner D1 SoC.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .../devicetree/bindings/timer/sifive,clint.yaml     | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index a35952f48742..d3b4c6844e2f 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -26,6 +26,7 @@ properties:
       - enum:
           - sifive,fu540-c000-clint
           - canaan,k210-clint
+          - allwinner,sun20i-d1-clint
       - const: sifive,clint0
 
     description:
@@ -33,14 +34,22 @@ properties:
       Supported compatible strings are -
       "sifive,fu540-c000-clint" for the SiFive CLINT v0 as integrated
       onto the SiFive FU540 chip, "canaan,k210-clint" for the SiFive
-      CLINT v0 as integrated onto the Canaan Kendryte K210 chip, and
-      "sifive,clint0" for the SiFive CLINT v0 IP block with no chip
+      CLINT v0 as integrated onto the Canaan Kendryte K210 chip,
+      "allwinner,sun20i-d1-clint" for the CLINT in the Allwinner D1 SoC,
+      and "sifive,clint0" for the SiFive CLINT v0 IP block with no chip
       integration tweaks.
       Please refer to sifive-blocks-ip-versioning.txt for details
 
   reg:
     maxItems: 1
 
+  reg-io-width:
+    description: |
+      Some CLINT implementations, e.g. on the T-HEAD 9xx, only support
+      32bit access for MTIMER.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    const: 4
+
   interrupts-extended:
     minItems: 1
 
-- 
2.32.0

