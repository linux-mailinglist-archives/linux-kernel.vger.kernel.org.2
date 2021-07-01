Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA41D3B95A8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 19:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhGARso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 13:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhGARsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:48:43 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13637C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 10:46:13 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id m9so12146714ybo.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 10:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YuEQ/0+GfUXuD93+sD0b18biDb2M6pGGHSqSSO1+UuE=;
        b=LwRldiJ6x3BDPyzWXCUQCVT7w7Nq6ItegVRwz4Hvnijj6RznRtT6uC+9iCLJJYi02f
         zzHxxy8uov62zs7l+LUOTT2P2/0A3RTfmmDwkwSbdU8OeTFmo3+g/0x6stmjWlYW8iP0
         E267aJc0D98iMrWtKF0OqHOsfJuyoO2P4Tnr00mVS7NKlj/jCCwAUYv/76rc9PbWfZb+
         TB92w5TUe9RTMCLYfVSADk2JJ6kpREuyEEXk1uvYzjxbJLOvu/aV47llCbzQX5nsBYk9
         6yxuTDS8ZD5FvhhC9z+ggI6rYAUJqE4pMLgTU7zHXqRc8gm8ltSTr2yK/aIOmZ0b9hCa
         4R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YuEQ/0+GfUXuD93+sD0b18biDb2M6pGGHSqSSO1+UuE=;
        b=eI+gPVMJz8xm0MLgM2kVxscAoVyotQfIaMJTThOl0KVtckk4ii1pituw2oaqBYmjSu
         Hf+7Wh5MxAKYeveYESJheCMcChxIsUqpKVRXMBPD/nVbLzsKogDklgorKChqvGLK/mBm
         3kgPKl52YFaTQBb5fqdC2Ggnj1P3gwZOYET28rbRLBTUkegEjURcVd0SPJHd1LQUaKMS
         kvAnyt3dBBxCbqwceKCIw7Yi2GAetmzhN83mjydrfoulWk8DfATSopn8xufaPTtJO11y
         bngZI2o3ZVkdIm2/xJFt2dw8JIERlelgP4TrvOJWbCoExHjwIY4nKUOZxn+CwWf0syOB
         6Giw==
X-Gm-Message-State: AOAM531KKhociCW+aqAAAWPVXqySmAevLQZGqScZZMYT5RgD8c/lGp+b
        iAqT/X46jzsosUsQII7zZbOGjq9P3v6+Z2b0MMJ9Eg==
X-Google-Smtp-Source: ABdhPJyW+2rNHz7TTh5ZLTxu/vUeNLQKnS5QAbeoiQWOV850EJ4EckVI9IjlgDPCCTSf4VVjHk8r9Cs11z6N8Gfg6qc=
X-Received: by 2002:a25:2e49:: with SMTP id b9mr1337732ybn.250.1625161571802;
 Thu, 01 Jul 2021 10:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210630205151.137001-1-surenb@google.com> <YN2DsLlE+WtxK6K9@hirez.programming.kicks-ass.net>
 <YN3vyvoDwSUepM18@cmpxchg.org>
In-Reply-To: <YN3vyvoDwSUepM18@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 1 Jul 2021 10:46:00 -0700
Message-ID: <CAJuCfpFTWUWmr_Zjj9d1rzNvtO9MjD-FQo1-j0aE6XN74b7_Lg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] psi: stop relying on timer_pending for poll_work rescheduling
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

On Thu, Jul 1, 2021 at 9:39 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Jul 01, 2021 at 10:58:24AM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 30, 2021 at 01:51:51PM -0700, Suren Baghdasaryan wrote:
> > > +   /* cmpxchg should be called even when !force to set poll_scheduled */
> > > +   if (atomic_cmpxchg(&group->poll_scheduled, 0, 1) && !force)
> > >             return;
> >
> > Why is that a cmpxchg() ?
>
> I now realize you had already pointed that out, but I dismissed it in
> the context of poll_lock not being always taken after all.
>
> But you're right, cmpxchg indeed seems inappropriate. xchg will do
> just fine for this binary toggle.
>
> When it comes to ordering, looking at it again, I think we actually
> need ordering here that the seqcount doesn't provide. We have:
>
> timer:
> scheduled = 0
> smp_rmb()
> x = state
>
> scheduler:
> state = y
> smp_wmb()
> if xchg(scheduled, 1) == 0
>   mod_timer()
>
> Again, the requirement is that when the scheduler sees the timer as
> already or still pending, the timer must observe its state updates -
> otherwise we miss poll events.
>
> The seqcount provides the wmb and rmb, but the scheduler-side read of
> @scheduled mustn't be reordered before the write to @state. Likewise,
> the timer-side read of @state also mustn't occur before the write to
> @scheduled.
>
> AFAICS this is broken, not just in the patch, but also in the current
> code when timer_pending() on the scheduler side gets reordered. (Not
> sure if timer reading state can be reordered before the detach_timer()
> of its own expiration, but I don't see full ordering between them.)
>
> So it seems to me we need the ordered atomic_xchg() on the scheduler
> side, and on the timer side an smp_mb() after we set scheduled to 0.

Thanks for the analysis Johannes. Let me dwell on it a bit.
