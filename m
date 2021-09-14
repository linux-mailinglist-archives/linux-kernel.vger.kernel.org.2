Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C99540ABBB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhINKcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:32:36 -0400
Received: from foss.arm.com ([217.140.110.172]:42968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231633AbhINKcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:32:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F321711FB;
        Tue, 14 Sep 2021 03:31:05 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E21D33F59C;
        Tue, 14 Sep 2021 03:31:02 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, elver@google.com,
        ink@jurassic.park.msu.ru, jonas@southpole.se,
        juri.lelli@redhat.com, linux@armlinux.org.uk, luto@kernel.org,
        mark.rutland@arm.com, mattst88@gmail.com, michal.simek@xilinx.com,
        mingo@redhat.com, mpe@ellerman.id.au, paulmck@kernel.org,
        paulus@samba.org, peterz@infradead.org, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, vincent.guittot@linaro.org, will@kernel.org
Subject: [PATCH v5 06/10] arm64: snapshot thread flags
Date:   Tue, 14 Sep 2021 11:30:23 +0100
Message-Id: <20210914103027.53565-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210914103027.53565-1-mark.rutland@arm.com>
References: <20210914103027.53565-1-mark.rutland@arm.com>
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
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/entry-common.c | 2 +-
 arch/arm64/kernel/ptrace.c       | 4 ++--
 arch/arm64/kernel/signal.c       | 2 +-
 arch/arm64/kernel/syscall.c      | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 32f9796c4ffe..83aef3dd6662 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -128,7 +128,7 @@ static __always_inline void prepare_exit_to_user_mode(struct pt_regs *regs)
 
 	local_daif_mask();
 
-	flags = READ_ONCE(current_thread_info()->flags);
+	flags = read_thread_flags();
 	if (unlikely(flags & _TIF_WORK_MASK))
 		do_notify_resume(regs, flags);
 }
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index e26196a33cf4..9dab4f127cfd 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1839,7 +1839,7 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 
 int syscall_trace_enter(struct pt_regs *regs)
 {
-	unsigned long flags = READ_ONCE(current_thread_info()->flags);
+	unsigned long flags = read_thread_flags();
 
 	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
@@ -1862,7 +1862,7 @@ int syscall_trace_enter(struct pt_regs *regs)
 
 void syscall_trace_exit(struct pt_regs *regs)
 {
-	unsigned long flags = READ_ONCE(current_thread_info()->flags);
+	unsigned long flags = read_thread_flags();
 
 	audit_syscall_exit(regs);
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 9fe70b12b34f..c531d5358461 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -950,7 +950,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
 		}
 
 		local_daif_mask();
-		thread_flags = READ_ONCE(current_thread_info()->flags);
+		thread_flags = read_thread_flags();
 	} while (thread_flags & _TIF_WORK_MASK);
 }
 
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 50a0f1a38e84..c938603b3ba0 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -81,7 +81,7 @@ void syscall_trace_exit(struct pt_regs *regs);
 static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 			   const syscall_fn_t syscall_table[])
 {
-	unsigned long flags = current_thread_info()->flags;
+	unsigned long flags = read_thread_flags();
 
 	regs->orig_x0 = regs->regs[0];
 	regs->syscallno = scno;
@@ -148,7 +148,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	 */
 	if (!has_syscall_work(flags) && !IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
 		local_daif_mask();
-		flags = current_thread_info()->flags;
+		flags = read_thread_flags();
 		if (!has_syscall_work(flags) && !(flags & _TIF_SINGLESTEP))
 			return;
 		local_daif_restore(DAIF_PROCCTX);
-- 
2.11.0

