Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC90C380FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhENSVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbhENSVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:21:40 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C291C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:20:22 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id h202so174115ybg.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdMfTFq+p2AV3NKNFb0bpljlABY/TwfShHFjcvSUVzg=;
        b=dHn86QCPxrUvY85Zj+PW33DwYOe9blB+d2udQfcFv8w9pPd+Hzej+ND5IUhQwtZuqg
         cMOrKJNDRwpk99Y+8FeEjjSMSL/EhHGLx/MWDfeZaAujF6T5zDYK30+l5dYWMx0LMUeW
         VekZb/Uvk1L03y3M3UqYt8gQvm9EAPPTROEYYdTJUhI2xu/nIGNoIXVWLZoVDalfo6Lw
         FA0Qy3IDOHz26sNAAybAR+8mS+Vy410ooDwBfwA3oMLWOecQON4aLYvVnbL0TtnKVFJG
         A+KKNTFk/y+ajft7d7pt8Vs2Qu067QdkpiGBZJPFwdGgEkwqxLigeiGvNX928QxdR489
         1+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdMfTFq+p2AV3NKNFb0bpljlABY/TwfShHFjcvSUVzg=;
        b=nDpN4hlEPmXsaZQAMPKZWBW+EWi3uqVViYEP3yjFhK5AHxwahnK9EZUmtvFmM8TODz
         SSYVgSv0qNIns64L0zIsGByecP04BfidD5MSbRHq7hCLN3OQhiIp+lIlxKkCy+W4mwtX
         JWkUb2mpIB45ubsleQTq8NEjp3bbi5bPtu3JcQwh9cgpYSySopZjadi6Az3Gc9/lcSUZ
         z2vhij25jJogQWIYdoylnPN0Qd8tZ7RRmguYMrQGAZApwiR18/G1eXph3saqBAZ0U1v/
         dL//ql08W1qPrWok3XoSU9UFR1DESe5gVGS7xsKbczDl3GSXn67RD8MMaOxWWlp1eU5S
         2M6Q==
X-Gm-Message-State: AOAM532+njOJRaOnEO2pdD5ndarLUKQ+auHACw9cDhRxzHc1tADbYzNI
        ny+4NlT0eOfkTroAyzrVFiB3VbRcs79Hn2Fo2APg5A==
X-Google-Smtp-Source: ABdhPJwPvGsv0HV3Wu67Frygjs5O+Rf2SflsOq+JYzjjmiIgcxKRdpVWnbyhvcDJgqolZZOW3W3wyrY93l3p36P1clw=
X-Received: by 2002:a5b:7c5:: with SMTP id t5mr63587418ybq.190.1621016421569;
 Fri, 14 May 2021 11:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210513175349.959661-1-surenb@google.com> <YJ5iAvqAmIhzJRot@hirez.programming.kicks-ass.net>
 <CAJuCfpHy+MknCepfjx9XYUA1j42Auauv7MFQbt+zOU-tA4gasA@mail.gmail.com> <YJ64xHoogrowXTok@hirez.programming.kicks-ass.net>
In-Reply-To: <YJ64xHoogrowXTok@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 14 May 2021 11:20:10 -0700
Message-ID: <CAJuCfpGkj9HxbkXnYN58JXJp1j6kVkvQhqscnEfjyB5unKg1NQ@mail.gmail.com>
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

On Fri, May 14, 2021 at 10:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, May 14, 2021 at 08:54:47AM -0700, Suren Baghdasaryan wrote:
>
> > Correct, for this function CONFIG_CGROUPS=n and
> > cgroup_disable=pressure are treated the same. True, from the code it's
> > not very obvious. Do you have some refactoring in mind that would make
> > it more explicit?
>
> Does this make sense?
>
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -744,24 +744,26 @@ static void psi_group_change(struct psi_
>
>  static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
>  {
> +       if (cgroup_psi_enabled()) {
>  #ifdef CONFIG_CGROUPS
> -       struct cgroup *cgroup = NULL;
> +               struct cgroup *cgroup = NULL;
>
> -       if (!*iter)
> -               cgroup = task->cgroups->dfl_cgrp;
> -       else if (*iter == &psi_system)
> -               return NULL;
> -       else
> -               cgroup = cgroup_parent(*iter);
> +               if (!*iter)
> +                       cgroup = task->cgroups->dfl_cgrp;
> +               else if (*iter == &psi_system)
> +                       return NULL;
> +               else
> +                       cgroup = cgroup_parent(*iter);
>
> -       if (cgroup && cgroup_parent(cgroup)) {
> -               *iter = cgroup;
> -               return cgroup_psi(cgroup);
> -       }
> -#else
> -       if (*iter)
> -               return NULL;
> +               if (cgroup && cgroup_parent(cgroup)) {
> +                       *iter = cgroup;
> +                       return cgroup_psi(cgroup);
> +               }
>  #endif
> +       } else {
> +               if (*iter)
> +                       return NULL;
> +       }
>         *iter = &psi_system;
>         return &psi_system;
>  }

Hmm. Looks like the case when cgroup_psi_enabled()==true and
CONFIG_CGROUPS=n would miss the "if (*iter) return NULL;" condition.
Effectively with CONFIG_CGROUPS=n this becomes:

       if (cgroup_psi_enabled()) {           <== assume this is true
#ifdef CONFIG_CGROUPS                <== compiled out
#endif
       } else {
               if (*iter)                                  <== this
statement will never execute
                       return NULL;
       }
       *iter = &psi_system;
        return &psi_system;

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
