Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592CC36E90D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbhD2KtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:49:09 -0400
Received: from foss.arm.com ([217.140.110.172]:46806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233114AbhD2KtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:49:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C25001FB;
        Thu, 29 Apr 2021 03:48:20 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.1.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA9A13F70D;
        Thu, 29 Apr 2021 03:48:18 -0700 (PDT)
Date:   Thu, 29 Apr 2021 11:48:13 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Subject: Re: [PATCH] arm64: stacktrace: Stop unwinding when the PC is zero
Message-ID: <20210429104813.GA33550@C02TD0UTHF1T.local>
References: <20210429014321.196606-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429014321.196606-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Thu, Apr 29, 2021 at 09:43:21AM +0800, Leo Yan wrote:
> When use ftrace for stack trace, it reports the spurious frame with the
> PC value is zero.  This can be reproduced with commands:
> 
>   # cd /sys/kernel/debug/tracing/
>   # echo "prev_pid == 0" > events/sched/sched_switch/filter
>   # echo stacktrace > events/sched/sched_switch/trigger
>   # echo 1 > events/sched/sched_switch/enable
>   # cat trace
> 
>            <idle>-0       [005] d..2   259.621390: sched_switch: ...
>            <idle>-0       [005] d..3   259.621394: <stack trace>
>   => __schedule
>   => schedule_idle
>   => do_idle
>   => cpu_startup_entry
>   => secondary_start_kernel
>   => 0

IIUC, this is my fault, and is an unintended side-effect of commit:

  6106e1112cc69a36 ("arm64: remove EL0 exception frame record")

... since before prior to that, we'd implicitly create a terminal record
in start_kernel and secondary_start_kernel by virtue of entering those
functions with both FP and LR set to NULL. After that commit, we report
the NULL LR before trying to unwind the NULL FP.

> The kernel initializes FP/PC values as zero for swapper threads in
> head.S, when walk the stack frame, this patch stops unwinding if detect
> the PC value is zero, therefore can avoid the spurious frame.
> 
> Below is the stacktrace after applying the change:
> 
>   # cat trace
> 
>            <idle>-0       [005] d..2   259.621390: sched_switch: ...
>            <idle>-0       [005] d..3   259.621394: <stack trace>
>   => __schedule
>   => schedule_idle
>   => do_idle
>   => cpu_startup_entry
>   => secondary_start_kernel
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  arch/arm64/kernel/stacktrace.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 84b676bcf867..02b1e85b2026 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -145,7 +145,11 @@ void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
>  		if (!fn(data, frame->pc))
>  			break;
>  		ret = unwind_frame(tsk, frame);
> -		if (ret < 0)
> +		/*
> +		 * When the frame->pc is zero, it has reached to the initial pc
> +		 * and fp values; stop unwinding for this case.
> +		 */
> +		if (ret < 0 || !frame->pc)
>  			break;

I don't think this is the right place for this, since we intend
unwind_frame() to detect when unwinding is finished; see commit:

  3c02600144bdb0a1 ("arm64: stacktrace: Report when we reach the end of the stack")

I think we have three options for what to do here:

a) Revert 6106e1112cc69a36, and identify these cases as terminal records
   where FP and LR are both NULL.

b) Have __primary_switched and __secondary_switched call start_kernel
   and secondary_start_kernel with BL rather than B. The __*_switched
   functions will show up in the trace, but we won't unwind any further
   as the next record will have a NULL FP.

c) Revert 6106e1112cc69a36, create terminal records in
   __primary_switched and __secondary_switched, and call start_kernel
   and secondary_start_kernel with BL rather than B. The __*_switched
   functions will show up in the trace, but we won't unwind any further
   as the next record will be a terminal record.

For RELIABLE_STACKTRACE, we're going to have to do (c), I think, but for
now we could do (a) so as to have a minimal fix, and we can build (c)
atop that.

How about the patch below? I've tested it with your instructions and
also by inspecting /proc/self/stack.

Thanks,
Mark.

---->8----
From b99e647b34b74059f3013c09f12fbd542c7679fd Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Thu, 29 Apr 2021 11:20:04 +0100
Subject: [PATCH] arm64: stacktrace: restore terminal records

We removed the terminal frame records in commit:

   6106e1112cc69a36 ("arm64: remove EL0 exception frame record")

... on the assumption that as we no longer used them to find the pt_regs
at exception boundaries, they were no longer necessary.

However, Leo reports that as an unintended side-effect, this causes
traces which cross secondary_start_kernel to terminate one entry too
late, with a spurious "0" entry.

There are a few ways we could sovle this, but as we're planning to use
terminal records for RELIABLE_STACKTRACE, let's revert the logic change
for now, keeping the update comments and accounting for the changes in
commit:

  3c02600144bdb0a1 ("arm64: stacktrace: Report when we reach the end of the stack")

This is effectively a partial revert of commit:

  6106e1112cc69a36 ("arm64: remove EL0 exception frame record")

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 6106e1112cc69a36 ("arm64: remove EL0 exception frame record")
Reported-by: Leo Yan <leo.yan@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
---
 arch/arm64/kernel/entry.S      |  6 +++---
 arch/arm64/kernel/stacktrace.c | 10 ++++++----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6acfc5e6b5e0..9b205744a233 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -263,16 +263,16 @@ alternative_else_nop_endif
 	stp	lr, x21, [sp, #S_LR]
 
 	/*
-	 * For exceptions from EL0, terminate the callchain here.
+	 * For exceptions from EL0, create a terminal frame record.
 	 * For exceptions from EL1, create a synthetic frame record so the
 	 * interrupted code shows up in the backtrace.
 	 */
 	.if \el == 0
-	mov	x29, xzr
+	stp	xzr, xzr, [sp, #S_STACKFRAME]
 	.else
 	stp	x29, x22, [sp, #S_STACKFRAME]
-	add	x29, sp, #S_STACKFRAME
 	.endif
+	add	x29, sp, #S_STACKFRAME
 
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 alternative_if_not ARM64_HAS_PAN
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index d55bdfb7789c..7032a5f9e624 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -44,10 +44,6 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 	unsigned long fp = frame->fp;
 	struct stack_info info;
 
-	/* Terminal record; nothing to unwind */
-	if (!fp)
-		return -ENOENT;
-
 	if (fp & 0xf)
 		return -EINVAL;
 
@@ -108,6 +104,12 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 
 	frame->pc = ptrauth_strip_insn_pac(frame->pc);
 
+	/*
+	 * This is a terminal record, so we have finished unwinding.
+	 */
+	if (!frame->fp && !frame->pc)
+		return -ENOENT;
+
 	return 0;
 }
 NOKPROBE_SYMBOL(unwind_frame);
-- 
2.11.0


 
