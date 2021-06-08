Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955AB39F584
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhFHLtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:49:39 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:37751 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbhFHLti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:49:38 -0400
Received: by mail-lj1-f179.google.com with SMTP id e2so26610508ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 04:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lSpJR4JGaHgDiWzGIah7bTjYhAXYw8Q1sE4YSNVI0i4=;
        b=COvYHpq+JVYGRzoy39ufIMUDfL75CBgXUZYk8XAKcGrpy16GXOlcUhTqkN2HT+oUSH
         ZFAaKfhcpyU3fgow/qYTC/O6oGaVjsQ9zfpUhSO0yv0hc9RTOJyPZ3YBTj0QL5JKdEQn
         iOCdwJ61YmmjKfMdiQBgvycVPZhgpY2d4oERw0CbgYnmNtWHKti7v9+yWs9v0cUEEmDI
         WD45PoL4d80hJWTcebGcKRFVX7wxkEt6nlmAwoPAlTB312F2FUOvMINrQdyfe8vmKKdj
         tKssusa6KbMH6Jv73zBZ3nETh06Z3EtjheJ9aO9MW6O7uABEIyEV3sTGPuTzTgO7S57I
         ez9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lSpJR4JGaHgDiWzGIah7bTjYhAXYw8Q1sE4YSNVI0i4=;
        b=eO1/EpwlLmGZC+flwkKPmzdY5+ZzYRC4URLTGZQOtxsdVGKRAXbTYhGpzSoUafZOAi
         mrQ74KPGhlTF7Lt+kKeWVO6xaWORJQU/iRc1HxrPB6TmjGZfYctlWEg+EpmJllLotkHW
         cUP4BTlIEsBQLDuneMN9Ob/yi8TXN7WriIzr6rOHckoRXWKlc+Z2Jf6d6XhSxwW+pf5b
         q13s1RrjD5fg3AhZqfxwLfkspa9ec+eypxcSEi9TjHMjXZ+uYaecyS+TVXvSK5U6FZGs
         fWOugpRtKTGA3Lxm/Vp2xXbqDCbf7EupEfKmY8JBUYd7f18MgYAvCDWcFrJPUFTJa4XJ
         xOBQ==
X-Gm-Message-State: AOAM531K9Dx9DvyiwvwLtmi3soSzeTjj4+xCd5V9g+umazRbDOSAusPy
        swWJM6KlsIZBbhxH37KCbEs5gMG/zjc/mglfbSg=
X-Google-Smtp-Source: ABdhPJxwoU6ZJiR6TKbbJvU5nIOxOFvo9BUV8g2ypuRdzbCRfr4yxSJKKhkx+8I/D4xlzHe+66vzqcW+b0G7cd6NzOI=
X-Received: by 2002:a2e:700f:: with SMTP id l15mr18148985ljc.52.1623152796007;
 Tue, 08 Jun 2021 04:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210602123803.15738-1-xuewen.yan94@gmail.com>
 <YLeF/556Wbvx1Ssc@google.com> <CAB8ipk9BqzEQ4Ta5s+vJeep=v1pmaXS-WsF2tq0u9G8Q2PGmsA@mail.gmail.com>
 <20210604160839.2op4ak75vle3gmt3@e107158-lin.cambridge.arm.com>
 <CAB8ipk9CgWvbGnJcvEtLcG=7v-pPmGJd25-R9jb2Am5zKngK3g@mail.gmail.com>
 <20210605114908.mqfsip5pskamls6k@e107158-lin.cambridge.arm.com>
 <CAB8ipk_a6VFNjiEnHRHkUMBKbA+qzPQvhtNjJ_YNzQhqV_o8Zw@mail.gmail.com> <20210607134902.nlgvqtzj35rhjg7x@e107158-lin.cambridge.arm.com>
In-Reply-To: <20210607134902.nlgvqtzj35rhjg7x@e107158-lin.cambridge.arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 8 Jun 2021 19:45:32 +0800
Message-ID: <CAB8ipk8FaovUYY8ncDgLHO7k_EoEHtsfm+1QYsFTMf4fb7ix_A@mail.gmail.com>
Subject: Re: [PATCH] sched/uclamp: Avoid setting cpu.uclamp.min bigger than cpu.uclamp.max
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, sorry for the late reply..

On Mon, Jun 7, 2021 at 9:49 PM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 06/05/21 21:24, Xuewen Yan wrote:
> > Hi Qais
> >
> > On Sat, Jun 5, 2021 at 7:49 PM Qais Yousef <qais.yousef@arm.com> wrote:
> > > > >
> > > > In addition=EF=BC=8CIn your patch:
> > > > 6938840392c89 ("sched/uclamp: Fix wrong implementation of cpu.uclam=
p.min")
> > > > https://lkml.kernel.org/r/20210510145032.1934078-2-qais.yousef@arm.=
com
> > > >
> > > > + switch (clamp_id) {
> > > > + case UCLAMP_MIN: {
> > > > + struct uclamp_se uc_min =3D task_group(p)->uclamp[clamp_id];
> > > > + if (uc_req.value < uc_min.value)
> > > > + return uc_min;
> > > > + break;
> > > >
> > > > When the clamp_id =3D UCLAMP_MIN, why not judge the uc_req.value is
> > > > bigger than task_group(p)->uclamp[UCLAMP_MAX] ?
> > >
> > > Because of the requirement I pointed you to in cgroup-v2.rst. We must=
 allow any
> > > value to be requested.
> > >
> > > Ultimately if we had
> > >
> > >         cpu.uclamp.min =3D 80
> > >         cpu.uclamp.max =3D 50
> > >
> > > then we want to remember the original request but make sure the effec=
tive value
> > > is capped.
> > >
> > > For the user in the future modifies the values such that
> > >
> > >         cpu.uclamp.max =3D max
> > >
> > > Then we want to remember cpu.uclamp.min =3D 80 and apply it since now=
 the
> > > cpu.uclamp.max was relaxed to allow the boost value.
> > >
> > > > Because when the p->uclamp_req[UCLAMP_MIN] >  task_group(p)->uclamp=
[UCLAMP_MAX],
> > > > the patch can not clamp the p->uclamp_req[UCLAMP_MIN/MAX] into
> > > > [ task_group(p)->uclamp[UCLAMP_MAX],  task_group(p)->uclamp[UCLAMP_=
MAX] ].
> > > >
> > > > Is it necessary to fix it here=EF=BC=9F
> > >
> > > Nope. We must allow any combination values to be accepted and remembe=
r them so
> > > if one changes we ensure the new effective value is updated according=
ly.
> > > This is how cgroups API works.
> >
> > Sorry. I may not have expressed it clearly. In your patch (which has
> > not yet merged into the mainline):
> >
> > 6938840392c89 ("sched/uclamp: Fix wrong implementation of cpu.uclamp.mi=
n")
> >  https://lkml.kernel.org/r/20210510145032.1934078-2-qais.yousef@arm.com
> >
> > This patch will not affect p->uclamp_req, but consider the following si=
tuation:
> >
> > tg->cpu.uclamp.min =3D 0
> > tg->cpu.uclamp.max =3D 50%
> >
> > p->uclamp_req[UCLAMP_MIN] =3D 60%
> > p->uclamp_req[UCLAMP_MIN] =3D 80%

sorry, here should be
p->uclamp_req[UCLAMP_MIN] =3D 60%
p->uclamp_req[UCLAMP_MAX] =3D 80%

> >
> > The function call process is as follows=EF=BC=9A
> > uclamp_eff_value() -> uclamp_eff_get() ->uclamp_tg_restrict()
> >
> > with your patch, the result is:
> >
> > p->effective_uclamp_min =3D 60%
> > p->effective_uclamp_max =3D 50%
> >
> > It would not affect the uclamp_task_util(p), but affect the rq:
> > when p enqueued:
> > rq->uclamp[UCLAMP_MIN] =3D 60%
> > rq->uclamp[UCLAMP_MIN] =3D 50%

sorry, here should be
rq->uclamp[UCLAMP_MIN] =3D 60%
rq->uclamp[UCLAMP_MAX] =3D 50%

> >
> > futher more,  in uclamp_rq_util_with() {
> > ...
> >
> > min_util =3D READ_ONCE(rq->uclamp[UCLAMP_MIN].value); //60%
> > max_util =3D READ_ONCE(rq->uclamp[UCLAMP_MAX].value);//50%
> > ...
> > if (unlikely(min_util >=3D max_util))
> > return min_util;
> >
> > return clamp(util, min_util, max_util);
> > ...
> > }
> > as a result, it would return 60%.
>
> Looking at this again now, I better understand what you were trying to sa=
y.
> I got confused that you were still arguing about cgroup inverted
> cpu.uclamp.min/max, but you're actually talking about something else.

Generally speaking, this kind of situation does not basically exist,
but I just consider all the situations that can occur when users use
it.

>
> It would be a lot easier to not cross talk threads and reply to my patch
> directly with this remark.
Sorry for the trouble because of my unfamiliar with the maillist, I
will pay attention next time :=EF=BC=89

>
> Anyways, still well spotted!
>
> What you're saying is we need something like the patch below to ensure th=
at the
> *task request* is within tg uclamp range, right? The worry is that the ta=
sk's
> uclamp_min is higher than the tg's uclamp_min, so we end up with the inve=
rsion
> because of that which will not be corrected later.

Yeah,  the task's uclamp_min is higher than the tg's uclamp_max.
>
> Hmm I need to think a bit more about this..
>
> Cheers
>
> --
> Qais Yousef
>
> --->8---
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9e9a5be35cde..e867813b9d5e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1405,6 +1405,7 @@ uclamp_tg_restrict(struct task_struct *p, enum ucla=
mp_id clamp_id)
>  {
>         struct uclamp_se uc_req =3D p->uclamp_req[clamp_id];
>  #ifdef CONFIG_UCLAMP_TASK_GROUP
> +       unsigned long uc_min, uc_max, val;
>
>         /*
>          * Tasks in autogroups or root task group will be
> @@ -1415,23 +1416,10 @@ uclamp_tg_restrict(struct task_struct *p, enum uc=
lamp_id clamp_id)
>         if (task_group(p) =3D=3D &root_task_group)
>                 return uc_req;
>
> -       switch (clamp_id) {
> -       case UCLAMP_MIN: {
> -               struct uclamp_se uc_min =3D task_group(p)->uclamp[clamp_i=
d];
> -               if (uc_req.value < uc_min.value)
> -                       return uc_min;
> -               break;
> -       }
> -       case UCLAMP_MAX: {
> -               struct uclamp_se uc_max =3D task_group(p)->uclamp[clamp_i=
d];
> -               if (uc_req.value > uc_max.value)
> -                       return uc_max;
> -               break;
> -       }
> -       default:
> -               WARN_ON_ONCE(1);
> -               break;
> -       }
> +       uc_min =3D task_group(p)->uclamp[UCLAMP_MIN].value;
> +       uc_max =3D task_group(p)->uclamp[UCLAMP_MAX].value;
> +       val =3D uc_req.value;
> +       uc_req.value =3D clamp(val, uc_min, uc_max);

This is not a good solution, because it just clamp the uc_req.value,
but the  uc_req.bucket_id is not changed.

>  #endif
>
>         return uc_req;
>

Thanks!
xuewen
