Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490D6450440
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 13:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhKOMT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 07:19:29 -0500
Received: from foss.arm.com ([217.140.110.172]:54618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231181AbhKOMTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 07:19:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B2D56D;
        Mon, 15 Nov 2021 04:16:21 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCE913F70D;
        Mon, 15 Nov 2021 04:16:19 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, dvyukov@google.com, mark.rutland@arm.com,
        peterz@infradead.org, quic_qiancai@quicinc.com, will@kernel.org,
        woodylin@google.com
Subject: Re: [PATCH] Reset task stack state in bringup_cpu()
In-Reply-To: <20211115113310.35693-1-mark.rutland@arm.com>
References: <20211115113310.35693-1-mark.rutland@arm.com>
Date:   Mon, 15 Nov 2021 12:16:14 +0000
Message-ID: <87pmr1r4vl.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mark,

Thanks for tackling this and glueing the pieces back together. LGTM, though
I couldn't stop myself from playing changelog police - I also have a
question/comment wrt the BP.

On 15/11/21 11:33, Mark Rutland wrote:
> To hot unplug a CPU, the idle task on that CPU calls a few layers of C
> code before finally leaving the kernel. When KASAN is in use, poisoned
> shadow is left around for each of the active stack frames, and when
> shadow call stacks are in use. When shadow call stacks are in use the
> task's SCS SP is left pointing at an arbitrary point within the task's
> shadow call stack.
>
> When an offlines CPU is hotlpugged back into the kernel, this stale
          ^^^^^^^^        ^^^^^^^^^^
          offlined?       hotplugged

> state can adversely affect the newly onlined CPU. Stale KASAN shadow can
> alias new stackframes and result in bogus KASAN warnings. A stale SCS SP
> is effectively a memory leak, and prevents a portion of the shadow call
> stack being used. Across a number of hotplug cycles the task's entire
> shadow call stack can become unusable.
>
> We previously fixed the KASAN issue in commit:
>
>   e1b77c92981a5222 ("sched/kasan: remove stale KASAN poison after hotplug")
>
> In commit:
>
>   f1a0a376ca0c4ef1 ("sched/core: Initialize the idle task with preemption disabled")
>
> ... we broke both KASAN and SCS, with SCS being fixed up in commit:
>
>   63acd42c0d4942f7 ("sched/scs: Reset the shadow stack when idle_task_exit")
>
> ... but as this runs in the context of the idle task being offlines it's
                                                             ^^^^^^^^
                                                             offlined

> potentially fragile.
>
> Fix both of these consistently and more robustly by resetting the SCS SP
> and KASAN shadow immediately before we online a CPU. This ensures the
> idle task always has a consistent state, and removes the need to do so
> when initializing an idle task or when unplugging an idle task.
>
> I've tested this with both GCC and clang, with reelvant options enabled,
                                                 ^^^^^^^^
                                                 relevant

> offlining and online CPUs with:
                ^^^^^^
                onlining

>
> | while true; do
> |   for C in /sys/devices/system/cpu/cpu*/online; do
> |     echo 0 > $C;
> |     echo 1 > $C;
> |   done
> | done
>
> Link: https://lore.kernel.org/lkml/20211012083521.973587-1-woodylin@google.com/
> Link: https://lore.kernel.org/linux-arm-kernel/YY9ECKyPtDbD9q8q@qian-HP-Z2-SFF-G5-Workstation/
> Fixes: 1a0a376ca0c4ef1 ("sched/core: Initialize the idle task with preemption disabled")
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Woody Lin <woodylin@google.com>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> ---
>  kernel/cpu.c        | 7 +++++++
>  kernel/sched/core.c | 4 ----
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 192e43a87407..407a2568f35e 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -31,6 +31,7 @@
>  #include <linux/smpboot.h>
>  #include <linux/relay.h>
>  #include <linux/slab.h>
> +#include <linux/scs.h>
>  #include <linux/percpu-rwsem.h>
>  #include <linux/cpuset.h>
>
> @@ -588,6 +589,12 @@ static int bringup_cpu(unsigned int cpu)
>       int ret;
>
>       /*
> +	 * Reset stale stack state from the last time this CPU was online.
> +	 */
> +	scs_task_reset(idle);
> +	kasan_unpoison_task_stack(idle);
> +
> +	/*
>        * Some architectures have to walk the irq descriptors to
>        * setup the vector space for the cpu which comes online.
>        * Prevent irq alloc/free across the bringup.
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3c9b0fda64ac..76f9deeaa942 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8619,9 +8619,6 @@ void __init init_idle(struct task_struct *idle, int cpu)
>       idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
>       kthread_set_per_cpu(idle, cpu);
>
> -	scs_task_reset(idle);
> -	kasan_unpoison_task_stack(idle);
> -

So those are no longer invoked for the BP during bootup (via sched_init());
that looks OK for KASAN per:

  e1b77c92981a ("sched/kasan: remove stale KASAN poison after hotplug")

I didn't find any explicit commit for SCS but from the looks of
arm64/include/asm/thread_info.h we seem to be initializing things
correctly, so IIUC the removed hunk wasn't actually necessary for the BP's
first boot.

>  #ifdef CONFIG_SMP
>       /*
>        * It's possible that init_idle() gets called multiple times on a task,
> @@ -8777,7 +8774,6 @@ void idle_task_exit(void)
>               finish_arch_post_lock_switch();
>       }
>
> -	scs_task_reset(current);
>       /* finish_cpu(), as ran on the BP, will clean up the active_mm state */
>  }
>
> --
> 2.11.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
