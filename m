Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7314736F709
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhD3IVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhD3IVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:21:23 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FCBC06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:20:34 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id m7so68921758ljp.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U4VWZamcLyX3tXFReagmlsiBdD3QATx8tPBAnLOS9/g=;
        b=TL1ydab5S3H75dWgmRs9qHH4Qw+2gebligvK+H8gdFjpHqYLs1eNFPEW0b/CYEdWX1
         I4YPeDARQuUgFYO/0q0TAvXqQsJYFPHAcTM4PglRlhoEZ0tSGJn5JIdtD5zBLn1cjqas
         JlA5C6F7vHt15cI0OC3ZZtl5gbpQj9yW7X6M4ZbxdmrT5mI9QcXNkG2hSv3HShrHCrDI
         RSJ+jLEjTMDYGX+DYgZoZ6Fp6r3MJbdUBXVKyBI0x7LqyqG05lK6lLJrNGe1XfOjFPdX
         OQ4q+qC9oF1shZcyv+xOlclirtnXSEaDnW6h9C8TN/2NtpaPUQaHDPBbY1WGoysrQ29u
         9L2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U4VWZamcLyX3tXFReagmlsiBdD3QATx8tPBAnLOS9/g=;
        b=WtA1u+WbUk5VuJN/DVSDeudheFGp59CoE3VpBx2odo4SC2Pl2F5uesj2LBI6MFdiGN
         L3QNv9e27YrsRBIT+Ta1F+NWZYTNSmnpK82yOplHTEF56dIcckoB8kX+MeHpLOQDWcxy
         jOjNkzhZQD8Ha9W/p3icYdtdNwWTdrezEMFrVkw/OeOthp0bSP3qzpMXizFczlYZ5blY
         kgLzBoDy4309Y1XBYwtVuByTeOVi/OVn6siS1BLAHRLV4J/O9reT09UImAZ/CFvwhC6F
         qQv0VfPYbXcupn/DZthkPR4NV97lmNM6qeZI4ZS4ayvNve531JK/6YXsiUIROgu4Ggan
         PLyA==
X-Gm-Message-State: AOAM531XuQ9C9qLYYFMaLylTTWp/vPGTnMFQaQuF8H+2IUJmhdFecFKS
        2F+pSOaZ8LwRyivAtaRyf3+9bxUTJPW/5QQ0Gk0=
X-Google-Smtp-Source: ABdhPJwOq56NPxXDR7noXnZ0KwtVPOL2kRzUQe6MccETqBntWleMoisK1siV31AzmDkYDSRX0MLUd1sQGnfob2ItHek=
X-Received: by 2002:a05:651c:102e:: with SMTP id w14mr2267817ljm.238.1619770832776;
 Fri, 30 Apr 2021 01:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CAERHkrsC9rC4Jrkz8r-7kp4SFPM6aU+EHN+Y+uQiTuPG5S72bA@mail.gmail.com> <CABk29NuS-B3n4sbmavo0NDA1OCCsz6Zf2VDjjFQvAxBMQoJ_Lg@mail.gmail.com>
In-Reply-To: <CABk29NuS-B3n4sbmavo0NDA1OCCsz6Zf2VDjjFQvAxBMQoJ_Lg@mail.gmail.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Fri, 30 Apr 2021 16:20:21 +0800
Message-ID: <CAERHkrvTkN3zJFr0RpO02wF1KdhgqWZL8VpFohc4i7qPzvr8Cg@mail.gmail.com>
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

On Fri, Apr 30, 2021 at 4:40 AM Josh Don <joshdon@google.com> wrote:
>
> On Thu, Apr 29, 2021 at 1:03 AM Aubrey Li <aubrey.intel@gmail.com> wrote:
> >
> > On Thu, Apr 22, 2021 at 8:39 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > ----snip----
> > > @@ -199,6 +224,25 @@ void raw_spin_rq_unlock(struct rq *rq)
> > >         raw_spin_unlock(rq_lockp(rq));
> > >  }
> > >
> > > +#ifdef CONFIG_SMP
> > > +/*
> > > + * double_rq_lock - safely lock two runqueues
> > > + */
> > > +void double_rq_lock(struct rq *rq1, struct rq *rq2)
> > > +{
> > > +       lockdep_assert_irqs_disabled();
> > > +
> > > +       if (rq1->cpu > rq2->cpu)
> >
> > It's still a bit hard for me to digest this function, I guess using (rq->cpu)
> > can't guarantee the sequence of locking when coresched is enabled.
> >
> > - cpu1 and cpu7 shares lockA
> > - cpu2 and cpu8 shares lockB
> >
> > double_rq_lock(1,8) leads to lock(A) and lock(B)
> > double_rq_lock(7,2) leads to lock(B) and lock(A)
> >
> > change to below to avoid ABBA?
> > +       if (__rq_lockp(rq1) > __rq_lockp(rq2))
> >
> > Please correct me if I was wrong.
>
> Great catch Aubrey. This is possibly what is causing the lockups that
> Don is seeing.
>
> The proposed usage of __rq_lockp() is prone to race with sched core
> being enabled/disabled.It also won't order properly if we do
> double_rq_lock(smt0, smt1) vs double_rq_lock(smt1, smt0), since these
> would have equivalent __rq_lockp()

If __rq_lockp(smt0) == __rq_lockp(smt1), rq0 and rq1 won't swap,
Later only one rq is locked and just returns. I'm not sure how does it not
order properly?

.> I'd propose an alternative but similar idea: order by core, then break ties
> by ordering on cpu.
>
> +#ifdef CONFIG_SCHED_CORE
> +       if (rq1->core->cpu > rq2->core->cpu)
> +               swap(rq1, rq2);
> +       else if (rq1->core->cpu == rq2->core->cpu && rq1->cpu > rq2->cpu)
> +               swap(rq1, rq2);

That is, why the "else if" branch is needed?

> +#else
>         if (rq1->cpu > rq2->cpu)
>                 swap(rq1, rq2);
> +#endif
