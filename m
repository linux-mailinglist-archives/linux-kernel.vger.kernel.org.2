Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D854A3636A3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 18:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhDRQfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 12:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhDRQfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 12:35:05 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1310C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 09:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=g0n2LQAUoImpmAm99p3TPUXAM9WD1a7ioxiHN336N+0=; b=bHbLHTDZ6BXM6
        nwE57QXkmiY6OAnHyVQ+5MhjEafZQm1Cj2dRK3rm5lYSuhRe1gcDLOpi75QBX72v
        67aMRZjDp1M+32obi4sC5MVPsUfzL59kXG0uOX73ASQWBR/8/UrzmVp0uscTj0yG
        KLTt6IezJB0P/xTI9wsZuzeI4pFbZc=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygD3r1SUX3xgAXAFAA--.8301S2;
        Mon, 19 Apr 2021 00:34:28 +0800 (CST)
Date:   Mon, 19 Apr 2021 00:29:19 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: kprobes: Remove redundant kprobe_step_ctx
Message-ID: <20210419002919.1a0a539d@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygD3r1SUX3xgAXAFAA--.8301S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryxXF45KrW5Cr1xZryDGFg_yoWrZw1fpF
        ZIkw13JrZ5Ja95uFyxAw4UZr1Syr48ArW7KrWUC34ftw1ayr13XF1xW3yjyr98Gr9Ygw13
        ZryUtrW8J34xAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyIb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2Iq
        xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
        106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
        xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7
        xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
        JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcVWlDUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

Inspired by commit ba090f9cafd5 ("arm64: kprobes: Remove redundant
kprobe_step_ctx"), the ss_pending and match_addr of kprobe_step_ctx
are redundant because those can be replaced by KPROBE_HIT_SS and
&cur_kprobe->ainsn.api.insn[0] + GET_INSN_LENGTH(cur->opcode)
respectively.

Remove the kprobe_step_ctx to simplify the code.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/kprobes.h   |  7 ------
 arch/riscv/kernel/probes/kprobes.c | 40 +++++++-----------------------
 2 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
index 4647d38018f6..9ea9b5ec3113 100644
--- a/arch/riscv/include/asm/kprobes.h
+++ b/arch/riscv/include/asm/kprobes.h
@@ -29,18 +29,11 @@ struct prev_kprobe {
 	unsigned int status;
 };
 
-/* Single step context for kprobe */
-struct kprobe_step_ctx {
-	unsigned long ss_pending;
-	unsigned long match_addr;
-};
-
 /* per-cpu kprobe control block */
 struct kprobe_ctlblk {
 	unsigned int kprobe_status;
 	unsigned long saved_status;
 	struct prev_kprobe prev_kprobe;
-	struct kprobe_step_ctx ss_ctx;
 };
 
 void arch_remove_kprobe(struct kprobe *p);
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 8c1f7a30aeed..4c1ad5536748 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -17,7 +17,7 @@ DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
 static void __kprobes
-post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
+post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
 
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
@@ -43,7 +43,7 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 		p->ainsn.api.handler((u32)p->opcode,
 					(unsigned long)p->addr, regs);
 
-	post_kprobe_handler(kcb, regs);
+	post_kprobe_handler(p, kcb, regs);
 }
 
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
@@ -149,21 +149,6 @@ static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ctlblk *kcb,
 	regs->status = kcb->saved_status;
 }
 
-static void __kprobes
-set_ss_context(struct kprobe_ctlblk *kcb, unsigned long addr, struct kprobe *p)
-{
-	unsigned long offset = GET_INSN_LENGTH(p->opcode);
-
-	kcb->ss_ctx.ss_pending = true;
-	kcb->ss_ctx.match_addr = addr + offset;
-}
-
-static void __kprobes clear_ss_context(struct kprobe_ctlblk *kcb)
-{
-	kcb->ss_ctx.ss_pending = false;
-	kcb->ss_ctx.match_addr = 0;
-}
-
 static void __kprobes setup_singlestep(struct kprobe *p,
 				       struct pt_regs *regs,
 				       struct kprobe_ctlblk *kcb, int reenter)
@@ -182,8 +167,6 @@ static void __kprobes setup_singlestep(struct kprobe *p,
 		/* prepare for single stepping */
 		slot = (unsigned long)p->ainsn.api.insn;
 
-		set_ss_context(kcb, slot, p);	/* mark pending ss */
-
 		/* IRQs and single stepping do not mix well. */
 		kprobes_save_local_irqflag(kcb, regs);
 
@@ -219,13 +202,8 @@ static int __kprobes reenter_kprobe(struct kprobe *p,
 }
 
 static void __kprobes
-post_kprobe_handler(struct kprobe_ctlblk *kcb, struct pt_regs *regs)
+post_kprobe_handler(struct kprobe *cur, struct kprobe_ctlblk *kcb, struct pt_regs *regs)
 {
-	struct kprobe *cur = kprobe_running();
-
-	if (!cur)
-		return;
-
 	/* return addr restore if non-branching insn */
 	if (cur->ainsn.api.restore != 0)
 		regs->epc = cur->ainsn.api.restore;
@@ -355,16 +333,16 @@ bool __kprobes
 kprobe_single_step_handler(struct pt_regs *regs)
 {
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+	unsigned long addr = instruction_pointer(regs);
+	struct kprobe *cur = kprobe_running();
 
-	if ((kcb->ss_ctx.ss_pending)
-	    && (kcb->ss_ctx.match_addr == instruction_pointer(regs))) {
-		clear_ss_context(kcb);	/* clear pending ss */
-
+	if (cur && (kcb->kprobe_status & (KPROBE_HIT_SS | KPROBE_REENTER)) &&
+	    ((unsigned long)&cur->ainsn.api.insn[0] + GET_INSN_LENGTH(cur->opcode) == addr)) {
 		kprobes_restore_local_irqflag(kcb, regs);
-
-		post_kprobe_handler(kcb, regs);
+		post_kprobe_handler(cur, kcb, regs);
 		return true;
 	}
+	/* not ours, kprobes should ignore it */
 	return false;
 }
 
-- 
2.31.0


