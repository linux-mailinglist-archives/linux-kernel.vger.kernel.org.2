Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4555378920
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 13:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbhEJLZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:25:45 -0400
Received: from foss.arm.com ([217.140.110.172]:54394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234314AbhEJK4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:56:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ECAC15BE;
        Mon, 10 May 2021 03:55:06 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56C163F719;
        Mon, 10 May 2021 03:55:05 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Yejune Deng <yejune.deng@gmail.com>, peterz@infradead.org,
        tglx@linutronix.de, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yejune Deng <yejunedeng@gmail.com>
Subject: Re: [PATCH] lib/smp_processor_id: Use is_percpu_thread() instead of nr_cpus_allowed
In-Reply-To: <1620458722-13026-1-git-send-email-yejunedeng@gmail.com>
References: <1620458722-13026-1-git-send-email-yejunedeng@gmail.com>
Date:   Mon, 10 May 2021 11:54:56 +0100
Message-ID: <87pmxyj1tr.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/21 15:25, Yejune Deng wrote:
> Use is_percpu_thread() instead of 'current->nr_cpus_allowed == 1',
> is_percpu_thread() is includes boths SMP and SP. It also more readable.
> The comments are no needed.
>
> Signed-off-by: Yejune Deng <yejunedeng@gmail.com>
> ---
>  lib/smp_processor_id.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
> index 1c1dbd3..046ac62 100644
> --- a/lib/smp_processor_id.c
> +++ b/lib/smp_processor_id.c
> @@ -19,11 +19,7 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
>       if (irqs_disabled())
>               goto out;
>
> -	/*
> -	 * Kernel threads bound to a single CPU can safely use
> -	 * smp_processor_id():
> -	 */
> -	if (current->nr_cpus_allowed == 1)
> +	if (is_percpu_thread())
>               goto out;

That's not entirely equivalent as this adds (p->flags & PF_NO_SETAFFINITY)
to the condition. Per-CPU kthreads will have it set, so that at least
matches the existing comment, but it's not an innocent change.

I'm thinking this might actually be something we want, as not having
this flag + having preemption enabled means this could race with
sched_setaffinity(), and it would be nice to detect this regardless of the
current affinity.

I ran this on my Juno and the idle thread gets in the way as it only has

  PF_KTHREAD | PF_IDLE

So you'd need something like the below (which is purely for instrumentation
/ assertion purposes).

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4a0668acd876..2a6fdf3e7061 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7445,7 +7445,7 @@ void init_idle(struct task_struct *idle, int cpu)
 
 	idle->state = TASK_RUNNING;
 	idle->se.exec_start = sched_clock();
-	idle->flags |= PF_IDLE;
+	idle->flags |= PF_IDLE | PF_NO_SETAFFINITY;
 
 	scs_task_reset(idle);
 	kasan_unpoison_task_stack(idle);
