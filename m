Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB8D3F4D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhHWPgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:36:50 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:60915 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231766AbhHWPgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 11:36:48 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GtbtN6ThDz9sWx;
        Mon, 23 Aug 2021 17:35:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q3MsoyM3ZJve; Mon, 23 Aug 2021 17:35:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GtbtM5bkyz9sWm;
        Mon, 23 Aug 2021 17:35:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9035A8B7AF;
        Mon, 23 Aug 2021 17:35:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id R3keXlOwx4s6; Mon, 23 Aug 2021 17:35:55 +0200 (CEST)
Received: from po18078vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 728DF8B7AD;
        Mon, 23 Aug 2021 17:35:55 +0200 (CEST)
Received: by po18078vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6B4476BC7C; Mon, 23 Aug 2021 15:35:55 +0000 (UTC)
Message-Id: <7d391d915d2bd1c0f601f55f61f8dd4c70066229.1629732940.git.christophe.leroy@csgroup.eu>
In-Reply-To: <fd7938d94008711d441551c06b25a033669a0618.1629732940.git.christophe.leroy@csgroup.eu>
References: <fd7938d94008711d441551c06b25a033669a0618.1629732940.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 5/5] powerpc/signal: Use unsafe_copy_siginfo_to_user()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 23 Aug 2021 15:35:55 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use unsafe_copy_siginfo_to_user() in order to do the copy
within the user access block.

On an mpc 8321 (book3s/32) the improvment is about 5% on a process
sending a signal to itself.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 13 ++++++-------
 arch/powerpc/kernel/signal_64.c |  5 +----
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index ff101e2b3bab..f9e16d108bc8 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -710,12 +710,6 @@ static long restore_tm_user_regs(struct pt_regs *regs, struct mcontext __user *s
 }
 #endif
 
-#ifdef CONFIG_PPC64
-
-#define copy_siginfo_to_user	copy_siginfo_to_user32
-
-#endif /* CONFIG_PPC64 */
-
 /*
  * Set up a signal frame for a "real-time" signal handler
  * (one which gets siginfo).
@@ -779,14 +773,19 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 		asm("dcbst %y0; sync; icbi %y0; sync" :: "Z" (mctx->mc_pad[0]));
 	}
 	unsafe_put_sigset_t(&frame->uc.uc_sigmask, oldset, failed);
+#ifndef CONFIG_COMPAT
+	unsafe_copy_siginfo_to_user(&frame->info, &ksig->info, failed);
+#endif
 
 	/* create a stack frame for the caller of the handler */
 	unsafe_put_user(regs->gpr[1], newsp, failed);
 
 	user_access_end();
 
-	if (copy_siginfo_to_user(&frame->info, &ksig->info))
+#ifdef CONFIG_COMPAT
+	if (copy_siginfo_to_user32(&frame->info, &ksig->info))
 		goto badframe;
+#endif
 
 	regs->link = tramp;
 
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 2cca6c8febe1..82b73fbd937d 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -901,15 +901,12 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 	}
 
 	unsafe_copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set), badframe_block);
+	unsafe_copy_siginfo_to_user(&frame->info, &ksig->info, badframe_block);
 	/* Allocate a dummy caller frame for the signal handler. */
 	unsafe_put_user(regs->gpr[1], newsp, badframe_block);
 
 	user_write_access_end();
 
-	/* Save the siginfo outside of the unsafe block. */
-	if (copy_siginfo_to_user(&frame->info, &ksig->info))
-		goto badframe;
-
 	/* Make sure signal handler doesn't get spurious FP exceptions */
 	tsk->thread.fp_state.fpscr = 0;
 
-- 
2.25.0

