Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F23836F75B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhD3Itf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhD3Ite (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:49:34 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AEFC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:48:45 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id a30so7273884qvb.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcbqiOtTmiC5jlNtcBXdTM6WSSrjdlexsm8VPgksS3Y=;
        b=vx9TakcIZtEzQl4Xg6+pIkZ2Od6la/GuhUNXKx83dw+HuSqAjvcU8xIn5ANlVAj2dj
         NnU3tuweFkLRBhYfd2n+2bvHqQgaIw7O55cwQFTQje4Bqs453rozC4C19yoLPmwNJfbB
         p043Nc80fMPinaGDAd1vpVX+Q9E4RXwGqioynmVUy92jP05SXPc/tLsdFdsZUNnxXKKO
         +ZNmPpzU2tPOpQMtNyxnsIOUwIVIPs4pIhRlfbfjVZ/VrE+VJrzO74E5qE6WdiBnRMt1
         XiSTtMBN0ZR75m7hsQLfWKlJUlQwoQQW/yCFzEj3Grt4NubDknWhdt9F/z198wL0a3gZ
         sRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcbqiOtTmiC5jlNtcBXdTM6WSSrjdlexsm8VPgksS3Y=;
        b=B+i6JygTxH70cge9C7iHH12MWH6ro6Vc5lrurJSWQcJksEBxa3IU+AJ76Q58L8jGic
         mAvrBH8U4fcLSEdNvRM0OUbwohQQv8dI1Hbtf/1uRMV227+q+Qm20T/4oaUz47gH0sRe
         cWZhAaJL0/y21JjXTm9g23iJCSBrfplkW1AMzGtCTOKdFvn7q4HBG3UZkJ3cA15dgJqD
         ox9ooll+V8xsVWZNL/MDd4Oa16nkvJbV2NZeEkQdp0bjcJH+0f5hjZ0WmSmFnMrmY9Zb
         MytSBWeLlg+F+9w1dHpM7x148vBdGGixSRSehOcCS8U48LzepAXRN4+DUJ4+EjMGLxuz
         yhCQ==
X-Gm-Message-State: AOAM533KDw03UbiikXeWnr4Ga1vyZRIl0z5BcL/waVQF5gaI0wqQ536q
        WyfRkYlTIWkBoqBvbgdhUUAElrC28g5jrJpy9+vtqQ==
X-Google-Smtp-Source: ABdhPJxi6LeTkPBZjec0P7nT7gz2I3C6SEJGtrwukmk9HoGx8Ytw56QNA4I8+N1+VzggJYBB+8sGDacVpiKBLrbi6mk=
X-Received: by 2002:a0c:a425:: with SMTP id w34mr4579283qvw.2.1619772523909;
 Fri, 30 Apr 2021 01:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CAERHkrsC9rC4Jrkz8r-7kp4SFPM6aU+EHN+Y+uQiTuPG5S72bA@mail.gmail.com>
 <CABk29NuS-B3n4sbmavo0NDA1OCCsz6Zf2VDjjFQvAxBMQoJ_Lg@mail.gmail.com> <CAERHkrvTkN3zJFr0RpO02wF1KdhgqWZL8VpFohc4i7qPzvr8Cg@mail.gmail.com>
In-Reply-To: <CAERHkrvTkN3zJFr0RpO02wF1KdhgqWZL8VpFohc4i7qPzvr8Cg@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 30 Apr 2021 01:48:32 -0700
Message-ID: <CABk29NtLR5q_i=CGyCqtjR5ruJ1dtWN=_JB8wiRhxgevdCiPPQ@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Aubrey Li <aubrey.intel@gmail.com>
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

On Fri, Apr 30, 2021 at 1:20 AM Aubrey Li <aubrey.intel@gmail.com> wrote:
>
> On Fri, Apr 30, 2021 at 4:40 AM Josh Don <joshdon@google.com> wrote:
> >
> > On Thu, Apr 29, 2021 at 1:03 AM Aubrey Li <aubrey.intel@gmail.com> wrote:
> > >
> > > On Thu, Apr 22, 2021 at 8:39 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > ----snip----
> > > > @@ -199,6 +224,25 @@ void raw_spin_rq_unlock(struct rq *rq)
> > > >         raw_spin_unlock(rq_lockp(rq));
> > > >  }
> > > >
> > > > +#ifdef CONFIG_SMP
> > > > +/*
> > > > + * double_rq_lock - safely lock two runqueues
> > > > + */
> > > > +void double_rq_lock(struct rq *rq1, struct rq *rq2)
> > > > +{
> > > > +       lockdep_assert_irqs_disabled();
> > > > +
> > > > +       if (rq1->cpu > rq2->cpu)
> > >
> > > It's still a bit hard for me to digest this function, I guess using (rq->cpu)
> > > can't guarantee the sequence of locking when coresched is enabled.
> > >
> > > - cpu1 and cpu7 shares lockA
> > > - cpu2 and cpu8 shares lockB
> > >
> > > double_rq_lock(1,8) leads to lock(A) and lock(B)
> > > double_rq_lock(7,2) leads to lock(B) and lock(A)
> > >
> > > change to below to avoid ABBA?
> > > +       if (__rq_lockp(rq1) > __rq_lockp(rq2))
> > >
> > > Please correct me if I was wrong.
> >
> > Great catch Aubrey. This is possibly what is causing the lockups that
> > Don is seeing.
> >
> > The proposed usage of __rq_lockp() is prone to race with sched core
> > being enabled/disabled.It also won't order properly if we do
> > double_rq_lock(smt0, smt1) vs double_rq_lock(smt1, smt0), since these
> > would have equivalent __rq_lockp()
>
> If __rq_lockp(smt0) == __rq_lockp(smt1), rq0 and rq1 won't swap,
> Later only one rq is locked and just returns. I'm not sure how does it not
> order properly?

If there is a concurrent switch from sched_core enable <-> disable,
the value of __rq_lockp() will race.

In the version you posted directly above, where we swap rq1 and rq2 if
__rq_lockp(rq1) > __rqlockp(rq2) rather than comparing the cpu, the
following can happen:

cpu 1 and cpu 7 share a core lock when coresched is enabled

- schedcore enabled
- double_lock(7, 1)
- __rq_lockp compares equal for 7 and 1; no swap is done
- schedcore disabled; now __rq_lockp returns the per-rq lock
- lock(__rq_lockp(7)) => lock(7)
- lock(__rq_lockp(1)) => lock(1)

Then we can also have

- schedcore disabled
- double_lock(1, 7)
- __rq_lock(1) < rq_lock(7), so no swap
- lock(__rqlockp(1)) => lock(1)
- lock(__rq_lockp(7)) => lock(7)

So we have in the first 7->1 and in the second 1->7

>
> .> I'd propose an alternative but similar idea: order by core, then break ties
> > by ordering on cpu.
> >
> > +#ifdef CONFIG_SCHED_CORE
> > +       if (rq1->core->cpu > rq2->core->cpu)
> > +               swap(rq1, rq2);
> > +       else if (rq1->core->cpu == rq2->core->cpu && rq1->cpu > rq2->cpu)
> > +               swap(rq1, rq2);
>
> That is, why the "else if" branch is needed?

Ensuring that core siblings always take their locks in the same order
if coresched is disabled.

>
> > +#else
> >         if (rq1->cpu > rq2->cpu)
> >                 swap(rq1, rq2);
> > +#endif

Best,
Josh
