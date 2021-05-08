Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D900B376E10
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 03:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhEHB0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 21:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhEHB0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 21:26:33 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43896C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 18:25:32 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id v6so13814024ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 18:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UO5n5JJicAxX5p7zS8VwfLqfSuD5YIVNKEByE2pLl0c=;
        b=gRGkAPLgXjC0nFFXFZ5lswhY9Zog40ucTQNVIX4auWckQ3XCgkA64OyBVraUAD+scW
         xPYCk+pUHF+wyEJy5cQDPovPIuRjV9+MYVdQ6HXg+wMAg0kM0irYdtZiiVDATbn92Xt2
         EFXgHacn6LHs9Ufg5vgyfXeqo0lNEfCZ9cyWhkbOkPaWvenQyrYKQETMVD3TQZZfa704
         78diNLnF5wmzIVM6vSn5v03H7TdEGPjJEgAwLzu29VfHlKC8KskOXLH4+2ayD5K2bAVE
         5GNG21C2+kZm2aYjilpTW8n6qL03Sg1uGHznTESlnxxwqoU/VnmjmgJsfcePhw//tfq4
         UBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UO5n5JJicAxX5p7zS8VwfLqfSuD5YIVNKEByE2pLl0c=;
        b=E+rJ6pggftHgbtxYp7V9twZT8K8ChW0AhvibcBo+UNM1ICNENahC1iLlVGGBaVDipk
         JI0zReLHRQH1SaK+vddsbT8sJCkxansGZmpZSHdV4QnmGDPiz+zpCwLrh1zvjfXFRtTe
         dtH6Ld8l0czt0FCKHxqWHfis0oV2K8XupjvRIsR0L/TaP+8hmq7KtmUjPtj8N2O+LGfN
         GJJWKaoWR0w1W8U4PhK8bzkbIZHsRQCw0EMVlx+xgN9o5LMdgwMcFbbyLqRthIXMaqFH
         gsvYnVqI10E6rd3hbIWJlYYbhbhEqeCSgfJegMnA6k2sScGUb2ywE9ldTdeRWrAPvmmD
         jZfw==
X-Gm-Message-State: AOAM531erA63NgGYROJakRwmoaR6ZjlOsLQubcYoXchstcIguB8Jgcow
        Pkitwyff13s9WLIz2BeE1skW9gSM9VbW6x3o/4lVqMuKuRZvLQ==
X-Google-Smtp-Source: ABdhPJzmNE5WWJ+b+uIqJYWfNX8Pwstl6LwR+4PpW2ly9j2+eYp9aJWPedLb/vd4Hj1lmGPRkxfavt1v9XvE96ssdpE=
X-Received: by 2002:a2e:a489:: with SMTP id h9mr10249085lji.21.1620437130695;
 Fri, 07 May 2021 18:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210507112031.23073-1-xuewen.yan94@gmail.com>
 <20210507123528.GA106818@e120877-lin.cambridge.arm.com> <da0fe50a-f419-e6a1-d67f-76fbe5cbf520@arm.com>
 <20210507153827.GA176408@e120877-lin.cambridge.arm.com> <c265d9ab-f06f-692f-df43-464bf4f2ea68@arm.com>
 <20210507171438.GA326455@e120877-lin.cambridge.arm.com>
In-Reply-To: <20210507171438.GA326455@e120877-lin.cambridge.arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Sat, 8 May 2021 09:23:55 +0800
Message-ID: <CAB8ipk_VF0iD-4Lp73UsPYwz9wOawro5ZfyZihFU4Pu3_ehZjA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/pelt: Keep UTIL_AVG_UNCHANGED flag in sync when
 calculating last_enqueued_diff
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 8, 2021 at 1:14 AM Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> [...]
>
> > >
> > > But we take the abs() of last_enqueued_diff.
> > >
> > > If we consider the following examples:
> > >
> > >    enqueued_old = 5, enqueued_new = 9
> > >    diff = 5 - (9 + 1) => 5 - 10 => -5
> > >
> > >    enqueued_old = 9, enqueued_new = 5
> > >    diff = 9 - (5 + 1) => 9 - 6 => 3
> > >
> > > In both cases the delta is supposed to be 4. But in the first case we end-up
> > > with 5. In the second, we end-up with 3. That's why I meant the effect on the
> > > diff depends on who's greater, ue.enqueued or task_util().
> >
> > Ah, OK, due to the abs() in within_margin(). But util's LSB is lost due
> > to the flag anyway. Hence I assume e.g. enqueued_new = 9 should be
> > (task_util() = 8) + 1 (| flag) in the example.
>
> Yeah, I should have used an even number for the demonstration :-)
>
> >
> > OTHA, implementing UTIL_AVG_UNCHANGED as LSB and making this visible on
> > the util_est 'API' has other issues too. The condition
> > `!task_util_est(p)` can never be true in find_energy_efficient_cpu()
> > because of UTIL_AVG_UNCHANGED.
> >
> > So why not use `UTIL_AVG_UNCHANGED = 0x80000000` and just keep its use
> > internal (between cfs_se_util_change() and util_est_update()), i.e. not
> > exporting it (via _task_util_est()) and not eclipsing util_est's LSB
> > value?
>
> As this would be fixing two issues at once, it's probably preferable.
>
> [...]
>
> >  kernel/sched/fair.c |  5 +++--
> >  kernel/sched/pelt.h | 11 ++++++-----
> >  2 files changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1d75af1ecfb4..dd30e362c3cc 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3902,7 +3902,7 @@ static inline unsigned long _task_util_est(struct task_struct *p)
> >  {
> >       struct util_est ue = READ_ONCE(p->se.avg.util_est);
> >
> > -     return (max(ue.ewma, ue.enqueued) | UTIL_AVG_UNCHANGED);
> > +     return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
> >  }
> >
> >  static inline unsigned long task_util_est(struct task_struct *p)
> > @@ -4002,7 +4002,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
> >        * Reset EWMA on utilization increases, the moving average is used only
> >        * to smooth utilization decreases.
> >        */
>
> Needs to be updated to add:
>
>         last_enqueued_diff = ue.enqueued & ~UTIL_AVG_UNCHANGED;

The flag had been cleared before, otherwise would return earlier, so
there is no need to clear this flag again.

>
> > -     ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
> > +     ue.enqueued = task_util(p);
> >       if (sched_feat(UTIL_EST_FASTUP)) {
> >               if (ue.ewma < ue.enqueued) {
> >                       ue.ewma = ue.enqueued;
> > @@ -4051,6 +4051,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
> >       ue.ewma  += last_ewma_diff;
> >       ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
> >  done:
> > +     ue.enqueued |= UTIL_AVG_UNCHANGED;
> >       WRITE_ONCE(p->se.avg.util_est, ue);
> >
> >       trace_sched_util_est_se_tp(&p->se);
> > diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> > index 1462846d244e..476faf61f14a 100644
