Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7D142B236
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 03:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbhJMBYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 21:24:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234055AbhJMBYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 21:24:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C89E9604D2;
        Wed, 13 Oct 2021 01:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634088134;
        bh=468WHYFwB6WFDhp8ouf1HntwGAoFETGsz8CZghL0FKA=;
        h=From:To:Cc:Subject:Date:From;
        b=RipuErGRqkVoqnXnfk2l6WgyfFMaVtMuXqOttmm6D+0kKavAT52ABC0etQyzNjgyj
         JSxsnhtFdw1+hhaZ4bymhMhOCm6f9UTF0usrkdWXRIK4apJqIOmoTAgcCXAS6Yq26l
         PSBCYz4lkApVimpSVFjTfzfxyxaO9x9kp4eIOvM8Q7yewxah0C9+D1oVEMsd+5IjRt
         NmFF4/Ls5tFKlwuuaHepTgzLOdJJkIa6+mKyOR0ajiFPhqHfICP61mxRt5eDuLiD8k
         LsztBiHuHLwQv6oC/d2u1YPM6ONg+QLTAu3Q0D2BSTxkDPtGQhILppNv22gdFxGTSj
         b17srNpQqGwqA==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, atish.patra@wdc.com,
        maz@kernel.org, tglx@linutronix.de, palmer@dabbelt.com,
        heiko@sntech.de
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH V3 1/2] dt-bindings: update riscv plic compatible string
Date:   Wed, 13 Oct 2021 09:21:48 +0800
Message-Id: <20211013012149.2834212-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add the compatible string "thead,c900-plic" to the riscv plic
bindings to support SOCs with thead,c9xx processor cores.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@wdc.com>

---

Changes since V3:
 - Rename "c9xx" to "c900"
 - Add thead,c900-plic in the description section
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 08d5a57ce00f..82629832e5a5 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -35,6 +35,11 @@ description:
   contains a specific memory layout, which is documented in chapter 8 of the
   SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
 
+  While the "thead,c900-plic" would mask IRQ with readl(claim), so it needn't
+  mask/unmask which needed in RISC-V PLIC. When in IRQS_ONESHOT & IRQCHIP_EOI_THREADED
+  path, unnecessary mask operation would cause a blocking irq bug in thead,c900-plic.
+  Because when IRQ is disabled in c900, writel(hwirq, claim) would be invalid.
+
 maintainers:
   - Sagar Kadam <sagar.kadam@sifive.com>
   - Paul Walmsley  <paul.walmsley@sifive.com>
@@ -46,6 +51,7 @@ properties:
       - enum:
           - sifive,fu540-c000-plic
           - canaan,k210-plic
+          - thead,c900-plic
       - const: sifive,plic-1.0.0
 
   reg:
-- 
2.25.1

