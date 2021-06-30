Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3FF3B7B38
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 03:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhF3B1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 21:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhF3B06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 21:26:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92024C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 18:24:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f30so1911357lfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 18:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GJckAPyZphl8ne165hqhsBoc+p3wqBpzAVQesrHuWFc=;
        b=I71W471+pH5v0HmQ39J8FrffnCGfJOK8Esf9oDpsl1MoAgXEYnTWgXSilEFmKdZZTl
         D2lfJM6KyXJapbZN/eE4v1HTb3KkplsNc7WqTqaEJO/GZAzH3RTMaJmGsW8a2AKXYFiv
         6BPvRBRkNaLjgtX3bQo2Du8QUYsXIhH5fpdDLm9iFSoYMGfxCPJFB0McgAh4bG8+/0Ep
         74hN4YOc59dK2mqg5cQ66yKAL+wej15l6tY8UDzVHOdSEZu2Fy/qya1/0bT+cfzodVpq
         NKues1QftoRW2M+NOe5DN7IhBk/5aVfvMbQlMOuRQZTfTiXpZ8QtRIVkxhxeUEiGT8XR
         LUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GJckAPyZphl8ne165hqhsBoc+p3wqBpzAVQesrHuWFc=;
        b=Ol6xd55D/1mMdhpfEh4lweeOkMRE1D4irzQCOTN/FfGM/Z8Pz+patucRfwbtQfEFe0
         6Ix639EwJw6+49N2BvQaqjmiX46DgHSgJBGtwayFJlCZA83O8SgF8z4wkZVumH1MPqr4
         hmSqf0+nRt+4F71yY1VaMHaeBKMMH00Gm8uUsf2eav/2u+JQq4fi5i/yS4Kbs2xGDnKx
         rP/K8/b7AsRImqLR+Lf6ZstfYuNiV6MCjadpyeqX1SPOWG4eI7bPoZlN3u+V0QQCh6kL
         NEuvxAsC3l0b5mhd0N1YhJFuZAUFEHaVr0nCvL3koAcvTfwKpDZM9NN+qy2NxZNxXYoe
         bo9Q==
X-Gm-Message-State: AOAM531oSNzMCi3tQrimWforkInjf7ITRCNAKAELO8JPI78mUjLwJVIO
        WGPJnVYC97xOfUOwuHeGo8yh/Pt1+jI50Lb2SM0=
X-Google-Smtp-Source: ABdhPJzJn8Wjo3et4qjInK6/vcI5+0msrFnKphta6rJX5hjysOg4+LiZznMS1cufp76NA6SFCn6WowLNRe4umzbchuA=
X-Received: by 2002:ac2:4950:: with SMTP id o16mr17988266lfi.487.1625016268969;
 Tue, 29 Jun 2021 18:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210618072349.503-1-xuewen.yan94@gmail.com> <87fsx093vm.mognet@arm.com>
In-Reply-To: <87fsx093vm.mognet@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Wed, 30 Jun 2021 09:24:12 +0800
Message-ID: <CAB8ipk9TMTbw2WGrbLuewk_CaYxrvMOp2Ui5xiHiwYB4NmoRhA@mail.gmail.com>
Subject: Re: [PATCH] sched/uclamp: Fix getting unreasonable ucalmp_max when rq
 is idle
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Quentin Perret <qperret@google.com>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 9:50 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> +Cc Patrick's current address
>
> On 18/06/21 15:23, Xuewen Yan wrote:
> > From: Xuewen Yan <xuewen.yan@unisoc.com>
> >
> > Now in uclamp_rq_util_with(), when the task !=3D NULL, the uclamp_max a=
s following:
> > uc_rq_max =3D rq->uclamp[UCLAMP_MAX].value;
> > uc_eff_max =3D uclamp_eff_value(p, UCLAMP_MAX);
> > uclamp_max =3D max{uc_rq_max, uc_eff_max};
> >
> > Consider the following scenario:
> > (1)the rq is idle, the uc_rq_max is last task's UCLAMP_MAX;
> > (2)the p's uc_eff_max < uc_rq_max.
> >
> > The result is the uclamp_max =3D uc_rq_max instead of uc_eff_max, it is=
 unreasonable.
> >
> > The scenario often happens in find_energy_efficient_cpu(), when the tas=
k has smaller UCLAMP_MAX.
> >
> > Inserts whether the rq is idle in the uclamp_rq_util_with().
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  kernel/sched/sched.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index a189bec13729..0feef6af89f2 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2550,7 +2550,10 @@ unsigned long uclamp_rq_util_with(struct rq *rq,=
 unsigned long util,
> >
> >       if (p) {
> >               min_util =3D max(min_util, uclamp_eff_value(p, UCLAMP_MIN=
));
> > -             max_util =3D max(max_util, uclamp_eff_value(p, UCLAMP_MAX=
));
> > +             if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> > +                     max_util =3D uclamp_eff_value(p, UCLAMP_MAX);
> > +             else
> > +                     max_util =3D max(max_util, uclamp_eff_value(p, UC=
LAMP_MAX));
>
> That makes sense to me - enqueuing the task will lift UCLAMP_FLAG_IDLE an=
d
> set the rq clamp as the task's via uclamp_idle_reset().
>
> Does this want a
>
>   Fixes: 9d20ad7dfc9a ("sched/uclamp: Add uclamp_util_with()")
>
> ?

Yes=EF=BC=8Cadd it.

>
> Also, when we have UCLAMP_FLAG_IDLE, we don't even need to read the rq ma=
x
> - and I'm pretty sure the same applies to the rq min. What about somethin=
g like:

Good idea, I'll try it in V2.

>
> ---
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 6510f0a46789..a2c6f6ae6392 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2833,23 +2833,27 @@ static __always_inline
>  unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
>                                   struct task_struct *p)
>  {
> -       unsigned long min_util;
> -       unsigned long max_util;
> +       unsigned long min_util =3D 0;
> +       unsigned long max_util =3D 0;
>
>         if (!static_branch_likely(&sched_uclamp_used))
>                 return util;
>
> -       min_util =3D READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
> -       max_util =3D READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
> -
>         if (p) {
> -               min_util =3D max(min_util, uclamp_eff_value(p, UCLAMP_MIN=
));
> +               min_util =3D uclamp_eff_value(p, UCLAMP_MIN);
> +               max_util =3D uclamp_eff_value(p, UCLAMP_MAX);
> +
> +               /*
> +                * Ignore last runnable task's max clamp, as this task wi=
ll
> +                * reset it. Similarly, no need to read the rq's min clam=
p.
> +                */
>                 if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> -                       max_util =3D uclamp_eff_value(p, UCLAMP_MAX);
> -               else
> -                       max_util =3D max(max_util, uclamp_eff_value(p, UC=
LAMP_MAX));
> +                       goto out;
>         }
>
> +       min_util =3D max_t(unsigned long, min_util, READ_ONCE(rq->uclamp[=
UCLAMP_MIN].value));
> +       max_util =3D max_t(unsigned long, max_util, READ_ONCE(rq->uclamp[=
UCLAMP_MAX].value));

Is it necessary to use max_t here? although it is not the main problem...

> +out:
>         /*
>          * Since CPU's {min,max}_util clamps are MAX aggregated consideri=
ng
>          * RUNNABLE tasks with _different_ clamps, we can end up with an

Thanks!
xuewen
