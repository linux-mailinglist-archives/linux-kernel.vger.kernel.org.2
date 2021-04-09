Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E79E3591EB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhDICWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhDICWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:22:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408B3C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 19:22:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r9so6219158ejj.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 19:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tihn+691p7iWK//izJ5iKcTFaKEbda2SvpleteY067A=;
        b=gfbpt+fCTC2llTG8KgbmsKCtpLnOoUOAivy4mzCkmYtqw2y8iEkP8+uOqCjGsJHmhO
         jSA/4bjQUCSdmGJvbrPmkYIsxM05wr2nmEZpPHPgcGuo4m70wBLcszov3I7NabpLq5VU
         v4QiKVSPNXyMGtQLBDMd9mqmrPshQsBuwZbXEjyY7XJxRveDzeUpHYE9+IJ8pIYXRVH+
         tmBddYbvFzUzQqUM5IAUPFQNVLmM8WDxBqbr5OuCymYBXkCITmHwe8gqrvob8TTHVJHC
         yZdHwnY58zrrhL3CP778Q9TEX/zULPKIAvUFuI7Lw96mFSFuyFKLi4V/7auJbOPT1IuV
         IQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tihn+691p7iWK//izJ5iKcTFaKEbda2SvpleteY067A=;
        b=rlgA+bn//KDu+GlnFlTfLfvKR84eyVhzt26PpPXwZWzgJYPlNhtrRvFby/DHOKL1k4
         G1+cC1bv4s16sQf4UCYDSZ8xc8iP8j3cE0MUwe8RSiRzP8zJOKBTmmy+uQasyDQ2soYf
         Zeh9OZMsbTTxy5QDUJEP6XvKSXsH0BAf+1mRTcxwLmY+ITi35bkixUsVx5HrmVkiPQkF
         BtRMxtfJ+8MQxwZLp6q9DWlpzZblKTw549/qPsrHmWcJgd9zXTg8/7WDXn65J/KzHprs
         B0TZury6svqr2EhybkGQoOH7MgYQgo/3BWw2ZCO79RphFPRo536RfEpq0ODYE8k1bE8a
         7kxA==
X-Gm-Message-State: AOAM531dwFJUWM+nK+Fcmkg4PH0ls8dgKlzGY3m26QaR5DMnQzUI6Z2O
        tzBUvmqz70Y04SF1kTqfPylduvF0E0RvlaCvFji01rIu5mg=
X-Google-Smtp-Source: ABdhPJywuvwzT6E0mGE+ospgnfd+yL2cK+m5CNEokcsNlOnCpYojvVt3IjHuDjdAnG/lg5Bis0tLE6+KGBX5AADEoIo=
X-Received: by 2002:a17:906:590b:: with SMTP id h11mr14034374ejq.437.1617934923888;
 Thu, 08 Apr 2021 19:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210330052154.26861-1-xuewen.yan94@gmail.com>
 <YGLzQAvVqlrKb8AB@google.com> <34ce11ad-9c20-7ba7-90d8-4830725bf38a@arm.com>
 <CAB8ipk9JATYxJBnpVFfH_XHLqh=yHesbo73wx=Mm7t8mSqW_Gg@mail.gmail.com>
 <1ebddd33-4666-1e6e-7788-a3fe28c9e99c@arm.com> <CAB8ipk9+fdGMY6cYoHnicPUOdd+meJo+EaGaaVZTgoxQ84+Wiw@mail.gmail.com>
 <d85a1db9-4680-1d31-d3e7-6a081f652c5e@arm.com>
In-Reply-To: <d85a1db9-4680-1d31-d3e7-6a081f652c5e@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Fri, 9 Apr 2021 10:20:52 +0800
Message-ID: <CAB8ipk_J-W35+iZqsmAm+VO2=OUXRR3EsW6BuhYmvmBiPcHxMA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: use signed long when compute energy delta in eas
To:     Pierre <pierre.gondois@arm.com>
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
>
> Hi,
> > Hi
> >
> > On Wed, Apr 7, 2021 at 10:11 PM Pierre <pierre.gondois@arm.com> wrote:
> > >
> > > Hi,
> > > > I test the patch, but the overflow still exists.
> > > > In the "sched/fair: Use pd_cache to speed up
> > find_energy_efficient_cpu()"
> > > > I wonder why recompute the cpu util when cpu=3D=3Ddst_cpu in
> > compute_energy(),
> > > > when the dst_cpu's util change, it also would cause the overflow.
> > >
> > > The patches aim to cache the energy values for the CPUs whose
> > > utilization is not modified (so we don't have to compute it multiple
> > > times). The values cached are the 'base values' of the CPUs, i.e. whe=
n
> > > the task is not placed on the CPU. When (cpu=3D=3Ddst_cpu) in
> > > compute_energy(), it means the energy values need to be updated inste=
ad
> > > of using the cached ones.
> > >
> > well, is it better to use the task_util(p) + cache values ? but in
> > this case, the cache
> > values may need more parameters.
>
> This patch-set is not significantly improving the execution time of
> feec(). The results we have so far are an improvement of 5-10% in
> execution time, with feec() being executed in < 10us. So the gain is not
> spectacular.

well=EF=BC=8C I meaned to cache all util value and compute energy with cach=
es, when
(cpu=3D=3Ddst_cpu), use caches instead of updating util, and do not get
util with function:
 "effective_cpu_util()", to compute util with cache.
I add more parameters into pd_cache:
struct pd_cache {
        unsigned long util;
        unsigned long util_est;
        unsigned long util_cfs;
        unsigned long util_irq;
        unsigned long util_rt;
        unsigned long util_dl;
        unsigned long bw_dl;
        unsigned long freq_util;
        unsigned long nrg_util;
};
In this way, it can avoid util update while feec. I tested with it,
and the negative delta disappeared.
Maybe this is not a good method, but it does work.
>
> >
> > > You are right, there is still a possibility to have a negative delta
> > > with the patches at:
> > >
> > https://gitlab.arm.com/linux-arm/linux-power/-/commits/eas/next/integra=
tion-20210129
> > <https://gitlab.arm.com/linux-arm/linux-power/-/commits/eas/next/integr=
ation-20210129>
> > > Adding a check before subtracting the values, and bailing out in such
> > > case would avoid this, such as at:
> > > https://gitlab.arm.com/linux-arm/linux-pg/-/commits/feec_bail_out/
> > <https://gitlab.arm.com/linux-arm/linux-pg/-/commits/feec_bail_out/>
> > >
> > In your patch, you bail out the case by "go to fail", that means you
> > don't use eas in such
> > case. However, in the actual scene, the case often occurr when select
> > cpu for small task.
> > As a result, the small task would not select cpu according to the eas,
> > it may affect
> > power consumption?
> With this patch (bailing out), the percentage of feec() returning due to
> a negative delta I get are:
> on a Juno-r2, with 2 big CPUs and 4 CPUs (capacity of 383), with a
> workload running during 5s with task having a period of 16 ms and:
>   - 50 tasks at 1%:   0.14%
>   - 30 tasks at 1%:   0.54%
>   - 10 tasks at 1%: < 0.1%
>   - 30 tasks at 5%: < 0.1%
>   - 10 tasks at 5%: < 0.1%
> It doesn't happen so often to me.If we bail out of feec(), the task will
> still have another opportunity in the next call. However I agree this
> can lead to a bad placement when this happens.
> >
> > > I think a similar modification should be done in your patch. Even tho=
ugh
> > > this is a good idea to group the calls to compute_energy() to reduce =
the
> > > chances of having updates of utilization values in between the
> > > compute_energy() calls,
> > > there is still a chance to have updates. I think it happened when I
> > > applied your patch.
> > >
> > > About changing the delta(s) from 'unsigned long' to 'long', I am not
> > > sure of the meaning of having a negative delta. I thing it would be
> > > better to check and fail before it happens instead.
> > >
> > > Regards
> > >
>
>
>
