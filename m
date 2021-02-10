Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCEA31616C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhBJIsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:48:12 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:41254 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230415AbhBJIpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:45:01 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DbCwn5BhRz9v1NH;
        Wed, 10 Feb 2021 09:44:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZREmQ3qwA8h7; Wed, 10 Feb 2021 09:44:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DbCwn4Qsqz9v1NF;
        Wed, 10 Feb 2021 09:44:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4FD948B7FB;
        Wed, 10 Feb 2021 09:44:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TXrQUKk5z4R8; Wed, 10 Feb 2021 09:44:10 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DF2E68B801;
        Wed, 10 Feb 2021 09:44:09 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id AE6CE6736C; Wed, 10 Feb 2021 08:44:09 +0000 (UTC)
Message-Id: <ad0363ff0ff8c125f40e1cdc589a85bbd7e31693.1612946484.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612898425.git.christophe.leroy@csgroup.eu>
References: <cover.1612898425.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v6 3/2] powerpc/syscall: Avoid storing 'current' in another
 pointer
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 10 Feb 2021 08:44:09 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By saving the pointer pointing to thread_info.flags, gcc copies r2
in a non-volatile register.

We know 'current' doesn't change, so avoid that intermediaite pointer.

Reduces null_syscall benchmark by 2 cycles (322 => 320 cycles)

On PPC64, gcc seems to know that 'current' is not changing, and it keeps
it in a non volatile register to avoid multiple read of 'current' in paca.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v5: Also in interrupt exit prepare
v6: Removed change related to booke current->thread.debug
v7: Rebased on top of "powerpc/32: Handle bookE debugging in C in syscall entry/exit"
---
 arch/powerpc/kernel/interrupt.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index f93664ad4a5e..398cd86b6ada 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -241,7 +241,6 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 					   struct pt_regs *regs,
 					   long scv)
 {
-	unsigned long *ti_flagsp = &current_thread_info()->flags;
 	unsigned long ti_flags;
 	unsigned long ret = 0;
 	bool is_not_scv = !IS_ENABLED(CONFIG_PPC_BOOK3S_64) || !scv;
@@ -257,7 +256,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	/* Check whether the syscall is issued inside a restartable sequence */
 	rseq_syscall(regs);
 
-	ti_flags = *ti_flagsp;
+	ti_flags = current_thread_info()->flags;
 
 	if (unlikely(r3 >= (unsigned long)-MAX_ERRNO) && is_not_scv) {
 		if (likely(!(ti_flags & (_TIF_NOERROR | _TIF_RESTOREALL)))) {
@@ -271,7 +270,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 			ret = _TIF_RESTOREALL;
 		else
 			regs->gpr[3] = r3;
-		clear_bits(_TIF_PERSYSCALL_MASK, ti_flagsp);
+		clear_bits(_TIF_PERSYSCALL_MASK, &current_thread_info()->flags);
 	} else {
 		regs->gpr[3] = r3;
 	}
@@ -284,7 +283,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	local_irq_disable();
 
 again:
-	ti_flags = READ_ONCE(*ti_flagsp);
+	ti_flags = READ_ONCE(current_thread_info()->flags);
 	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
 		local_irq_enable();
 		if (ti_flags & _TIF_NEED_RESCHED) {
@@ -300,7 +299,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 			do_notify_resume(regs, ti_flags);
 		}
 		local_irq_disable();
-		ti_flags = READ_ONCE(*ti_flagsp);
+		ti_flags = READ_ONCE(current_thread_info()->flags);
 	}
 
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S) && IS_ENABLED(CONFIG_PPC_FPU)) {
@@ -357,7 +356,6 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 #ifndef CONFIG_PPC_BOOK3E_64 /* BOOK3E not yet using this */
 notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs, unsigned long msr)
 {
-	unsigned long *ti_flagsp = &current_thread_info()->flags;
 	unsigned long ti_flags;
 	unsigned long flags;
 	unsigned long ret = 0;
@@ -380,7 +378,7 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs, unsigned
 	local_irq_save(flags);
 
 again:
-	ti_flags = READ_ONCE(*ti_flagsp);
+	ti_flags = READ_ONCE(current_thread_info()->flags);
 	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
 		local_irq_enable(); /* returning to user: may enable */
 		if (ti_flags & _TIF_NEED_RESCHED) {
@@ -391,7 +389,7 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs, unsigned
 			do_notify_resume(regs, ti_flags);
 		}
 		local_irq_disable();
-		ti_flags = READ_ONCE(*ti_flagsp);
+		ti_flags = READ_ONCE(current_thread_info()->flags);
 	}
 
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S) && IS_ENABLED(CONFIG_PPC_FPU)) {
@@ -443,7 +441,6 @@ void preempt_schedule_irq(void);
 
 notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsigned long msr)
 {
-	unsigned long *ti_flagsp = &current_thread_info()->flags;
 	unsigned long flags;
 	unsigned long ret = 0;
 #ifdef CONFIG_PPC64
@@ -466,8 +463,8 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 	amr = kuap_get_and_check_amr();
 #endif
 
-	if (unlikely(*ti_flagsp & _TIF_EMULATE_STACK_STORE)) {
-		clear_bits(_TIF_EMULATE_STACK_STORE, ti_flagsp);
+	if (unlikely(current_thread_info()->flags & _TIF_EMULATE_STACK_STORE)) {
+		clear_bits(_TIF_EMULATE_STACK_STORE, &current_thread_info()->flags);
 		ret = 1;
 	}
 
@@ -479,7 +476,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 again:
 		if (IS_ENABLED(CONFIG_PREEMPT)) {
 			/* Return to preemptible kernel context */
-			if (unlikely(*ti_flagsp & _TIF_NEED_RESCHED)) {
+			if (unlikely(current_thread_info()->flags & _TIF_NEED_RESCHED)) {
 				if (preempt_count() == 0)
 					preempt_schedule_irq();
 			}
-- 
2.25.0

