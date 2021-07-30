Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B818B3DBA84
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbhG3OY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:24:28 -0400
Received: from foss.arm.com ([217.140.110.172]:42702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239594AbhG3OXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:23:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7C106D;
        Fri, 30 Jul 2021 07:23:43 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.13.245])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34B513F70D;
        Fri, 30 Jul 2021 07:23:42 -0700 (PDT)
Date:   Fri, 30 Jul 2021 15:23:36 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Yuchen Wei <weiyuchen3@huawei.com>, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, keescook@chromium.org, pcc@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        He Zhe <zhe.he@windriver.com>
Subject: Re: [PATCH] arm64: audit: fix return value high 32bit truncation
 problem
Message-ID: <20210730142336.GA19569@C02TD0UTHF1T.local>
References: <20210722060707.531-1-weiyuchen3@huawei.com>
 <20210730122236.GE23589@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730122236.GE23589@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[adding He Zhe]

On Fri, Jul 30, 2021 at 01:22:37PM +0100, Will Deacon wrote:
> On Thu, Jul 22, 2021 at 02:07:07PM +0800, Yuchen Wei wrote:
> > From: weiyuchen <weiyuchen3@huawei.com>
> > 
> > Add error code judgment in invoke_syscall() to prevent kernel
> > components such as audit and tracepoint from obtaining incorrect
> > return values. For example:
> > 
> > type=SYSCALL msg=audit(342.780:69): arch=40000028 syscall=235
> > success=yes exit=4294967235
> > 
> > The syscall return value is -61, but due to the following process in
> > invoke_syscall():
> > 
> > 	if (is_compat_task())
> > 		ret = lower_32_bits(ret);
> > 	regs->regs[0] = ret;
> > 
> > The return value audit or tracepoint get from regs[0] is 4294967235,
> > which is an incorrect return value.
> > 
> > Signed-off-by: weiyuchen <weiyuchen3@huawei.com>
> > ---
> >  arch/arm64/kernel/syscall.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> > index 263d6c1a525f..f9f042d9a088 100644
> > --- a/arch/arm64/kernel/syscall.c
> > +++ b/arch/arm64/kernel/syscall.c
> > @@ -54,7 +54,7 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
> >  		ret = do_ni_syscall(regs, scno);
> >  	}
> >  
> > -	if (is_compat_task())
> > +	if (is_compat_task() && !IS_ERR_VALUE(ret))
> >  		ret = lower_32_bits(ret);
> 
> Hmm, I'm worried this might break other users who don't expect to see
> non-zero bits for the upper 32-bits of a compat task.
> 
> Mark -- I remember you looking into this relatively recently. Where did you
> get to with it?

Sorry, I've been meaning to chase this up for a bit.

There are a few problems here, but I think we can solve them all (patch
below).

Generally, syscall_get_return_value() should be used to get syscall
return values, and this *should* always sign-extend compat values to 64
bits (but arm64's implementation currently doesn't).

Audit currently uses regs_return_value() rather than
syscall_get_return_value(). That's mostly for historical reasons, but
some architectures don't implement syscall_get_return_value() at the
moment, so we'll have to bodge regs_return_value() on arm64 for now. On
32-bit arm regs_return_value() returns a long, and so is sign-extended.

On 32-bit arm, since syscall_get_return_value() returns a long, it'll
get sign-extended (whether returning an errno or a pointer in the high
2GiB), and we should do the same for compat. We can shuffle
syscall_get_return_value() and syscall_get_error() to handle that.

There are a few places we directly assign to the regs where we need to
truncate the assignment. We can use syscall_set_return_value() to do
that for us.

I think for now, the below should be sufficient for arm64, and we can
chase that up with some cleanup to the core audit code to use
syscall_get_return_value().

Thanks,
Mark.
---->8----
From 20131e3e51e4b6034e11df044ae916a853be43de Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Fri, 30 Jul 2021 15:12:41 +0100
Subject: [PATCH] arm64: fix compat syscall return truncation

TODO: explain this.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: He Zhe <zhe.he@windriver.com>
Cc: Will Deacon <will@kernel.org>
Cc: weiyuchen <weiyuchen3@huawei.com>
---
 arch/arm64/include/asm/ptrace.h  | 12 +++++++++++-
 arch/arm64/include/asm/syscall.h | 19 ++++++++++---------
 arch/arm64/kernel/ptrace.c       |  2 +-
 arch/arm64/kernel/signal.c       |  3 ++-
 arch/arm64/kernel/syscall.c      |  9 +++------
 5 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index e58bca832dff..41b332c054ab 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -320,7 +320,17 @@ static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 
 static inline unsigned long regs_return_value(struct pt_regs *regs)
 {
-	return regs->regs[0];
+	unsigned long val = regs->regs[0];
+
+	/*
+	 * Audit currently uses regs_return_value() instead of
+	 * syscall_get_return_value(). Apply the same sign-extension here until
+	 * audit is updated to use syscall_get_return_value().
+	 */
+	if (compat_user_mode(regs))
+		val = sign_extend64(val, 31);
+
+	return val;
 }
 
 static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index cfc0672013f6..03e20895453a 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -29,22 +29,23 @@ static inline void syscall_rollback(struct task_struct *task,
 	regs->regs[0] = regs->orig_x0;
 }
 
-
-static inline long syscall_get_error(struct task_struct *task,
-				     struct pt_regs *regs)
+static inline long syscall_get_return_value(struct task_struct *task,
+					    struct pt_regs *regs)
 {
-	unsigned long error = regs->regs[0];
+	unsigned long val = regs->regs[0];
 
 	if (is_compat_thread(task_thread_info(task)))
-		error = sign_extend64(error, 31);
+		val = sign_extend64(val, 31);
 
-	return IS_ERR_VALUE(error) ? error : 0;
+	return val;
 }
 
-static inline long syscall_get_return_value(struct task_struct *task,
-					    struct pt_regs *regs)
+static inline long syscall_get_error(struct task_struct *task,
+				     struct pt_regs *regs)
 {
-	return regs->regs[0];
+	unsigned long error = syscall_get_return_value(task, regs);
+
+	return IS_ERR_VALUE(error) ? error : 0;
 }
 
 static inline void syscall_set_return_value(struct task_struct *task,
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 499b6b2f9757..b381a1ee9ea7 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1862,7 +1862,7 @@ void syscall_trace_exit(struct pt_regs *regs)
 	audit_syscall_exit(regs);
 
 	if (flags & _TIF_SYSCALL_TRACEPOINT)
-		trace_sys_exit(regs, regs_return_value(regs));
+		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
 	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_EXIT);
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 53c2c85efb34..62e273b2d83f 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -29,6 +29,7 @@
 #include <asm/unistd.h>
 #include <asm/fpsimd.h>
 #include <asm/ptrace.h>
+#include <asm/syscall.h>
 #include <asm/signal32.h>
 #include <asm/traps.h>
 #include <asm/vdso.h>
@@ -890,7 +891,7 @@ static void do_signal(struct pt_regs *regs)
 		     retval == -ERESTART_RESTARTBLOCK ||
 		     (retval == -ERESTARTSYS &&
 		      !(ksig.ka.sa.sa_flags & SA_RESTART)))) {
-			regs->regs[0] = -EINTR;
+			syscall_set_return_value(current, regs, -EINTR, 0);
 			regs->pc = continue_addr;
 		}
 
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 263d6c1a525f..50a0f1a38e84 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -54,10 +54,7 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 		ret = do_ni_syscall(regs, scno);
 	}
 
-	if (is_compat_task())
-		ret = lower_32_bits(ret);
-
-	regs->regs[0] = ret;
+	syscall_set_return_value(current, regs, 0, ret);
 
 	/*
 	 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
@@ -115,7 +112,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		 * syscall. do_notify_resume() will send a signal to userspace
 		 * before the syscall is restarted.
 		 */
-		regs->regs[0] = -ERESTARTNOINTR;
+		syscall_set_return_value(current, regs, -ERESTARTNOINTR, 0);
 		return;
 	}
 
@@ -136,7 +133,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		 * anyway.
 		 */
 		if (scno == NO_SYSCALL)
-			regs->regs[0] = -ENOSYS;
+			syscall_set_return_value(current, regs, -ENOSYS, 0);
 		scno = syscall_trace_enter(regs);
 		if (scno == NO_SYSCALL)
 			goto trace_exit;
-- 
2.11.0

