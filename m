Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B736336FBF4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhD3OQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhD3OQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:16:39 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EA4C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:15:50 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a36so70152569ljq.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lm81RBkf41FAiDC7CerKJbXO98vFgZVEYp8ITdElgcI=;
        b=a6vk3+YNXfHnDYRMd+3BPmlK9oaBXO6huVbNevJOZ8s1fUuc8HEFm85c/jY5Sb34Jl
         Nq2k/fsqnxxwdgNVkg4SCzLWuvRiLxiH6e8o6TWJqptSYvDFuRmtjqQjg7WQPjTeG29h
         Rrog4KUZujGg+q6xHJQinRTWr1yvLiF0C50PaaH9iJgX+HfK6XVto+p76ChF8TFK3/9R
         nfnFgO37w9MCujgpMjhDXm3d16f9WGoidvv3PbqGkw66gG5ZiZKjVa1mbNHkxmJ2+QKJ
         fP3fz/ZPvR9jj+GSN4gxFfoIAT6lwOo6xq8jUPY7SpQxFF9nAm5Bm0HWAx/lsbpcdOzO
         XGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lm81RBkf41FAiDC7CerKJbXO98vFgZVEYp8ITdElgcI=;
        b=F1puIPZTSFZi1re4QUhrjd3gcFAXsiLMbMsiHPBBGvXLfF3XWz9nWR0BJXnKmGNjEJ
         2+GoN7LdnmGE4ui13jN6YbYD58APCDne8tNdRcugCFKLau54Aslo2VoTmsQBlAaJ+i+z
         /cSVxVVkgD/PmCetbI/1cqw3888audkyfvsMo0iLUugrdTypmZJtEc8E/uaJj8xEr7y9
         pcjDbujqcRRdnWqDDl4iKE7Ic4kXeN0A6MNE1eBb700c5byXiIWO7Pb7xD10Feje9u3x
         qhbohUt3jUBdGremnsH9GT6blHZkAF8VWox9qgp/PT3H+qP5v8EvkmuTyYL7qFMi8xaI
         Ip+w==
X-Gm-Message-State: AOAM5333ES9FIWG6y+y9wBs9j6ydqJwONWC3DJs+KrNVxZ2qd7emgdd6
        1WkP4Ac71PwWQIK/oI5SfvX1UkPugpv0EMjmxkA=
X-Google-Smtp-Source: ABdhPJybS4z5TIghwSriK+9JeOYo0dyXf01M0PZrJAeXLGakKFXKQC08hv6d4fUVAZY1OysJHLGbMc68PCu3dzbdIlo=
X-Received: by 2002:a2e:9782:: with SMTP id y2mr3956737lji.371.1619792149046;
 Fri, 30 Apr 2021 07:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CAERHkrsC9rC4Jrkz8r-7kp4SFPM6aU+EHN+Y+uQiTuPG5S72bA@mail.gmail.com>
 <CABk29NuS-B3n4sbmavo0NDA1OCCsz6Zf2VDjjFQvAxBMQoJ_Lg@mail.gmail.com>
 <CAERHkrvTkN3zJFr0RpO02wF1KdhgqWZL8VpFohc4i7qPzvr8Cg@mail.gmail.com> <CABk29NtLR5q_i=CGyCqtjR5ruJ1dtWN=_JB8wiRhxgevdCiPPQ@mail.gmail.com>
In-Reply-To: <CABk29NtLR5q_i=CGyCqtjR5ruJ1dtWN=_JB8wiRhxgevdCiPPQ@mail.gmail.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Fri, 30 Apr 2021 22:15:37 +0800
Message-ID: <CAERHkrtyUrDDnZYPCzj3juVVnxpTJvdD7F=QRC0Kg_LGCouLZg@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Hiatt <dhiatt@digitalocean.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 4:48 PM Josh Don <joshdon@google.com> wrote:
>
> On Fri, Apr 30, 2021 at 1:20 AM Aubrey Li <aubrey.intel@gmail.com> wrote:
> >
> > On Fri, Apr 30, 2021 at 4:40 AM Josh Don <joshdon@google.com> wrote:
> > >
> > > On Thu, Apr 29, 2021 at 1:03 AM Aubrey Li <aubrey.intel@gmail.com> wrote:
> > > >
> > > > On Thu, Apr 22, 2021 at 8:39 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > ----snip----
> > > > > @@ -199,6 +224,25 @@ void raw_spin_rq_unlock(struct rq *rq)
> > > > >         raw_spin_unlock(rq_lockp(rq));
> > > > >  }
> > > > >
> > > > > +#ifdef CONFIG_SMP
> > > > > +/*
> > > > > + * double_rq_lock - safely lock two runqueues
> > > > > + */
> > > > > +void double_rq_lock(struct rq *rq1, struct rq *rq2)
> > > > > +{
> > > > > +       lockdep_assert_irqs_disabled();
> > > > > +
> > > > > +       if (rq1->cpu > rq2->cpu)
> > > >
> > > > It's still a bit hard for me to digest this function, I guess using (rq->cpu)
> > > > can't guarantee the sequence of locking when coresched is enabled.
> > > >
> > > > - cpu1 and cpu7 shares lockA
> > > > - cpu2 and cpu8 shares lockB
> > > >
> > > > double_rq_lock(1,8) leads to lock(A) and lock(B)
> > > > double_rq_lock(7,2) leads to lock(B) and lock(A)
> > > >
> > > > change to below to avoid ABBA?
> > > > +       if (__rq_lockp(rq1) > __rq_lockp(rq2))
> > > >
> > > > Please correct me if I was wrong.
> > >
> > > Great catch Aubrey. This is possibly what is causing the lockups that
> > > Don is seeing.
> > >
> > > The proposed usage of __rq_lockp() is prone to race with sched core
> > > being enabled/disabled.It also won't order properly if we do
> > > double_rq_lock(smt0, smt1) vs double_rq_lock(smt1, smt0), since these
> > > would have equivalent __rq_lockp()
> >
> > If __rq_lockp(smt0) == __rq_lockp(smt1), rq0 and rq1 won't swap,
> > Later only one rq is locked and just returns. I'm not sure how does it not
> > order properly?
>
> If there is a concurrent switch from sched_core enable <-> disable,
> the value of __rq_lockp() will race.
>
> In the version you posted directly above, where we swap rq1 and rq2 if
> __rq_lockp(rq1) > __rqlockp(rq2) rather than comparing the cpu, the
> following can happen:
>
> cpu 1 and cpu 7 share a core lock when coresched is enabled
>
> - schedcore enabled
> - double_lock(7, 1)
> - __rq_lockp compares equal for 7 and 1; no swap is done
> - schedcore disabled; now __rq_lockp returns the per-rq lock
> - lock(__rq_lockp(7)) => lock(7)
> - lock(__rq_lockp(1)) => lock(1)
>
> Then we can also have
>
> - schedcore disabled
> - double_lock(1, 7)
> - __rq_lock(1) < rq_lock(7), so no swap
> - lock(__rqlockp(1)) => lock(1)
> - lock(__rq_lockp(7)) => lock(7)
>
> So we have in the first 7->1 and in the second 1->7
>
> >
> > .> I'd propose an alternative but similar idea: order by core, then break ties
> > > by ordering on cpu.
> > >
> > > +#ifdef CONFIG_SCHED_CORE
> > > +       if (rq1->core->cpu > rq2->core->cpu)
> > > +               swap(rq1, rq2);
> > > +       else if (rq1->core->cpu == rq2->core->cpu && rq1->cpu > rq2->cpu)
> > > +               swap(rq1, rq2);
> >
> > That is, why the "else if" branch is needed?
>
> Ensuring that core siblings always take their locks in the same order
> if coresched is disabled.
>

Both this and above make sense to me. Thanks for the great elaboration, Josh!

Thanks,
-Aubrey
