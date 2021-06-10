Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374E63A2FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhFJQAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 12:00:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:47789 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230413AbhFJQAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:00:33 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G17tg617CzBCQr;
        Thu, 10 Jun 2021 17:58:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Rrp_wFE1o9kL; Thu, 10 Jun 2021 17:58:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G17tg579XzBCB8;
        Thu, 10 Jun 2021 17:58:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8F1C38B81E;
        Thu, 10 Jun 2021 17:58:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 30l8isz-zIYT; Thu, 10 Jun 2021 17:58:35 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E5DD48B81C;
        Thu, 10 Jun 2021 17:58:34 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B7ED264C8C; Thu, 10 Jun 2021 15:58:34 +0000 (UTC)
Message-Id: <a069a348ee3c2fe3123a5a93695c2b35dc42cb40.1623340691.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/signal32: Remove impossible #ifdef combinations
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 10 Jun 2021 15:58:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPC_TRANSACTIONAL_MEM is only on book3s/64
SPE is only on booke

PPC_TRANSACTIONAL_MEM selects ALTIVEC and VSX

Therefore, within PPC_TRANSACTIONAL_MEM sections,
ALTIVEC and VSX are always defined while SPE never is.

Remove all SPE code and all #ifdef ALTIVEC and VSX in tm
functions.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 55 ---------------------------------
 1 file changed, 55 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 8f05ed0da292..c3f14d0f31f5 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -354,14 +354,8 @@ static void prepare_save_tm_user_regs(void)
 {
 	WARN_ON(tm_suspend_disabled);
 
-#ifdef CONFIG_ALTIVEC
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		current->thread.ckvrsave = mfspr(SPRN_VRSAVE);
-#endif
-#ifdef CONFIG_SPE
-	if (current->thread.used_spe)
-		flush_spe_to_thread(current);
-#endif
 }
 
 static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame,
@@ -379,7 +373,6 @@ static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user
 	 */
 	unsafe_put_user((msr >> 32), &tm_frame->mc_gregs[PT_MSR], failed);
 
-#ifdef CONFIG_ALTIVEC
 	/* save altivec registers */
 	if (current->thread.used_vr) {
 		unsafe_copy_to_user(&frame->mc_vregs, &current->thread.ckvr_state,
@@ -412,7 +405,6 @@ static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user
 	else
 		unsafe_put_user(current->thread.ckvrsave,
 				(u32 __user *)&tm_frame->mc_vregs[32], failed);
-#endif /* CONFIG_ALTIVEC */
 
 	unsafe_copy_ckfpr_to_user(&frame->mc_fregs, current, failed);
 	if (msr & MSR_FP)
@@ -420,7 +412,6 @@ static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user
 	else
 		unsafe_copy_ckfpr_to_user(&tm_frame->mc_fregs, current, failed);
 
-#ifdef CONFIG_VSX
 	/*
 	 * Copy VSR 0-31 upper half from thread_struct to local
 	 * buffer, then write that to userspace.  Also set MSR_VSX in
@@ -436,23 +427,6 @@ static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user
 
 		msr |= MSR_VSX;
 	}
-#endif /* CONFIG_VSX */
-#ifdef CONFIG_SPE
-	/* SPE regs are not checkpointed with TM, so this section is
-	 * simply the same as in __unsafe_save_user_regs().
-	 */
-	if (current->thread.used_spe) {
-		unsafe_copy_to_user(&frame->mc_vregs, current->thread.evr,
-				    ELF_NEVRREG * sizeof(u32), failed);
-		/* set MSR_SPE in the saved MSR value to indicate that
-		 * frame->mc_vregs contains valid data */
-		msr |= MSR_SPE;
-	}
-
-	/* We always copy to/from spefscr */
-	unsafe_put_user(current->thread.spefscr,
-			(u32 __user *)&frame->mc_vregs + ELF_NEVRREG, failed);
-#endif /* CONFIG_SPE */
 
 	unsafe_put_user(msr, &frame->mc_gregs[PT_MSR], failed);
 
@@ -587,9 +561,7 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 				 struct mcontext __user *tm_sr)
 {
 	unsigned long msr, msr_hi;
-#ifdef CONFIG_VSX
 	int i;
-#endif
 
 	if (tm_suspend_disabled)
 		return 1;
@@ -610,7 +582,6 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	/* Restore the previous little-endian mode */
 	regs->msr = (regs->msr & ~MSR_LE) | (msr & MSR_LE);
 
-#ifdef CONFIG_ALTIVEC
 	regs->msr &= ~MSR_VEC;
 	if (msr & MSR_VEC) {
 		/* restore altivec registers from the stack */
@@ -629,13 +600,11 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 			(u32 __user *)&sr->mc_vregs[32], failed);
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		mtspr(SPRN_VRSAVE, current->thread.ckvrsave);
-#endif /* CONFIG_ALTIVEC */
 
 	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1);
 
 	unsafe_copy_fpr_from_user(current, &sr->mc_fregs, failed);
 
-#ifdef CONFIG_VSX
 	regs->msr &= ~MSR_VSX;
 	if (msr & MSR_VSX) {
 		/*
@@ -649,24 +618,6 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 			current->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
 			current->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
 		}
-#endif /* CONFIG_VSX */
-
-#ifdef CONFIG_SPE
-	/* SPE regs are not checkpointed with TM, so this section is
-	 * simply the same as in restore_user_regs().
-	 */
-	regs->msr &= ~MSR_SPE;
-	if (msr & MSR_SPE) {
-		unsafe_copy_from_user(current->thread.evr, &sr->mc_vregs,
-				      ELF_NEVRREG * sizeof(u32), failed);
-		current->thread.used_spe = true;
-	} else if (current->thread.used_spe)
-		memset(current->thread.evr, 0, ELF_NEVRREG * sizeof(u32));
-
-	/* Always get SPEFSCR back */
-	unsafe_get_user(current->thread.spefscr,
-			(u32 __user *)&sr->mc_vregs + ELF_NEVRREG, failed);
-#endif /* CONFIG_SPE */
 
 	user_read_access_end();
 
@@ -675,7 +626,6 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 
 	unsafe_restore_general_regs(regs, tm_sr, failed);
 
-#ifdef CONFIG_ALTIVEC
 	/* restore altivec registers from the stack */
 	if (msr & MSR_VEC)
 		unsafe_copy_from_user(&current->thread.vr_state, &tm_sr->mc_vregs,
@@ -684,11 +634,9 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	/* Always get VRSAVE back */
 	unsafe_get_user(current->thread.vrsave,
 			(u32 __user *)&tm_sr->mc_vregs[32], failed);
-#endif /* CONFIG_ALTIVEC */
 
 	unsafe_copy_ckfpr_from_user(current, &tm_sr->mc_fregs, failed);
 
-#ifdef CONFIG_VSX
 	if (msr & MSR_VSX) {
 		/*
 		 * Restore altivec registers from the stack to a local
@@ -697,7 +645,6 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 		unsafe_copy_vsx_from_user(current, &tm_sr->mc_vsregs, failed);
 		current->thread.used_vsr = true;
 	}
-#endif /* CONFIG_VSX */
 
 	/* Get the top half of the MSR from the user context */
 	unsafe_get_user(msr_hi, &tm_sr->mc_gregs[PT_MSR], failed);
@@ -742,12 +689,10 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 		load_fp_state(&current->thread.fp_state);
 		regs->msr |= (MSR_FP | current->thread.fpexc_mode);
 	}
-#ifdef CONFIG_ALTIVEC
 	if (msr & MSR_VEC) {
 		load_vr_state(&current->thread.vr_state);
 		regs->msr |= MSR_VEC;
 	}
-#endif
 
 	preempt_enable();
 
-- 
2.25.0

