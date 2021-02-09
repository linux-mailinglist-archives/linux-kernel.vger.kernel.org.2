Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DAE314FCE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhBINKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:10:17 -0500
Received: from foss.arm.com ([217.140.110.172]:51442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhBINKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:10:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E90A7ED1;
        Tue,  9 Feb 2021 05:09:28 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EC363F719;
        Tue,  9 Feb 2021 05:09:26 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, fweisbec@gmail.com, tglx@linutronix.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org
Cc:     qais.yousef@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 1/6] sched/fair: remove update of blocked load from newidle_balance
In-Reply-To: <20210205114830.781-2-vincent.guittot@linaro.org>
References: <20210205114830.781-1-vincent.guittot@linaro.org> <20210205114830.781-2-vincent.guittot@linaro.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 09 Feb 2021 13:09:20 +0000
Message-ID: <jhjv9b1tmkf.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 12:48, Vincent Guittot wrote:
> @@ -10517,16 +10499,11 @@ static void nohz_newidle_balance(struct rq *this_rq)
>           time_before(jiffies, READ_ONCE(nohz.next_blocked)))
>               return;
>

I was wondering whether all the conditions above were still relevant. I
think they are, but this one:

        /* Will wake up very soon. No time for doing anything else*/
        if (this_rq->avg_idle < sysctl_sched_migration_cost)
                return;

should have its comment updated to something like:

        /*
         * Will wake up very soon. Blocked load will be updated
         * periodically, no need to wake an idle CPU.
         */

given kick_ilb() isn't the costliest of things.

> -	raw_spin_unlock(&this_rq->lock);
>       /*
> -	 * This CPU is going to be idle and blocked load of idle CPUs
> -	 * need to be updated. Run the ilb locally as it is a good
> -	 * candidate for ilb instead of waking up another idle CPU.
> -	 * Kick an normal ilb if we failed to do the update.
> +	 * Blocked load of idle CPUs need to be updated.
> +	 * Kick an ILB to update statistics.
>        */
> -	if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
> -		kick_ilb(NOHZ_STATS_KICK);
> -	raw_spin_lock(&this_rq->lock);

With this change, the return value of _nohz_idle_balance() is no longer
used. This means we could get rid of the tracking of whether it iterated
over all nohz CPUs or not.

> +	kick_ilb(NOHZ_STATS_KICK);
>  }
>
>  #else /* !CONFIG_NO_HZ_COMMON */
