Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94419362118
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 15:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244015AbhDPNfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 09:35:19 -0400
Received: from foss.arm.com ([217.140.110.172]:41714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240407AbhDPNfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 09:35:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F61F11B3;
        Fri, 16 Apr 2021 06:34:53 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.1.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AD323F85F;
        Fri, 16 Apr 2021 06:34:50 -0700 (PDT)
Date:   Fri, 16 Apr 2021 14:34:41 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org
Cc:     He Zhe <zhe.he@windriver.com>, oleg@redhat.com,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: ptrace: Add is_syscall_success to handle
 compat
Message-ID: <20210416133431.GA2303@C02TD0UTHF1T.local>
References: <20210416075533.7720-1-zhe.he@windriver.com>
 <20210416123322.GA23184@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416123322.GA23184@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 01:33:22PM +0100, Catalin Marinas wrote:
> On Fri, Apr 16, 2021 at 03:55:31PM +0800, He Zhe wrote:
> > The general version of is_syscall_success does not handle 32-bit
> > compatible case, which would cause 32-bit negative return code to be
> > recoganized as a positive number later and seen as a "success".
> > 
> > Since is_compat_thread is defined in compat.h, implementing
> > is_syscall_success in ptrace.h would introduce build failure due to
> > recursive inclusion of some basic headers like mutex.h. We put the
> > implementation to ptrace.c
> > 
> > Signed-off-by: He Zhe <zhe.he@windriver.com>
> > ---
> >  arch/arm64/include/asm/ptrace.h |  3 +++
> >  arch/arm64/kernel/ptrace.c      | 10 ++++++++++
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> > index e58bca832dff..3c415e9e5d85 100644
> > --- a/arch/arm64/include/asm/ptrace.h
> > +++ b/arch/arm64/include/asm/ptrace.h
> > @@ -328,6 +328,9 @@ static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
> >  	regs->regs[0] = rc;
> >  }
> >  
> > +extern inline int is_syscall_success(struct pt_regs *regs);
> > +#define is_syscall_success(regs) is_syscall_success(regs)
> > +
> >  /**
> >   * regs_get_kernel_argument() - get Nth function argument in kernel
> >   * @regs:	pt_regs of that context
> > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > index 170f42fd6101..3266201f8c60 100644
> > --- a/arch/arm64/kernel/ptrace.c
> > +++ b/arch/arm64/kernel/ptrace.c
> > @@ -1909,3 +1909,13 @@ int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task)
> >  	else
> >  		return valid_native_regs(regs);
> >  }
> > +
> > +inline int is_syscall_success(struct pt_regs *regs)
> > +{
> > +	unsigned long val = regs->regs[0];
> > +
> > +	if (is_compat_thread(task_thread_info(current)))
> > +		val = sign_extend64(val, 31);
> > +
> > +	return !IS_ERR_VALUE(val);
> > +}
> 
> It's better to use compat_user_mode(regs) here instead of
> is_compat_thread(). It saves us from worrying whether regs are for the
> current context.
> 
> I think we should change regs_return_value() instead. This function
> seems to be called from several other places and it has the same
> potential problems if called on compat pt_regs.

I think this is a problem we created for ourselves back in commit:

  15956689a0e60aa0 ("arm64: compat: Ensure upper 32 bits of x0 are zero on syscall return)

AFAICT, the perf regs samples are the only place this matters, since for
ptrace the compat regs are implicitly truncated to compat_ulong_t, and
audit expects the non-truncated return value. Other architectures don't
truncate here, so I think we're setting ourselves up for a game of
whack-a-mole to truncate and extend wherever we need to.

Given that, I suspect it'd be better to do something like the below.

Will, thoughts?

Mark.

---->8----
From df0f7c160240d9ee6f20f87a180326d3253e80fb Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Fri, 16 Apr 2021 13:58:54 +0100
Subject: [PATCH] arm64: perf: truncate compat regs

For compat userspace, it doesn't generally make sense for the upper 32
bits of GPRs to be set, as these bits don't really exist in AArch32.
However, for structural reasons the kernel may transiently set the upper
32 bits of registers in pt_regs at points where a perf sample can be
taken.

We tried to avoid this happening in commit:

  15956689a0e60aa0 ("arm64: compat: Ensure upper 32 bits of x0 are zero on syscall return")

... by having invoke_syscall() truncate the return value for compat
tasks, with helpers in <asm/syscall.h> extending the return value when
required.

Unfortunately this is not complete, as there are other places where we
assign the return value, such as when el0_svc_common() sets up a return
of -ENOSYS.

Further, this approach breaks the audit code, which relies on the upper
32 bits of the return value.

Instead, let's have the perf code explicitly truncate the user regs to
32 bits, and otherwise preserve those within the kernel.

Fixes: 15956689a0e60aa0 ("arm64: compat: Ensure upper 32 bits of x0 are zero on syscall return")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/syscall.h | 11 +----------
 arch/arm64/kernel/perf_regs.c    | 26 ++++++++++++++++----------
 arch/arm64/kernel/syscall.c      |  3 ---
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index cfc0672013f6..0ebeaf6dbd45 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -35,9 +35,6 @@ static inline long syscall_get_error(struct task_struct *task,
 {
 	unsigned long error = regs->regs[0];
 
-	if (is_compat_thread(task_thread_info(task)))
-		error = sign_extend64(error, 31);
-
 	return IS_ERR_VALUE(error) ? error : 0;
 }
 
@@ -51,13 +48,7 @@ static inline void syscall_set_return_value(struct task_struct *task,
 					    struct pt_regs *regs,
 					    int error, long val)
 {
-	if (error)
-		val = error;
-
-	if (is_compat_thread(task_thread_info(task)))
-		val = lower_32_bits(val);
-
-	regs->regs[0] = val;
+	regs->regs[0] = (long) error ? error : val;
 }
 
 #define SYSCALL_MAX_ARGS 6
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index f6f58e6265df..296f0c55b4e2 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -9,6 +9,17 @@
 #include <asm/perf_regs.h>
 #include <asm/ptrace.h>
 
+static u64 __perf_reg_value(struct pt_regs *regs, int idx)
+{
+	if ((u32)idx == PERF_REG_ARM64_SP)
+		return regs->sp;
+
+	if ((u32)idx == PERF_REG_ARM64_PC)
+		return regs->pc;
+
+	return regs->regs[idx];
+}
+
 u64 perf_reg_value(struct pt_regs *regs, int idx)
 {
 	if (WARN_ON_ONCE((u32)idx >= PERF_REG_ARM64_MAX))
@@ -38,20 +49,15 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	 */
 	if (compat_user_mode(regs)) {
 		if ((u32)idx == PERF_REG_ARM64_SP)
-			return regs->compat_sp;
+			return lower_32_bits(regs->compat_sp);
 		if ((u32)idx == PERF_REG_ARM64_LR)
-			return regs->compat_lr;
+			return lower_32_bits(regs->compat_lr);
 		if (idx == 15)
-			return regs->pc;
+			return lower_32_bits(regs->pc);
+		return lower_32_bits(__perf_reg_value(regs, idx));
 	}
 
-	if ((u32)idx == PERF_REG_ARM64_SP)
-		return regs->sp;
-
-	if ((u32)idx == PERF_REG_ARM64_PC)
-		return regs->pc;
-
-	return regs->regs[idx];
+	return __perf_reg_value(regs, idx);
 }
 
 #define REG_RESERVED (~((1ULL << PERF_REG_ARM64_MAX) - 1))
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index b9cf12b271d7..84314fae4b5c 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -51,9 +51,6 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 		ret = do_ni_syscall(regs, scno);
 	}
 
-	if (is_compat_task())
-		ret = lower_32_bits(ret);
-
 	regs->regs[0] = ret;
 }
 
-- 
2.11.0

