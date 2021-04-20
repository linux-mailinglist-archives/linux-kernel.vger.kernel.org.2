Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18462365C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhDTPpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbhDTPp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:45:28 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC15C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:44:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y4so22023554lfl.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BAPvvtwfIwS2cMONM+8rdChOeN4vzoXdvSyqPwacZ8s=;
        b=nNHda3qLj+q/zArpUIAbHfAd2dJeyQQ68PYyOrtjZ0vd6iJiPHXgCGykBBwT2dWATd
         mixMrQMx79Co+YlpROaAhWDBqAyRQKCVss646HjFmc6ZtkSsRL9xaHYyx7VDHm/WuT/v
         0jv7sfl2xdP3pnJNV91ZLOfT5nD57f2tInKjp53MS9nu5OIe3dYuQemcNrpFArgwDX79
         JcP96snc9n9TsazqWnu3XCU6oIXKJUQ9fVXdW8Tf685Hdy8Zgo2T5KkmS1jJn69wytPY
         sZsmPqqEAu4EG7Qt9zeT9ridIgbCV5D8K/1phoPodwmxkEec1nUixDyLj4VTBwDzlk3C
         Gxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BAPvvtwfIwS2cMONM+8rdChOeN4vzoXdvSyqPwacZ8s=;
        b=Wf8AneyVuRqCoxRl4mpanp15W0pqA6ECs1Hy9/VuUTS+QvSGOXFQnLNYjWH8bvYcbt
         be7G+xNbW2JTl92Vr9OVO6AyXuZFV8jGSylbpwNeC/OlBoZGSyqhgdG3KH4weyjpxMi7
         xMU2zwrfE8MVdSMh30jKpRwXVrgVDAei/lLKXCDfvRsVnogPtz2F7mSTzs3eaKXodqL9
         DsxCLqhvdjw6+3EKhEUEV/tuFgpaM4wkbbAq/TlFhtJuEwsc5UUcvxH9gi9GM2hNpJj+
         PAfgo33KrDtXqdplekzZR9ZdsiBRWYwPuFm2sz5MTXHAdLaZRig4eTHYzJLuoWqe9n5p
         njoA==
X-Gm-Message-State: AOAM533sZZ7XBko13wMhCvFT3Dl5+kEtUE0qKNK3niisRH19QLsHsAYZ
        hPrU/Agd/5iPsp/Pz9c2q9w8eUOED76r5SCOw/skjAgDeq8=
X-Google-Smtp-Source: ABdhPJwoqiJFbaFoHbxVmltIuvzBHdj0powaPx20w1YGv7+c+0r7MtUMX/pylHcQLsZRJ7ErPFnkxjz8AvF/B7n8Mu4=
X-Received: by 2002:a19:4082:: with SMTP id n124mr16639312lfa.154.1618933495630;
 Tue, 20 Apr 2021 08:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210419125134.5cab12ea@imladris.surriel.com> <CAKfTPtDjEMJeoZgE1an9Nh9QZPc2gJetsZHL+8QAWzqX5_znvw@mail.gmail.com>
 <5e21452a727dcd6d3257496a2c42f49bd16e9cb5.camel@surriel.com>
In-Reply-To: <5e21452a727dcd6d3257496a2c42f49bd16e9cb5.camel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 20 Apr 2021 17:44:44 +0200
Message-ID: <CAKfTPtDS-4Y+POk6PWu+B3Tte0qUNDcfU_Cu0KfZErTbrrCFDQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched,fair: skip newidle_balance if a wakeup is pending
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 at 17:20, Rik van Riel <riel@surriel.com> wrote:
>
> On Tue, 2021-04-20 at 11:04 +0200, Vincent Guittot wrote:
> > On Mon, 19 Apr 2021 at 18:51, Rik van Riel <riel@surriel.com> wrote:
> > >
> > > @@ -10688,7 +10697,7 @@ static int newidle_balance(struct rq
> > > *this_rq, struct rq_flags *rf)
> > >         if (this_rq->nr_running != this_rq->cfs.h_nr_running)
> > >                 pulled_task = -1;
> > >
> > > -       if (pulled_task)
> > > +       if (pulled_task || this_rq->ttwu_pending)
> >
> > This needs at least a comment to explain why we must clear
> > this_rq->idle_stamp when this_rq->ttwu_pending is set whereas it is
> > also done during sched_ttwu_pending()
> >
> > >                 this_rq->idle_stamp = 0;
>
> I spent some time staring at sched_ttwu_pending and
> the functions it calls, but I can't seem to spot
> where it clears rq->idle_stamp, except inside
> ttwu_do_wakeup where it will end up adding a
> non-idle period into the rq->avg_idle, which seems
> wrong.

Not sure that this is really wrong because it ends up scheduling the
idle task which is immediately preempted. But the preemption happened
in the idle task, isn't it ?

>
> If we are actually idle, and get woken up with a
> ttwu_queue task, we do not come through newidle_balance,
> and we end up counting the idle time into the avg_idle
> number.
>
> However, if a task is woken up while the CPU is
> in newidle_balance, because prev != idle, we should
> not count that period towards rq->avg_idle, for
> the same reason we do so when we pulled a task.

As mentioned above, we have effectively schedule the idle task in your
case whereas we don't in the other cases

IIUC, your problem comes from rq->avg_idle decreasing a lot in such
cases. And because rq->avg_idle is used to decide if you have time to
run newlyidle_balance,you skip it more often.

>
> I'll add a comment in v3 explaining why idle_stamp
> needs to be 0.

Yes please.

>
> --
> All Rights Reversed.
