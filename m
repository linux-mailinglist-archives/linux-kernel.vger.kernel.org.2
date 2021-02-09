Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D13314FD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhBINKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:10:40 -0500
Received: from foss.arm.com ([217.140.110.172]:51484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhBINKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:10:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84555106F;
        Tue,  9 Feb 2021 05:09:45 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2D6D3F719;
        Tue,  9 Feb 2021 05:09:43 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, fweisbec@gmail.com, tglx@linutronix.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org
Cc:     qais.yousef@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 5/6] sched/fair: trigger the update of blocked load on newly idle cpu
In-Reply-To: <20210205114830.781-6-vincent.guittot@linaro.org>
References: <20210205114830.781-1-vincent.guittot@linaro.org> <20210205114830.781-6-vincent.guittot@linaro.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 09 Feb 2021 13:09:41 +0000
Message-ID: <jhjsg65tmju.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 12:48, Vincent Guittot wrote:
> Instead of waking up a random and already idle CPU, we can take advantage
> of this_cpu being about to enter idle to run the ILB and update the
> blocked load.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  include/linux/sched/nohz.h |  2 ++
>  kernel/sched/fair.c        | 11 ++++++++---
>  kernel/sched/idle.c        |  6 ++++++
>  3 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
> index 6d67e9a5af6b..74cdc4e87310 100644
> --- a/include/linux/sched/nohz.h
> +++ b/include/linux/sched/nohz.h
> @@ -9,8 +9,10 @@
>  #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
>  extern void nohz_balance_enter_idle(int cpu);
>  extern int get_nohz_timer_target(void);
> +extern void nohz_run_idle_balance(int cpu);
>  #else
>  static inline void nohz_balance_enter_idle(int cpu) { }
> +static inline void nohz_run_idle_balance(int cpu) { }
>  #endif
>
>  #ifdef CONFIG_NO_HZ_COMMON
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 935594cd5430..3d2ab28d5736 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10461,6 +10461,11 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>       return true;
>  }
>
> +void nohz_run_idle_balance(int cpu)
> +{
> +	nohz_idle_balance(cpu_rq(cpu), CPU_IDLE);
> +}
> +
>  static void nohz_newidle_balance(struct rq *this_rq)
>  {
>       int this_cpu = this_rq->cpu;
> @@ -10482,10 +10487,10 @@ static void nohz_newidle_balance(struct rq *this_rq)
>               return;
>
>       /*
> -	 * Blocked load of idle CPUs need to be updated.
> -	 * Kick an ILB to update statistics.
> +	 * Set the need to trigger ILB in order to update blocked load
> +	 * before entering idle state.
>        */
> -	kick_ilb(NOHZ_STATS_KICK);
> +	this_rq->nohz_idle_balance = NOHZ_STATS_KICK;
>  }
>
>  #else /* !CONFIG_NO_HZ_COMMON */
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 305727ea0677..52a4e9ce2f9b 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -261,6 +261,12 @@ static void cpuidle_idle_call(void)
>  static void do_idle(void)
>  {
>       int cpu = smp_processor_id();
> +
> +	/*
> +	 * Check if we need to update some blocked load
> +	 */
> +	nohz_run_idle_balance(cpu);
> +

What do we gain from doing this here vs having a stats update in
newidle_balance()?

The current approach is to have a combined load_balance() + blocked load
update during newidle, and I get that this can take too long. But then,
we could still have what you're adding to do_idle() in the tail of
newidle_balance() itself, no? i.e.

  newidle_balance()
    ...
    for_each_domain(this_cpu, sd) {
       ...
       pulled_task = load_balance(...);
       ...
    }
    ...
    if (!pulled_task && !this_rq->nr_running) {
      this_rq->nohz_idle_balance = NOHZ_STATS_KICK;
      _nohz_idle_balance();
    }

or somesuch.

>       /*
>        * If the arch has a polling bit, we maintain an invariant:
>        *
> --
> 2.17.1
