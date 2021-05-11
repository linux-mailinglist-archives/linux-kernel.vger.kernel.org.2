Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA337AD59
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhEKRtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKRti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:49:38 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C280AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=gNbV2evxtF39QMDw6yzbvkVK2nPO0DcmjBsDBPMap9A=; b=feAP/FbZZOdXx
        3CelCeZURgCsqdbnpcd71oKy5e3FDLcK0+YWq4ZLJHlTJyDYKX8TJ5QzMwem9ZMP
        wdGq7kfckBJ3fyjBqcb0+Pnlr+68dDSPmseQloMqN/DknM4mb5fVr+42gDp+XOxw
        oLetZFhLSNNl79bAnQqMwGRdRttdlk=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDX3JhFw5pgIoPBAA--.62566S2;
        Wed, 12 May 2021 01:47:50 +0800 (CST)
Date:   Wed, 12 May 2021 01:42:31 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Optimize switch_mm by passing "cpu" to
 flush_icache_deferred()
Message-ID: <20210512014231.466aff04@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygDX3JhFw5pgIoPBAA--.62566S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy3uFW7GF1kZw18KF4DArb_yoW8GF4rpr
        W7Ca1qyr4rJF1I9a9F9FW8ZFyS9a9Yga4xK348Cwn0vF15t34jgr1xXanYyw4UCFyrurW3
        CF4Yyw15Wr42v3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2Iq
        xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
        106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
        xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7
        xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
        JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUgg_TUUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

Directly passing the cpu to flush_icache_deferred() rather than calling
smp_processor_id() again.

Here are some performance numbers:

With a run of hackbench 30 times on a single core riscv64 Qemu instance
with 1GB memory:

without this patch: mean 36.934
with this patch: mean 36.104 (improved by 2.24%)

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/context.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 68aa312fc352..6d445f2888ec 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -281,10 +281,9 @@ static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
  * actually performs that local instruction cache flush, which implicitly only
  * refers to the current hart.
  */
-static inline void flush_icache_deferred(struct mm_struct *mm)
+static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu)
 {
 #ifdef CONFIG_SMP
-	unsigned int cpu = smp_processor_id();
 	cpumask_t *mask = &mm->context.icache_stale_mask;
 
 	if (cpumask_test_cpu(cpu, mask)) {
@@ -320,5 +319,5 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 	set_mm(next, cpu);
 
-	flush_icache_deferred(next);
+	flush_icache_deferred(next, cpu);
 }
-- 
2.31.0


