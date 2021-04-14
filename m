Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961D235EAA0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhDNCK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhDNCKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:10:54 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC1FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:10:31 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id l11so1080634vsr.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rqpmVSMeGO85HYhXbbrqjAjjgDBDlXCmgwDZysFf8H8=;
        b=RdORCPpEX/0RF83AbL12/OxNPbXJarx3Ud34+xQeNTgiFTGqcGKeYCW2CneDCwO2Bz
         rvJeA8FX7uU31hBg3B2NKRJkxhDG+A/wzVxMjyyRnYsQgpry2re4Fgu9AEU8mX2xafbG
         I6OvF8RMsH1dctjjmoil7BvwHaRimJdm14cb5NjJS6xENKH6xwUn5bAjaPEpv68ThqWw
         3F6MIQ/DqZ/NLgkYAUjzDN7vppdXbcP0lkVtnbAsF+MiFLaON/hGoy7XmC5tHoePE/Dk
         G2TrbtzicWEZX00Sxq+U+p/qzDAhaRbTZ2uJdD/B0V+zwsx12f6aieZe/J+hvzkim7Wm
         B7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rqpmVSMeGO85HYhXbbrqjAjjgDBDlXCmgwDZysFf8H8=;
        b=bXo44bDHckNSATYqbaPc0zPIdcVJJT6l921TIZxY0gKo8H83ZBZi3kRsW/h7/WVX7a
         vcNQk+bNxvU+OtzrBzjWf+6BuJOjgtqZ8q6NSmfXqTZjkg20M8Crv8q0jMWnKXynOlTl
         Ovr0v/pNUb1jJjktHylD+8NRJYW7URpvHbNl+GMFHiizss/msJOWoc4DQ1bWMDkvQnEx
         FyG+hVe4/TUqdLk+cN8IGzxHG4r7uacpDZiTWJIToqX1mJw8SpvQJllXbiKppxRArjgW
         nd3p79R4+RJxhpO6D8VvB2s/OUkKQxDniRnjNdr1dOrfFHKkJgyMdNeEEBu4SPmWCMNg
         CKBQ==
X-Gm-Message-State: AOAM53116uDibFboHHsRQu4vu5AoZeke0thc2NvyRrH1T0LKVBA2gP/q
        7CcHweTVAP/fKw5mxb1di0NqvPsnTQQvod5Kf/I=
X-Google-Smtp-Source: ABdhPJyuoCoTLUa5as2KmtyQ19vrqLGgEe9aWttUwr+H+o46TCNFOC10lGRXQsXo/rurA+lNwDKvsaLh4/iZvdCRlMQ=
X-Received: by 2002:a67:2c46:: with SMTP id s67mr5067774vss.13.1618366230123;
 Tue, 13 Apr 2021 19:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210413131842.44430-1-qianjun.kernel@gmail.com> <YHWpknBamqQz2rpJ@hirez.programming.kicks-ass.net>
In-Reply-To: <YHWpknBamqQz2rpJ@hirez.programming.kicks-ass.net>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Wed, 14 Apr 2021 10:10:19 +0800
Message-ID: <CAKc596J1eEqYjYy9dnK6VriGU6GE-7be-6Tq4VA5UUhCp3+ZMQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/fair:Reduce unnecessary check preempt in the
 sched tick
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2021=E5=B9=B44=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Apr 13, 2021 at 09:18:42PM +0800, qianjun.kernel@gmail.com wrote:
> > From: jun qian <qianjun.kernel@gmail.com>
> >
> > If it has been determined that the current cpu need resched in the
> > early stage of for_each_sched_entity, then there is no need to check
> > preempt in the subsequent se->parent entity_tick.
>
> Right, but does it actually do anything, except increase linecount?
>
> > Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> > ---
> >  kernel/sched/fair.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1a68a0536add..c0d135100d54 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4352,8 +4352,13 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct=
 sched_entity *curr)
> >  {
> >       unsigned long ideal_runtime, delta_exec;
> >       struct sched_entity *se;
> > +     struct rq *rq =3D rq_of(cfs_rq);
> >       s64 delta;
> >
> > +     /* If the TIF_NEED_RESCHED has been set, it is no need to check a=
gain */
> > +     if (test_tsk_need_resched(rq->curr))
> > +             return;
> > +
> >       ideal_runtime =3D sched_slice(cfs_rq, curr);
> >       delta_exec =3D curr->sum_exec_runtime - curr->prev_sum_exec_runti=
me;
> >       if (delta_exec > ideal_runtime) {
>
> Also, I think that's placed wrong; this way we can mis clear_buddies().

thanks, i will modify it in the next version
