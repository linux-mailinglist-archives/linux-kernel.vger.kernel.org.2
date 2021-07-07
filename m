Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4052F3BE0F2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 04:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGGCpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 22:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGGCpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 22:45:30 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02198C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 19:42:49 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id s129so844676ybf.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 19:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4Yuded0Kw88JMGw8sa798WPvDJHLb/pzmUTCTo2A3w=;
        b=a6MEnYH9x2ODwMVBkGbhVVIIM/+36glvaFrVGSV2bwRkix+hmKqRW0m1TQKUw9C+c/
         cXCJ6wbYyAttOu+xTCroLVhwFL2Wn1J0fSCp0u4Ock1Lp18wYm28mZ863YKafjdXGXhy
         vQ/Fs1OK5DB8IcTRsZq/PlEbtfRhKD2H6jYkp2C1RhT2AMFT+rFIT2yZwCc5odDJB4wS
         D4JrXp2WFLPLSEAgN/MXH1GDhQnvofMrKhmE/kuS5NiU+PXJyj35LTW1adx/FHE69WsV
         mt2r5axHqNgPctRlnmKU2kSpOq99/DqPOYYwobJWv9lcNSCWTbhrKY5DALA8Mq5/ZgWX
         avww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4Yuded0Kw88JMGw8sa798WPvDJHLb/pzmUTCTo2A3w=;
        b=WElj9xhH9UiXhSL+WiM0EuF9na0BQqQbXf17GEz9NbuxXogyErIpD/SHMgl1mqASAS
         9eeybrVztG46+97uwxxrJWENMm/HXR5KAkytM2ube7iSNesA3/OXZuNnEisn0xBBk/oG
         g09jXXqu6tvnrkYX9tH6D5DohKeqJgcJ9xtYSF8vkXQZHSLApWspKD1wsX9xNkSz/D9j
         7KEWmfUemO+jn+iIQ9KyO6ms5EdL0Y1IGvB6oJPWfYOtmdjYjv+4JyhfWRSJTwEujf1A
         QY8BQhjSi91s0UF0rhkumI9bVaDWI/BoLbYXsQ59eJFKFMkFKF+XOuziBU+NPJnu/C8I
         xGvQ==
X-Gm-Message-State: AOAM531UYHEOpoH0WvZ1le9S9Wpvr0Ix3Rq+msEBHH9dw7xAcye/07yF
        NYI9bot5kkl2Vuzyk4V274tfcRqUFgwjbxMdcczsOw==
X-Google-Smtp-Source: ABdhPJxXK+QpQy2by1tDpQkrIdLehrUiWBvobGwHKyJsUnEYIPDA9XRU5GHPFc1J2rclYBq66Nu1YgBiWjIDtbLX7OM=
X-Received: by 2002:a25:83ca:: with SMTP id v10mr29809951ybm.84.1625625768387;
 Tue, 06 Jul 2021 19:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210630205151.137001-1-surenb@google.com> <YN2DsLlE+WtxK6K9@hirez.programming.kicks-ass.net>
 <CAJuCfpF=Ty4ruiKQQweVoF6Ojx8P8LxvUBxp1TmMFo2W1xNWfg@mail.gmail.com>
 <YN3pUNgpBjn42f8s@hirez.programming.kicks-ass.net> <CAJuCfpFKDhcgjU=MGsz+JuetrWvYCe0EL3FMp91zopH+8T=mMQ@mail.gmail.com>
 <YN7cJZOZzjYJFClR@hirez.programming.kicks-ass.net> <CAJuCfpHbZ2ShG02OfXzBfm7vvzCUTeP1qoTzgicGOrPh9W+5Gg@mail.gmail.com>
In-Reply-To: <CAJuCfpHbZ2ShG02OfXzBfm7vvzCUTeP1qoTzgicGOrPh9W+5Gg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 6 Jul 2021 19:42:37 -0700
Message-ID: <CAJuCfpHKmspg6apXSnQR_9m9ZVypw3Bg7Z4NgYQJ0Lg6akKZ+A@mail.gmail.com>
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

On Fri, Jul 2, 2021 at 8:49 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Fri, Jul 2, 2021 at 2:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jul 01, 2021 at 09:28:04AM -0700, Suren Baghdasaryan wrote:
> > > On Thu, Jul 1, 2021 at 9:12 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Thu, Jul 01, 2021 at 09:09:25AM -0700, Suren Baghdasaryan wrote:
> > > > > On Thu, Jul 1, 2021 at 1:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > > >
> > > > > > On Wed, Jun 30, 2021 at 01:51:51PM -0700, Suren Baghdasaryan wrote:
> > > > > > > +     /* cmpxchg should be called even when !force to set poll_scheduled */
> > > > > > > +     if (atomic_cmpxchg(&group->poll_scheduled, 0, 1) && !force)
> > > > > > >               return;
> > > > > >
> > > > > > Why is that a cmpxchg() ?
> > > > >
> > > > > We want to set poll_scheduled and proceed with rescheduling the timer
> > > > > unless it's already scheduled, so cmpxchg helps us to make that
> > > > > decision atomically. Or did I misunderstand your question?
> > > >
> > > > What's wrong with: atomic_xchg(&group->poll_scheduled, 1) ?
> > >
> > > Yes, since poll_scheduled can be only 0 or 1 atomic_xchg should work
> > > fine here. Functionally equivalent but I assume atomic_xchg() is more
> > > efficient due to no comparison.
> >
> > Mostly conceptually simpler; the cmpxchg-on-0 makes that you have to
> > check if there's ever any state outside of {0,1}. The xchg() thing is
> > the classical test-and-set pattern.
> >
> > On top of all that, the cmpxchg() can fail, which brings ordering
> > issues.
>
> Oh, I see. That was my mistake. I was wrongly assuming that all RMW
> atomic operations are fully ordered but indeed, documentation states
> that:
> ```
> - RMW operations that have a return value are fully ordered;
> - RMW operations that are conditional are unordered on FAILURE,
>    otherwise the above rules apply.
> ```
> So that's the actual functional difference here. Thanks for catching
> this and educating me!
>
> >
> > Typically, I think, you want to ensure that everything that happens
> > before psi_schedule_poll_work() is visible to the work when it runs
> > (also see Johannes' email).
>
> Correct and I think I understand now the concern Johannes expressed.
>
> > In case poll_scheduled is already 1, the
> > cmpxchg will fail and *NOT* provide that ordering. Meaning the work
> > might not observe the latest changes. xchg() doesn't have this subtlety.
>
> Got it.
> So I think the modifications needed to this patch is:
> 1. replacing atomic_cmpxchg(&group->poll_scheduled, 0, 1) with
> atomic_chg(&group->poll_scheduled, 1)
> 2. an explicit smp_mb() barrier right after
> atomic_set(&group->poll_scheduled, 0) in psi_poll_work().
>
> I think that should ensure the correct ordering here.
> If you folks agree I'll respin v3 with these changes (or maybe I
> should respin and we continue discussion with that version?).

To keep things moving I posted v3
(https://lore.kernel.org/patchwork/patch/1454547) with the changes I
mentioned above. Let's keep discussing it there. Thanks!

>
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
