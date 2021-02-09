Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665D3314FCF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhBINK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:10:26 -0500
Received: from foss.arm.com ([217.140.110.172]:51462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhBINKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:10:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EC851042;
        Tue,  9 Feb 2021 05:09:39 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C3F63F719;
        Tue,  9 Feb 2021 05:09:37 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, fweisbec@gmail.com, tglx@linutronix.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org
Cc:     qais.yousef@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 3/6] sched/fair: merge for each idle cpu loop of ILB
In-Reply-To: <20210205114830.781-4-vincent.guittot@linaro.org>
References: <20210205114830.781-1-vincent.guittot@linaro.org> <20210205114830.781-4-vincent.guittot@linaro.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 09 Feb 2021 13:09:34 +0000
Message-ID: <jhjtuqltmk1.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 12:48, Vincent Guittot wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 60b8c1c68ab9..c587af230010 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10043,22 +10043,9 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
>        * When the cpu is attached to null domain for ex, it will not be
>        * updated.
>        */
> -	if (likely(update_next_balance)) {
> +	if (likely(update_next_balance))
>               rq->next_balance = next_balance;
>
> -#ifdef CONFIG_NO_HZ_COMMON
> -		/*
> -		 * If this CPU has been elected to perform the nohz idle
> -		 * balance. Other idle CPUs have already rebalanced with
> -		 * nohz_idle_balance() and nohz.next_balance has been
> -		 * updated accordingly. This CPU is now running the idle load
> -		 * balance for itself and we need to update the
> -		 * nohz.next_balance accordingly.
> -		 */
> -		if ((idle == CPU_IDLE) && time_after(nohz.next_balance, rq->next_balance))
> -			nohz.next_balance = rq->next_balance;
> -#endif
> -	}

I was never fond of this bit, so FWIW I'm happy to see it go!
