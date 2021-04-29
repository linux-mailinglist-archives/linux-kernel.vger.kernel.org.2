Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F2936F139
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbhD2Ukz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 16:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbhD2Ukx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 16:40:53 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19363C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 13:40:06 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id z2so31638071qkb.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 13:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFb15ZMjaV6JQrUKpgKUzgMYCYW0ui4LjECZptZ36oM=;
        b=Fdw56/aBYilSisy70jltjWIgerhxu2sQGHPZm1B+Uvk6Ysq6ZyvqYeqLk1c7LsbCl0
         wBKKosYF2cBWq/sB/ZENX9wPVuojKrqreX6IausIfjQQsr9LW3hFzywu8XG3MYUjhxCY
         RP23cri+uNPqWQwdOeI8KJaI0OuftG2VG7PKCWhqIEXC07cFDIxDAJW6ABruxwRp4q33
         immAU+4R+sprvMh6lAHoUblb/JrvCgLKZlCWL1e/4iDYtGRu10CVf8mbsB18gNW2I0h/
         JumMTpP9dnl9zWWlLlnj5A67qCbw5JGtB3M01NV0IYr6myjbO0JnoGq/iaN8VXbZ8VKG
         ZOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFb15ZMjaV6JQrUKpgKUzgMYCYW0ui4LjECZptZ36oM=;
        b=RWws+CJL7qgObPmtdien2iI20a9QwQOkEYL8YkTjuUgWjyYpAFjdbJI8sTFGrvBTcQ
         2rBFMVon0C3sfaIyfguc5OLh+g5oHJUMsyyRbz3SV1PJrBgrxedsKMfFn/EoNPpicyPZ
         PSLMTQRQQ+XQ5FwD5f/csuqDsC5rMw8LxJtJPbs8OlBWlGTP4XoztEClmFaawHINXGYb
         cPo0YEBDg6DKTgQkGkU74gpE3lW8YyjZlEWs8B/TvbYpjaFCUEcnsUGFDwEKvRh67fA8
         wq62uVsRgfC0gV0phdLYU0H7Yt5XqRrpNjlhvd5TWNg0vtRJ+P650RheC0Scmqshbi2A
         A03A==
X-Gm-Message-State: AOAM5300PWIwdKOOS5Yz/PIm5VyWfCX+vEHGGTu0ZiTXyiVnbe/EAkpZ
        ymOz0pdGlbIym3DWjsc8Ax+3f/W4J5QhaboAacaV2A==
X-Google-Smtp-Source: ABdhPJwwCIS/YiCixgJ+N0X8LKladOHybcdVNsajPx8KTPexm8GMxWCBBjm/qvHdEbCmAIDiM2Kvqo6sPoFvvQ4ts9Y=
X-Received: by 2002:a37:a788:: with SMTP id q130mr1608535qke.276.1619728804981;
 Thu, 29 Apr 2021 13:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CAERHkrsC9rC4Jrkz8r-7kp4SFPM6aU+EHN+Y+uQiTuPG5S72bA@mail.gmail.com>
In-Reply-To: <CAERHkrsC9rC4Jrkz8r-7kp4SFPM6aU+EHN+Y+uQiTuPG5S72bA@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 29 Apr 2021 13:39:54 -0700
Message-ID: <CABk29NuS-B3n4sbmavo0NDA1OCCsz6Zf2VDjjFQvAxBMQoJ_Lg@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Hiatt <dhiatt@digitalocean.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 1:03 AM Aubrey Li <aubrey.intel@gmail.com> wrote:
>
> On Thu, Apr 22, 2021 at 8:39 PM Peter Zijlstra <peterz@infradead.org> wrote:
> ----snip----
> > @@ -199,6 +224,25 @@ void raw_spin_rq_unlock(struct rq *rq)
> >         raw_spin_unlock(rq_lockp(rq));
> >  }
> >
> > +#ifdef CONFIG_SMP
> > +/*
> > + * double_rq_lock - safely lock two runqueues
> > + */
> > +void double_rq_lock(struct rq *rq1, struct rq *rq2)
> > +{
> > +       lockdep_assert_irqs_disabled();
> > +
> > +       if (rq1->cpu > rq2->cpu)
>
> It's still a bit hard for me to digest this function, I guess using (rq->cpu)
> can't guarantee the sequence of locking when coresched is enabled.
>
> - cpu1 and cpu7 shares lockA
> - cpu2 and cpu8 shares lockB
>
> double_rq_lock(1,8) leads to lock(A) and lock(B)
> double_rq_lock(7,2) leads to lock(B) and lock(A)
>
> change to below to avoid ABBA?
> +       if (__rq_lockp(rq1) > __rq_lockp(rq2))
>
> Please correct me if I was wrong.

Great catch Aubrey. This is possibly what is causing the lockups that
Don is seeing.

The proposed usage of __rq_lockp() is prone to race with sched core
being enabled/disabled. It also won't order properly if we do
double_rq_lock(smt0, smt1) vs double_rq_lock(smt1, smt0), since these
would have equivalent __rq_lockp(). I'd propose an alternative but
similar idea: order by core, then break ties by ordering on cpu.

+#ifdef CONFIG_SCHED_CORE
+       if (rq1->core->cpu > rq2->core->cpu)
+               swap(rq1, rq2);
+       else if (rq1->core->cpu == rq2->core->cpu && rq1->cpu > rq2->cpu)
+               swap(rq1, rq2);
+#else
        if (rq1->cpu > rq2->cpu)
                swap(rq1, rq2);
+#endif
