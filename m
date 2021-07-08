Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4ECA3C194F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhGHSld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 14:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhGHSlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 14:41:32 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A499C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 11:38:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h1-20020a17090a3d01b0290172d33bb8bcso6616058pjc.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oYyGT0KTIm/nNsMmN7965VbdTTSrQLQ+D7tsa96mwIM=;
        b=q+CGLCLh1DItOWyDk5zZjNqU3t5nU96RLi66qrgD1gy0+IyWzMvD7ar/jA67PdhXNf
         V7Lfi9WOs+Zk6ZFBrc5Ejx9xbu5o/3uRhflM3UZ/tifkBNV5eiTyn+/zpBNqM7DRNYSl
         nCKHahsSCYAxzzPzGD4R+rLq0aZHKW5AVZn2hbcAk/VEY1LIMWfhVOps4vHnYszxwp4p
         IRHyQIGYRCNNWqcOAUn1Un/9PBAEtqRb03ICdFbVYazyLuMhGwPGzH3dH6kyiD1WDkXS
         CbKBgXE04OIwUlj3tgZlAO4JezDzW3W4vmMdP6dnhIvBxQ44PanrhD0Cq4hAV/o94oCL
         V35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oYyGT0KTIm/nNsMmN7965VbdTTSrQLQ+D7tsa96mwIM=;
        b=iHEIjspbp5J6zSuqDTC4+A3QwlNRzcSxbmZ7dx7SMkN3dOOvcJVOcA1CRcfG0dvo5X
         v7lq+TJAInXtc0VGOE1i/XVns8Hd+zxodoTq+txuz88a1NCk+b9zxxV/2AjujLgaarCC
         +pfLeER785Ki9Zgtcnd23HEDIwPoXOF+tFUmtwyqb+jCO/vN85pj+S1th+L+b4uU4E5Z
         MEF2YcA8NAawnuACKGJoXKaZmmezDReoc5/yZpC+OVcS/sxoNzxaEMz3MI6Oyr5wXssG
         HjkXQU/gGYg6jVOCP8wKF5U7gObj8V7K+EboURKQfN27E3Qw4h1mFGvRrpY3WSP9mY5L
         52RA==
X-Gm-Message-State: AOAM532VUzUOAIcsdP//Z9F4tAIZbWzSVPDpVICT7EvujgaSDzNXknwB
        zFAmccZqAQcV2ZxUaxVD/J14zw==
X-Google-Smtp-Source: ABdhPJxjZJ7WiU46r1WhIokN9qfAawnDzk1VajsJ6aOlSlRr90d4PJex7Ymtixosuiglb25ke8iqsg==
X-Received: by 2002:a17:90b:198a:: with SMTP id mv10mr6281337pjb.67.1625769529574;
        Thu, 08 Jul 2021 11:38:49 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:ab8a])
        by smtp.gmail.com with ESMTPSA id r10sm3583285pff.7.2021.07.08.11.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 11:38:49 -0700 (PDT)
Date:   Thu, 8 Jul 2021 14:38:45 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
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
        Wenju Xu =?utf-8?B?KOiuuOaWh+S4vik=?= <wenju.xu@mediatek.com>,
        Jonathan JMChen =?utf-8?B?KOmZs+WutuaYjik=?= 
        <jonathan.jmchen@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-team <kernel-team@android.com>,
        SH Chen <show-hong.chen@mediatek.com>
Subject: Re: [PATCH v3 1/1] psi: stop relying on timer_pending for poll_work
 rescheduling
Message-ID: <YOdGNVFtYAKmfpiY@cmpxchg.org>
References: <20210707023933.1691149-1-surenb@google.com>
 <YOWugYxQ9Yfsqba2@cmpxchg.org>
 <CAJuCfpGx22iTaDGCfOrM_pD6PYZqQrni2+u5jQy+NpNeNg7B9w@mail.gmail.com>
 <YOcPUs97epJ5VrEf@cmpxchg.org>
 <CAJuCfpFCi6fa+Ke4bvP9hbMeC82VaT6twNWC3+ckXz6yD0qCtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFCi6fa+Ke4bvP9hbMeC82VaT6twNWC3+ckXz6yD0qCtQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 08:54:56AM -0700, Suren Baghdasaryan wrote:
> On Thu, Jul 8, 2021 at 7:44 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > On Wed, Jul 07, 2021 at 03:43:48PM -0700, Suren Baghdasaryan wrote:
> > > On Wed, Jul 7, 2021 at 6:39 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > This looks good to me now code wise. Just a comment on the comments:
> > > >
> > > > On Tue, Jul 06, 2021 at 07:39:33PM -0700, Suren Baghdasaryan wrote:
> > > > > @@ -559,18 +560,14 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> > > > >       return now + group->poll_min_period;
> > > > >  }
> > > > >
> > > > > -/* Schedule polling if it's not already scheduled. */
> > > > > -static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
> > > > > +/* Schedule polling if it's not already scheduled or forced. */
> > > > > +static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay,
> > > > > +                                bool force)
> > > > >  {
> > > > >       struct task_struct *task;
> > > > >
> > > > > -     /*
> > > > > -      * Do not reschedule if already scheduled.
> > > > > -      * Possible race with a timer scheduled after this check but before
> > > > > -      * mod_timer below can be tolerated because group->polling_next_update
> > > > > -      * will keep updates on schedule.
> > > > > -      */
> > > > > -     if (timer_pending(&group->poll_timer))
> > > > > +     /* xchg should be called even when !force to set poll_scheduled */
> > > > > +     if (atomic_xchg(&group->poll_scheduled, 1) && !force)
> > > > >               return;
> > > >
> > > > This explains what the code does, but not why. It would be good to
> > > > explain the ordering with poll_work, here or there. But both sides
> > > > should mention each other.
> > >
> > > How about this:
> > >
> > > /*
> > >  * atomic_xchg should be called even when !force to always set poll_scheduled
> > >  * and to provide a memory barrier (see the comment inside psi_poll_work).
> > >  */
> >
> > The memory barrier part makes sense, but the first part says what the
> > code does and the message is unclear to me. Are you worried somebody
> > might turn this around in the future and only conditionalize on
> > poll_scheduled when !force? Essentially, I don't see the downside of
> > dropping that. But maybe I'm missing something.
> 
> Actually you are right. Originally I was worried that there might be a
> case when poll_scheduled==0 and force==true and if someone flips the
> conditions we will reschedule the timer but will not set
> poll_scheduled back to 1.

Oh I see.

Right, flipping the condition doesn't make sense because we need
poll_scheduled to be set when we go ahead - whether we're forcing or
not. I.e. if we were in a locked section, we'd write it like this:

	if (poll_scheduled)
		if (!force)
			return;
	else
		poll_scheduled = 1;

> However I don't think this condition is possible. We set force=true
> only when we skipped resetting poll_schedule to 0 and on initial
> wakeup we always reset poll_schedule. How about changing the comment
> to this:
> 
>  /*
>   * atomic_xchg should be called even when !force to provide a
>   * full memory barrier (see the comment inside psi_poll_work).
>   */

Personally, I still find this more confusing than no comment on
!force, because when you read it it sort of raises the question what
the alternatives would be. And the alternatives appear to be
nonsensical code rather than legitimate options.

But I won't insist if you prefer to leave it in. Your call.

> > /*
> >  * A task change can race with the poll worker that is supposed to
> >  * report on it. To avoid missing events, ensure ordering between
> >  * poll_scheduled and the task state accesses, such that if the poll
> >  * worker misses the state update, the task change is guaranteed to
> >  * reschedule the poll worker:
> >  *
> >  * poll worker:
> >  *   atomic_set(poll_scheduled, 0)
> >  *   smp_mb()
> >  *   LOAD states
> >  *
> >  * task change:
> >  *   STORE states
> >  *   if atomic_xchg(poll_scheduled, 1) == 0:
> >  *     schedule poll worker
> >  *
> >  * The atomic_xchg() implies a full barrier.
> >  */
> >  smp_mb();
> >
> > This gives a high-level view of what's happening but it can still be
> > mapped to the code by following the poll_scheduled variable.
> 
> This looks really good to me.
> If you agree on the first comment modification, should I respin the
> next version?

Yeah, sounds good to me!
