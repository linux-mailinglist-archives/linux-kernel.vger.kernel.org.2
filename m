Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371D045B08D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 01:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240241AbhKXALA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 19:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhKXAK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 19:10:59 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E47C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 16:07:49 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g14so2135050edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 16:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UPn1RQb6m6ux/VuPOD98r25FyLV3k7Pakxz0gVLX0p0=;
        b=f3WgkDAEouU49B65aACu6yjJ1LBvot6qbp+fQNb6NcngpWHNa5qi4ouOlwwl0owKC5
         S8SicoghLHtwgU4GGuLAUhcGXGSvr9AG5Wj+UuR8rixd0JGa0a46D1pEFklabMVHcGE/
         riJGkiglAu+0bClLpR4qcNBgIwdKKnhQX74pXK+QdXkXVmPtE2QEQ7/WHegAtwHZcTLo
         ZNnW5sbcrR5gSAa6EnxLhqkDC1krK/oqr7dHKPlMz7nWZMbcCJQhTWYtDrXXlF4hhKTl
         H2O0C62AZ1KVZxnCRfuG5CxrfWdDhqo4pWU25pTxXrAa48eBUy3EhaJVRHhvN5Mh9rZn
         A5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UPn1RQb6m6ux/VuPOD98r25FyLV3k7Pakxz0gVLX0p0=;
        b=5NsXcZGuzp22Tc8kUBhe1FXGfEJIQKgTbpLcJ6tnYTWe/IrFmKl0twn8p33lC9+xuu
         5wvVLNJ3HTOmBeE1XS0pMPl+aU1r9BvcBMORPbXAKYbhwrdmPKf60u8or4DdDKDzCt+s
         NSdWVZl9z5AhDps4KKgtdiiy3YV8UexWEj/M+kB7MicNXjohjQsIWG0e2x1E8C3uqM+1
         uXUV7AWRyuO65O3GAahCrWDmbPMosyhLOHn6kkSwNObh9gynuc5SMSy8hWAu6EJ4st9W
         TxFJqMwzPTru/B8XP2j90AyExIbeMkUAWnKL3c8zjzvbVuLArlSn8JtctR/23FXB5RYL
         heMA==
X-Gm-Message-State: AOAM531kIsbmYqaZjbPtjq3Z/WwtGAXP733CSVaEHR2S76j0JV2N/nhT
        HA0bLvGtZ8DEAm/GRQURhPd0C7NRG8y6Up6kqalV0/HMhxgGMQ==
X-Google-Smtp-Source: ABdhPJxYsA1ltBo8Cn1EInzoSvxSsht5RcP6JJQbBTQY5nBcTbiigoUPQt0gSZl/Uauwgv7+W1W9khgHCOfrj8C0SX4=
X-Received: by 2002:a17:906:d92f:: with SMTP id rn15mr13239790ejb.557.1637712467934;
 Tue, 23 Nov 2021 16:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20211123112229.7812-1-21cnbao@gmail.com> <20211123210705.GD721624@worktop.programming.kicks-ass.net>
In-Reply-To: <20211123210705.GD721624@worktop.programming.kicks-ass.net>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 24 Nov 2021 13:07:36 +1300
Message-ID: <CAGsJ_4z-zm=7rCsswTByr_YWzkNHpYyGhhFs1USoOPmwB3XkuA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Remove the cost of a redundant
 cpumask_next_wrap in select_idle_cpu
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 10:07 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 23, 2021 at 07:22:29PM +0800, Barry Song wrote:
> > From: Barry Song <song.bao.hua@hisilicon.com>
> >
> > This patch keeps the same scanning amount, but drops a redundant loop
> > of cpumask_next_wrap.
> > The original code did for_each_cpu_wrap(cpu, cpus, target + 1), then
> > checked --nr; this patch does --nr before doing the next loop, thus,
> > it can remove a cpumask_next_wrap() which costs a little bit.
> >
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >  kernel/sched/fair.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index ff69f24..e2fb3e0 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6298,9 +6298,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >
> >               span_avg = sd->span_weight * avg_idle;
> >               if (span_avg > 4*avg_cost)
> > -                     nr = div_u64(span_avg, avg_cost);
> > +                     nr = div_u64(span_avg, avg_cost) - 1;
> >               else
> > -                     nr = 4;
> > +                     nr = 3;
> >
> >               time = cpu_clock(this);
> >       }
> > @@ -6312,11 +6312,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >                               return i;
> >
> >               } else {
> > -                     if (!--nr)
> > -                             return -1;
> >                       idle_cpu = __select_idle_cpu(cpu, p);
> >                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
> >                               break;
> > +                     if (!--nr)
> > +                             return -1;
> >               }
> >       }
>
> That's just confusing code. Isn't it much clearer to write the whole
> thing like so ?
>
>         nr--;

this is fine to avoid the code of setting 4 to 3 and setting
div_u64(span_avg, avg_cost) to
div_u64(span_avg, avg_cost) - 1;

>         for_each_cpu_wrap(cpu, cpus, target+1) {
>                 ...
>                 if (!nr--)

I guess you mean if(!--nr).

For example, if nr=4, the original code will only check 3 cpus for
__select_idle_cpu.
the new code "nr--" will check 4 cpus for __select_idle_cpu. to keep the amount
untouched,  the code should be --nr.

>                         return -1;
>         }
>

Thanks
Barry
