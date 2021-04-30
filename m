Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BD536F60D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 08:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhD3G7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 02:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhD3G7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 02:59:45 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2F6C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 23:58:55 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a36so68687999ljq.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 23:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C89COMiUe0yLqYe/x35cp1T+l6GmFBSs3ETcmN6DCBo=;
        b=rbUDdoguhlMqgfAUqWws7ZKpmbQ/EiVEbkpD/6UV0+h9gXF1KIs9sVWXS0rHUs9Viz
         t9FdXoBcav5/0AxEPjagYglQfEyLjev31PuWAICbqfA57OBiNkSFcDOfQvq3wbpWbNym
         O2OeWqtxJqyZ5YH2bV1JL56089poJpRRm8BxDCDqx4Rf6OMIt+oOGa7vVoNOP6hvEUvp
         Ru9eEJw6brjUGNGmLK5Zrp4Q77rRlCXVpLz6WZBQbf1ZWqBvG+fZdPJvdPM93zS+8wep
         meyy3OsaXyKHkvwJ7ZV/dWiHrgbRqJBq2GSE1ecRhpqRQfxy4eIu1DUj04tZjKF6u6Qa
         4hNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C89COMiUe0yLqYe/x35cp1T+l6GmFBSs3ETcmN6DCBo=;
        b=QyqxLL9UOETe+pl89Lxy2ydtGk/BIf8ywvG61rloUMYCupAN4JVCap1kw8QjL1E78e
         Fag/aqNILE6qa2CkckIg+/EOiWCGv3GoKxu9UqCd7tVl6eycZJ+qZZ3vkOehYezcY1kW
         IZ4kYO0Xky/f5h/CLC0m2Ts2TrY9a5zUnXKoVYDWXsFE2vP5HEkw8vfJvOHqUJhgu59v
         dCV6yj895AqTyFzBtJ86UJe2GWGgYuyc18uPLY5SwH1GV/M7vtGT82FR+LLIyHfRugL7
         PcuTZoinPYKK+DaAygstXyVQnZAu9mMLAA8FmLLDvMVWyy+s4E+GKIXGfR1pGakW0oMv
         FDdA==
X-Gm-Message-State: AOAM530wt3oSG8d50SD+1eh35hvmSkoyZ4Ie0pbyaFLxqmSN3Bgcwu+x
        72s+AWdAYlKgnCFL4i92hOA+AylU46lzhCRQncEPmA==
X-Google-Smtp-Source: ABdhPJzg5ivK3KOImGieVt++TStFQCXlM7zyT/OtbRv0zVPvFiMEWdghjxbB3o6cE0XCdDpgIHVOEZxV68OWU5EJ0QM=
X-Received: by 2002:a2e:8256:: with SMTP id j22mr2731512ljh.284.1619765934011;
 Thu, 29 Apr 2021 23:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210415175846.494385-1-valentin.schneider@arm.com>
 <20210415175846.494385-3-valentin.schneider@arm.com> <20210416135113.GA16445@vingu-book>
 <87blaakxji.mognet@arm.com> <CAKfTPtCLNeSzMLO_7uhj13k6CgtzAMhcW5aXJTYUOSYJZi220w@mail.gmail.com>
 <878s5bvrij.mognet@arm.com>
In-Reply-To: <878s5bvrij.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 30 Apr 2021 08:58:42 +0200
Message-ID: <CAKfTPtA+w1Euepw+MP0o1EGYhoohpQm3jJP+WFQrmZ6Zet+F3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Relax task_hot() for misfit tasks
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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

On Wed, 21 Apr 2021 at 12:52, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 20/04/21 16:33, Vincent Guittot wrote:
> > On Mon, 19 Apr 2021 at 19:13, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >>
> >> On 16/04/21 15:51, Vincent Guittot wrote:
> >> > Le jeudi 15 avril 2021 =C3=AF=C2=BF=C2=BD 18:58:46 (+0100), Valentin=
 Schneider a =C3=AF=C2=BF=C2=BDcrit :
> >> >> +
> >> >> +/*
> >> >> + * What does migrating this task do to our capacity-aware scheduli=
ng criterion?
> >> >> + *
> >> >> + * Returns 1, if the task needs more capacity than the dst CPU can=
 provide.
> >> >> + * Returns 0, if the task needs the extra capacity provided by the=
 dst CPU
> >> >> + * Returns -1, if the task isn't impacted by the migration wrt cap=
acity.
> >> >> + */
> >> >> +static int migrate_degrades_capacity(struct task_struct *p, struct=
 lb_env *env)
> >> >> +{
> >> >> +    if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
> >> >> +            return -1;
> >> >> +
> >> >> +    if (!task_fits_capacity(p, capacity_of(env->src_cpu))) {
> >> >> +            if (cpu_capacity_greater(env->dst_cpu, env->src_cpu))
> >> >> +                    return 0;
> >> >> +            else if (cpu_capacity_greater(env->src_cpu, env->dst_c=
pu))
> >> >> +                    return 1;
> >> >> +            else
> >> >> +                    return -1;
> >> >> +    }
> >> >
> >> > Being there means that task fits src_cpu capacity so why testing p a=
gainst dst_cpu ?
> >> >
> >>
> >> Because if p fits on src_cpu, we don't want to move it to a dst_cpu on
> >> which it *doesn't* fit.
> >
> > OK. I was confused because I thought that this was only to force
> > migration in case of group_misfit_task but you tried to extend to
> > other cases... I'm not convinced that you succeeded to cover all cases
> >
> > Also I found this function which returns 3 values a bit disturbing.
> > IIUC you tried to align to migrate_degrades_capacity but you should
> > have better aligned to task_hot and return only 0 or 1. -1 is not used
> >
>
> Ack, will do.
>
> >> >> @@ -7672,6 +7698,15 @@ int can_migrate_task(struct task_struct *p, =
struct lb_env *env)
> >> >>      if (tsk_cache_hot =3D=3D -1)
> >> >>              tsk_cache_hot =3D task_hot(p, env);
> >> >>
> >> >> +    /*
> >> >> +     * On a (sane) asymmetric CPU capacity system, the increase in=
 compute
> >> >> +     * capacity should offset any potential performance hit caused=
 by a
> >> >> +     * migration.
> >> >> +     */
> >> >> +    if ((env->dst_grp_type =3D=3D group_has_spare) &&
> >> >
> >> > Shouldn't it be env->src_grp_type =3D=3D group_misfit_task to only c=
are of misfit task case as
> >> > stated in $subject
> >> >
> >>
> >> Previously this was env->idle !=3D CPU_NOT_IDLE, but I figured dst_grp=
_type
> >> could give us a better picture. Staring at this some more, this isn't =
so
> >> true when the group size goes up - there's no guarantees the dst_cpu i=
s the
> >> one that has spare cycles, and the other CPUs might not be able to gra=
nt
> >> the capacity uplift dst_cpu can.
> >
> > yeah you have to keep checking for env->idle !=3D CPU_NOT_IDLE
> >
> >>
> >> As for not using src_grp_type =3D=3D group_misfit_task, this is pretty=
 much the
> >> same as [1]. CPU-bound (misfit) task + some other task on the same rq
> >> implies group_overloaded classification when balancing at MC level (no=
 SMT,
> >> so one group per CPU).
> >
> > Is it something that happens often or just a sporadic/transient state
> > ? I mean does it really worth the extra complexity and do you see
> > performance improvement ?
> >
>
> "Unfortunately" yes, this is a relatively common scenario when running "1
> big task per CPU" types of workloads. The expected behaviour for big.LITT=
LE
> systems is to upmigrate tasks stuck on the LITTLE CPUs as soon as a big C=
PU
> becomes free, usually via newidle balance (which, since they process work
> faster than the LITTLEs, is bound to happen), and an extra task being
> enqueued at "the wrong time" can prevent this from happening.
>
> This usually means a misfit task can take a few dozen extra ms than it

A few dozens is quite long. With a big core being idle, it should try
every 8ms on a quad x quad system and I suspect the next try will be
during the next tick. Would be good to understand why it has to wait
so much

> should to be migrated - in the tests I run (which are pretty much this 1
> hog per CPU workload) this happens about ~20% of the time.
>
> > You should better focus on fixing the simple case of group_misfit_task
> > task. This other cases looks far more complex with lot of corner cases
> >
> >>
> >> [1]: http://lore.kernel.org/r/jhjblcuv2mo.mognet@arm.com
