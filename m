Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551BE35D4F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243670AbhDMBwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 21:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbhDMBwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:52:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636CFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 18:52:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z13so7576592lfd.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 18:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UaWESlZfNopg4i2N6j19qrpbek87zp6OfXN7prhD3zU=;
        b=QBBHPQmI1MzAwGlJx6PXF10nxlxX1P3fV2vz2mH4j3XWtfc05/Jvn+tkQSx9Yp45Tg
         pNA3WqA8kPpA8cOEn9vIq4tOTSubUE30wsBaFGS+sY6cTHz2sJCRtaRSLUtLxo/HOUcb
         vXPh0TeO+0PX4hOqE3MFdAok5C5i0faGHcaBroZXeMTp7skRsBJdjjPTzgnLppYjffqR
         DIDX2Sq0Htbyk86VO+1IDMyR5x/wlnBqaIpo5AkE7RhAWjmtjhMnC3lv646QmgKGEni9
         2hSm/FqmK/MWJ0I315gV/SPrcejKoJ8elXHRbHegJo+Rzce8KcoUOpqbJ4dyEj0cAwQF
         V3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UaWESlZfNopg4i2N6j19qrpbek87zp6OfXN7prhD3zU=;
        b=XC+uLxhj85FY8jIOiCl83DdqspqGl9IFQ6gjQb1hp/uqfV/LzJYdifWLumNehgsjNj
         8WGa9XLhbw89iARZ9yywn3OnjJ1tJdCfCgq2cXp4X90ffZ8m1N3nYGOAlJJCxXUw4O2Y
         LYkSOvMR7f/i1T4oROu0q+tQls1WaByLvLEiHTA3hXSCA/8JzJSqqrfzpjSYzqijyz0i
         ZANIfNgZkstG52QWfUfgwOGsoo+Dt1r2fB9qTC850w9agII57pNKabIIfm5BXI6Jw5/d
         UnoCuENSDUIekRXRKunhoWo110+1PSJa+bYAUtKjj0yIkUxn6a5dkwzD/1yxtYlQPeNn
         Eq0g==
X-Gm-Message-State: AOAM532XZ+xhRMj6WyrA38bFK4aT5ifINE5twrwc+jHg5oWkvD/BT3vw
        FYjGekD8aH2k1AeJJ+TFoDzWQq6cyzw8eFa+8PU=
X-Google-Smtp-Source: ABdhPJzvzyCci+y8urSlh84IPwjuBEIfXSlZjx4AlUd2INpqetXPD1elrAr4p9C70M5jkxFvdyi8wHgHX5z0Gy/75qQ=
X-Received: by 2002:a19:f807:: with SMTP id a7mr13094952lff.437.1618278729896;
 Mon, 12 Apr 2021 18:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210330052154.26861-1-xuewen.yan94@gmail.com>
 <YGLzQAvVqlrKb8AB@google.com> <34ce11ad-9c20-7ba7-90d8-4830725bf38a@arm.com>
 <CAB8ipk9JATYxJBnpVFfH_XHLqh=yHesbo73wx=Mm7t8mSqW_Gg@mail.gmail.com>
 <1ebddd33-4666-1e6e-7788-a3fe28c9e99c@arm.com> <CAB8ipk9+fdGMY6cYoHnicPUOdd+meJo+EaGaaVZTgoxQ84+Wiw@mail.gmail.com>
 <d85a1db9-4680-1d31-d3e7-6a081f652c5e@arm.com> <CAB8ipk_J-W35+iZqsmAm+VO2=OUXRR3EsW6BuhYmvmBiPcHxMA@mail.gmail.com>
 <d80b7b3e-7eb3-4d0a-99fd-167e14ab86bc@arm.com> <CAB8ipk8RhhBvRq3jUnP2ENfSG_L=LonnVfweymYkQJrZQyA9jQ@mail.gmail.com>
 <b4631807-9b10-ce11-c206-ba347980f771@arm.com>
In-Reply-To: <b4631807-9b10-ce11-c206-ba347980f771@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 13 Apr 2021 09:50:57 +0800
Message-ID: <CAB8ipk_vgtg5d1obH36BYfNLZosbwr2k_U3xnAD4=H5uZt_M_g@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: use signed long when compute energy delta in eas
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Apr 13, 2021 at 1:15 AM Pierre Gondois <pierre.gondois@arm.com> wro=
te:
>
> Hi
> > > > >
> > > > > This patch-set is not significantly improving the execution time =
of
> > > > > feec(). The results we have so far are an improvement of 5-10% in
> > > > > execution time, with feec() being executed in < 10us. So the
> > gain is not
> > > > > spectacular.
> > > >
> > > > well=EF=BC=8C I meaned to cache all util value and compute energy w=
ith
> > caches,
> > > > when
> > > > (cpu=3D=3Ddst_cpu), use caches instead of updating util, and do not=
 get
> > > > util with function:
> > > >  "effective_cpu_util()", to compute util with cache.
> > > > I add more parameters into pd_cache:
> > > > struct pd_cache {
> > > >         unsigned long util;
> > > >         unsigned long util_est;
> > > >         unsigned long util_cfs;
> > > >         unsigned long util_irq;
> > > >         unsigned long util_rt;
> > > >         unsigned long util_dl;
> > > >         unsigned long bw_dl;
> > > >         unsigned long freq_util;
> > > >         unsigned long nrg_util;
> > > > };
> > > > In this way, it can avoid util update while feec. I tested with it,
> > > > and the negative delta disappeared.
> > > > Maybe this is not a good method, but it does work.
> > > If I understand correctly, you put all the fields used by
> > > core.c:effective_cpu_util() in the caches, allowing to have values no=
t
> > > subject to updates.
> > Yes.
> > > core.c:effective_cpu_util() isn't only called from
> > > fair.c:compute_energy(). It is used in the cpufreq_schedutil.c and
> > > cpufreq_cooling.c (through core.c:sched_cpu_util()).
> > > Did you have to duplicate core.c:effective_cpu_util() to have a secon=
d
> > > version using the caches ? If yes, I think the function was meant to =
be
> > > unique so that all the utilization estimations go through the same pa=
th.
> > >
> > I defined a new function to distinguish it from the effective_cpu_util.
> >
> > > If your concern is to avoid negative delta, I think just bailing out
> > > when this happens should be sufficient. As shown in the last message,
> > > having a wrong placement should not happen that often, plus the prev_=
cpu
> > > should be used which should be ok.
> > In your patch, you didn't actually choose the prev_cpu. you return (-1)=
;
> >
> > > If you want to cache the values, I think a stronger justification wil=
l
> > > be asked: this seems to be a big modification compared to the initial
> > > issue, knowing that another simpler solution is available (i.e. baili=
ng
> > > out). I was not able to prove there was a significant gain in the
> > > find_energy_efficient_cpu() execution time, but I would be happy if y=
ou
> > > can, or if you find other arguments.
> > Yes, you are right, perhaps there is indeed no need for such a big
> > modification.
> >
> > Regards
>
> In fair.c:select_task_rq_fair(), if feec() returns a error (< 0), then
> prev_cpu is selected. I think it's better to still let feec() signal
> that something happened and let select_task_rq_fair() select prev_cpu by
> itself.
In fair.c:select_task_rq_fair(), when feec() returns a error (< 0),
the new_cpu =3D find_idlest_cpu() or select_idle_sibling().
In your patch, you should return prev_cpu instead of -1 if you want to
select the prev_cpu.

> Are you planning to submit a V2 with the bail out mechanism ?
Maybe it would be better if you submitted the V2 ? I just check the
patch and raised some questions.
>
Regards
