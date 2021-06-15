Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBAE3A7737
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 08:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhFOGnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 02:43:09 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:57145 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhFOGnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:43:03 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G3zGx6s9lzB9CB;
        Tue, 15 Jun 2021 08:40:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IH65QaxPJ6dr; Tue, 15 Jun 2021 08:40:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G3zGx5y0QzB9BM;
        Tue, 15 Jun 2021 08:40:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B98838B7A3;
        Tue, 15 Jun 2021 08:40:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9l20SPmXXWb7; Tue, 15 Jun 2021 08:40:57 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 814828B7A2;
        Tue, 15 Jun 2021 08:40:57 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 43DE56627B; Tue, 15 Jun 2021 06:40:57 +0000 (UTC)
Message-Id: <b813c1f4d3dab2f51300eac44d99029aa8e57830.1623739212.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/7] powerpc/signal64: Copy siginfo before changing regs->nip
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 15 Jun 2021 06:40:57 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

In commit 96d7a4e06fab ("powerpc/signal64: Rewrite handle_rt_signal64()
to minimise uaccess switches") the 64-bit signal code was rearranged to
use user_write_access_begin/end().

As part of that change the call to copy_siginfo_to_user() was moved
later in the function, so that it could be done after the
user_write_access_end().

In particular it was moved after we modify regs->nip to point to the
signal trampoline. That means if copy_siginfo_to_user() fails we exit
handle_rt_signal64() with an error but with regs->nip modified, whereas
previously we would not modify regs->nip until the copy succeeded.

Returning an error from signal delivery but with regs->nip updated
leaves the process in a sort of half-delivered state. We do immediately
force a SEGV in signal_setup_done(), called from do_signal(), so the
process should never run in the half-delivered state.

However that SEGV is not delivered until we've gone around to
do_notify_resume() again, so it's possible some tracing could observe
the half-delivered state.

There are other cases where we fail signal delivery with regs partly
updated, eg. the write to newsp and SA_SIGINFO, but the latter at least
is very unlikely to fail as it reads back from the frame we just wrote
to.

Looking at other arches they seem to be more careful about leaving regs
unchanged until the copy operations have succeeded, and in general that
seems like good hygenie.

So although the current behaviour is not cleary buggy, it's also not
clearly correct. So move the call to copy_siginfo_to_user() up prior to
the modification of regs->nip, which is closer to the old behaviour, and
easier to reason about.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_64.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index dca66481d0c2..f9e1f5428b9e 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -902,6 +902,10 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 	unsafe_copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set), badframe_block);
 	user_write_access_end();
 
+	/* Save the siginfo outside of the unsafe block. */
+	if (copy_siginfo_to_user(&frame->info, &ksig->info))
+		goto badframe;
+
 	/* Make sure signal handler doesn't get spurious FP exceptions */
 	tsk->thread.fp_state.fpscr = 0;
 
@@ -915,11 +919,6 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 		regs->nip = (unsigned long) &frame->tramp[0];
 	}
 
-
-	/* Save the siginfo outside of the unsafe block. */
-	if (copy_siginfo_to_user(&frame->info, &ksig->info))
-		goto badframe;
-
 	/* Allocate a dummy caller frame for the signal handler. */
 	newsp = ((unsigned long)frame) - __SIGNAL_FRAMESIZE;
 	err |= put_user(regs->gpr[1], (unsigned long __user *)newsp);
-- 
2.25.0

