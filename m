Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6F3380DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbhENP4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbhENP4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:56:11 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF764C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:54:58 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id r8so39424550ybb.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y052LogTUvmTYDDB+WfKoZ5F+9wGSH/Xp6XYfMNjiT0=;
        b=rmOj1JlGNHpx+uPiVKXp2GXMWFkLj/A2WtlyaZyD5pZFxwhlsqd9zu0CmNdx2nQKz3
         hyKBSMJEwq4rkRa1IKAxZNhcGDAR+T6fks73i5T1b7VEfpOp/gDb2G/+5nFgGIONK+KE
         5WTx5ufZ/30+cWeOlNLTJcwxWCkVh7nMAyWjrV77SCuEV9Vv+/qhYpaSzCD2TSPjXpbE
         pthBuekUFWiKhmAdMmrAYeNIhk//NcnHznalrkjl4A1UoLj5Q/zs2/74f2tVtHRtlnn6
         LkS6QSRN4TUGoxGxletRTqpWwfMbv6aWju2Cxk02zuImCHGjcle6K1d3PDeirZ5+JyYO
         DsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y052LogTUvmTYDDB+WfKoZ5F+9wGSH/Xp6XYfMNjiT0=;
        b=ehTWels+5fa+RziFPhxPhKaTuGrWFg0BTHF5Ev4A9usK3PHSyaY5eWmkInxhLWuTXi
         ujr+HFeKqtMdN/Q0faZDLb1cb8qmiTvS3AAv8SK4Xn8jA6gR4HXY/k9DiofwQQ0Csmcp
         +MAiqjivA40ZUI6U4AdR8e6iOkThlzdmt0Z38bRVmw4M/beMDblpEbD+McdrTsZExpCE
         lthPSl0NE2XOpIjNgyrf/RNlqLhpzLyKdDa2o6G07Ff7SVEOK9yUSQrXRcuEV9Ra2394
         4LVbL/syuY8uHvRZGg5heLiwqb5EP0tF9lK1ijtEDC62u9tk7fcw1HspJlGfP/aNWrtl
         u9kg==
X-Gm-Message-State: AOAM5303oleIkMoYqrblFOr4uLCw7WkodVUsgVUsSFE72k+dATsLmij8
        qBXADXWlYPg3YDk6rh8DspfVyIG75TelGYGEY4Dl1g==
X-Google-Smtp-Source: ABdhPJyu519H1CbTJd0D9J/Ujh2yRd7lt7a0n437lQGd0MJ3hccYmkjEelSz6fIq59LX12MQeRNDwQiSuC0eJZFEAvs=
X-Received: by 2002:a5b:7c5:: with SMTP id t5mr62727703ybq.190.1621007697955;
 Fri, 14 May 2021 08:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210513175349.959661-1-surenb@google.com> <YJ5iAvqAmIhzJRot@hirez.programming.kicks-ass.net>
In-Reply-To: <YJ5iAvqAmIhzJRot@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 14 May 2021 08:54:47 -0700
Message-ID: <CAJuCfpHy+MknCepfjx9XYUA1j42Auauv7MFQbt+zOU-tA4gasA@mail.gmail.com>
Subject: Re: [PATCH 1/1] cgroup: make per-cgroup pressure stall tracking configurable
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        lizefan.x@bytedance.com, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        Minchan Kim <minchan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, bristot@redhat.com,
        "Paul E . McKenney" <paulmck@kernel.org>, rdunlap@infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, macro@orcam.me.uk,
        Viresh Kumar <viresh.kumar@linaro.org>,
        mike.kravetz@oracle.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 4:42 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, May 13, 2021 at 10:53:49AM -0700, Suren Baghdasaryan wrote:
>
> > +bool cgroup_psi_enabled(void)
> > +{
> > +     return (cgroup_feature_disable_mask & (1 << OPT_FEATURE_PRESSURE)) == 0;
> > +}
>
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index cc25a3cff41f..c73efd7d4fba 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -747,9 +747,12 @@ static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
> >  #ifdef CONFIG_CGROUPS
> >       struct cgroup *cgroup = NULL;
> >
> > -     if (!*iter)
> > +     if (!*iter) {
> > +             /* Skip to psi_system if per-cgroup accounting is disabled */
> > +             if (!cgroup_psi_enabled())
> > +                     goto update_sys;
> >               cgroup = task->cgroups->dfl_cgrp;
> > -     else if (*iter == &psi_system)
> > +     } else if (*iter == &psi_system)
> >               return NULL;
> >       else
> >               cgroup = cgroup_parent(*iter);
> > @@ -758,6 +761,7 @@ static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
> >               *iter = cgroup;
> >               return cgroup_psi(cgroup);
> >       }
> > +update_sys:
> >  #else
> >       if (*iter)
> >               return NULL;
>
> I'm confused; shouldn't that do the same as that #else branch?

Correct, for this function CONFIG_CGROUPS=n and
cgroup_disable=pressure are treated the same. True, from the code it's
not very obvious. Do you have some refactoring in mind that would make
it more explicit?

>Also, can you pretty please make cgroup_psi_enabled() a static_key ?

Certainly, will post an update on Monday.
Thanks for the feedback, Peter!

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
