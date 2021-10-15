Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F3542FAB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 20:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbhJOSEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 14:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbhJOSET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 14:04:19 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37283C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 11:02:13 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id n65so24649557ybb.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 11:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vdk/fXShymfS/lvHoorcBT3Y2sXZVvcy7ptGDxBQds8=;
        b=xb9RfJODGDHpxN+Qq+fua2srw5GCFJsf9vtKx2r/lCCgHUA7FTTYx0lyKhCx0ZncTr
         Umz5X36iGfR4NZJ9UAyzuc4czl5zHmXGRC3TTlnR8WX5FJHTc4+woUiM6ucvUXcpBYeL
         XCWJ7VzyAwJBHEkbQU9dxXGQI+rrHlR4c3OxTum0q+HxfkD8+bOd36ggagWs1NyTFOYJ
         6hVN1HI8rFlLElPhbJCRBt3r6so6MJQpPExuWS6tAsbQIZ3/iZrY2rxyhIdU4UdtVbXE
         arRWMAInnK/wc0jzzpcwFpYmi/GA/iSp4Wg6tRNW5VQphHsdU6YNs9i8myNqJlOudEDv
         Bsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vdk/fXShymfS/lvHoorcBT3Y2sXZVvcy7ptGDxBQds8=;
        b=Uoz+OK3gkEHcEud4w73sVod5jooRfrtdAXjloy0P6PXCZW2VfX4S5HTBigWzLOZGKn
         Q4MHPVAv5HbvK6VRWc5B0mQLJ/0k1UPdCZikloRCpTl6gk80ET0K9HafjHX3GiTxFfop
         zdeAYcwFTsd3wiHMMRyorAC0GYpuBazK/mWk9DGXVXdmTFNNG6xyo2Vsc8YKYXnXAOgc
         rKR8nYlZy3X0dEwxDUD49NQwvmhO6S84F8530d441THkjzGK9uPlJrm4wWpjfU1PJ3VF
         XKXhu7aDRQkfGCoXaFbi74OiMhMx6/1rTU63BB/ihgU+cSyr+jASHcedIU98sFETxLLH
         TynA==
X-Gm-Message-State: AOAM530TiXgSkncuA+OxHqatP7vXL6SB2MYzIwqC7+b1//ENLvAiD4N+
        kYAVjHbzAaEbfktuzjzp7EafLdwT+7DfmfJ9tgrOcg==
X-Google-Smtp-Source: ABdhPJz3iJk+ecIP+Ko40xPSk9GLNwqTXxPx/oPCg94JpC8H3NBCVfrKAx/sq8VYiU55pD6cNv27Tra20DV8OPvIKFs=
X-Received: by 2002:a25:c644:: with SMTP id k65mr14447581ybf.191.1634320932403;
 Fri, 15 Oct 2021 11:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211015124654.18093-1-vincent.guittot@linaro.org>
 <20211015124654.18093-4-vincent.guittot@linaro.org> <20211015174045.GI174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211015174045.GI174703@worktop.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Oct 2021 20:02:01 +0200
Message-ID: <CAKfTPtD4RgqR4um3faHeR5AC2Uw5+cbH6vee4wq-5Qox9bqwQA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sched/fair: Wait before decaying max_newidle_lb_cost
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 at 19:41, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Oct 15, 2021 at 02:46:53PM +0200, Vincent Guittot wrote:
> > Decay max_newidle_lb_cost only when it has not been updated for a while
> > and ensure to not decay a recently changed value.
>
> I was more thinking something long these lines; ofcourse, no idea how
> well it actually behaves.
>
> Index: linux-2.6/include/linux/sched/topology.h
> ===================================================================
> --- linux-2.6.orig/include/linux/sched/topology.h
> +++ linux-2.6/include/linux/sched/topology.h
> @@ -98,7 +98,6 @@ struct sched_domain {
>
>         /* idle_balance() stats */
>         u64 max_newidle_lb_cost;
> -       unsigned long next_decay_max_lb_cost;
>
>         u64 avg_scan_cost;              /* select_idle_sibling */
>
> Index: linux-2.6/kernel/sched/fair.c
> ===================================================================
> --- linux-2.6.orig/kernel/sched/fair.c
> +++ linux-2.6/kernel/sched/fair.c
> @@ -10241,6 +10241,17 @@ void update_max_interval(void)
>  }
>
>  /*
> + * Asymmetric IIR filter, 1/4th down, 3/4th up.
> + */
> +static void update_newidle_cost(u64 *cost, u64 new)
> +{
> +       s64 diff = new - *cost;
> +       if (diff > 0)
> +               diff *= 3;
> +       *cost += diff / 4;
> +}

I tried to use something similar which was based on update_avg() but
there were some performance regressions:
some regressions were linked to not jumping to the new max directly. I
assume some level were started whereas it would take too much time
and some regressions happened  if the decay was too quick

> +
> +/*
>   * It checks each scheduling domain to see if it is due to be balanced,
>   * and initiates a balancing operation if so.
>   *
> @@ -10256,33 +10267,18 @@ static void rebalance_domains(struct rq
>         /* Earliest time when we have to do rebalance again */
>         unsigned long next_balance = jiffies + 60*HZ;
>         int update_next_balance = 0;
> -       int need_serialize, need_decay = 0;
> -       u64 max_cost = 0;
> +       int need_serialize;
>
>         rcu_read_lock();
>         for_each_domain(cpu, sd) {
> -               /*
> -                * Decay the newidle max times here because this is a regular
> -                * visit to all the domains. Decay ~1% per second.
> -                */
> -               if (time_after(jiffies, sd->next_decay_max_lb_cost)) {
> -                       sd->max_newidle_lb_cost =
> -                               (sd->max_newidle_lb_cost * 253) / 256;
> -                       sd->next_decay_max_lb_cost = jiffies + HZ;
> -                       need_decay = 1;
> -               }
> -               max_cost += sd->max_newidle_lb_cost;
>
>                 /*
>                  * Stop the load balance at this level. There is another
>                  * CPU in our sched group which is doing load balancing more
>                  * actively.
>                  */
> -               if (!continue_balancing) {
> -                       if (need_decay)
> -                               continue;
> +               if (!continue_balancing)
>                         break;
> -               }
>
>                 interval = get_sd_balance_interval(sd, busy);
>
> @@ -10313,14 +10309,7 @@ out:
>                         update_next_balance = 1;
>                 }
>         }
> -       if (need_decay) {
> -               /*
> -                * Ensure the rq-wide value also decays but keep it at a
> -                * reasonable floor to avoid funnies with rq->avg_idle.
> -                */
> -               rq->max_idle_balance_cost =
> -                       max((u64)sysctl_sched_migration_cost, max_cost);
> -       }
> +
>         rcu_read_unlock();
>
>         /*
> @@ -10909,8 +10898,7 @@ static int newidle_balance(struct rq *th
>
>                         t1 = sched_clock_cpu(this_cpu);
>                         domain_cost = t1 - t0;
> -                       if (domain_cost > sd->max_newidle_lb_cost)
> -                               sd->max_newidle_lb_cost = domain_cost;
> +                       update_newidle_cost(&sd->max_newidle_lb_cost, domain_cost);
>
>                         curr_cost += domain_cost;
>                         t0 = t1;
> @@ -10930,8 +10918,7 @@ static int newidle_balance(struct rq *th
>
>         raw_spin_rq_lock(this_rq);
>
> -       if (curr_cost > this_rq->max_idle_balance_cost)
> -               this_rq->max_idle_balance_cost = curr_cost;
> +       update_newidle_cost(&this_rq->max_idle_balance_cost, curr_cost);
>
>         /*
>          * While browsing the domains, we released the rq lock, a task could
>
