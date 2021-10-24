Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34525438634
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 03:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhJXBfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 21:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231474AbhJXBfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 21:35:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21EAD60F36;
        Sun, 24 Oct 2021 01:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635039199;
        bh=mbXBgfm2vZH7xDcmcMmYbJZmmdRHiEC5rQ00XeKK6Ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OlXNCYN5C9eOCJCHBlcD9PSVm56iMEyyUH1eYCvo2E37mzySG0XtyAa/1pWv757Ji
         arfo+RjrEU5A5s45BUoGytllRYOJ3bZv/IHu6eJaJPocfxw4JJGmJr7DDqkXT8BnUZ
         /f/JLRbInV/1AEoFtwo9XY+ndnyCcS8qQnihp0/cBJ6IjhRQc9zPkiMqm3zFJdfKsu
         6bqfyOywo8SF36C1pM73hSpYZPl28AuIwbvzRd3WwQtPtOM6e7nu4HvMnLl4RiZzmO
         xcnb2yCNw+qx4RmA5wC4pWvx5IvMIeVf8393nPgtYOxLzJ+kKgoDOcEFnskCmGgnHD
         ZIb87NBmshxKQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, atish.patra@wdc.com,
        maz@kernel.org, tglx@linutronix.de, palmer@dabbelt.com,
        heiko@sntech.de, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH V5 2/3] dt-bindings: update riscv plic compatible string
Date:   Sun, 24 Oct 2021 09:33:02 +0800
Message-Id: <20211024013303.3499461-3-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024013303.3499461-1-guoren@kernel.org>
References: <20211024013303.3499461-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add the compatible string "thead,c900-plic" to the riscv plic
bindings to support allwinner d1 SOC which contains c906 core.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>

---

Changes since V5:
 - Add DT list
 - Fixup compatible string
 - Remove allwinner-d1 compatible
 - make dt_binding_check

Changes since V4:
 - Update description in errata style
 - Update enum suggested by Anup, Heiko, Samuel

Changes since V3:
 - Rename "c9xx" to "c900"
 - Add thead,c900-plic in the description section
---
 .../interrupt-controller/sifive,plic-1.0.0.yaml   | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 08d5a57ce00f..18b97bfd7954 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -35,6 +35,10 @@ description:
   contains a specific memory layout, which is documented in chapter 8 of the
   SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
 
+  The thead,c900-plic couldn't complete masked irq source which has been disabled in
+  enable register. Add thead_plic_chip which fix up c906-plic irq source completion
+  problem by unmask/mask wrapper.
+
 maintainers:
   - Sagar Kadam <sagar.kadam@sifive.com>
   - Paul Walmsley  <paul.walmsley@sifive.com>
@@ -42,11 +46,16 @@ maintainers:
 
 properties:
   compatible:
-    items:
+   oneOf:
+    - items:
       - enum:
-          - sifive,fu540-c000-plic
-          - canaan,k210-plic
+        - sifive,fu540-c000-plic
+        - canaan,k210-plic
       - const: sifive,plic-1.0.0
+    - items:
+      - enum:
+        - allwinner,sun20i-d1-plic
+      - const: thead,c900-plic
 
   reg:
     maxItems: 1
-- 
2.25.1

