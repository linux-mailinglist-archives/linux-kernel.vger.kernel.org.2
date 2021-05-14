Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F33381002
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhENSvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhENSva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:51:30 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555ADC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:50:18 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i4so336904ybe.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+muSPPrBFQS9BSc0XLvqjbGXmXt1qzS3v/wikaP3SFA=;
        b=cwimqVsxRhMfLl3BUVdKOfBuVUWCAaEwy2N+oSpdJihUEyOv8KKE9wmrwBugETu4Cj
         kAd6i6KkaTWyq3+xAesgB78ZLsomdzHKjUXLyq8QjJWV699jE//SYZ5t+qj9oGmbQb+l
         /n4+uqQtvp119b5o+bzYd/ZXfdyUDJG+tfJgKObJvZlSWmIdFo+ClW8Zq1X1gXgYIiZO
         pvabe/l9/8HvLZVMbg6T53jeQfdupvP/ZLB10YmnZHUQm3ezR7yNEk1WsBfSTKa668k0
         36W1W3jvk4s0ju35RM4z7N7RkN8ipSFlYIkFzc6G1ssd60DJm0j9WY1TXAmzJgNqcTeE
         7m0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+muSPPrBFQS9BSc0XLvqjbGXmXt1qzS3v/wikaP3SFA=;
        b=ngDkO4ZApCdfKTCVnhTSjWLebJhKXjoSS5ALz/mWDBT52iOBtbCeCUkDY+RXCuec6Z
         ++E781LMutjAxhhXdFyS9vVpBSNpjUvH9VAX+5691JxWQ0KdCfRtBI+cKL0sk5Hbt3cI
         64WnhVVayz8U7QMwohjCb6vWPjV1dLHjRMDY2K0zVJhHL0QPCsWsQ6h0XjZnRiOiYcFD
         /ffv5YDD3wNbzd7Ta3VmYi8mPrbJE5/p7NhBPMTsMx3eVhJuYC8KK+hZmj0TQWqws7Dl
         7Pdl8lGo4CF96uA3J9qP4AZl6mBGNkkP5YLEIPQeOAcepQbmVgoiIuk7aV8HlZ3UttF1
         PKiA==
X-Gm-Message-State: AOAM530wWjx39HqKh9mz785tOPhMXPXSWyAWmSqmD9NXTXZmsrW7cb9f
        kzdzvnKSo1dqh4rVso4wfJyZmft5antAM86WYJnz4A==
X-Google-Smtp-Source: ABdhPJwd0ZOJ0DFc9TcGosPgVAj7cAqy5VJcgtZUeB7uah2zixr3YhHvLRDXWA6ib6hjGxoRb2Bd05VAzx+Iyg03QvU=
X-Received: by 2002:a25:bd7:: with SMTP id 206mr4989095ybl.23.1621018217331;
 Fri, 14 May 2021 11:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210513175349.959661-1-surenb@google.com> <YJ5iAvqAmIhzJRot@hirez.programming.kicks-ass.net>
 <CAJuCfpHy+MknCepfjx9XYUA1j42Auauv7MFQbt+zOU-tA4gasA@mail.gmail.com>
 <YJ64xHoogrowXTok@hirez.programming.kicks-ass.net> <CAJuCfpGkj9HxbkXnYN58JXJp1j6kVkvQhqscnEfjyB5unKg1NQ@mail.gmail.com>
In-Reply-To: <CAJuCfpGkj9HxbkXnYN58JXJp1j6kVkvQhqscnEfjyB5unKg1NQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 14 May 2021 11:50:06 -0700
Message-ID: <CAJuCfpH2X47_3VvfZXs_eWhYDziOh13qdUwcfxPJe=Zg_Nkvqw@mail.gmail.com>
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

On Fri, May 14, 2021 at 11:20 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Fri, May 14, 2021 at 10:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, May 14, 2021 at 08:54:47AM -0700, Suren Baghdasaryan wrote:
> >
> > > Correct, for this function CONFIG_CGROUPS=n and
> > > cgroup_disable=pressure are treated the same. True, from the code it's
> > > not very obvious. Do you have some refactoring in mind that would make
> > > it more explicit?
> >
> > Does this make sense?
> >
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -744,24 +744,26 @@ static void psi_group_change(struct psi_
> >
> >  static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
> >  {
> > +       if (cgroup_psi_enabled()) {
> >  #ifdef CONFIG_CGROUPS
> > -       struct cgroup *cgroup = NULL;
> > +               struct cgroup *cgroup = NULL;
> >
> > -       if (!*iter)
> > -               cgroup = task->cgroups->dfl_cgrp;
> > -       else if (*iter == &psi_system)
> > -               return NULL;
> > -       else
> > -               cgroup = cgroup_parent(*iter);
> > +               if (!*iter)
> > +                       cgroup = task->cgroups->dfl_cgrp;
> > +               else if (*iter == &psi_system)
> > +                       return NULL;
> > +               else
> > +                       cgroup = cgroup_parent(*iter);
> >
> > -       if (cgroup && cgroup_parent(cgroup)) {
> > -               *iter = cgroup;
> > -               return cgroup_psi(cgroup);
> > -       }
> > -#else
> > -       if (*iter)
> > -               return NULL;
> > +               if (cgroup && cgroup_parent(cgroup)) {
> > +                       *iter = cgroup;
> > +                       return cgroup_psi(cgroup);
> > +               }
> >  #endif
> > +       } else {
> > +               if (*iter)
> > +                       return NULL;
> > +       }
> >         *iter = &psi_system;
> >         return &psi_system;
> >  }
>
> Hmm. Looks like the case when cgroup_psi_enabled()==true and
> CONFIG_CGROUPS=n would miss the "if (*iter) return NULL;" condition.
> Effectively with CONFIG_CGROUPS=n this becomes:
>
>        if (cgroup_psi_enabled()) {           <== assume this is true
> #ifdef CONFIG_CGROUPS                <== compiled out
> #endif
>        } else {
>                if (*iter)                                  <== this
> statement will never execute
>                        return NULL;
>        }
>        *iter = &psi_system;
>         return &psi_system;
>

Ah, sorry. I forgot that CONFIG_CGROUPS=n would force
cgroup_psi_enabled()==false (the way function is defined in cgroup.h),
so (CONFIG_CGROUPS=n && cgroup_psi_enabled()==true) is an invalid
configuration. I think adding a comment to your suggestion would make
it more clear.
So your suggestion seems to work. I'll test it and include it in the
next revision. Thanks!


> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
