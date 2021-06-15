Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2413A7739
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 08:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFOGnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 02:43:22 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15402 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229983AbhFOGnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:43:05 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G3zGz6YgjzB9CM;
        Tue, 15 Jun 2021 08:40:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4LSHGgtLUzVC; Tue, 15 Jun 2021 08:40:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G3zGy5lp4zB9BM;
        Tue, 15 Jun 2021 08:40:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BB4848B7A3;
        Tue, 15 Jun 2021 08:40:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iSE_0BqpddPX; Tue, 15 Jun 2021 08:40:58 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 79B488B7A2;
        Tue, 15 Jun 2021 08:40:58 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 51AE26627B; Tue, 15 Jun 2021 06:40:58 +0000 (UTC)
Message-Id: <a2134d0ed504f5ccdd4449487e731a4e244fd13f.1623739212.git.christophe.leroy@csgroup.eu>
In-Reply-To: <b813c1f4d3dab2f51300eac44d99029aa8e57830.1623739212.git.christophe.leroy@csgroup.eu>
References: <b813c1f4d3dab2f51300eac44d99029aa8e57830.1623739212.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/7] powerpc/signal64: Don't read sigaction arguments back
 from user memory
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 15 Jun 2021 06:40:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

When delivering a signal to a sigaction style handler (SA_SIGINFO), we
pass pointers to the siginfo and ucontext via r4 and r5.

Currently we populate the values in those registers by reading the
pointers out of the sigframe in user memory, even though the values in
user memory were written by the kernel just prior:

  unsafe_put_user(&frame->info, &frame->pinfo, badframe_block);
  unsafe_put_user(&frame->uc, &frame->puc, badframe_block);
  ...
  if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
  	err |= get_user(regs->gpr[4], (unsigned long __user *)&frame->pinfo);
  	err |= get_user(regs->gpr[5], (unsigned long __user *)&frame->puc);

ie. we write &frame->info into frame->pinfo, and then read frame->pinfo
back into r4, and similarly for &frame->uc.

The code has always been like this, since linux-fullhistory commit
d4f2d95eca2c ("Forward port of 2.4 ppc64 signal changes.").

There's no reason for us to read the values back from user memory,
rather than just setting the value in the gpr[4/5] directly. In fact
reading the value back from user memory opens up the possibility of
another user thread changing the values before we read them back.
Although any process doing that would be racing against the kernel
delivering the signal, and would risk corrupting the stack, so that
would be a userspace bug.

Note that this is 64-bit only code, so there's no subtlety with the size
of pointers differing between kernel and user. Also the frame variable
is not modified to point elsewhere during the function.

In the past reading the values back from user memory was not costly, but
now that we have KUAP on some CPUs it is, so we'd rather avoid it for
that reason too.

So change the code to just set the values directly, using the same
values we have written to the sigframe previously in the function.

Note also that this matches what our 32-bit signal code does.

Using a version of will-it-scale's signal1_threads that sets SA_SIGINFO,
this results in a ~4% increase in signals per second on a Power9, from
229,777 to 239,766.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index f9e1f5428b9e..8b2eb758131c 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -947,8 +947,8 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 	regs->gpr[3] = ksig->sig;
 	regs->result = 0;
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-		err |= get_user(regs->gpr[4], (unsigned long __user *)&frame->pinfo);
-		err |= get_user(regs->gpr[5], (unsigned long __user *)&frame->puc);
+		regs->gpr[4] = (unsigned long)&frame->info;
+		regs->gpr[5] = (unsigned long)&frame->uc;
 		regs->gpr[6] = (unsigned long) frame;
 	} else {
 		regs->gpr[4] = (unsigned long)&frame->uc.uc_mcontext;
-- 
2.25.0

