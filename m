Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1607E42FFE1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 05:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243616AbhJPDZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 23:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239691AbhJPDY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 23:24:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F4EB60F48;
        Sat, 16 Oct 2021 03:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634354541;
        bh=+1DBBbaQVSby7WUGxXC3pmVab5QowIju69Lvqfx+p7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=os2ilB8BD7U/YPjDVc3Q89ZEm3puACHFLnh52nJBRWHkWs9+oy7S+BL8hs3nnUXQt
         uGXBG894Sj0JWaAw8mgybZ3Sft7qg2G/sPcLAXJxr2GXiw8Oe+/n1wYG52r/W64Wx+
         odMewlbEeMvBUrlydruZgzjp5QQnjjPvlolmeBMqhsI3cdRXbIG8Oiw60e8n0RarKv
         2n1KRo5DQr0acKBwK3CDCQFuYovm11vxpRPZtDpEgUQYyQuOaiQQyv0CLAvgP3nC5S
         55opWGAn3+Or23GHaL1EuYdGeUoZyrezr56jpb/3hgbyJf/43qWDjA7BJJoScW9s6i
         PuDWGCpKetvdQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, atish.patra@wdc.com,
        maz@kernel.org, tglx@linutronix.de, palmer@dabbelt.com,
        heiko@sntech.de, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH V4 2/3] dt-bindings: update riscv plic compatible string
Date:   Sat, 16 Oct 2021 11:21:59 +0800
Message-Id: <20211016032200.2869998-3-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211016032200.2869998-1-guoren@kernel.org>
References: <20211016032200.2869998-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add the compatible string "thead,c900-plic" to the riscv plic
bindings to support allwinner d1 SOC which contains c906 core.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@wdc.com>

---

Changes since V4:
 - Update description in errata style
 - Update enum suggested by Anup, Heiko, Samuel

Changes since V3:
 - Rename "c9xx" to "c900"
 - Add thead,c900-plic in the description section
---
 .../interrupt-controller/sifive,plic-1.0.0.yaml       | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 08d5a57ce00f..272f29540135 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -35,6 +35,12 @@ description:
   contains a specific memory layout, which is documented in chapter 8 of the
   SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
 
+  The C9xx PLIC does not comply with the interrupt claim/completion process defined
+  by the RISC-V PLIC specification because C9xx PLIC will mask an IRQ when it is
+  claimed by PLIC driver (i.e. readl(claim) and the IRQ will be unmasked upon
+  completion by PLIC driver (i.e. writel(claim). This behaviour breaks the handling
+  of IRQS_ONESHOT by the generic handle_fasteoi_irq() used in the PLIC driver.
+
 maintainers:
   - Sagar Kadam <sagar.kadam@sifive.com>
   - Paul Walmsley  <paul.walmsley@sifive.com>
@@ -46,7 +52,10 @@ properties:
       - enum:
           - sifive,fu540-c000-plic
           - canaan,k210-plic
-      - const: sifive,plic-1.0.0
+      - enmu:
+          - sifive,plic-1.0.0
+          - thead,c900-plic
+          - allwinner,sun20i-d1-plic
 
   reg:
     maxItems: 1
-- 
2.25.1

