Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BE03EB4FB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 14:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbhHMMDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 08:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhHMMDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 08:03:42 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BABC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 05:03:15 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n17so11401587ioc.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 05:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v1i1kiGHokMWuwVc001aJVhcggBj3EMjVZCUeCy2JMI=;
        b=d5nfSW+1fjNgYiEfgbHNEi0na/WM0T2b2185b06JWTiBnD+ZBFqZWStjV+VnFqFQpP
         XBFcnvr+aneF5dyKrNyAHcgSYoeWtIm4dVa+F7VerF2orXuJfpCmu+zU7jAnxe/0UmqZ
         ypSLY44YzqEeRAP1OuW9CIyOOdOHVnlpacTpYwhIVN7bmME8QI76Z+MfY4CrkwyeaP4c
         b6ZcJxmg94t8E2oHXS4XBWAzCi0cz8+PWVJdXuJwjm124E0OkU7JYkXjo197SBNn4EoK
         w1J1+NrSa35w3FGJxzuYeZ8fl5TWAgzD5XtHUnfjL8T5T7rzzI1QoteCwLc+MYfZ4qnG
         GG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1i1kiGHokMWuwVc001aJVhcggBj3EMjVZCUeCy2JMI=;
        b=pjUN7wYWZkxG2gbO/7cyJJX+VAweTBzP1AGJfzVkQYRhAnJgBfaVoLsccY+7QGROFO
         SvHvgI1iUnvh62dfS4ED2xbteCOxSAQgHsMReLpLQBl52CZGpk95NdQPhRE9Q7t1w08C
         dhdgpoND675Fixbd9KIp/yHGrdIfIRdT96GjzCNfRkgF+GC94TKWnDR1xDju0VhTGWF9
         la51vvQrcuPtSZVFCNGISr05qWdgnR+oo4ERfawbEj0ZF6wRLIB1lLpTeNw0Ej/sJwXh
         ouwce8kDqkWTyauxoHL6E0SSmK0LLt5ioOHepeTT0nudlWbNcAF5ytB14Zsrg/OWXAdA
         GZIQ==
X-Gm-Message-State: AOAM531BQ2RHXlc2Y+VJCV1N7tBNPM7zfBEVEvyIG9zExVOz/w6zR4/z
        VynsONZTo3rbIv9fw97Nlp2Z7ha/pBk2B37r8Ts=
X-Google-Smtp-Source: ABdhPJzSRLVn7Knad+TGemmDNaLZUt0ZvtUj6C3HxC03atESFzjIopMFRPfuQVi3QbJJiEGxcbDm0M61zF/Sxd9/5hs=
X-Received: by 2002:a5d:8541:: with SMTP id b1mr1757063ios.105.1628856195130;
 Fri, 13 Aug 2021 05:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210812083814.32453-1-lizhe.67@bytedance.com>
In-Reply-To: <20210812083814.32453-1-lizhe.67@bytedance.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 13 Aug 2021 20:03:04 +0800
Message-ID: <CAJhGHyBsn+rqVQzNqRw2RxtpHyrpQpa0kMtU1RcZP7TCbC6dqg@mail.gmail.com>
Subject: Re: [PATCH] workqueue: fix memory leak of struct pool_workqueue in destroy_workqueue()
To:     lizhe.67@bytedance.com
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lizefan.x@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 4:38 PM <lizhe.67@bytedance.com> wrote:
>
> From: Li Zhe <lizhe.67@bytedance.com>
>
> Even after def98c84b6cd, we may encount sanity check failures in
> destroy_workqueue() although we call flush_work() before, which
> result in memory leak of struct pool_workqueue.
>
> The warning logs are listed below.
>
> WARNING: CPU: 0 PID: 19336 at kernel/workqueue.c:4430 destroy_workqueue+0x11a/0x2f0
> *****
> destroy_workqueue: test_workqueue9 has the following busy pwq
>   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=0/1 refcnt=2
>       in-flight: 5658:wq_barrier_func
> Showing busy workqueues and worker pools:
> *****
>
> The possible stack which result in the failure is listed below.
>
> thread A:
> destroy_workqueue()
> ----raw_spin_lock_irq(&pwq->pool->lock)
> ----pwq_busy()
>
> thread B:
> ----process_one_work()
> ----raw_spin_unlock_irq(&pool->lock)
> ----worker->current_func(work)
> ----cond_resched()
> ----raw_spin_lock_irq(&pool->lock)
> ----pwq_dec_nr_in_flight(pwq, work_color)

Hello, Li

Thanks for your report.
As this list of events shows, the problem does exist.

But complicating process_one_work() and adding branches to it
are not optimized.  I'm trying to figure out another way to fix it.

Thanks
Lai

>
> Thread A may get pool->lock before thread B, with the pwq->refcnt
> is still 2, which result in memory leak and sanity check failures.
>
> Notice that wq_barrier_func() only calls complete(), and it is not
> suitable to expand struct work_struct considering of the memory cost,
> this patch put complete() after obtaining pool->lock in function
> process_one_work() to eliminate competition by identify the work as a
> barrier with the work->func equal to NULL.
>
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>  kernel/workqueue.c | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index f148eacda55a..02f77f35522c 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -280,6 +280,12 @@ struct workqueue_struct {
>         struct pool_workqueue __rcu *numa_pwq_tbl[]; /* PWR: unbound pwqs indexed by node */
>  };
>
> +struct wq_barrier {
> +       struct work_struct      work;
> +       struct completion       done;
> +       struct task_struct      *task;  /* purely informational */
> +};
> +
>  static struct kmem_cache *pwq_cache;
>
>  static cpumask_var_t *wq_numa_possible_cpumask;
> @@ -2152,6 +2158,11 @@ static bool manage_workers(struct worker *worker)
>         return true;
>  }
>
> +static inline bool is_barrier_func(work_func_t func)
> +{
> +       return func == NULL;
> +}
> +
>  /**
>   * process_one_work - process single work
>   * @worker: self
> @@ -2273,7 +2284,8 @@ __acquires(&pool->lock)
>          */
>         lockdep_invariant_state(true);
>         trace_workqueue_execute_start(work);
> -       worker->current_func(work);
> +       if (likely(!is_barrier_func(worker->current_func)))
> +               worker->current_func(work);
>         /*
>          * While we must be careful to not use "work" after this, the trace
>          * point will only record its address.
> @@ -2303,6 +2315,11 @@ __acquires(&pool->lock)
>
>         raw_spin_lock_irq(&pool->lock);
>
> +       if (unlikely(is_barrier_func(worker->current_func))) {
> +               struct wq_barrier *barr = container_of(work, struct wq_barrier, work);
> +               complete(&barr->done);
> +       }
> +
>         /* clear cpu intensive status */
>         if (unlikely(cpu_intensive))
>                 worker_clr_flags(worker, WORKER_CPU_INTENSIVE);
> @@ -2618,18 +2635,6 @@ static void check_flush_dependency(struct workqueue_struct *target_wq,
>                   target_wq->name, target_func);
>  }
>
> -struct wq_barrier {
> -       struct work_struct      work;
> -       struct completion       done;
> -       struct task_struct      *task;  /* purely informational */
> -};
> -
> -static void wq_barrier_func(struct work_struct *work)
> -{
> -       struct wq_barrier *barr = container_of(work, struct wq_barrier, work);
> -       complete(&barr->done);
> -}
> -
>  /**
>   * insert_wq_barrier - insert a barrier work
>   * @pwq: pwq to insert barrier into
> @@ -2667,7 +2672,11 @@ static void insert_wq_barrier(struct pool_workqueue *pwq,
>          * checks and call back into the fixup functions where we
>          * might deadlock.
>          */
> -       INIT_WORK_ONSTACK(&barr->work, wq_barrier_func);
> +       /* no need to init func because complete() has been moved to
> +        * proccess_one_work(), which means that we use NULL to identify
> +        * if this work is a barrier
> +        */
> +       INIT_WORK_ONSTACK(&barr->work, NULL);
>         __set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&barr->work));
>
>         init_completion_map(&barr->done, &target->lockdep_map);
> @@ -4682,7 +4691,7 @@ static void pr_cont_pool_info(struct worker_pool *pool)
>
>  static void pr_cont_work(bool comma, struct work_struct *work)
>  {
> -       if (work->func == wq_barrier_func) {
> +       if (is_barrier_func(work->func)) {
>                 struct wq_barrier *barr;
>
>                 barr = container_of(work, struct wq_barrier, work);
> --
> 2.11.0
>
