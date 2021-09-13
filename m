Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489EB40972E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344451AbhIMPYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:24:08 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:35321 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345157AbhIMPXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:23:12 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H7VWm3dBGz9sVf;
        Mon, 13 Sep 2021 17:19:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ALW_r9C92Jf8; Mon, 13 Sep 2021 17:19:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H7VWh3dSRz9sVr;
        Mon, 13 Sep 2021 17:19:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D3288B781;
        Mon, 13 Sep 2021 17:19:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id sRnfFZEVp5ui; Mon, 13 Sep 2021 17:19:28 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.107])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2DDBE8B775;
        Mon, 13 Sep 2021 17:19:28 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18DFJKkt157780
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 13 Sep 2021 17:19:20 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18DFJKuW157779;
        Mon, 13 Sep 2021 17:19:20 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ebiederm@xmission.com,
        hch@infradead.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RESEND v3 6/6] powerpc/signal: Use unsafe_copy_siginfo_to_user()
Date:   Mon, 13 Sep 2021 17:19:10 +0200
Message-Id: <2b179deba4fd4ec0868cdc48a0230dfa3aa5a22f.1631537060.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <1718f38859d5366f82d5bef531f255cedf537b5d.1631537060.git.christophe.leroy@csgroup.eu>
References: <1718f38859d5366f82d5bef531f255cedf537b5d.1631537060.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use unsafe_copy_siginfo_to_user() in order to do the copy
within the user access block.

On an mpc 8321 (book3s/32) the improvment is about 5% on a process
sending a signal to itself.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: Don't leave compat aside, use the new unsafe_copy_siginfo_to_user32()
---
 arch/powerpc/kernel/signal_32.c | 8 +++-----
 arch/powerpc/kernel/signal_64.c | 5 +----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index ff101e2b3bab..3a2db8af2d65 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -710,9 +710,9 @@ static long restore_tm_user_regs(struct pt_regs *regs, struct mcontext __user *s
 }
 #endif
 
-#ifdef CONFIG_PPC64
+#ifndef CONFIG_PPC64
 
-#define copy_siginfo_to_user	copy_siginfo_to_user32
+#define unsafe_copy_siginfo_to_user32	unsafe_copy_siginfo_to_user
 
 #endif /* CONFIG_PPC64 */
 
@@ -779,15 +779,13 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 		asm("dcbst %y0; sync; icbi %y0; sync" :: "Z" (mctx->mc_pad[0]));
 	}
 	unsafe_put_sigset_t(&frame->uc.uc_sigmask, oldset, failed);
+	unsafe_copy_siginfo_to_user32(&frame->info, &ksig->info, failed);
 
 	/* create a stack frame for the caller of the handler */
 	unsafe_put_user(regs->gpr[1], newsp, failed);
 
 	user_access_end();
 
-	if (copy_siginfo_to_user(&frame->info, &ksig->info))
-		goto badframe;
-
 	regs->link = tramp;
 
 #ifdef CONFIG_PPC_FPU_REGS
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index d80ff83cacb9..56c0c74aa28c 100644
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
2.31.1

