Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92183324155
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbhBXPr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:47:58 -0500
Received: from foss.arm.com ([217.140.110.172]:36876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231942AbhBXPfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 10:35:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47BDE31B;
        Wed, 24 Feb 2021 07:34:43 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 102123F70D;
        Wed, 24 Feb 2021 07:34:41 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 2/6] sched: Simplify migration_cpu_stop()
In-Reply-To: <20210224131355.430014682@infradead.org>
References: <20210224122439.176543586@infradead.org> <20210224131355.430014682@infradead.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 24 Feb 2021 15:34:36 +0000
Message-ID: <jhjmtvt5vjn.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/21 13:24, Peter Zijlstra wrote:
> @@ -1950,31 +1931,20 @@ static int migration_cpu_stop(void *data
>                       goto out;
>
>               if (pending) {
> -			p->migration_pending = NULL;
> +			if (p->migration_pending == pending)
> +				p->migration_pending = NULL;
>                       complete = true;
>               }
>
> -		/* migrate_enable() --  we must not race against SCA */
> -		if (dest_cpu < 0) {
> -			/*
> -			 * When this was migrate_enable() but we no longer
> -			 * have a @pending, a concurrent SCA 'fixed' things
> -			 * and we should be valid again. Nothing to do.
> -			 */
> -			if (!pending) {
> -				WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
> -				goto out;
> -			}
> -

This is fixed by 5+6, but at this patch I think you can have double
completions - I thought this was an issue, but briefly looking at
completion stuff it might not. In any case, consider:

  task_cpu(p) == Y

  SCA(p, X);
                 SCA(p, Y);


SCA(p, Y) will uninstall SCA(p, X)'s pending and complete.

migration/Y kicked by SCA(p, X) will grab arg->pending, which is still
SCA(p, X)'s pending and also complete.

> +		if (dest_cpu < 0)
>                       dest_cpu = cpumask_any_distribute(&p->cpus_mask);
> -		}
>
>               if (task_on_rq_queued(p))
>                       rq = __migrate_task(rq, &rf, p, dest_cpu);
>               else
>                       p->wake_cpu = dest_cpu;
>
> -	} else if (dest_cpu < 0 || pending) {
> +	} else if (pending) {
>               /*
>                * This happens when we get migrated between migrate_enable()'s
>                * preempt_enable() and scheduling the stopper task. At that
