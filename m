Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC5138800B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244165AbhERS5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244990AbhERS5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:57:30 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A2AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:56:11 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id w1so3379320ybt.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U5LLkV364fFy+W60IIkSO6ynttP+rk35+EuRn6ckGs8=;
        b=cxprohY/XMTUx1TEQw8jbzPmXFucnMNA2eyWUf19LpmAQx4UNLsmqbHDZHdjS/CaGr
         t03JLmDOtp4Xg8I94GL554PMO32h1RtbAqafRiUuHeVq0UM4yvTJUOloXYB06ANBfGoL
         jHHUFpm3nc2I9VvFuOTc16xcLvyF/tSSQeTmyKXCLvcacBJg/QcxMiYoGjz3FPLCq2i4
         yYN8KkaSHTDa9C4UeiuwVYyH/i+SWrdUN9pY85oTs04kt0M7iKY9mN+soWEbt1EI4dpk
         edMxfCj+tyiAfv6N8heO33kP/Uy2yt6kyaDwkgF3bgtxtw/079Q1Rsuq/cikCVm577W8
         /QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5LLkV364fFy+W60IIkSO6ynttP+rk35+EuRn6ckGs8=;
        b=Zb4Gm1Vsyhsv/xdWuyjHcqVrXjZ0SsWEYxsfnvS9qUr28+J7e/PdAIHvPSIeeUh9Gv
         aJbjDagdKQqfoptp4Ltk57I0t/svr+5rCTWAcRhOnatejI1R60Xf7dlTYgmVRIrOiSYh
         9KdayhTw368tBF/DF6M0Bt9SrJnIm+OZ/B0ypwclVA48Ftz2qeyJE6O4xmtAKwz5D15V
         S6WsWrbXNVN8KPLDhckjGk3c3IiyIWtQdTQCoZyrOx5UUs94uZCtxlkjSsPQgvJS4JW/
         SZ58XJD4tu65J9qWDG/AnXy3syQyzTgR3nlTGtBBnYJYW1pqtVaeL9yitpHe7G8oyBnI
         wQ6g==
X-Gm-Message-State: AOAM531+DqgNcsg7rXYMoBE9MLenjcS8VI2sP0Bwp+lDgezvB4vMrYxO
        nniXhKg16uRAhSFDTwm4PjpIj4wpIwuyMDXv1BTK7g==
X-Google-Smtp-Source: ABdhPJw+r9Vs8W/wHNhLBVF/L2/v9zN6CWY6uzHU1K20kYiRC4gsip28a5tC3+Qqg8OJDi8hfcKE77la5Q0Nvw9ThKI=
X-Received: by 2002:a25:7ec4:: with SMTP id z187mr9138416ybc.136.1621364170924;
 Tue, 18 May 2021 11:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210518020200.1790058-1-surenb@google.com> <20210518185251.GI5618@worktop.programming.kicks-ass.net>
In-Reply-To: <20210518185251.GI5618@worktop.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 18 May 2021 11:55:59 -0700
Message-ID: <CAJuCfpFVEmYdnqDz+-txLtxM3OhLTyQUJPPP-jLq1YPg0fZ_dA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] cgroup: make per-cgroup pressure stall tracking configurable
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, macro@orcam.me.uk,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 11:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, May 17, 2021 at 07:02:00PM -0700, Suren Baghdasaryan wrote:
>
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index cc25a3cff41f..4b8e72640ac9 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -148,6 +148,7 @@
> >  static int psi_bug __read_mostly;
> >
> >  DEFINE_STATIC_KEY_FALSE(psi_disabled);
> > +DEFINE_STATIC_KEY_FALSE(psi_cgroups_disabled);
>
> I'm thinking the whole thing will be easier/clearer when you make this:
>
> DEFINE_STATIC_KEY_TRUE(psi_cgroups_enabled);
>

Sounds good. Will respin another version. Thanks for reviewing!


> >
> >  #ifdef CONFIG_PSI_DEFAULT_DISABLED
> >  static bool psi_enable;
> > @@ -211,6 +212,9 @@ void __init psi_init(void)
> >               return;
> >       }
> >
> > +     if (!cgroup_psi_enabled())
> > +             static_branch_enable(&psi_cgroups_disabled);
>
>         if (!cgroup_psi_enabled())
>                 static_branch_disable(&psi_cgroups_enabled);
>
> > +
> >       psi_period = jiffies_to_nsecs(PSI_FREQ);
> >       group_init(&psi_system);
> >  }
> > @@ -744,23 +748,23 @@ static void psi_group_change(struct psi_group *group, int cpu,
> >
> >  static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
> >  {
> > +     if (*iter == &psi_system)
> > +             return NULL;
> > +
> >  #ifdef CONFIG_CGROUPS
> > +     if (!static_branch_likely(&psi_cgroups_disabled)) {
>
>         if (static_branch_likely(&psi_cgroups_enabled)) {
>
> > +             struct cgroup *cgroup = NULL;
> >
> > +             if (!*iter)
> > +                     cgroup = task->cgroups->dfl_cgrp;
> > +             else
> > +                     cgroup = cgroup_parent(*iter);
> >
> > +             if (cgroup && cgroup_parent(cgroup)) {
> > +                     *iter = cgroup;
> > +                     return cgroup_psi(cgroup);
> > +             }
> >       }
> >  #endif
> >       *iter = &psi_system;
> >       return &psi_system;
>
> But yes, very nice.
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
