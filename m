Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E6142EE75
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbhJOKL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:11:59 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:40278
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231776AbhJOKL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:11:58 -0400
Received: from workstation5.fritz.box (ip-88-152-144-157.hsi03.unitymediagroup.de [88.152.144.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 909263F0B8;
        Fri, 15 Oct 2021 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634292589;
        bh=4vBofezLzSZ267ePulcBjbn/3hP3KcAP9nzxWY7BwCc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=oo7KCxGip8hAvtiFb6719RTzo21kgwTdVknb14u/HrnGiSZ++JCoY/YoYbdd6mrue
         p9vEdK5oHaFbPg+MtyPXXUFK9XxZxtBZDR/Lf+A05aFGsSlvKtg5srEUXJMB4+6RVc
         v/EGNYYyb+zBeT+FSM5goCPaXupEqGePlVv9+35HVzlVAfqAoc3mLSIb/SBj3Houno
         EHVshFC4/ZzcD629vQ/zDl85T0O7CmuoD99/fO8T97j+d8UltFu8q53t0o6GhF7OZt
         Iy2Og74H0FkjnBH+X1XJkMXc+Dx+QRq0eKYfzfy7UOjrXiwHhoHaEsMl0vbiraFkhd
         LVaHi5tzWURYA==
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
Subject: [PATCH 1/1] dt-bindings: reg-io-width for SiFive CLINT
Date:   Fri, 15 Oct 2021 12:09:41 +0200
Message-Id: <20211015100941.17621-1-heinrich.schuchardt@canonical.com>
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

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index a35952f48742..266012d887b5 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -41,6 +41,13 @@ properties:
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

