Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74AF3B94A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 18:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhGAQas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhGAQas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 12:30:48 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987A1C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 09:28:16 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id g5so11737185ybu.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jW9usmzYUneRtmPUUy8bPkIeD350ID0dCtIjd2wQbSQ=;
        b=nga6WacM6U52NLeH8VpfecsBjtdk02B2lXY37A1ANhERVcUSRWNPMz6NXXu3ZdKE2t
         xVdbc72ukqInAh1x/3KFXIMHUYfoIQKKBdL5KGYy0xhPAcebSQShwob41BY4D1Y+cTke
         5j+IUh/1pu6ZaG5EcbEY0GNJ1EzcNVHbGBcKsftVHSHci4uVb1b+eHBeodvZP7Y9DF1+
         5lIgo6o4dzQFlw/x0ArhoVmeEtpr69uDijMGs04kDukeJ9JE1CrWJ+giAqa3DLFGsNA0
         e04uxDISEgnhuWQN7/fF6LoZ7Y7vhbH4HdHYWrTH3RkJLs0GWQvkbimBCcGOqeVPdFOL
         JZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jW9usmzYUneRtmPUUy8bPkIeD350ID0dCtIjd2wQbSQ=;
        b=EQfTE6RcPa3kfIknxIo274F9pZ6nR4y5N3voA6ImsOWjjYYPT3t+NmBLNgKFJLvpni
         DHkops92muN0/wO1ny90lZTa3tdWdJmpmzBdxCO/BH7LBDMWND6pwLBmgRPh8QrfGDk+
         wRD2PzLLD7i2hK9nA5uejHfVMUR45oBX5LEpVGwzRt+q/lj1rxWm1+DCje4Qy3IqU3Br
         kagGE1wBMgJ2L3axbdtOpAAAZqK0wjIwhltirAy5xByd4Y3ySp79xgCwTl7A8Oicwk/S
         afNbe3HHInQvgHl+d4Bnn3Q6+tKwWm+/ecTQRH7hqI9IX1qQBwF4JkucTPdgCEwtrxXj
         06OA==
X-Gm-Message-State: AOAM532QLQnY1Zg+ox1W8B9/lJZjlzsZJ+27iz2yMNVeZz3Iy0klg7Gd
        SJjsXXiKXr7TjUuh6CrblgoRjtBlbPWP+o1iXpR7vQ==
X-Google-Smtp-Source: ABdhPJxJ105tQZtXJ2g6qDlXmogBaYsJLcJDXxQ5kncWGkCRYNQNcvRP9rBXNCvVZ0sAPG97Vogi4w7B9zdX140PCKE=
X-Received: by 2002:a25:2e49:: with SMTP id b9mr836477ybn.250.1625156895472;
 Thu, 01 Jul 2021 09:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210630205151.137001-1-surenb@google.com> <YN2DsLlE+WtxK6K9@hirez.programming.kicks-ass.net>
 <CAJuCfpF=Ty4ruiKQQweVoF6Ojx8P8LxvUBxp1TmMFo2W1xNWfg@mail.gmail.com> <YN3pUNgpBjn42f8s@hirez.programming.kicks-ass.net>
In-Reply-To: <YN3pUNgpBjn42f8s@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 1 Jul 2021 09:28:04 -0700
Message-ID: <CAJuCfpFKDhcgjU=MGsz+JuetrWvYCe0EL3FMp91zopH+8T=mMQ@mail.gmail.com>
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

On Thu, Jul 1, 2021 at 9:12 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jul 01, 2021 at 09:09:25AM -0700, Suren Baghdasaryan wrote:
> > On Thu, Jul 1, 2021 at 1:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Jun 30, 2021 at 01:51:51PM -0700, Suren Baghdasaryan wrote:
> > > > +     /* cmpxchg should be called even when !force to set poll_scheduled */
> > > > +     if (atomic_cmpxchg(&group->poll_scheduled, 0, 1) && !force)
> > > >               return;
> > >
> > > Why is that a cmpxchg() ?
> >
> > We want to set poll_scheduled and proceed with rescheduling the timer
> > unless it's already scheduled, so cmpxchg helps us to make that
> > decision atomically. Or did I misunderstand your question?
>
> What's wrong with: atomic_xchg(&group->poll_scheduled, 1) ?

Yes, since poll_scheduled can be only 0 or 1 atomic_xchg should work
fine here. Functionally equivalent but I assume atomic_xchg() is more
efficient due to no comparison.
Will respin v3 if the rest looks ok.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
