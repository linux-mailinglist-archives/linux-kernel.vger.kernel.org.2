Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8D036CF90
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 01:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbhD0XbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 19:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbhD0Xa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 19:30:59 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC68C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 16:30:15 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id 1so45510591qtb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 16:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Egrxs+tP6FH+3UGq8SD5QzOQNFT4ls7dPK5Sy7xketE=;
        b=hCvaDpn4c7HJBKkEJ9SR+1DdlKZKOIWvMiO//uVfLnVRtlqcKBxhT44pSpANzkmrZy
         /iSw5nHmiBM87gLLCOKQ9qyFWXxPx8Fa92mMlPyeEB5tjyRIzGdnaShByFQyQoGYdyjY
         2CFO7u9CteNLTM9C0H5z1b5heSPC5sDSy4578bXlAj/VmQLosM8jND/ADz6DKLdlO9ty
         MPD5Z86Z+RrTwbeafZZb1pfPnxPERPU0HLmLUDVZjAKr1QXdI0+VPsw5AYoSO2Hq1qyH
         nQ/TJk/0ylm2vFwCEDVJsZsxnOb2onnmmY/dW0uKbn1B+lrqnaQXSbV0RXEAPugMxt0w
         PlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Egrxs+tP6FH+3UGq8SD5QzOQNFT4ls7dPK5Sy7xketE=;
        b=NYX7oGbumcp6iRBxt5FJEE8gKvWZfjiacYNejbEuS/5k1U4S8kv295wJdfayvXqdzT
         Xo4Y589h9xpedGrkxofKaDVd6Ti22jlUJJJ3/r06/uuMsQs0eF23irBQkDDeL93axd63
         onS/Lm7JqUvBTt1b5OGzkTrl3pP8pwbPkRtG/GKcRo/RmS6cPmAXdyGcao8Am0ky7Ao4
         uVfj707dfg3N2wzIn/OXZd8CeReGS8H97P1LVUPIn3jkzfdLsy92q4ezOsRH9Es4s9Kd
         Up+suc7oHybxoF7NrQ0yEQx8v0t8eFYjzanfAME+uYUQPBs1DVKghFGqNYF1WlaZGI/E
         HbOA==
X-Gm-Message-State: AOAM530P+Md404VlCBK06674XutLQ1JtumtDne5mjWEMS2ZYsfdHiR7J
        MNaEfoA+s1fYSo6fr2RVJx6PNc23lbqkFZBg2WXAxA==
X-Google-Smtp-Source: ABdhPJzjHisdJskvWF/vnAaKw7+dt8iQwUzsAUTwVpt+mU6wqIXJJIdJBZtJw03keNF2aKxWvEEkhYiBjxoksDEyO7k=
X-Received: by 2002:a05:622a:c8:: with SMTP id p8mr13288319qtw.145.1619566213468;
 Tue, 27 Apr 2021 16:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net> <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
In-Reply-To: <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 27 Apr 2021 16:30:02 -0700
Message-ID: <CABk29NvaH687GfOm_b5_hJF6HBQ6fu+1hzc0GFNEMv5mj3DrUw@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, dhiatt@digitalocean.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 3:21 PM Josh Don <joshdon@google.com> wrote:
>
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f732642e3e09..1a81e9cc9e5d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -290,6 +290,10 @@ static void sched_core_assert_empty(void)
> >  static void __sched_core_enable(void)
> >  {
> >         static_branch_enable(&__sched_core_enabled);
> > +       /*
> > +        * Ensure raw_spin_rq_*lock*() have completed before flipping.
> > +        */
> > +       synchronize_sched();
>
> synchronize_rcu()
>
> >         __sched_core_flip(true);
> >         sched_core_assert_empty();
> >  }
> > @@ -449,16 +453,22 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
> >  {
> >         raw_spinlock_t *lock;
> >
> > +       preempt_disable();
> >         if (sched_core_disabled()) {
> >                 raw_spin_lock_nested(&rq->__lock, subclass);
> > +               /* preempt *MUST* still be disabled here */
> > +               preempt_enable_no_resched();
> >                 return;
> >         }
>
> This approach looks good to me. I'm guessing you went this route
> instead of doing the re-check after locking in order to optimize the
> disabled case?
>
> Recommend a comment that the preempt_disable() here pairs with the
> synchronize_rcu() in __sched_core_enable().
>
> >
> >         for (;;) {
> >                 lock = __rq_lockp(rq);
> >                 raw_spin_lock_nested(lock, subclass);
> > -               if (likely(lock == __rq_lockp(rq)))
> > +               if (likely(lock == __rq_lockp(rq))) {
> > +                       /* preempt *MUST* still be disabled here */
> > +                       preempt_enable_no_resched();
> >                         return;
> > +               }
> >                 raw_spin_unlock(lock);
> >         }
> >  }

Also, did you mean to have a preempt_enable_no_resched() rather than
prempt_enable() in raw_spin_rq_trylock?

I went over the rq_lockp stuff again after Don's reported lockup. Most
uses are safe due to already holding an rq lock. However,
double_rq_unlock() is prone to race:

double_rq_unlock(rq1, rq2):
/* Initial state: core sched enabled, and rq1 and rq2 are smt
siblings. So, double_rq_lock(rq1, rq2) only took a single rq lock */
raw_spin_rq_unlock(rq1);
/* now not holding any rq lock */
/* sched core disabled. Now __rq_lockp(rq1) != __rq_lockp(rq2), so we
falsely unlock rq2 */
if (__rq_lockp(rq1) != __rq_lockp(rq2))
        raw_spin_rq_unlock(rq2);
else
        __release(rq2->lock);

Instead we can cache __rq_lockp(rq1) and __rq_lockp(rq2) before
releasing the lock, in order to prevent this. FWIW I think it is
likely that Don is seeing a different issue.
