Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9FF45B980
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 12:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbhKXLxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 06:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241781AbhKXLxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 06:53:00 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882AEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 03:49:50 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r25so9094317edq.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 03:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+MzWwWx0dm+TlJ+NfteVDSJkTM33adCuaQ734O/0Ww=;
        b=UHprbtG4MERwSddjhYSkRljo/IdkXJ/uSi5jzRf0KubT60an2k/EDxRHtR0CFdErqt
         2Qd6OqYD5p0c99eLWoYgwhZvllhkWWnsS3gm4EQLsseY7lhVH9QFWMzhNMkeJcatfhYq
         8KDmJ3+xxE2FTtU43v2pCmToCIxDZDVA93sTijuUk9ZryZxRgkbjY/Zg5qSymvS7EP6J
         oltlXgEQ+YZk9FrOQBlyY5Mk1IX2w/KmgOB0xoAHMpsuoNUbSHMMokjh9dSadcpdYsc/
         hRTMqoy3LpuxJLqQ19NkS3ET+LsSYFYYCsShNQ6mCx3r3H9YASBu3H6ASGFVVbc9k3OQ
         exVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+MzWwWx0dm+TlJ+NfteVDSJkTM33adCuaQ734O/0Ww=;
        b=THiBG9LcnfsQa+iWcrc5if+bJJu/8oyR2yQP1+obWUzjMWkA5OzarAgn4+9So8d9mO
         DDn6JoG/6S+5ac35eQQ3fOZGbYy8uiJa6oNAJMXr0jGHwTw2fb1smRmmNQxa/i5nO2hy
         RZd9aSDTsMjSOCNXCyNl8udq2D7eRxQPLP5Vw/aN727YHwIf1ZPTdrtD62MT4VhH2ieV
         4RPnn6f6fuSHW3RyOqwKtA79D0rekx43mEPr2B84dozRHHn1XV1XuVe2nKLEolfAebcG
         FF93HCIIIlHe3MZvaYxMNl5aw9Umq7s9nsbqefs2YcewNyWwJZIIiTbVvvJjJ2shIrpk
         tdfQ==
X-Gm-Message-State: AOAM530WWyYc/6nJdvEo+ZuohpZfsv1ief4LIhoadAgukjPnH0jMmGgh
        +83lUw10yYuNdOUP2XkzkD1lmcGJGwp8ElXj+92/C0KJ/CkQGQ==
X-Google-Smtp-Source: ABdhPJz50+ayqkC9PwUfQPDs/F1c9P5unYO9TynVWF7Kek+kEY46C8Vd7syKWRFSF65D77gqApFm+4+9l0MskbPch9Q=
X-Received: by 2002:a17:906:9754:: with SMTP id o20mr13288549ejy.277.1637754589119;
 Wed, 24 Nov 2021 03:49:49 -0800 (PST)
MIME-Version: 1.0
References: <20211124091546.5072-1-21cnbao@gmail.com> <YZ4eWHarf7QDONLB@hirez.programming.kicks-ass.net>
In-Reply-To: <YZ4eWHarf7QDONLB@hirez.programming.kicks-ass.net>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 25 Nov 2021 00:49:37 +1300
Message-ID: <CAGsJ_4xpqvhBW0G5UfCjRD8BfR4m4EUv4B_cxoOtYTO5+iRsCQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Remove the cost of a redundant
 cpumask_next_wrap in select_idle_cpu
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 12:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Nov 24, 2021 at 05:15:46PM +0800, Barry Song wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6e476f6..8cd23f1 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6278,6 +6278,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >               time = cpu_clock(this);
> >       }
> >
> > +     --nr;
> >       for_each_cpu_wrap(cpu, cpus, target + 1) {
> >               if (has_idle_core) {
> >                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > @@ -6285,11 +6286,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >                               return i;
> >
> >               } else {
> > -                     if (!--nr)
> > -                             return -1;
> >                       idle_cpu = __select_idle_cpu(cpu, p);
> >                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
> >                               break;
> > +                     if (!--nr)
> > +                             return -1;
> >               }
> >       }
>
> This way nr can never be 1 for a single iteration -- it current isn't,
> but that's besides the point.

Yep. nr=1 seems to be a corner case.
if nr=1, the original code will return -1 directly without scanning
any cpu. but the new code will scan
one  time because I haven't checked if(!--nr)  and return before
for_each_cpu_wrap(). so this changes
the behaviour for this corner case.

but if i change "--nr" to "nr--", this new code will scan nr  times
rather than nr-1, this changes the behaviour
for all cases besides nr!=1. The original code was looping nr times
but scanning nr-1 times only.

so you prefer here the codes should scan nr times and change the
scanning amount from nr-1
to nr?

Thanks
Barry
