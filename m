Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6493F5982
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhHXH5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbhHXH5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:57:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB13CC061575
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:56:21 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r9so43622247lfn.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=89iz/MxDzahCL/GLnt/CKfUxUo8O84OAzdIjlZFZ7g8=;
        b=Ediay7JYlDULF4x73Qfdhzk+Pjn/fzi0S7luNuZPbEBtOu3A/MjDvSQsUUv1e0VHXV
         ZJ3kw+tqgAIMZTWNw+KP/KWkaeWUVT/vRNYwzVFYQjullmGCneNu6j4w7moz9oaOu7hU
         6TPKS7nY2oRT448p+scmYkY4E49rgq4mYQ8XO4zJJPzMa8VWyPD83KgNzvGYS+k80qSK
         Qv44jdSpaESYxcDOjuouMF0az7qWVtVmhrpftHfDOVWlPAlU5k9+Kcb7mgbUbVWmbbIG
         UqdJHejHgaK17l4QMtJM2ERFeiAwdT/XYU9NyachrpePRarZ5UX+6z2y2+3W4T+ipQdl
         4Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89iz/MxDzahCL/GLnt/CKfUxUo8O84OAzdIjlZFZ7g8=;
        b=VGfzmGH+U6l1FSSfwNPaIHuJvJX/14XcZR6YWXn8ou/EEvH+t26GdVM7H+BYKKIEsp
         olgoftucUVHvZezCqMqF2GwMlW9mIGMGSnPwU056AnisPKxuTJt0Wk/uK55sDrw0LNFp
         pQjVwucukPsFXWFPsgTgo7JWk4JFGfJUto+J0+bOx+0uo1QJzfH0zxDDXZluA6DBbPMv
         NdagEuXsjWjazD2QTs0Hqy35T8eR5alq2ZCRP+TM0Uz7vma1x0IOcUw4vWzhATrO5s0M
         Yobb++Yi+fFp//zATTTHdhrlHG+x0X+tjhj9BpEe1KjaA1evfDcas5pVv1EWEqyVnzQi
         cYuw==
X-Gm-Message-State: AOAM530i0W8OiFWSuk3rFS7cP+cJosxjWhjOo4JdkUk86rd3PRl7vVsZ
        /6JztS5mhyz2IwE1jjTXEoXSe/XZF/b2nL/6C649vw==
X-Google-Smtp-Source: ABdhPJyoVHirq6CcJFwkQEBzUDrKScJ7V8BH/zPmx4u3EL9V1Yxac0gXOMltOX/HG9NAlRotLr4Jl/kyb4QGE0RL6So=
X-Received: by 2002:a05:6512:3385:: with SMTP id h5mr28656817lfg.154.1629791780173;
 Tue, 24 Aug 2021 00:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210820010403.946838-1-joshdon@google.com> <20210820010403.946838-4-joshdon@google.com>
 <CAKfTPtC_uEqP8y9j-Njk2mHJXEqo02PHhM9koAtUTfYbc+KQEA@mail.gmail.com> <CABk29NvEW+aa3ysMOK2J24OHpWpjiAVqjfQ6+T_49V9Dp8T4Hg@mail.gmail.com>
In-Reply-To: <CABk29NvEW+aa3ysMOK2J24OHpWpjiAVqjfQ6+T_49V9Dp8T4Hg@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 24 Aug 2021 09:56:09 +0200
Message-ID: <CAKfTPtDDNgbneGrQ+p8FOKLZ=SqvY59GO+itYwje6MU7xEN9LQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] sched: reduce sched slice for SCHED_IDLE entities
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 at 19:40, Josh Don <joshdon@google.com> wrote:
>
> On Mon, Aug 23, 2021 at 3:08 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Fri, 20 Aug 2021 at 03:04, Josh Don <joshdon@google.com> wrote:
> > >
> > > @@ -684,12 +696,13 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > >         for_each_sched_entity(se) {
> > >                 struct load_weight *load;
> > >                 struct load_weight lw;
> > > +               struct cfs_rq *qcfs_rq;
> > >
> > > -               cfs_rq = cfs_rq_of(se);
> > > -               load = &cfs_rq->load;
> > > +               qcfs_rq = cfs_rq_of(se);
> > > +               load = &qcfs_rq->load;
> > >
> > >                 if (unlikely(!se->on_rq)) {
> > > -                       lw = cfs_rq->load;
> > > +                       lw = qcfs_rq->load;
> > >
> > >                         update_load_add(&lw, se->load.weight);
> > >                         load = &lw;
> > > @@ -697,8 +710,14 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > >                 slice = __calc_delta(slice, se->load.weight, load);
> > >         }
> > >
> > > -       if (sched_feat(BASE_SLICE))
> > > -               slice = max(slice, (u64)sysctl_sched_min_granularity);
> > > +       if (sched_feat(BASE_SLICE)) {
> > > +               if (se_is_idle(init_se) && !sched_idle_cfs_rq(cfs_rq))
> >
> > Like for place_entity, we should probably not dynamically switch
> > between the 2 values below depending on the presence or not of non
> > sched idle tasks and always use sysctl_sched_idle_min_granularity
>
> My reasoning here is that sched_slice is something we reasonably
> expect to change as tasks enqueue/dequeue, and unlike place_entity()
> it does not create fairness issues by messing with vruntime.
> Additionally, it would be preferable to use the larger min granularity
> on a cpu running only idle tasks.

Fair enough

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
