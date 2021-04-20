Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E66365B41
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhDTOep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbhDTOem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:34:42 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7F9C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 07:34:07 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id o16so43793012ljp.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4iYTXeKOmGh/KQWyiVfbBlmiKganzaGsHCSZRJ5l+hI=;
        b=GFCTY6YAaoRxG/+AG03/4c3qi9ytbf8z3zT0rm/9UTz+CnH/Fq4C1snfxSJELY/W3P
         +We7ljvqP+fNIO0oR3NUzhzdDQs+xttBfHm6fpC2IJZvHl515GxWT+gLQdGmDxRZnZCG
         Y+0QV+A/J7+K8befSm9m1ewrmfNV2ey2bsh48uwGyjaQgMhKPr2iqvmjZ6V0nzzuNQuV
         JXB1iwGX67lb4rAdZ8OmbFGyLLtYP3dkF9sJnenR19iAYyuy1GwWLUD8rtcY3P6ppAa3
         jg/CuUeUQLRgNbx3ysz3Av5h2Jz2NoING/ELouTa8paxQU4LUPFrU/2pxVl8zQzWMS29
         3Dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4iYTXeKOmGh/KQWyiVfbBlmiKganzaGsHCSZRJ5l+hI=;
        b=foUroGV/UDZ8+kUZ6zHTqpXUOY3yZrMP8ejRYJVcCGSmnUbuBvmTDp0xbtroxnxY7M
         YcqOpx4BkHmUua7SmnnEe2gFLh+TNQXqqwgEclwCWHSO5CkAQh75DwbjRdsO5Cq4eJzT
         X0lTXoKm9iD4DAmIcX0ylyywOrluoJKtHxQ4SC6QReLMauGedO0IttA/HQhlQkembxU3
         2/9lAiX5Tl3IU7Z4IQDBBAcY7nlpccyLPRhxpTFWsqorWscEl8098z07usJukRTUuSXG
         DgYZQB9O+2yqNjK/m3ABDALO3JYxwknvBKB8cyL+qQP3nLsqic7VtU6Gt3cEYIvzz0H0
         qzjw==
X-Gm-Message-State: AOAM5329eY3s4Zr218oktFBDxDa1QNCmUVYo//KyaC8RZLWOWk24U/Oc
        +yKIV77dfWZgt3G/IUfGBB39DwX+zRVp9oemZ7HCdXIQQX9YdQ==
X-Google-Smtp-Source: ABdhPJyv8xM4ReCq8ttl2cc6ZDHgtmE1AxFKI3Lp6RAf+mQXjXD+xkuRNwD5ZBpGCF06V8eybar8x6GdWnu3ojryJzw=
X-Received: by 2002:a05:651c:612:: with SMTP id k18mr11787066lje.445.1618929246414;
 Tue, 20 Apr 2021 07:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210415175846.494385-1-valentin.schneider@arm.com>
 <20210415175846.494385-3-valentin.schneider@arm.com> <20210416135113.GA16445@vingu-book>
 <87blaakxji.mognet@arm.com>
In-Reply-To: <87blaakxji.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 20 Apr 2021 16:33:54 +0200
Message-ID: <CAKfTPtCLNeSzMLO_7uhj13k6CgtzAMhcW5aXJTYUOSYJZi220w@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Relax task_hot() for misfit tasks
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 at 19:13, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 16/04/21 15:51, Vincent Guittot wrote:
> > Le jeudi 15 avril 2021 =C3=AF=C2=BF=C2=BD 18:58:46 (+0100), Valentin Sc=
hneider a =C3=AF=C2=BF=C2=BDcrit :
> >> +
> >> +/*
> >> + * What does migrating this task do to our capacity-aware scheduling =
criterion?
> >> + *
> >> + * Returns 1, if the task needs more capacity than the dst CPU can pr=
ovide.
> >> + * Returns 0, if the task needs the extra capacity provided by the ds=
t CPU
> >> + * Returns -1, if the task isn't impacted by the migration wrt capaci=
ty.
> >> + */
> >> +static int migrate_degrades_capacity(struct task_struct *p, struct lb=
_env *env)
> >> +{
> >> +    if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
> >> +            return -1;
> >> +
> >> +    if (!task_fits_capacity(p, capacity_of(env->src_cpu))) {
> >> +            if (cpu_capacity_greater(env->dst_cpu, env->src_cpu))
> >> +                    return 0;
> >> +            else if (cpu_capacity_greater(env->src_cpu, env->dst_cpu)=
)
> >> +                    return 1;
> >> +            else
> >> +                    return -1;
> >> +    }
> >
> > Being there means that task fits src_cpu capacity so why testing p agai=
nst dst_cpu ?
> >
>
> Because if p fits on src_cpu, we don't want to move it to a dst_cpu on
> which it *doesn't* fit.

OK. I was confused because I thought that this was only to force
migration in case of group_misfit_task but you tried to extend to
other cases... I'm not convinced that you succeeded to cover all cases

Also I found this function which returns 3 values a bit disturbing.
IIUC you tried to align to migrate_degrades_capacity but you should
have better aligned to task_hot and return only 0 or 1. -1 is not used

>
> >> +
> >> +    return task_fits_capacity(p, capacity_of(env->dst_cpu)) ? -1 : 1;
> >> +}
> >
> > I prefer the below which easier to read because the same var is use eve=
rywhere and you can remove cpu_capacity_greater.
> >
> > static int migrate_degrades_capacity(struct task_struct *p, struct lb_e=
nv *env)
> > {
> >     unsigned long src_capacity, dst_capacity;
> >
> >     if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
> >         return -1;
> >
> >     src_capacity =3D capacity_of(env->src_cpu);
> >     dst_capacity =3D capacity_of(env->dst_cpu);
> >
> >     if (!task_fits_capacity(p, src_capacity)) {
> >         if (capacity_greater(dst_capacity, src_capacity))
> >             return 0;
> >         else if (capacity_greater(src_capacity, dst_capacity))
> >             return 1;
> >         else
> >             return -1;
> >     }
> >
> >     return task_fits_capacity(p, dst_capacity) ? -1 : 1;
> > }
> >
>
> I'll take it, thanks!
>
> >
> >> +
> >>  #ifdef CONFIG_NUMA_BALANCING
> >>  /*
> >>   * Returns 1, if task migration degrades locality
> >> @@ -7672,6 +7698,15 @@ int can_migrate_task(struct task_struct *p, str=
uct lb_env *env)
> >>      if (tsk_cache_hot =3D=3D -1)
> >>              tsk_cache_hot =3D task_hot(p, env);
> >>
> >> +    /*
> >> +     * On a (sane) asymmetric CPU capacity system, the increase in co=
mpute
> >> +     * capacity should offset any potential performance hit caused by=
 a
> >> +     * migration.
> >> +     */
> >> +    if ((env->dst_grp_type =3D=3D group_has_spare) &&
> >
> > Shouldn't it be env->src_grp_type =3D=3D group_misfit_task to only care=
 of misfit task case as
> > stated in $subject
> >
>
> Previously this was env->idle !=3D CPU_NOT_IDLE, but I figured dst_grp_ty=
pe
> could give us a better picture. Staring at this some more, this isn't so
> true when the group size goes up - there's no guarantees the dst_cpu is t=
he
> one that has spare cycles, and the other CPUs might not be able to grant
> the capacity uplift dst_cpu can.

yeah you have to keep checking for env->idle !=3D CPU_NOT_IDLE

>
> As for not using src_grp_type =3D=3D group_misfit_task, this is pretty mu=
ch the
> same as [1]. CPU-bound (misfit) task + some other task on the same rq
> implies group_overloaded classification when balancing at MC level (no SM=
T,
> so one group per CPU).

Is it something that happens often or just a sporadic/transient state
? I mean does it really worth the extra complexity and do you see
performance improvement ?

You should better focus on fixing the simple case of group_misfit_task
task. This other cases looks far more complex with lot of corner cases

>
> [1]: http://lore.kernel.org/r/jhjblcuv2mo.mognet@arm.com
