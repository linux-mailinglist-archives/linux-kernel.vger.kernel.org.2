Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C5533F0BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 13:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhCQMza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 08:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhCQMzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:55:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C08B64F6C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615985721;
        bh=VTpFVMscC2ZS5zTHGA+3sEixNuJvoOgW/ohm5EunFR4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BZHG/4nYskrmM7mwF/jEsR/7iwgngenLi0ETXs9+owCVvBraukmdINkF+t5HFcEHk
         N78EucWLbWzVnbl32S0bPl06IvxcUTJxpy5YuXAuXgcCojjQ22eIID8skApRQDHv9e
         I47DJ/NSgbGr+hS2Ycgz6eVYSDXFO4/HmbUJumrYPZvylLEpksdKtPWz0KLDXlwJrg
         7w9Vw8Ct/RNxDmpCFw2OUKfDJAHj1FdrYf7sCgPbdetyrSp/KXfidXCgEuXh0yhBBm
         1cLXH5TohllbqO/ox9k1qqQMIiSLNnnwFp2sSmvTp9tLyLyOyFIUmfSdZcQ6O32q6p
         hmds/rptiYAUA==
Received: by mail-ot1-f43.google.com with SMTP id o19-20020a9d22130000b02901bfa5b79e18so1678552ota.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 05:55:21 -0700 (PDT)
X-Gm-Message-State: AOAM532KCh9KmUDOr0fXJCkGnOq83A8k11F5SMZulP8D7RhFekcNmSLJ
        6rMXCEAEicxXYZFhVmBDu3RZL88h0VApdVvSEUs=
X-Google-Smtp-Source: ABdhPJzH1HZyPkwlqXO2eIpV4/fflAUDSNWe1HrwKRyOm6MeY0e41EOpAVoq+hoRI7D2lQtpkup9HgBN1Eyw7xzKMFU=
X-Received: by 2002:a05:6830:14c1:: with SMTP id t1mr3238358otq.305.1615985720417;
 Wed, 17 Mar 2021 05:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <1615949121-70877-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <20210317083947.GD3881262@gmail.com> <20210317084132.GA378908@gmail.com>
In-Reply-To: <20210317084132.GA378908@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 17 Mar 2021 13:55:04 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2qqWV3RGvb4ooiz4LS5GAKL0OHEiVtdgnHAgtmiRDSNA@mail.gmail.com>
Message-ID: <CAK8P3a2qqWV3RGvb4ooiz4LS5GAKL0OHEiVtdgnHAgtmiRDSNA@mail.gmail.com>
Subject: Re: [PATCH] sched: replace if (cond) BUG() with BUG_ON()
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 9:45 AM Ingo Molnar <mingo@kernel.org> wrote:
> * Ingo Molnar <mingo@kernel.org> wrote:
> > * Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:
> >
> > > Fix the following coccicheck warnings:
> > >
> > > ./kernel/sched/core.c:8039:2-5: WARNING: Use BUG_ON instead of if
> > > condition followed by BUG.
> > >
> > > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > > ---
> > >  kernel/sched/core.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 9819121..7392bc0 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -8035,8 +8035,7 @@ void __init sched_init_smp(void)
> > >     mutex_unlock(&sched_domains_mutex);
> > >
> > >     /* Move init over to a non-isolated CPU */
> > > -   if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0)
> > > -           BUG();
> > > +   BUG(set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0);
> >
> > The patch doesn't quite do what the title & changelog claims...
>
> More importantly, we use this pattern when we don't want !CONFIG_BUG
> to remove the 'condition'.
>
> I.e. the "side effect" here is important scheduler logic. It must
> never be optimized out.

This behavior for !CONFIG_BUG has changed a while ago, it is now safe
to rely on the side-effect of the BUG_ON() condition regardless of
CONFIG_BUG. When that option is disabled, running into the condition
just ends up in a "do {} while (1)" loop.

        Arnd
