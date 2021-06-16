Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2B83A8E84
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 03:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhFPBrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 21:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhFPBr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 21:47:28 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96644C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 18:45:22 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h3so883562ilc.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 18:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uq1Cnx49xtMXR5qEyQv2s3G5oS+XYxPHZ0zVrsY2ZfU=;
        b=Fc15+tdKgZKYVd2Zy9HdSDxXLMNMz94HH9Pgg2PcZUKvvRFcJ+w3ucxcWMfvi+iC+Y
         yDcG3VsLg2L2lebwSwRrqSLAHEWGpsd4XkeexhzjzuDgN4FdTfQwg5I2fEc6YumxNQ9d
         XjuVxgTGkh3OAa2pEKbt0j/9BmB1RRyY4l4L6mEVwpXe701ZjXU/p6v4MqApdDK59/If
         quU0y7UFu6DVtCiPLr3pUTcrYu0essGh4qQrSkFBhAVuPGBAzMrW4a8Iju2bYZlZmka9
         WatEWGuA4ZtSimrxo50txjmDqhwm8l6df9wqt8h3M1n9Ff64L6GA1dwTS3d7jkh7z+0I
         xgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uq1Cnx49xtMXR5qEyQv2s3G5oS+XYxPHZ0zVrsY2ZfU=;
        b=S1QTrDWUslo8l2sesviT9ZBUtUPalUKpRu8GbSGdSm6FQWpfF+THPhV/01G6/1F1T4
         0RltAitL8WLNSgpI6Robyc+cVVyA+YS8YIo/QpQXRsQ/nZtStgKE1jhO+H8ydNegP5QV
         JxCxO6FKh5knvlIt7UpkOPp7piHNyq9z3jQCfpq9EPePwHdCgc4mLmD2DWetbiwhHtpA
         PnyWNXjkw84n1+M5J0YOGnsWvRD3UJeoynksG2Kw49aD6V8qNttpMPEcUQTs7pp5XDwE
         rAqwn+XephKskU6LGjqi6S0Rvgohn1F/IOhZ86p9gNASQGsuzjwY3fxITFKjcfdJo9D7
         Mz+g==
X-Gm-Message-State: AOAM533WiRP2iRDv9TmXnJ07qbZ+PnVG2NNR/hreY2lZhHwjjWJY63K7
        jUXwLPQ5wa7CYpLLwxa6hUlz2sH84vVWTZBErWXanCaWG4WFqA==
X-Google-Smtp-Source: ABdhPJyqtEsTI6j9toMRHky0WrISQaGEdbDWWDHS46lcgQd65xIr6i5ivi0j6vqLGZfpbSFVoRnbkS2WVUP5vCXsWZQ=
X-Received: by 2002:a92:b30d:: with SMTP id p13mr1788296ilh.142.1623807922013;
 Tue, 15 Jun 2021 18:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210615121551.31138-1-laoar.shao@gmail.com> <20210615203534.GA4272@worktop.programming.kicks-ass.net>
In-Reply-To: <20210615203534.GA4272@worktop.programming.kicks-ass.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 16 Jun 2021 09:44:46 +0800
Message-ID: <CALOAHbBuZJaK+fEg7toRUHJNP8rJKDoADeAUxorUuNU17kdTOA@mail.gmail.com>
Subject: Re: [PATCH] sched, fair: try to prevent migration thread from
 preempting non-cfs task
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 4:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 15, 2021 at 08:15:51PM +0800, Yafang Shao wrote:
> > ---
> >  kernel/sched/fair.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 3248e24a90b0..597c7a940746 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9797,6 +9797,20 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >                       /* Record that we found at least one task that could run on this_cpu */
> >                       env.flags &= ~LBF_ALL_PINNED;
> >
> > +                     /*
> > +                      * There may be a race between load balance starting migration
> > +                      * thread to pull the cfs running thread and the RT thread
> > +                      * waking up and preempting cfs task before migration threads
> > +                      * which then preempt the RT thread.
> > +                      * We'd better do the last minute check before starting
> > +                      * migration thread to avoid preempting latency-sensitive thread.
> > +                      */
> > +                     if (busiest->curr->sched_class != &fair_sched_class) {
> > +                             raw_spin_unlock_irqrestore(&busiest->lock,
> > +                                                        flags);
>
> This won't apply.
>
> Also, there's still a race window, you've just shrunk it, not fixed it.
> Busiest can reschedule between the mandatory rq unlock and doing the
> stopper wakeup.
>
> An actual fix might be to have the active migration done by a FIFO-1
> task, instead of stopper. The obvious down-side is that that would mean
> spawning yet another per-cpu kthread.
>

The stopper and the migration thread are different threads in the earlier days.
commit 969c79215a35 ("sched: replace migration_thread with cpu_stop")
merged them into one thread.

Regarding the priority of stopper (with highest priority) and
migration (higher than CFS, but lower than RT) , keeping them in one
single thread seems not a good way.


> How much do we care?



-- 
Thanks
Yafang
