Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E8D3B41F2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhFYKwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:52:15 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19544 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhFYKwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:52:14 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GBDKX63ZFzB9gd;
        Fri, 25 Jun 2021 12:49:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y164RUTDqSRM; Fri, 25 Jun 2021 12:49:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GBDKX56HGzB9TV;
        Fri, 25 Jun 2021 12:49:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 97F1D8B802;
        Fri, 25 Jun 2021 12:49:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9laEfmfNKLR5; Fri, 25 Jun 2021 12:49:52 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E9E58B7FF;
        Fri, 25 Jun 2021 12:49:52 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 082F666359; Fri, 25 Jun 2021 10:49:51 +0000 (UTC)
Message-Id: <afe50d1db63a10fde9547ea08fe1fa68b0638aba.1624618157.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/2] powerpc/signal: Fix handling of SA_RESTORER sigaction
 flag
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 25 Jun 2021 10:49:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc advertises support of SA_RESTORER sigaction flag.

Make it the truth.

Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 8 ++++++--
 arch/powerpc/kernel/signal_64.c | 4 +++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 0608581967f0..cf3da1386595 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -769,7 +769,9 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	}
 
 	/* Save user registers on the stack */
-	if (tsk->mm->context.vdso) {
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
+		tramp = (unsigned long)ksig->ka.sa.sa_restorer;
+	} else if (tsk->mm->context.vdso) {
 		tramp = VDSO32_SYMBOL(tsk->mm->context.vdso, sigtramp_rt32);
 	} else {
 		tramp = (unsigned long)mctx->mc_pad;
@@ -865,7 +867,9 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 	else
 		unsafe_save_user_regs(regs, mctx, tm_mctx, 1, failed);
 
-	if (tsk->mm->context.vdso) {
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
+		tramp = (unsigned long)ksig->ka.sa.sa_restorer;
+	} else if (tsk->mm->context.vdso) {
 		tramp = VDSO32_SYMBOL(tsk->mm->context.vdso, sigtramp32);
 	} else {
 		tramp = (unsigned long)mctx->mc_pad;
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 1831bba0582e..fb31a334aca6 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -910,7 +910,9 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 	tsk->thread.fp_state.fpscr = 0;
 
 	/* Set up to return from userspace. */
-	if (tsk->mm->context.vdso) {
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
+		regs_set_return_ip(regs, (unsigned long)ksig->ka.sa.sa_restorer);
+	} else if (tsk->mm->context.vdso) {
 		regs_set_return_ip(regs, VDSO64_SYMBOL(tsk->mm->context.vdso, sigtramp_rt64));
 	} else {
 		err |= setup_trampoline(__NR_rt_sigreturn, &frame->tramp[0]);
-- 
2.25.0

