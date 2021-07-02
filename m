Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5FF3BA2EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 17:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhGBPwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 11:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhGBPwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 11:52:43 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229F8C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 08:50:11 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id i4so17117559ybe.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 08:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qA8VgGLlkFB/PkXrTcenc5nCOSnabAFGt5bfyGsdlu8=;
        b=UHAD63/yXxCyyYZYt5IZFX/NsDNvW4cR5o2wVYjbiQ6AjisFxLh0wGLMLupHuV/4D5
         IAj2LSmJORVGCrv6nvGAm5hxHadjS/g5q/u2P3kWtvT9gzSVbRGv3yauLrPRgpLtpI4X
         pJU+c3BTU0sTEKQeCJschfl9lvMknix5kF8vs6qQzDbGuJOdjOdje2+5zZuMNzdjOEVP
         URrVCOhgrExl+pan77E/WpJISnX9HqoCif8YCk7mr7ffpKNqp1KbOH/S2I0ugooD5nAY
         TTCOLEVjWW9odiUGCiVUrWX703n52/KvH5gii53SyXcJDJ0T6m4bunAjJVQe03Zu8E+c
         OFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qA8VgGLlkFB/PkXrTcenc5nCOSnabAFGt5bfyGsdlu8=;
        b=DE3ORErQRxIYPqO/QzAarD56jwCCOpUHaqS8KX450sNqKvjOh89TpRqhk0DRtYTQIY
         dAx+4dMzr4Snhh0YQbLlbyOsj7nGQdbBBoi6b25cYrGRzazihiMhJ5inU28Cx40yvZPX
         AQVjl/hL6vBMa5ncYlKXjXKJ/k31vRPdJHiKqsgV7GzPTfyanPFWzAmDcKK6uycrH7OS
         CCm8gQD3PYqorupagddQen6moWn4grBpBawtJ/V2TgW35UDFreMiS2797Cb4cQL42wu0
         ECXGoV5uQDS+9B0aJPNwhY1d4v8IsvYXKlLXGt4ubAIfd1pArOb5Y7++NohiksT1od0J
         xpTg==
X-Gm-Message-State: AOAM532WATRutwa+ivV0dyWwnJqU38/XZ+eZEi0zhDbm2yOKHRplky29
        g9T9MmaEoikgWr8HZSWPQxtjE+UaIjhHExKxx1U0+g==
X-Google-Smtp-Source: ABdhPJyHntmDdthDS54GlrPzHQ5DU3ubq3o9deXw/J4JZCB+oThlJ84A/mgRALRtY9H9RW2IUIiTvRopgvhh63Oji0U=
X-Received: by 2002:a25:9945:: with SMTP id n5mr77710ybo.294.1625241010145;
 Fri, 02 Jul 2021 08:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210630205151.137001-1-surenb@google.com> <YN2DsLlE+WtxK6K9@hirez.programming.kicks-ass.net>
 <CAJuCfpF=Ty4ruiKQQweVoF6Ojx8P8LxvUBxp1TmMFo2W1xNWfg@mail.gmail.com>
 <YN3pUNgpBjn42f8s@hirez.programming.kicks-ass.net> <CAJuCfpFKDhcgjU=MGsz+JuetrWvYCe0EL3FMp91zopH+8T=mMQ@mail.gmail.com>
 <YN7cJZOZzjYJFClR@hirez.programming.kicks-ass.net>
In-Reply-To: <YN7cJZOZzjYJFClR@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 2 Jul 2021 08:49:59 -0700
Message-ID: <CAJuCfpHbZ2ShG02OfXzBfm7vvzCUTeP1qoTzgicGOrPh9W+5Gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] psi: stop relying on timer_pending for poll_work rescheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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

On Fri, Jul 2, 2021 at 2:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jul 01, 2021 at 09:28:04AM -0700, Suren Baghdasaryan wrote:
> > On Thu, Jul 1, 2021 at 9:12 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Jul 01, 2021 at 09:09:25AM -0700, Suren Baghdasaryan wrote:
> > > > On Thu, Jul 1, 2021 at 1:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > >
> > > > > On Wed, Jun 30, 2021 at 01:51:51PM -0700, Suren Baghdasaryan wrote:
> > > > > > +     /* cmpxchg should be called even when !force to set poll_scheduled */
> > > > > > +     if (atomic_cmpxchg(&group->poll_scheduled, 0, 1) && !force)
> > > > > >               return;
> > > > >
> > > > > Why is that a cmpxchg() ?
> > > >
> > > > We want to set poll_scheduled and proceed with rescheduling the timer
> > > > unless it's already scheduled, so cmpxchg helps us to make that
> > > > decision atomically. Or did I misunderstand your question?
> > >
> > > What's wrong with: atomic_xchg(&group->poll_scheduled, 1) ?
> >
> > Yes, since poll_scheduled can be only 0 or 1 atomic_xchg should work
> > fine here. Functionally equivalent but I assume atomic_xchg() is more
> > efficient due to no comparison.
>
> Mostly conceptually simpler; the cmpxchg-on-0 makes that you have to
> check if there's ever any state outside of {0,1}. The xchg() thing is
> the classical test-and-set pattern.
>
> On top of all that, the cmpxchg() can fail, which brings ordering
> issues.

Oh, I see. That was my mistake. I was wrongly assuming that all RMW
atomic operations are fully ordered but indeed, documentation states
that:
```
- RMW operations that have a return value are fully ordered;
- RMW operations that are conditional are unordered on FAILURE,
   otherwise the above rules apply.
```
So that's the actual functional difference here. Thanks for catching
this and educating me!

>
> Typically, I think, you want to ensure that everything that happens
> before psi_schedule_poll_work() is visible to the work when it runs
> (also see Johannes' email).

Correct and I think I understand now the concern Johannes expressed.

> In case poll_scheduled is already 1, the
> cmpxchg will fail and *NOT* provide that ordering. Meaning the work
> might not observe the latest changes. xchg() doesn't have this subtlety.

Got it.
So I think the modifications needed to this patch is:
1. replacing atomic_cmpxchg(&group->poll_scheduled, 0, 1) with
atomic_chg(&group->poll_scheduled, 1)
2. an explicit smp_mb() barrier right after
atomic_set(&group->poll_scheduled, 0) in psi_poll_work().

I think that should ensure the correct ordering here.
If you folks agree I'll respin v3 with these changes (or maybe I
should respin and we continue discussion with that version?).

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
