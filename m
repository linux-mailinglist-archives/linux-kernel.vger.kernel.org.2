Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC9043FC27
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhJ2MVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbhJ2MVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:21:48 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9597C061714
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 05:19:19 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id d10so12896203ybe.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 05:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10tnfe2pHN9R0eBYE2LkUNGIm0iK4Dotq+pfruoYsew=;
        b=eLCfvMJaYk0AGY3BBsj3AanlexjWk4dw45Xfxhyc7f3cga5qHv2q1h6PlXa87quX5C
         CZWcTY8ePOq8RLlyQVAruiR/muqkS3y2UWDCiLXstuKiuEDuB0xrdB2914jCJv7psfvJ
         E2W9DaPB1Hp4Rkk57eH/X/sWrWWNPKbZK/Nl/5b0K0M1TRMbHiaVn47PqniojMBAPUPi
         5EQW1GKl0gKgjLRUwkYH8m1D5apz0vDqsR5JrTWsBgbKijWG+d37/ZSfuwJpAiE3rSvc
         bePW7TRSnPQdoH6cCjeEAm/ov5xZixPuv0YDlh1jxuDryzzIze7TZ6h8RMk4+gXuxQae
         QzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10tnfe2pHN9R0eBYE2LkUNGIm0iK4Dotq+pfruoYsew=;
        b=Y372ny3NE/H11quMp1KfRxL/3xL1OnhW0VRXXd19lPheWVhxsLNmBCUfTL8PxRkE49
         oa5lCrIhc+0GSlnucPuTsUAvjsVjAIZy5ReSQ78eoZgGU1UQHv0H6ZJWbIL0wEIBc8Ym
         LpnzrafvEJHPI4Xxk7yoJArwPA5Aol4Zk53FUT11c7gm7BqIO0GDLQFJC3XUSZsRF8NH
         zpezuyiHbgDOjsUs50o3EpXJmaVOm1717zsdtyV+B/BEPamvr5gpC4j1T/chfIr6eXhS
         i8OPR85++C7dZAoZndFlIb8z6YRZjVGmtkDycvmW5nvaqB1Ud318lcKCP8TZ6xvfDmMv
         3lWA==
X-Gm-Message-State: AOAM531GUNdC5uy0GHKxMJ45xWJtEaVBBiAbnTTyvKjcCzyKHe6Bwdc7
        IaAmYLVmnxDkC3JTRHlDY0RPls4h+K4YidOakJmFzKlQJb+NLQ==
X-Google-Smtp-Source: ABdhPJxA2IXU2YkwHzXx6V7TwviE4RmOoetMkRun+h4tOQJ4Wt9gBxFsG4ATG56L445xQG+fPAl7W5Yi3Y61mxtIlaQ=
X-Received: by 2002:a5b:d50:: with SMTP id f16mr1224928ybr.350.1635509958954;
 Fri, 29 Oct 2021 05:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
 <20211019123537.17146-4-vincent.guittot@linaro.org> <67218e25-a472-baa0-19bf-71af26f5e767@arm.com>
In-Reply-To: <67218e25-a472-baa0-19bf-71af26f5e767@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 29 Oct 2021 14:19:07 +0200
Message-ID: <CAKfTPtDHfvZQ7uKkFHdFX+gjyOW+BaSmJepGiVtfBMpJaUmtFw@mail.gmail.com>
Subject: Re: [PATCH 3/5] sched/fair: Wait before decaying max_newidle_lb_cost
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 at 12:01, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 19/10/2021 14:35, Vincent Guittot wrote:
> > Decay max_newidle_lb_cost only when it has not been updated for a while
> > and ensure to not decay a recently changed value.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  include/linux/sched/topology.h |  2 +-
> >  kernel/sched/fair.c            | 36 +++++++++++++++++++++++++---------
> >  kernel/sched/topology.c        |  2 +-
> >  3 files changed, 29 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > index 2f9166f6dec8..c07bfa2d80f2 100644
> > --- a/include/linux/sched/topology.h
> > +++ b/include/linux/sched/topology.h
> > @@ -105,7 +105,7 @@ struct sched_domain {
> >
> >       /* idle_balance() stats */
> >       u64 max_newidle_lb_cost;
> > -     unsigned long next_decay_max_lb_cost;
> > +     unsigned long last_decay_max_lb_cost;
> >
> >       u64 avg_scan_cost;              /* select_idle_sibling */
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index c4c36865321b..e50fd751e1df 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10239,6 +10239,30 @@ void update_max_interval(void)
> >       max_load_balance_interval = HZ*num_online_cpus()/10;
> >  }
> >
> > +static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
> > +{
> > +     if (cost > sd->max_newidle_lb_cost) {
> > +             /*
> > +              * Track max cost of a domain to make sure to not delay the
> > +              * next wakeup on the CPU.
> > +              */
> > +             sd->max_newidle_lb_cost = cost;
> > +             sd->last_decay_max_lb_cost = jiffies;
>
> That's the actual change of the patch: sd->last_decay_max_lb_cost being
> moved forward also when newidle cost is updated from newidle_balance() ?
>
> > +     } else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
> > +             /*
> > +              * Decay the newidle max times by ~1% per second to ensure that
> > +              * it is not outdated and the current max cost is actually
> > +              * shorter.
>
> I assume that `max cost` refers here to a local variable of the only
> caller of update_newidle_cost(..., 0) - rebalance_domains()?
>
> "the current max cost" has to be shorter so that
> rq->max_idle_balance_cost also decays in this case. Is this what this
> comment tries to say here?

I refer to the time tracked in sd->max_newidle_lb_cost
here i set current_cost to zero to trigger a possible decay of
sd->max_newidle_lb_cost

>
> [...]
