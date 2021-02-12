Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB82A31A53F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 20:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhBLTUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 14:20:44 -0500
Received: from foss.arm.com ([217.140.110.172]:41572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231430AbhBLTUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 14:20:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1066A113E;
        Fri, 12 Feb 2021 11:19:54 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BAB43F719;
        Fri, 12 Feb 2021 11:19:52 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 6/7 v3] sched/fair: trigger the update of blocked load on newly idle cpu
In-Reply-To: <20210212141744.24284-7-vincent.guittot@linaro.org>
References: <20210212141744.24284-1-vincent.guittot@linaro.org> <20210212141744.24284-7-vincent.guittot@linaro.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Fri, 12 Feb 2021 19:19:41 +0000
Message-ID: <jhj5z2xt7oy.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/21 15:17, Vincent Guittot wrote:
> Instead of waking up a random and already idle CPU, we can take advantage
> of this_cpu being about to enter idle to run the ILB and update the
> blocked load.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c  | 24 +++++++++++++++++++++---
>  kernel/sched/idle.c  |  6 ++++++
>  kernel/sched/sched.h |  5 +++++
>  3 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5d285d93e433..cd0ea635225e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10453,6 +10453,24 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>       return true;
>  }
>
> +/*
> + * Check if we need to run the ILB for updating blocked load before entering
> + * idle state.
> + */
> +void nohz_run_idle_balance(int cpu)
> +{
> +	unsigned int flags;
> +
> +	flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(cpu));
> +
> +	if (flags && !need_resched()) {
> +		struct rq *rq = cpu_rq(cpu);
> +
> +		rq->nohz_idle_balance = flags;
> +		nohz_idle_balance(rq, CPU_IDLE);
> +	}

So this can now run a full fledged nohz_idle_balance() if NOHZ_BALANCE_MASK
is set.

I don't think there is anything inherently wrong with it - the
nohz_idle_balance() call resulting from the kick_ilb() IPI will just bail
out due to the flags being cleared here. This wasn't immediately clear to
me however.

> +}
> +
