Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C243B097D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhFVPvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhFVPvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:51:21 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADE6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:49:04 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id bl4so4788735qkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D08i5WTXo1+ei91JvYVmebG92e88A+VfKzRMQAIzqTM=;
        b=jgidxwU3rvWrgcqGkIz7gxsf8q34Aei30cqet0yNDoKa6Hm/JCxj6yqJiLESLRrZVA
         ll899Zhw7iQb7AeReITNvPVIMJ4IFUuR9kw/41EtBa1H0NaYNkvUG59sER6B7M/8D37g
         YyVOTgTwTFB2xwsVR4l7lukpfDyToapK0CRGmIhcJFHIp0F/AnvtyqJPTOzu7/ae/Tae
         x06TzLOotgnMYXO25mEI0JSnrFdG9v6SjquOLDWjprM/RezT7h0/pq7eKzpXLL4XgN1I
         lvf8ANIDlauF1WKmS9U29MZxvstcp1bvqEw/ILDfXRe9l4N0RVyjBJDDwLa4aq2UoIfx
         K56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D08i5WTXo1+ei91JvYVmebG92e88A+VfKzRMQAIzqTM=;
        b=HNr6B9J/RYJ/TjkLp2uoMuXxaSOl1X82pDc8hQoAOc4q3ohuc0pVARnDsz+y7pYQBD
         y7eIIYqeS86mUFJZVu+uJj3pisWHuAEKax2HuPMJNNY8dWn8iR6pQ1M1mf/+q0AHaQcE
         pJtYWtJZlgdgc5AtThAYm5UwPK9icgwfdWjCzmBjklC5voIJT/tGUBuKYf2xGSU4Uah0
         EB7l2hSe4rFKdcR1ZoPZbdmE+gtvCdIRfdM1I7bmygFPDF3G2+9NgYaJHYR3XgLbeDO/
         DF9RmAImgKrRAfF5z9rb4YviPj8IfqOde888V1sNl1QWM8SmxjJgfivLAu6WwRFArsly
         LdgA==
X-Gm-Message-State: AOAM530u65EIgwIbdemO7zTdY3Tb3n7+9SOjvkT4hLldVp4J35Uul31D
        zd0XJArLMdEz2hI6QcSncebckkEj/nH4GlWBqdzP8w==
X-Google-Smtp-Source: ABdhPJxlSgAQuZC1mdGJER44LnEsZkvBvVA3DgjtrCOiG9SBqYE3gDoWVFuBtbTyWDOaaDGD0gFFHk3axXToVC3sQME=
X-Received: by 2002:a25:d913:: with SMTP id q19mr5873657ybg.397.1624376943574;
 Tue, 22 Jun 2021 08:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210617212654.1529125-1-surenb@google.com> <YNHr81D/fPD2Q8kM@hirez.programming.kicks-ass.net>
 <YNH8x9HRyfvF53Pl@cmpxchg.org>
In-Reply-To: <YNH8x9HRyfvF53Pl@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 22 Jun 2021 08:48:52 -0700
Message-ID: <CAJuCfpEL+Sp8e7z=JqLNuu5UKZCmCnx0nPugxXnFYd0w=7qbBQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] psi: stop relying on timer_pending for poll_work rescheduling
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        matthias.bgg@gmail.com, Minchan Kim <minchan@google.com>,
        Tim Murray <timmurray@google.com>,
        YT Chang <yt.chang@mediatek.com>,
        =?UTF-8?B?V2VuanUgWHUgKOiuuOaWh+S4vik=?= <wenju.xu@mediatek.com>,
        =?UTF-8?B?Sm9uYXRoYW4gSk1DaGVuICjpmbPlrrbmmI4p?= 
        <jonathan.jmchen@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 8:08 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Jun 22, 2021 at 03:56:03PM +0200, Peter Zijlstra wrote:
> > On Thu, Jun 17, 2021 at 02:26:54PM -0700, Suren Baghdasaryan wrote:
> > > Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger scheduling mechanism")
> > > Reported-by: Kathleen Chang <yt.chang@mediatek.com>
> > > Reported-by: Wenju Xu <wenju.xu@mediatek.com>
> > > Reported-by: Jonathan Chen <jonathan.jmchen@mediatek.com>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Johannes?
>
> Looks generally good to me, I'd just want to get to the bottom of the
> memory ordering before acking...
>
> > > -/* Schedule polling if it's not already scheduled. */
> > > -static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
> > > +/* Schedule polling if it's not already scheduled or forced. */
> > > +static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay,
> > > +                              bool force)
> > >  {
> > >     struct task_struct *task;
> > >
> > > -   /*
> > > -    * Do not reschedule if already scheduled.
> > > -    * Possible race with a timer scheduled after this check but before
> > > -    * mod_timer below can be tolerated because group->polling_next_update
> > > -    * will keep updates on schedule.
> > > -    */
> > > -   if (timer_pending(&group->poll_timer))
> > > +   /* cmpxchg should be called even when !force to set poll_scheduled */
> > > +   if (atomic_cmpxchg(&group->poll_scheduled, 0, 1) != 0 && !force)

Will change to Peter's suggested "if
(atomic_cmpxchg(&group->poll_scheduled, 0, 1) && !force)" once the
ordering question is finalized.

> >
> > Do you care about memory ordering here? Afaict the whole thing is
> > supposed to be ordered by ->trigger_lock, so you don't.
>
> It's not always held when we get here.
>
> The worker holds it when it reschedules itself, to serialize against
> userspace destroying the trigger itself. But the scheduler doesn't
> hold it when it kicks the worker on an actionable task change.
>
> That said, I think the ordering we care about there is that when the
> scheduler side sees the worker still queued, the worker must see the
> scheduler's updates to the percpu states and process them correctly.
> But that should be ensured already by the ordering implied by the
> seqcount sections around both the writer and the reader side.

Thanks Johannes! I have nothing to add here really.

>
> Is there another possible race that I'm missing?
