Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A2C454B07
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhKQQfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:35:12 -0500
Received: from foss.arm.com ([217.140.110.172]:60618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239182AbhKQQer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:34:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E9B51476;
        Wed, 17 Nov 2021 08:31:48 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C13B93F5A1;
        Wed, 17 Nov 2021 08:31:44 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, efuller@redhat.com,
        elver@google.com, ink@jurassic.park.msu.ru, joey.gouly@arm.com,
        jonas@southpole.se, juri.lelli@redhat.com, linux@armlinux.org.uk,
        luto@kernel.org, mark.rutland@arm.com, mattst88@gmail.com,
        michal.simek@xilinx.com, mingo@redhat.com, mpe@ellerman.id.au,
        npiggin@gmail.com, paulmck@kernel.org, paulus@samba.org,
        peterz@infradead.org, rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        vincent.guittot@linaro.org, will@kernel.org
Subject: [PATCHv7 10/11] powerpc: snapshot thread flags
Date:   Wed, 17 Nov 2021 16:30:48 +0000
Message-Id: <20211117163050.53986-11-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211117163050.53986-1-mark.rutland@arm.com>
References: <20211117163050.53986-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some thread flags can be set remotely, and so even when IRQs are
disabled, the flags can change under our feet. Generally this is
unlikely to cause a problem in practice, but it is somewhat unsound, and
KCSAN will legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/interrupt.c     | 13 ++++++-------
 arch/powerpc/kernel/ptrace/ptrace.c |  3 +--
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 1c821b76c2d1..ff25888ffc25 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -181,7 +181,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 
 	local_irq_enable();
 
-	if (unlikely(current_thread_info()->flags & _TIF_SYSCALL_DOTRACE)) {
+	if (unlikely(read_thread_flags() & _TIF_SYSCALL_DOTRACE)) {
 		if (unlikely(trap_is_unsupported_scv(regs))) {
 			/* Unsupported scv vector */
 			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
@@ -343,7 +343,7 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
 	unsigned long ti_flags;
 
 again:
-	ti_flags = READ_ONCE(current_thread_info()->flags);
+	ti_flags = read_thread_flags();
 	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
 		local_irq_enable();
 		if (ti_flags & _TIF_NEED_RESCHED) {
@@ -359,7 +359,7 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
 			do_notify_resume(regs, ti_flags);
 		}
 		local_irq_disable();
-		ti_flags = READ_ONCE(current_thread_info()->flags);
+		ti_flags = read_thread_flags();
 	}
 
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && IS_ENABLED(CONFIG_PPC_FPU)) {
@@ -437,7 +437,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	/* Check whether the syscall is issued inside a restartable sequence */
 	rseq_syscall(regs);
 
-	ti_flags = current_thread_info()->flags;
+	ti_flags = read_thread_flags();
 
 	if (unlikely(r3 >= (unsigned long)-MAX_ERRNO) && is_not_scv) {
 		if (likely(!(ti_flags & (_TIF_NOERROR | _TIF_RESTOREALL)))) {
@@ -532,8 +532,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 	unsigned long flags;
 	unsigned long ret = 0;
 	unsigned long kuap;
-	bool stack_store = current_thread_info()->flags &
-						_TIF_EMULATE_STACK_STORE;
+	bool stack_store = read_thread_flags() & _TIF_EMULATE_STACK_STORE;
 
 	if (regs_is_unrecoverable(regs))
 		unrecoverable_exception(regs);
@@ -554,7 +553,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 again:
 		if (IS_ENABLED(CONFIG_PREEMPT)) {
 			/* Return to preemptible kernel context */
-			if (unlikely(current_thread_info()->flags & _TIF_NEED_RESCHED)) {
+			if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
 				if (preempt_count() == 0)
 					preempt_schedule_irq();
 			}
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index 7c7093c17c45..c43f77e2ac31 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -260,8 +260,7 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	u32 flags;
 
-	flags = READ_ONCE(current_thread_info()->flags) &
-		(_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
+	flags = read_thread_flags() & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
 
 	if (flags) {
 		int rc = tracehook_report_syscall_entry(regs);
-- 
2.11.0

