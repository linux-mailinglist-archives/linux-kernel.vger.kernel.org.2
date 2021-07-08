Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF27F3C1A36
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 21:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhGHT6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 15:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhGHT6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 15:58:16 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A09C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 12:55:34 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id g5so10838660ybu.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 12:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9iOwtoKh5dIem8Q7pumODGxDiYORpzZAEGyCC5iaV0=;
        b=XUR2GC0nhu7k0ndzcebonfz2/tdwPtDew+NcmbDNh5tyOaUVYoEMVeS4733HmAdo0b
         HAUFkJF8iqRIvigI+mefLb9/qCWXCkcP+ik3Pms27FP9Vc1kHf93J2kv/DwW9QLZIeLx
         4tgBdDDgmt3Udw6JJLRWmB3NIEzu4OVqSNGjBZIiSOUnGpR3mzNedPFNRbmk0CUdVAR1
         bd4tbYMJj756MPeyvNgVLkd+f19D3MZj+8p+46j0Bfz4wMxq0xFraK/TZwqf+RqEgzV7
         bUuPZiy+sv4wizOCuh0OkMVdRP+w3rZEY0nWI+RnlMytH4kLB1O+9RcDMpe1Z9KzwleR
         t25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9iOwtoKh5dIem8Q7pumODGxDiYORpzZAEGyCC5iaV0=;
        b=oE66DrTQ9CHT2y0XxgGkODhC68aMr8UVu3NhGBLtpn9SY4u82sJjZxPjdAVHcMOqtx
         ZIJXQIVaZMBg14fvWXbUCnZae6MVPYVgJJXgNBerL++8R371D13dT4MqSEt/U/l3s541
         +V6+n+xVybEicY2mEwFf9mLYqOE037lYM/YOwlbk+38f8XAglsjujOl7td9p89Zgq3K6
         NPxf20ojNmGtkd3xR3Y/Of1RLm0KkxPT9bJSzZEJD2fGyCAuZGIA78DRYGo/W6OCB+7+
         gFGaqXvZDxefAam4fyuyCFK4MIiPGnb2FA68kKjmL5TlpI7tGPw0hW9DbXZPOF5pY75N
         MejQ==
X-Gm-Message-State: AOAM5308/m+zCdQFKSHPNtIAWEILLkIBMQwLL1CHs2zq5ol+Jew4PLyb
        dWi/VzQ6FTSCFQexKzWPrrOcVJU8Ha24D1tyIz+hqA==
X-Google-Smtp-Source: ABdhPJxphBkJdzx//zx+e418675z33iJqy2cKWUye6RjIYyGU1cr/7kJ/jWfapwOSx49L0P0x4shlToXrYbzl5YFeYA=
X-Received: by 2002:a25:71c4:: with SMTP id m187mr35918036ybc.397.1625774133119;
 Thu, 08 Jul 2021 12:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210707023933.1691149-1-surenb@google.com> <YOWugYxQ9Yfsqba2@cmpxchg.org>
 <CAJuCfpGx22iTaDGCfOrM_pD6PYZqQrni2+u5jQy+NpNeNg7B9w@mail.gmail.com>
 <YOcPUs97epJ5VrEf@cmpxchg.org> <CAJuCfpFCi6fa+Ke4bvP9hbMeC82VaT6twNWC3+ckXz6yD0qCtQ@mail.gmail.com>
 <YOdGNVFtYAKmfpiY@cmpxchg.org>
In-Reply-To: <YOdGNVFtYAKmfpiY@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 8 Jul 2021 12:55:22 -0700
Message-ID: <CAJuCfpHccsaV46x6kTf4d8iZNjXAS-iXLXsupDb=OiNsNJ-RKw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] psi: stop relying on timer_pending for poll_work rescheduling
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
        kernel-team <kernel-team@android.com>,
        SH Chen <show-hong.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 8, 2021 at 11:38 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Jul 08, 2021 at 08:54:56AM -0700, Suren Baghdasaryan wrote:
> > On Thu, Jul 8, 2021 at 7:44 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > On Wed, Jul 07, 2021 at 03:43:48PM -0700, Suren Baghdasaryan wrote:
> > > > On Wed, Jul 7, 2021 at 6:39 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > > This looks good to me now code wise. Just a comment on the comments:
> > > > >
> > > > > On Tue, Jul 06, 2021 at 07:39:33PM -0700, Suren Baghdasaryan wrote:
> > > > > > @@ -559,18 +560,14 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> > > > > >       return now + group->poll_min_period;
> > > > > >  }
> > > > > >
> > > > > > -/* Schedule polling if it's not already scheduled. */
> > > > > > -static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
> > > > > > +/* Schedule polling if it's not already scheduled or forced. */
> > > > > > +static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay,
> > > > > > +                                bool force)
> > > > > >  {
> > > > > >       struct task_struct *task;
> > > > > >
> > > > > > -     /*
> > > > > > -      * Do not reschedule if already scheduled.
> > > > > > -      * Possible race with a timer scheduled after this check but before
> > > > > > -      * mod_timer below can be tolerated because group->polling_next_update
> > > > > > -      * will keep updates on schedule.
> > > > > > -      */
> > > > > > -     if (timer_pending(&group->poll_timer))
> > > > > > +     /* xchg should be called even when !force to set poll_scheduled */
> > > > > > +     if (atomic_xchg(&group->poll_scheduled, 1) && !force)
> > > > > >               return;
> > > > >
> > > > > This explains what the code does, but not why. It would be good to
> > > > > explain the ordering with poll_work, here or there. But both sides
> > > > > should mention each other.
> > > >
> > > > How about this:
> > > >
> > > > /*
> > > >  * atomic_xchg should be called even when !force to always set poll_scheduled
> > > >  * and to provide a memory barrier (see the comment inside psi_poll_work).
> > > >  */
> > >
> > > The memory barrier part makes sense, but the first part says what the
> > > code does and the message is unclear to me. Are you worried somebody
> > > might turn this around in the future and only conditionalize on
> > > poll_scheduled when !force? Essentially, I don't see the downside of
> > > dropping that. But maybe I'm missing something.
> >
> > Actually you are right. Originally I was worried that there might be a
> > case when poll_scheduled==0 and force==true and if someone flips the
> > conditions we will reschedule the timer but will not set
> > poll_scheduled back to 1.
>
> Oh I see.
>
> Right, flipping the condition doesn't make sense because we need
> poll_scheduled to be set when we go ahead - whether we're forcing or
> not. I.e. if we were in a locked section, we'd write it like this:
>
>         if (poll_scheduled)
>                 if (!force)
>                         return;
>         else
>                 poll_scheduled = 1;
>
> > However I don't think this condition is possible. We set force=true
> > only when we skipped resetting poll_schedule to 0 and on initial
> > wakeup we always reset poll_schedule. How about changing the comment
> > to this:
> >
> >  /*
> >   * atomic_xchg should be called even when !force to provide a
> >   * full memory barrier (see the comment inside psi_poll_work).
> >   */
>
> Personally, I still find this more confusing than no comment on
> !force, because when you read it it sort of raises the question what
> the alternatives would be. And the alternatives appear to be
> nonsensical code rather than legitimate options.
>
> But I won't insist if you prefer to leave it in. Your call.

I would like to keep it as a precaution, if you don't mind. In case
someone in the future thinks about "optimizing" this by flipping the
condition, hopefully the comment will give them a pause to think about
it :)

>
> > > /*
> > >  * A task change can race with the poll worker that is supposed to
> > >  * report on it. To avoid missing events, ensure ordering between
> > >  * poll_scheduled and the task state accesses, such that if the poll
> > >  * worker misses the state update, the task change is guaranteed to
> > >  * reschedule the poll worker:
> > >  *
> > >  * poll worker:
> > >  *   atomic_set(poll_scheduled, 0)
> > >  *   smp_mb()
> > >  *   LOAD states
> > >  *
> > >  * task change:
> > >  *   STORE states
> > >  *   if atomic_xchg(poll_scheduled, 1) == 0:
> > >  *     schedule poll worker
> > >  *
> > >  * The atomic_xchg() implies a full barrier.
> > >  */
> > >  smp_mb();
> > >
> > > This gives a high-level view of what's happening but it can still be
> > > mapped to the code by following the poll_scheduled variable.
> >
> > This looks really good to me.
> > If you agree on the first comment modification, should I respin the
> > next version?
>
> Yeah, sounds good to me!

Thanks! I'll post an update shortly.
