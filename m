Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD74330E1BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhBCSCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbhBCSBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:01:35 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487B6C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 10:00:54 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 012321F45A38
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kyle Huey <me@kylehuey.com>, Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Subject: [PATCH] entry: Fix missed trap after single-step on system call return
Organization: Collabora
References: <CAP045Ao_Zb0HGg0=bvUeV6GjX=-3fz0ScsvM_jE7VsZcVk_-tg@mail.gmail.com>
        <C479ACCB-A1A5-4422-8120-999E8D54314B@amacapital.net>
        <CAP045AoMRNjvVd1PdHvdf-nn3LNpTDp66sp+SAmZgNU888iFQQ@mail.gmail.com>
        <CAP045ApWnr=UQrBrv3fHj-C6EweukMWEyrCgsiY6Bt_i1Vdj6A@mail.gmail.com>
        <CAHk-=wgqRgk0hjvpjHNixK7xSOS_F3fpt3bL9ZUJVhCL3oGgyw@mail.gmail.com>
        <CAHk-=wgOp10DO9jtMC=B=RoTLWe7MFTS5pH4JeZ78-tbqTY1vw@mail.gmail.com>
Date:   Wed, 03 Feb 2021 13:00:48 -0500
In-Reply-To: <CAHk-=wgOp10DO9jtMC=B=RoTLWe7MFTS5pH4JeZ78-tbqTY1vw@mail.gmail.com>
        (Linus Torvalds's message of "Sun, 31 Jan 2021 15:55:54 -0800")
Message-ID: <87h7mtc9pr.fsf_-_@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, Jan 31, 2021 at 3:35 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I wonder if the simple solution is to just
>>
>>  (a) always set one of the SYSCALL_WORK_EXIT bits on the child in
>> ptrace (exactly to catch the child on system call exit)
>>
>>  (b) basically revert 299155244770 ("entry: Drop usage of TIF flags in
>> the generic syscall code") and have the syscall exit code check the
>> TIF_SINGLESTEP flag
>
> Actually, (b) looks unnecessary - as long as we get to
> syscall_exit_work(), the current code will work fine.
>
> So maybe just add a dummy SYSCALL_WORK_SYSCALL_EXIT_TRAP, and set that
> flag whenever a singestep is requested for a process that is currently
> in a system call?
>
> IOW, make it a very explicit "do TF for system calls", rather than the
> old code that was doing so implicitly and not very obviously. Hmm?

Linus,

Does the patch below follows your suggestion?  I'm setting the
SYSCALL_WORK shadowing TIF_SINGLESTEP every time, instead of only when
the child is inside a system call.  Is this acceptable?

This seems to pass Kyle's test case.  Kyle, can you verify it works with
rr?

I can also turn Kyle's test case into a selftest, if it is ok with him.

Thanks,

-- >8 --
Subject: [PATCH] entry: Fix missed trap after single-step on a system call return

Commit 299155244770 ("entry: Drop usage of TIF flags in the generic
syscall code") introduces a bug on architectures using the generic
syscall entry code, in which processes stopped by PTRACE_SYSCALL do not
trap on syscall return after receiving a TIF_SINGLESTEP. The reason is
the meaning of TIF_SINGLESTEP flag is overloaded to cause the trap after
a system call is executed, but since the above commit, the syscall call
handler only checks for the SYSCALL_WORK flags on the exit work.

This patch splits the meaning of TIF_SINGLESTEP such that it only means
single-step mode, and creates a new type of SYSCALL_WORK to request a
trap immediately after a syscall in single-step mode.  In the current
implementation, the SYSCALL_WORK flag shadows the TIF_SINGLESTEP flag
for simplicity.

Since x86 is the only code already using the generic syscall handling,
this also updates that architecture to flip this bit when a tracer
enables single step.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 299155244770 ("entry: Drop usage of TIF flags in the generic syscall code")
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/include/asm/entry-common.h |  2 --
 arch/x86/kernel/step.c              | 10 ++++++++--
 include/linux/entry-common.h        |  1 +
 include/linux/thread_info.h         |  2 ++
 kernel/entry/common.c               | 12 ++----------
 5 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 6fe54b2813c1..2b87b191b3b8 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -43,8 +43,6 @@ static __always_inline void arch_check_user_regs(struct pt_regs *regs)
 }
 #define arch_check_user_regs arch_check_user_regs
 
-#define ARCH_SYSCALL_EXIT_WORK		(_TIF_SINGLESTEP)
-
 static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 						  unsigned long ti_work)
 {
diff --git a/arch/x86/kernel/step.c b/arch/x86/kernel/step.c
index 60d2c3798ba2..de975b62f10a 100644
--- a/arch/x86/kernel/step.c
+++ b/arch/x86/kernel/step.c
@@ -127,12 +127,17 @@ static int enable_single_step(struct task_struct *child)
 		regs->flags |= X86_EFLAGS_TF;
 
 	/*
-	 * Always set TIF_SINGLESTEP - this guarantees that
-	 * we single-step system calls etc..  This will also
+	 * Always set TIF_SINGLESTEP.  This will also
 	 * cause us to set TF when returning to user mode.
 	 */
 	set_tsk_thread_flag(child, TIF_SINGLESTEP);
 
+	/*
+	 * Trigger a trap is triggered once stepping out of a system
+	 * call prior to executing any user instruction.
+	 */
+	set_task_syscall_work(child, SYSCALL_EXIT_TRAP);
+
 	oflags = regs->flags;
 
 	/* Set TF on the kernel stack.. */
@@ -230,6 +235,7 @@ void user_disable_single_step(struct task_struct *child)
 
 	/* Always clear TIF_SINGLESTEP... */
 	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
+	clear_task_syscall_work(child, SYSCALL_EXIT_TRAP);
 
 	/* But touch TF only if it was set by us.. */
 	if (test_and_clear_tsk_thread_flag(child, TIF_FORCED_TF))
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index ca86a00abe86..a104b298019a 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -46,6 +46,7 @@
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
 				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
+				 SYSCALL_WORK_SYSCALL_EXIT_TRAP	|	\
 				 ARCH_SYSCALL_WORK_EXIT)
 
 /*
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index c8a974cead73..9b2158c69275 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -43,6 +43,7 @@ enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SYSCALL_EMU,
 	SYSCALL_WORK_BIT_SYSCALL_AUDIT,
 	SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH,
+	SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP,
 };
 
 #define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
@@ -51,6 +52,7 @@ enum syscall_work_bit {
 #define SYSCALL_WORK_SYSCALL_EMU	BIT(SYSCALL_WORK_BIT_SYSCALL_EMU)
 #define SYSCALL_WORK_SYSCALL_AUDIT	BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
 #define SYSCALL_WORK_SYSCALL_USER_DISPATCH BIT(SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH)
+#define SYSCALL_WORK_SYSCALL_EXIT_TRAP	BIT(SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP)
 #endif
 
 #include <asm/thread_info.h>
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 6dd82be60df8..f9d491b17b78 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -209,15 +209,9 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
 	lockdep_sys_exit();
 }
 
-#ifndef _TIF_SINGLESTEP
-static inline bool report_single_step(unsigned long work)
-{
-	return false;
-}
-#else
 /*
  * If SYSCALL_EMU is set, then the only reason to report is when
- * TIF_SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
+ * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
  * instruction has been already reported in syscall_enter_from_user_mode().
  */
 static inline bool report_single_step(unsigned long work)
@@ -225,10 +219,8 @@ static inline bool report_single_step(unsigned long work)
 	if (work & SYSCALL_WORK_SYSCALL_EMU)
 		return false;
 
-	return !!(current_thread_info()->flags & _TIF_SINGLESTEP);
+	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
 }
-#endif
-
 
 static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 {
-- 
2.30.0

