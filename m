Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37CA43FC5B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhJ2MdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhJ2MdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:33:17 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE8EC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 05:30:48 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id y80so23715133ybe.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=POCkhyJh1pTuOpdrjR5OwVuwH9o0vid/5lSmmbQ3+/M=;
        b=zfAI/VLA8v7vyKyANISkysL8W9SO5K++KHrxdMFv8L+PAzTNbEU6qjtjy+TBp0etkd
         wRS8QmqlF8PX5yWM1GeeSsX6et0CK/7KeLQpQsF4ixptCyplPhm+oG8FiJV56l+ejLRs
         Z5e0t6DOCydFXyOtMe1rwnXdkgdXVqTq44bv1BvFhHqISht6VuRxSLwrK7v2Ce6Zia6T
         /OxiuXCscZa0vyJJQEODiUstxaP32rmE5BwxNPBsq2izYlChoJnrbUYHR/9+h262VIDv
         dc9al8OAut0B56bGinRtiWW9RUMsi20zr7oaq7ky8gRkt9ksRhK6Vv5ZtF60aq0SncqD
         CVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POCkhyJh1pTuOpdrjR5OwVuwH9o0vid/5lSmmbQ3+/M=;
        b=XEhICx8AxskIE8i+njavh2td5xN8pkWdu9AUV8rjFtGLAI8Ii4kzv0UfWEwGjymPod
         1l87uYGSRpnYG2PqJS9a2wTIXm0ogu+u5AEUjZ2ju2AOTlpny2HnrJma9plrFDktC2m0
         7zo94mrn2TkMI5cnz424Kdh0uWK45O/UdRliVrMRQbkzuSM6Cxpjxky+ZNuwCsnM3kIK
         6/Jb1YvORiHgjHcowkd+bhoh3W/E5DUCVhdLkecldLcI9Ejn6HGM6ytMTHnqrGin6ZN1
         VTz9nsxzQvFgbfguLvNQyGtbqTryzmNYxk8z1CMmFA4O8EJ/3sYGYQWqmVX5LBZQOpNu
         h4uA==
X-Gm-Message-State: AOAM532Z6c9Y13CQSL8mrL2pGg8pBCFN6G8jA9FcF61DNQd8JaYedix0
        IHwHf9/Bbi2uXlm9MYVmFQck6JICKseH/zvKzxiB2Q==
X-Google-Smtp-Source: ABdhPJzzdCEKPjQ20a70J54hh4ha5CoDkEZTnZzmLEsEnx4gN18N8uJsgI1la1FPsNcK9CCSIHaC9tojDyYRWZhChHU=
X-Received: by 2002:a05:6902:727:: with SMTP id l7mr12139075ybt.259.1635510648094;
 Fri, 29 Oct 2021 05:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
 <20211019123537.17146-5-vincent.guittot@linaro.org> <2fb13962-0432-2e36-26e6-d05534464294@arm.com>
In-Reply-To: <2fb13962-0432-2e36-26e6-d05534464294@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 29 Oct 2021 14:30:36 +0200
Message-ID: <CAKfTPtDEqYa23UmAZS5S9OX07jQr-4DWStoX0uLd2fHScMgNYg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] sched/fair: Remove sysctl_sched_migration_cost condition
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 at 12:02, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 19/10/2021 14:35, Vincent Guittot wrote:
> > With a default value of 500us, sysctl_sched_migration_cost is
> > significanlty higher than the cost of load_balance. Remove the
>
> Shouldn't this be rather `load balance cost on the lowest sd`? I assume
> here that lb cost stands for sd->max_newidle_lb_cost of the 1st sd.

Both.

During the tests, I did on thx2, the sum of sd->max_newidle_lb_cost
could range between 18us and 829us.

During those tests, I had a limited number of cgroup and the
update_blocked_average could certainly go above the 273us of SMT
sd->max_newidle_lb_cost and the 500us of sysctl_sched_migration_cost

>
> We still use sysctl_sched_migration_cost as a floor against max_cost
> (i.e. lb cost of all sd's) when setting rq->max_idle_balance_cost in
> rebalance_domains().

rq->max_idle_balance_cost is used to cap the value used to compute rq->avg_idle.

>
> And in the add-on discussion (disabling the call to
> nohz_newidle_balance() you mention that sd->max_newidle_lb_cost can be
> higher than sysctl_sched_migration_cost (even when default 500us).

yes, I have reached 273us on thx2 with 2 empty cgroups

>
>
> > condition and rely on the sd->max_newidle_lb_cost to abort
> > newidle_balance.
> >
> > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e50fd751e1df..57eae0ebc492 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10895,8 +10895,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >       rcu_read_lock();
> >       sd = rcu_dereference_check_sched_domain(this_rq->sd);
> >
> > -     if (this_rq->avg_idle < sysctl_sched_migration_cost ||
> > -         !READ_ONCE(this_rq->rd->overload) ||
> > +     if (!READ_ONCE(this_rq->rd->overload) ||
> >           (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> >
> >               if (sd)
> >
>
