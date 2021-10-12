Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AA942A18A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhJLKCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:02:08 -0400
Received: from foss.arm.com ([217.140.110.172]:60374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235881AbhJLKCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:02:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FC1C101E;
        Tue, 12 Oct 2021 03:00:01 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B8323F694;
        Tue, 12 Oct 2021 02:59:59 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Woody Lin <woodylin@google.com>, Ingo Molnar <mingo@redhat.com>,
        Ben Segall <bsegall@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, Woody Lin <woodylin@google.com>
Subject: Re: [PATCH] sched/scs: Reset the shadow stack when idle_task_exit
In-Reply-To: <20211012083521.973587-1-woodylin@google.com>
References: <20211012083521.973587-1-woodylin@google.com>
Date:   Tue, 12 Oct 2021 10:59:54 +0100
Message-ID: <87zgrek1gl.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 16:35, Woody Lin wrote:
> There was a 'init_idle' that resets scs sp to base, but is removed by
> f1a0a376ca0c. Without the resetting, the hot-plugging implemented by
> cpu_psci_cpu_boot will use the previous scs sp as new base when starting
> up a CPU core, so the usage on scs page is being stacked up until
> overflow.
>
> This only happens on idle task since __cpu_up is using idle task as the
> main thread to start up a CPU core, so the overflow can be fixed by
> resetting scs sp to base in 'idle_task_exit'.
>

Looking at init_idle() for similar issues, it looks like we might also want
to re-issue kasan_unpoison_task_stack() on the idle task upon hotplug.

> Fixes: f1a0a376ca0c ("sched/core: Initialize the idle task with preemption disabled")
> Signed-off-by: Woody Lin <woodylin@google.com>
> ---
>  kernel/sched/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1bba4128a3e6..f21714ea3db8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8795,6 +8795,7 @@ void idle_task_exit(void)
>               finish_arch_post_lock_switch();
>       }
>
> +	scs_task_reset(current);
>       /* finish_cpu(), as ran on the BP, will clean up the active_mm state */

So AIUI for SCS that works just fine - one thing I'm unclear on is how the
following pops are going to work given the SP reset happens in the middle
of a call stack, but AFAICT that was already the case before I messed about
with init_idle(), so that must already be handled.

I'm not familiar enough with KASAN to say whether that
kasan_unpoison_task_stack() should rather happen upon hotplugging the CPU
back (rather than on hot-unplug). If that is the case, then maybe somewhere
around cpu_startup_entry() might work (and then you could bunch these two
"needs to be re-run at init for the idle task" functions into a common
helper).

>  }
>
> --
> 2.33.0.882.g93a45727a2-goog
