Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373F944EB05
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhKLQIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhKLQIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:08:44 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B65C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:05:53 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id q74so24822926ybq.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkuxDS6t0tcAaRotTMVpEen3isy6bKfo7Q8ytKiC9G0=;
        b=qS2NWrgEvw7tAmCh1tg9LbV9Pp0DSpz8AGa2giFaNJ+ESnNOvQk1UOIs8jPk2P8n5H
         5dATVLoUZagLoSWMiL8XkAf0qD3mq8JTRLV/jkIppcJS6MCUyfzbAdFtXEdCniR4qYoC
         Wu0M/fZk1U6WTDDEikiIALzuw6hcZITPsoNSxfkNH6b0b0pNT2PYGHl+cSkrCKn95wX6
         GNINjZjS/HeH+mUKBXMGVkJPuBd0fJp1GfI6BE+xTeqed0aS1G63NGSKHGYOCI/Rng+Q
         M9swTyvX/9dS04b0FEy2LGJ1jEqXfy5I3ThsT5NiDKK0XEXS9KMII5ijpMhARePZClA8
         y8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkuxDS6t0tcAaRotTMVpEen3isy6bKfo7Q8ytKiC9G0=;
        b=ogeD7y0pznwhxJdMYZLccC73Sx69g9cqMhVpnS83nQP1bZzv+DQZ/0oaD9l1Yr7lcs
         wAxwAklpt4BcTyI5/YWQrcPlZ1dCMhIRwUs6tTu3v7Pc0HHtnzkUs+L5xnsyc0vkMN57
         VPAj8eAJFbu0CzQrKjLms1LgXR0kiM8aHlLiNAzu0N/uvU4165OZQ4xlZ0GH89cK9cG/
         oVhINEkYR3hNCkt0fX5u7yKyHlO7jXNiCbod0R1vQ3LYRu9YmXIo8yoXy1beTgwzUxX7
         tLkSibDTqx2udynQAyZtPKjfT+ec+MUdoT5A5ZANUiQx+xtq204/+rJ7glr4yN3qUcvI
         gYrw==
X-Gm-Message-State: AOAM5300K25b6YdeNpGKYZipCUWo1+CDGZ5Tf7BS5hoIYaGWtqfINvAR
        exlFQeVaDvoMY6IfsgpJ/uu2BP9dTzOGWKqxNb+meg==
X-Google-Smtp-Source: ABdhPJxUca9F534RKO9gMQ93xB/mq5f9Zcwmn5hh0EFIYvNT4tSf+SMGb39EjD5Jvhqm/TQsbenp51lhBXNF8C5wkTE=
X-Received: by 2002:a5b:d50:: with SMTP id f16mr16605102ybr.350.1636733152868;
 Fri, 12 Nov 2021 08:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20211112095857.7016-1-vincent.guittot@linaro.org>
 <20211112095857.7016-2-vincent.guittot@linaro.org> <YY6ARaFrpuWYqege@hirez.programming.kicks-ass.net>
 <YY6AXx2lhJ27IBuJ@hirez.programming.kicks-ass.net>
In-Reply-To: <YY6AXx2lhJ27IBuJ@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 12 Nov 2021 17:05:41 +0100
Message-ID: <CAKfTPtDPtsRRajctvL1S=ySneRqN7nMyHgc6X9fChmRWTU9eNg@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: skip newidle update stats
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 at 15:55, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Subject: sched/fair: Reflow newidle_balance()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri Nov 12 15:46:08 CET 2021
>
> The control flow in newidle_balance() is a little convoluted, attempt
> simplification.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/fair.c |   21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10858,10 +10858,10 @@ static inline void nohz_newidle_balance(
>  static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  {
>         unsigned long next_balance = jiffies + HZ;
> +       int pulled_task = 0, timeout = 0;
>         int this_cpu = this_rq->cpu;
>         u64 t0, t1, curr_cost = 0;
>         struct sched_domain *sd;
> -       int pulled_task = 0, early_stop = 0;
>
>         update_misfit_status(NULL, this_rq);
>
> @@ -10889,17 +10889,9 @@ static int newidle_balance(struct rq *th
>         if (!READ_ONCE(this_rq->rd->overload) ||
>             (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>
> -               if (sd) {
> +               if (sd)
>                         update_next_balance(sd, &next_balance);
>
> -                       /*
> -                        * We skip new idle LB because there is not enough
> -                        * time before next wake up. Make sure that we will
> -                        * not kick NOHZ_NEWILB_KICK
> -                        */
> -                       early_stop = 1;
> -               }
> -
>                 goto out;
>         }
>
> @@ -10922,7 +10914,7 @@ static int newidle_balance(struct rq *th
>                 update_next_balance(sd, &next_balance);
>
>                 if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
> -                       early_stop = 1;
> +                       timeout = 1;
>                         break;
>                 }
>
> @@ -10967,6 +10959,11 @@ static int newidle_balance(struct rq *th
>         if (this_rq->nr_running != this_rq->cfs.h_nr_running)
>                 pulled_task = -1;
>
> +       if (pulled_task || timeout)
> +               goto out;
> +
> +       nohz_newidle_balance(this_rq);

maybe

       if (!pulled_task && !timeout)
               nohz_newidle_balance(this_rq);

> +
>  out:
>         /* Move the next balance forward */
>         if (time_after(this_rq->next_balance, next_balance))
> @@ -10974,8 +10971,6 @@ static int newidle_balance(struct rq *th
>
>         if (pulled_task)
>                 this_rq->idle_stamp = 0;
> -       else if (!early_stop)
> -               nohz_newidle_balance(this_rq);
>
>         return pulled_task;
>  }
