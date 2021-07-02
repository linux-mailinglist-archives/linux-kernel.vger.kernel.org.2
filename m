Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BB93B9D52
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 10:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhGBIKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 04:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGBIKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:10:54 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782D1C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 01:08:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id q18so16596735lfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 01:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yN1JzFQU4unToYWY8NK5C5gYLDQEtwyJk7jPmsLsEp8=;
        b=D/LeWMQtjBYgH73i/c8YhbQLtaFWbn6Z9DeQsu7X/Iyt5mFnbYD5jKv8R0uaA3wY5s
         UmnAMJcgQau4mJJbCJp70hJF3DC1pUGESSBOFYm/mAAoJnpulmYi/9i0dc2sgHOnOIGc
         NcAd1YA7BVoUbGb3/JTK3CPgMXeLetQinKHBWa+ykHge6O2rnAat251W/TugdmgT4lvE
         BYBjpBKZK7xjt5+ICdZlWalexVDIlB8S1iyba/ELv4j4qVG92/3F5TSxjcu0TrSzqG+T
         n/OcZ5R6mvLbGEIaEkyFB5Io9qH91zoxA5BkyNxSu463lz2y/CTZMpyMhLy5+ADI8Oxd
         47yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yN1JzFQU4unToYWY8NK5C5gYLDQEtwyJk7jPmsLsEp8=;
        b=W9nxWoB86/uSyo+kniG0TRja3UiunoznzqotbFkr9tfu6EKRaEwJIRk933S9gPXNjc
         qFPJGGrW0bbtn4P45nOFJtC9VNeLgiMNntRYuEu4USwumwUVdz5NAc1WyMmsvx1M8ctY
         +qFEuIWx85CYZ0kWq1+HybpHqeuAAX/RX7YVcRJM516EpP/kkLygXxV3Zbbcfh//E6Al
         OaWMu+SpYYwdZS6tx1IAkX+w5pIxjgOd4HO51HN3Cvf3TLPsoxi2yghnlCdc8yafc0tJ
         LPqFcOnIhN5uxgVKPPutj1WuGEOYw/9TxUq0vOxu2LC6iMERy6Ss1kbZcO12Z0tUWEd5
         R5aA==
X-Gm-Message-State: AOAM5338qB5y+i1d7bGC+npemrreLNGPu/tYlschVTx7GYGPoF6r26eq
        PMZtUrQfvCttJOCJumU8xV6s5F3w79hsERgem2H2Yw==
X-Google-Smtp-Source: ABdhPJwL7BmXsthKodpGU325iOcVo9DuP0LDJcGh8/TAP1Eta7KM+FM1XvKOf3JEJXEn+lwA3DVNYHRQINFxlU+87RE=
X-Received: by 2002:a05:6512:3d1d:: with SMTP id d29mr3004059lfv.286.1625213300604;
 Fri, 02 Jul 2021 01:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210701171837.32156-1-vincent.guittot@linaro.org> <DAABF914-F5D0-4C92-BFE0-341D83B9F3D0@linux.vnet.ibm.com>
In-Reply-To: <DAABF914-F5D0-4C92-BFE0-341D83B9F3D0@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 2 Jul 2021 10:08:09 +0200
Message-ID: <CAKfTPtCuV6iCRfb53Avu7=+rV6G=AYYRyutqm0_LJU6mVV1kKg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Sync load_sum with load_avg after dequeue
To:     Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Odin Ugedal <odin@uged.al>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2021 at 08:16, Sachin Sant <sachinp@linux.vnet.ibm.com> wrote=
:
>
>
>
> > On 01-Jul-2021, at 10:48 PM, Vincent Guittot <vincent.guittot@linaro.or=
g> wrote:
> >
> > commit 9e077b52d86a ("sched/pelt: Check that *_avg are null when *_sum =
are")
> > reported some inconsitencies between *_avg and *_sum.
> >
> > commit 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay cons=
istent")
> > fixed some but one remains when dequeuing load.
> >
> > sync the cfs's load_sum with its load_avg after dequeuing the load of a
> > sched_entity.
> >
> > Fixes: 9e077b52d86a ("sched/pelt: Check that *_avg are null when *_sum =
are")
> > Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > I have been able to trigger a WARN on my system even with the patch
> > listed above. This patch fixes it.
> > Sachin could you test that it also fixes yours ?
> >
>
> I ran various LTP stress tests, scheduler tests and kernel compile operat=
ion for about 5 hours.
> Haven=E2=80=99t seen the warning during the testing.
>
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>

Thanks

>
> I have left the tests running, will let it run for few more hours.
>
> Thanks
> -Sachin
>
> > kernel/sched/fair.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 11d22943753f..48fc7dfc2f66 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3037,8 +3037,9 @@ enqueue_load_avg(struct cfs_rq *cfs_rq, struct sc=
hed_entity *se)
> > static inline void
> > dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > {
> > +     u32 divider =3D get_pelt_divider(&se->avg);
> >       sub_positive(&cfs_rq->avg.load_avg, se->avg.load_avg);
> > -     sub_positive(&cfs_rq->avg.load_sum, se_weight(se) * se->avg.load_=
sum);
> > +     cfs_rq->avg.load_sum =3D cfs_rq->avg.load_avg * divider;
> > }
> > #else
> > static inline void
> > --
> > 2.17.1
> >
>
