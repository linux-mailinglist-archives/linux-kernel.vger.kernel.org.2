Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A436440DCE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 11:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhJaKUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 06:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhJaKUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 06:20:48 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBF5C061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 03:18:17 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id a129so23858199yba.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 03:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LMVI1kpqvvyiP3Olw3uywPocXg6WxoMUFeIKvUYY17I=;
        b=LJfWLP1GRusAODbhA/S1ZDFw18z+WmxHOYF7IJnikHj6R/HZo351kZgtzEBx0+pwBh
         ESLQaIxvr7hpOdeTRcnh0OrWr/1IwuwS6e5lVAb2+jF9eYXdL+1VhHLvgP6XTqELHoB7
         W0RL8qmRguf50UOIlARwYdRDxlWsChnxM1ZuQFjcXHp6htcX/yAWtaFpXa8GUTCXMUqv
         wyP3frpYdGX0B3pPzciGSgZEwRupYwiYRHuiZ8SCEuXbjQ+pcZS8+krrqSsGsqtAmHYs
         eBEiPrjo+WC0Of2uaIx0ZUJc27R3oTWlIrc9wjjZVn3i3D9DHJh5Y1+pqczg/Tt5Zsk4
         Ve3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LMVI1kpqvvyiP3Olw3uywPocXg6WxoMUFeIKvUYY17I=;
        b=EwYMVO39yC/GSjKfJwhQD4uEmXzFipnZFTxktPTR+Gy0dLXojZeqZlgbcOz+P+34dv
         i9CJvnoZqVXvU8vETOqblt0dccVJ3SpvUGMPVZs/DrjDuMAy1FddO+qzG3O4z6CYabFB
         vjKrHKWpFnsCGPLmGJFXcQqmqpxLUD1vI7iB9uAzozo6M4fcgPGa/EV+l/n7SthWO+Qj
         RtAWSgtPHkTsKvY14AOjllKNZZbICr2Xy/Oo5lwc8Ln4MZ7HdYmLLpNyxGesUeEDxPAv
         t/doBA90+p7VM+9G9uZ217vy5fWWgXvTsI+N8tbll/oydlwXbT7vrgdKHBsu/sVfwUqB
         lr4g==
X-Gm-Message-State: AOAM5319FfLt+g3hsEC7O0raCzK2CQQhn+axXsfIGLPEuG0UZk0b3D8d
        L+yf4x5pZWi3cRHdyYDGVtrh1PS9exKAlQyUvdbcVQ==
X-Google-Smtp-Source: ABdhPJwqdHjzz/qrOvohvsPmNT4PqonDfVpaca+xA7AjcHuLu/87i3Ivx7ZwjPx6QojRmKSb65+SNk8arn6pJRsojT8=
X-Received: by 2002:a25:44c5:: with SMTP id r188mr17615327yba.191.1635675496310;
 Sun, 31 Oct 2021 03:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
 <7128695d64e9161637b67315b5beb51c4accdc82.camel@linux.intel.com>
 <CAKfTPtAv7vPGYAwUSmGL5wtbY=if8G+3geWMKpHu3vLGqthPfg@mail.gmail.com> <f21e1c14148039eb5c7d475f53aba1f4a2e0ca43.camel@linux.intel.com>
In-Reply-To: <f21e1c14148039eb5c7d475f53aba1f4a2e0ca43.camel@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sun, 31 Oct 2021 11:18:04 +0100
Message-ID: <CAKfTPtDc4V9sV=K68zer__3THkbbTpwC7v8t36Z88oVx4-Z-wg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Improve newidle lb cost tracking and early abort
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 at 19:00, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Wed, 2021-10-27 at 10:49 +0200, Vincent Guittot wrote:
> >
> >
> > Few problems still remain in your case if I'm not wrong:
> > There is a patch that ensures that rq->next_balance is never set in
> > the past.
> >
>
> Vincent,
>
> Were you planning to take the patch to prevent the next_balance to be
> in the past?

I can add it to this serie


>
> Tim
>
> ---
> From 2a5ebdeabbfdf4584532ef0e27d37ed75ca7dbd3 Mon Sep 17 00:00:00 2001
> From: Tim Chen <tim.c.chen@linux.intel.com>
> Date: Tue, 11 May 2021 09:55:41 -0700
> Subject: [PATCH] sched: sched: Fix rq->next_balance time updated to earlier
>  than current time
> To: hmem@eclists.intel.com
>
> In traces on newidle_balance(), this_rq->next_balance
> time goes backward and earlier than current time jiffies, e.g.
>
> 11.602 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb739
> 11.624 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
> 13.856 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73b
> 13.910 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
> 14.637 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73c
> 14.666 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
>
> It doesn't make sense to have a next_balance in the past.
> Fix newidle_balance() and update_next_balance() so the next
> balance time is at least jiffies+1.
> ---
>  kernel/sched/fair.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1d75af1ecfb4..740a0572cbf1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9901,7 +9901,10 @@ update_next_balance(struct sched_domain *sd, unsigned long *next_balance)
>
>         /* used by idle balance, so cpu_busy = 0 */
>         interval = get_sd_balance_interval(sd, 0);
> -       next = sd->last_balance + interval;
> +       if (time_after(jiffies+1, sd->last_balance + interval))
> +               next = jiffies+1;
> +       else
> +               next = sd->last_balance + interval;
>
>         if (time_after(*next_balance, next))
>                 *next_balance = next;
> @@ -10681,6 +10684,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>
>  out:
>         /* Move the next balance forward */
> +       if (time_after(jiffies+1, this_rq->next_balance))
> +               this_rq->next_balance = jiffies+1;
>         if (time_after(this_rq->next_balance, next_balance))
>                 this_rq->next_balance = next_balance;
>
> --
> 2.20.1
>
>
