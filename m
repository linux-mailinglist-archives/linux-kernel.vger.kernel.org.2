Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125B3314B04
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhBIJAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhBII4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:56:54 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1B8C061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 00:56:13 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u4so21288172ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 00:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80KDPeqcmUm1WB/LtZllE+tqBHcDrKxax6N2SNqKDu4=;
        b=TI14JhX0b5/rNHiU0RGNnVxo02rhxu36PvoukRYimh8O9DXU2fy7U4iYutBG9toU5N
         KPxg0rIpxr+bjX/Jml6DwZEy5ECGD9UAK6e77xitDDZ+Y1MpAUD2j6l39aymgK7Eb+pr
         9XL23XdtWVP8tZ4/15XgAfPvVlI5HoU2SD+prPYwfHGIL2PGKpm2eQbcZL9s7gC8wZuw
         +4MyvSYbuyPAX81qcIPQkGuoNw5OktqaehPa6Ve49PlWrd024kynRCSkDrGfrT17N8Ji
         GH4byNJ8VWkcQFwgYJGofrKJ2svjJ62SFfb5PjX5KSgMPw2DefXgPUFYJ8JOldcaaxRg
         vUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80KDPeqcmUm1WB/LtZllE+tqBHcDrKxax6N2SNqKDu4=;
        b=sIQochKXDLoGRYeIEGjqDm8D3GWm0lYNwSfh4miKNPYgfmLD4ejDFTjRbtUnkCjpBC
         2xCehwteGqwTOw1FhjDg3i2nZAEPmcSOlFsM07haarJTbDbWoJVd/JuzY1v9fjvp11VG
         elSVTrACgerKlrjp48aS0hlvLeM3g3Ibn5uHb5DAuDofE/U9NgERYB/NGoILp1r+J92w
         YCeSnmhb8A+qDrcpAnTaFa4Qu/jtVEBlhaTMoTdL7zc7uGrQwVcDNIkzB4AgRe+HdZOX
         qk1Z3O5dVOvCmbbLhooNt82LMsRKtNwU6/IHHFEX4EMb0ChPbmJlPfa7uMj2Y0M1TQMS
         85OQ==
X-Gm-Message-State: AOAM532MBEAGfTqL6N7b0Kz8CT2CSAcnNzIkGqOQw7/GY1s1hgb4HifP
        6MrRDO+Qo61mhTYnUe8WDJQncnA+I+YP9sY+/lsjJA==
X-Google-Smtp-Source: ABdhPJy/1F2DKDvrsbbEO0SHPctu+ITTgMZdvtppenQI2OJNoofCK+48ZdhXJ13psVbbOrrcrTkgD++Snn45D4kCcrQ=
X-Received: by 2002:a2e:9047:: with SMTP id n7mr120097ljg.221.1612860972348;
 Tue, 09 Feb 2021 00:56:12 -0800 (PST)
MIME-Version: 1.0
References: <20210128183141.28097-1-valentin.schneider@arm.com>
 <20210128183141.28097-9-valentin.schneider@arm.com> <CAKfTPtDBPREA2oBXZ0=-396Dxh5WMYgNTF+=6d_+K-WVjq3Sag@mail.gmail.com>
 <jhjblcuv2mo.mognet@arm.com>
In-Reply-To: <jhjblcuv2mo.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 9 Feb 2021 09:56:01 +0100
Message-ID: <CAKfTPtB+TEL9SNVYVh_HyT24NefsB4FEPPWk65JHmvR5p_wP0g@mail.gmail.com>
Subject: Re: [PATCH 8/8] sched/fair: Relax task_hot() for misfit tasks
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Feb 2021 at 19:24, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 08/02/21 17:21, Vincent Guittot wrote:
> > On Thu, 28 Jan 2021 at 19:32, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >>
> >> Misfit tasks can and will be preempted by the stopper to migrate them over
> >> to a higher-capacity CPU. However, when runnable but not current misfit
> >> tasks are scanned by the load balancer (i.e. detach_tasks()), the
> >> task_hot() ratelimiting logic may prevent us from enqueuing said task onto
> >> a higher-capacity CPU.
> >>
> >> Align detach_tasks() with the active-balance logic and let it pick a
> >> cache-hot misfit task when the destination CPU can provide a capacity
> >> uplift.
> >>
> >> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> >> ---
> >>  kernel/sched/fair.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index cba9f97d9beb..c2351b87824f 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -7484,6 +7484,17 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
> >>         if (env->sd->flags & SD_SHARE_CPUCAPACITY)
> >>                 return 0;
> >>
> >> +       /*
> >> +        * On a (sane) asymmetric CPU capacity system, the increase in compute
> >> +        * capacity should offset any potential performance hit caused by a
> >> +        * migration.
> >> +        */
> >> +       if (sd_has_asym_cpucapacity(env->sd) &&
> >> +           env->idle != CPU_NOT_IDLE &&
> >> +           !task_fits_capacity(p, capacity_of(env->src_cpu)) &&
> >> +           cpu_capacity_greater(env->dst_cpu, env->src_cpu))
> >
> > Why not using env->migration_type to directly detect that it's a
> > misfit task active migration ?
> >
>
> This is admittedly a kludge. Consider the scenario described in patch 7/8,
> i.e.:
> - there's a misfit task running on a LITTLE CPU
> - a big CPU completes its work and is about to go through newidle_balance()
>
> Now, consider by the time that big CPU gets into load_balance(), the misfit
> task on the LITTLE CPU got preempted by a percpu kworker. As of right now,
> it's quite likely the imbalance won't be classified as group_misfit_task,
> but as group_overloaded (depends on the topology / workload, but that's a
> symptom I've been seeing).

IIRC, we already discussed this. And you should better track that a
misfit task remains on the rq instead of adding a lot of special case
everywhere

>
> Unfortunately, even if we e.g. change the misfit load-balance logic to also
> track preempted misfit tasks (rather than just the rq's current), this
> could still happen AFAICT.
>
> Long story short, we already trigger an active-balance to upmigrate running
> misfit tasks, this changes task_hot() to allow any preempted task that
> doesn't fit on its CPU to be upmigrated (regardless of the imbalance
> classification).
>
> >> +               return 0;
> >> +
> >>         /*
> >>          * Buddy candidates are cache hot:
> >>          */
> >> --
> >> 2.27.0
> >>
