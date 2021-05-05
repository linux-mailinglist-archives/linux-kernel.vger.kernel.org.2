Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C588C373ADD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 14:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhEEMPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 08:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbhEEMP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 08:15:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0E5C0612EF
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 05:13:38 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x20so2239170lfu.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 05:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXTIaMW1B+ItVk6xcLiLxkcpS7F048LG9tJDykqdBpo=;
        b=YPyoDKuT5sKE1gsWZ58iG0y7sUpGQl34SQ9Azyemyoz30GbFY6bRIecWEf19s1irD2
         4Q6G3Cca4sregoXOcGyKnnYu7lvx+HVba31aZu/RAvH7Zcd0yX5xn4qiXhJFVTUat7oD
         3eZmtibFFOOMneIShoL8xcwy/PMFKeXCYbSBtgWCweCwLHjoJhz6kylMjC8ChISwtHA4
         /hOf1D5ytLV04rIo3RExux1nUhV2ZicRwcYHw1gJPdfAWYM5mJQZ7SpshrGYwzkFf0oZ
         VEMQi3wPkfcVFkT+6hMk5Jx7eePZcTFGxZp4LbhOq0igCgGuIPD0Rc03eSjvx8Q1D30R
         FFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXTIaMW1B+ItVk6xcLiLxkcpS7F048LG9tJDykqdBpo=;
        b=PJwfssKpk9Ye9Oj2Cgda4bq84535ZX/YMTVy6gCmHswFwiQKn1Gxinq6hrlpNsES59
         AF9pFPXYByNBPFRG++FsOUzBQ2jHzrFh6IlUpquqr1lP0JO3QCx8OXAheW8qmmFlISeA
         z0LUUvyjBJ9JZGuykXp5r/nYC7EF17FsE34/lvW4MJSIkt6XLvgA/syDTcewbp6rdn4B
         0HgDfvX7RGahnPNPuTVB1xtamhe9nIscu/ZKq9LO+ecQthwUUGaR5z947/bKjt7FloVC
         i3rnrr1XIHDf+lkswXe84ALcOZGyPgHt+BiECMf+Aoep198AKCqocQJrBVK7lgk0yY9Y
         C15Q==
X-Gm-Message-State: AOAM530CgHQWcHUF93phqC6KU9bnlbcGCf/9+RxsKBF8EH0zrwZSSdk+
        Gn92lAS3TlJcQNJqKqKcDAS/UdRjkbBgFm25JX+aEA==
X-Google-Smtp-Source: ABdhPJyeZhzxIy/1HOMHrOgJy7lgL3GcuZKFVD4UVTBfhjSA4X/DNidzupZSEZ0suZaLyYNTs9Zaqn4VlpD2wIFLr1s=
X-Received: by 2002:a05:6512:234d:: with SMTP id p13mr1211167lfu.470.1620216816690;
 Wed, 05 May 2021 05:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210428232821.2506201-1-swood@redhat.com> <20210428232821.2506201-2-swood@redhat.com>
In-Reply-To: <20210428232821.2506201-2-swood@redhat.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 5 May 2021 14:13:25 +0200
Message-ID: <CAKfTPtBrGF72Zf37vPS6r4wy_jKagznBbiqKWpPyMEB_u4wo1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sched/fair: Call newidle_balance() from
 balance_callback on PREEMPT_RT
To:     Scott Wood <swood@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 at 01:28, Scott Wood <swood@redhat.com> wrote:
>
> This is required in order to be able to enable interrupts in the next
> patch.  This is limited to PREEMPT_RT to avoid adding potentially
> measurable overhead to the non-RT case (requiring a double switch when
> pulling a task onto a newly idle cpu).

IIUC, only the newidle_balance is a problem and not the idle load
balance that runs softirq. In this case, why not skipping
newidle_balance entirely in case of preempt_rt and kick an idle load
balance instead as you switch to idle thread context anyway


>
> update_misfit_status() is factored out for the PREEMPT_RT case, to ensure
> that the misfit status is kept consistent before dropping the lock.
>
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
> v2: Use a balance callback, and limit to PREEMPT_RT
>
>  kernel/sched/fair.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 794c2cb945f8..ff369c38a5b5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5660,6 +5660,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>
>  #ifdef CONFIG_SMP
>
> +static const bool newidle_balance_in_callback = IS_ENABLED(CONFIG_PREEMPT_RT);
> +static DEFINE_PER_CPU(struct callback_head, rebalance_head);
> +
>  /* Working cpumask for: load_balance, load_balance_newidle. */
>  DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
>  DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
> @@ -10549,7 +10552,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
>   *     0 - failed, no new tasks
>   *   > 0 - success, new (fair) tasks present
>   */
> -static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> +static int do_newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  {
>         unsigned long next_balance = jiffies + HZ;
>         int this_cpu = this_rq->cpu;
> @@ -10557,7 +10560,9 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>         int pulled_task = 0;
>         u64 curr_cost = 0;
>
> -       update_misfit_status(NULL, this_rq);
> +       if (!newidle_balance_in_callback)
> +               update_misfit_status(NULL, this_rq);
> +
>         /*
>          * We must set idle_stamp _before_ calling idle_balance(), such that we
>          * measure the duration of idle_balance() as idle time.
> @@ -10576,7 +10581,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>          * further scheduler activity on it and we're being very careful to
>          * re-start the picking loop.
>          */
> -       rq_unpin_lock(this_rq, rf);
> +       if (!newidle_balance_in_callback)
> +               rq_unpin_lock(this_rq, rf);
>
>         if (this_rq->avg_idle < sysctl_sched_migration_cost ||
>             !READ_ONCE(this_rq->rd->overload)) {
> @@ -10655,11 +10661,31 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>         if (pulled_task)
>                 this_rq->idle_stamp = 0;
>
> -       rq_repin_lock(this_rq, rf);
> +       if (!newidle_balance_in_callback)
> +               rq_repin_lock(this_rq, rf);
>
>         return pulled_task;
>  }
>
> +static void newidle_balance_cb(struct rq *this_rq)
> +{
> +       update_rq_clock(this_rq);
> +       do_newidle_balance(this_rq, NULL);
> +}
> +
> +static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> +{
> +       if (newidle_balance_in_callback) {
> +               update_misfit_status(NULL, this_rq);
> +               queue_balance_callback(this_rq,
> +                                      &per_cpu(rebalance_head, this_rq->cpu),
> +                                      newidle_balance_cb);
> +               return 0;
> +       }
> +
> +       return do_newidle_balance(this_rq, rf);
> +}
> +
>  /*
>   * run_rebalance_domains is triggered when needed from the scheduler tick.
>   * Also triggered for nohz idle balancing (with nohz_balancing_kick set).
> --
> 2.27.0
>
