Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5AB35C471
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbhDLKyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbhDLKyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:54:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D00C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:54:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g8so20616546lfv.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XRo5bssRo3/XOxD6r9RHZSv39kKk8qwong4dLDxEyOs=;
        b=pFgLmUSH1fcBkkYI6Fr0B2MWG/Y+A2QqG3L3jgwYzCEQg7i8MKlmktaoafe6ux5F/i
         rN/7bovLjqeWJ4kGdWKmxEDfkyWQnLj573ApF6QqfFNk7VtoL9nAmehfHb5t8SW44Dur
         yggYrfCio56lRiTp/cWWwor+7vA4Ph+SQbX1BnwaGjcNG8xzVDvUDe5ChjEEeOTvkHSz
         tSR/GilZhLeuDNA0nnuqnpQOUxcoF/och/SEq98SHCAH0LX0qg6wihw5O4yYbIcwVsjP
         gIcxuhIEXHCGQGrAIKuwRWRSP9naaQTnqRuE+9ft0GAm1Ni9YDy8qNG3a5UF6Cu7mQu8
         0zKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XRo5bssRo3/XOxD6r9RHZSv39kKk8qwong4dLDxEyOs=;
        b=Pn6lFHmJCkgaL8fX3CugiAm1GJIiLyXp41w9Yt2OeTA10cnWW9HVeI63wcoNURSZ1Z
         GanYtubdPEPNMuaWLO6VMcs/9iGDQ+36FHQqq/RC3okpRwyEjTEQsQj74s90+ctolm/R
         UIekmmPwp6w2x0tcMI1ZvkqKRbHOBYUdUQJjKE89gyW1HKmGOIwmrO/S9SuEod28c/+n
         vh9hoLTZedjzx+rBgDe556aYMpzsURSjY/+POF80Sc/Ck0bCecEc8adtkfU0d56W9yrF
         mRNUs3utxBCQALbBFrsITlOGWny8KOiAjw5bLtwG+ECYxkzQ42tExvt5cpQJDYOvGEiC
         61rQ==
X-Gm-Message-State: AOAM530S3VCsafNAzvO75vnxMGPMbjVPjdRZMUlNQcQFfeohpOM2766G
        VpuItH3q6KUiS6hnP86+ZPkNwQbQWnW2KyidG+0=
X-Google-Smtp-Source: ABdhPJx56CGrkbogjIFWe1a00OtJCz/xMI3r/UgSbiYh5apCKs1rz2ikhxr0TY5j1CQW4VkuYickW2Ts8aqiOOUOBWU=
X-Received: by 2002:a05:6512:3a83:: with SMTP id q3mr19052874lfu.460.1618224844513;
 Mon, 12 Apr 2021 03:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210330052154.26861-1-xuewen.yan94@gmail.com>
 <YGLzQAvVqlrKb8AB@google.com> <34ce11ad-9c20-7ba7-90d8-4830725bf38a@arm.com>
 <CAB8ipk9JATYxJBnpVFfH_XHLqh=yHesbo73wx=Mm7t8mSqW_Gg@mail.gmail.com>
 <1ebddd33-4666-1e6e-7788-a3fe28c9e99c@arm.com> <CAB8ipk9+fdGMY6cYoHnicPUOdd+meJo+EaGaaVZTgoxQ84+Wiw@mail.gmail.com>
 <d85a1db9-4680-1d31-d3e7-6a081f652c5e@arm.com> <CAB8ipk_J-W35+iZqsmAm+VO2=OUXRR3EsW6BuhYmvmBiPcHxMA@mail.gmail.com>
 <d80b7b3e-7eb3-4d0a-99fd-167e14ab86bc@arm.com>
In-Reply-To: <d80b7b3e-7eb3-4d0a-99fd-167e14ab86bc@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Mon, 12 Apr 2021 18:52:52 +0800
Message-ID: <CAB8ipk8RhhBvRq3jUnP2ENfSG_L=LonnVfweymYkQJrZQyA9jQ@mail.gmail.com>
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
>
> Hi,
> > >
> > > This patch-set is not significantly improving the execution time of
> > > feec(). The results we have so far are an improvement of 5-10% in
> > > execution time, with feec() being executed in < 10us. So the gain is =
not
> > > spectacular.
> >
> > well=EF=BC=8C I meaned to cache all util value and compute energy with =
caches,
> > when
> > (cpu=3D=3Ddst_cpu), use caches instead of updating util, and do not get
> > util with function:
> >  "effective_cpu_util()", to compute util with cache.
> > I add more parameters into pd_cache:
> > struct pd_cache {
> >         unsigned long util;
> >         unsigned long util_est;
> >         unsigned long util_cfs;
> >         unsigned long util_irq;
> >         unsigned long util_rt;
> >         unsigned long util_dl;
> >         unsigned long bw_dl;
> >         unsigned long freq_util;
> >         unsigned long nrg_util;
> > };
> > In this way, it can avoid util update while feec. I tested with it,
> > and the negative delta disappeared.
> > Maybe this is not a good method, but it does work.
> If I understand correctly, you put all the fields used by
> core.c:effective_cpu_util() in the caches, allowing to have values not
> subject to updates.
Yes.
> core.c:effective_cpu_util() isn't only called from
> fair.c:compute_energy(). It is used in the cpufreq_schedutil.c and
> cpufreq_cooling.c (through core.c:sched_cpu_util()).
> Did you have to duplicate core.c:effective_cpu_util() to have a second
> version using the caches ? If yes, I think the function was meant to be
> unique so that all the utilization estimations go through the same path.
>
I defined a new function to distinguish it from the effective_cpu_util.

> If your concern is to avoid negative delta, I think just bailing out
> when this happens should be sufficient. As shown in the last message,
> having a wrong placement should not happen that often, plus the prev_cpu
> should be used which should be ok.
In your patch, you didn't actually choose the prev_cpu. you return (-1);

> If you want to cache the values, I think a stronger justification will
> be asked: this seems to be a big modification compared to the initial
> issue, knowing that another simpler solution is available (i.e. bailing
> out). I was not able to prove there was a significant gain in the
> find_energy_efficient_cpu() execution time, but I would be happy if you
> can, or if you find other arguments.
Yes, you are right, perhaps there is indeed no need for such a big modifica=
tion.

Regards
