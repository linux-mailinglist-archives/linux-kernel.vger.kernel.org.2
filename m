Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA6C45CA03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 17:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348816AbhKXQbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 11:31:40 -0500
Received: from foss.arm.com ([217.140.110.172]:40822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242386AbhKXQbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 11:31:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB84F1FB;
        Wed, 24 Nov 2021 08:28:26 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FF523F66F;
        Wed, 24 Nov 2021 08:28:25 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [PATCH] sched/fair: Fix detection of per-CPU kthreads waking a task
In-Reply-To: <20211124154239.3191366-1-vincent.donnefort@arm.com>
References: <20211124154239.3191366-1-vincent.donnefort@arm.com>
Date:   Wed, 24 Nov 2021 16:28:20 +0000
Message-ID: <87ilwhcycb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/21 15:42, Vincent Donnefort wrote:
> select_idle_sibling() will return prev_cpu for the case where the task is
> woken up by a per-CPU kthread. However, the idle task has been recently
> modified and is now identified by is_per_cpu_kthread(), breaking the
> behaviour described above. Using !is_idle_task() ensures we do not
> spuriously trigger that select_idle_sibling() exit path.
>
> Fixes: 00b89fe0197f ("sched: Make the idle task quack like a per-CPU kthread")

This patch-set is the gift that keeps on giving... I owe a lot of folks a
lot of beer :(

> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 945d987246c5..8bf95b0e368d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6399,6 +6399,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>        * pattern is IO completions.
>        */
>       if (is_per_cpu_kthread(current) &&
> +	    !is_idle_task(current) &&
>           prev == smp_processor_id() &&
            ^^^^^^^^^^^^^^^^^^^^^^^^^^
                        (1)

>           this_rq()->nr_running <= 1) {

So if we get to here, it means we failed

        if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
            asym_fits_capacity(task_util, target))
                return target;

AFAICT (1) implies "prev == target" (target can be either prev or the
waking CPU), so per the above this implies prev isn't idle. If current is
the idle task, we can still have stuff enqueued (which matches nr_running
<= 1) and be on our way to schedule_idle(), or have rq->ttwu_pending (per
idle_cpu()) - IOW matching against the idle task here can lead to undesired
coscheduling.

If the above isn't bonkers:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

>               return prev;
> --
> 2.25.1
