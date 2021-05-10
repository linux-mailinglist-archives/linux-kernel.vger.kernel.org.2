Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C48237988E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 22:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhEJUsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 16:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhEJUsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 16:48:41 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08A2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 13:47:35 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id t3so16068036iol.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 13:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qQO1I07DMUA2ozNfw150ZG43CjyUr39oncrSVvx3JRA=;
        b=uRSkmMzk8v98p7JUBTJJtu5rYKy6Eui0g5HyjR5aENmJxxqn3bv4I4FA1XPhzah2Sp
         9z855hZcMBnct23upcD0FqUQZZilkVLzY5tbNTWrki4bxEzwqfvxYbvVFWdkPPgsosQa
         zU9L8IG4ZlhAxUv6FI0fyzPsqljMWOn/FtOvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qQO1I07DMUA2ozNfw150ZG43CjyUr39oncrSVvx3JRA=;
        b=Hh7zRL260Q/8SooP8P1dN5RX3Jc+PwYzZhbcJA4mtX9g5zqCMLnE13quLxjFjd+7T9
         dWTYwxEJ1X2BLAGyZ7H1FOfuUZiVXGGBjQ1i2lK4B7P2+vKF0r4r7/9zwWY/7olY6vkK
         9QcrQEhg49aQZ/uozMPoolEAbZzzd6TcKJmYwOKxa9V/OXOt7nJaesrIoQrUaOc1Cpnp
         F4N5GI590xdYOP6THzO+tM9l8l5L1uWMl9OaBONOo32D3Xldr2m4RG4PpmT4zhhqMnol
         qwEtNz9B0ZFHmqUAUt9nVJQs7TE7iB4y03GbD+7fGP69Pl5MKLq8byYQ5t1BF4+n4HgR
         EHyg==
X-Gm-Message-State: AOAM533GxJ8jkKRpnj3erpeQ7ZkVTPZwnyMuwc25Z6D7m9oGyPqlQW4y
        6tuSYuYfvVlGc3H40yZvYV4EKciAQpJsZ6RhkcDPpQ==
X-Google-Smtp-Source: ABdhPJzS5xWgsqeiR9hnMdRmCiR+QuIfYiJhQCq38RqFExorFcjwl2gPeVfV+LMmfTnpynVasGc2WQhsJpShD9qXUWM=
X-Received: by 2002:a5d:9959:: with SMTP id v25mr19528371ios.85.1620679655191;
 Mon, 10 May 2021 13:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.980003687@infradead.org>
 <CAEXW_YTHZF69YHD-r=ST97sagjnxEDy6492nDKaaJtkKMoQN9Q@mail.gmail.com> <3dbce4ff-44ed-73ca-2ea1-97b126dd664e@oracle.com>
In-Reply-To: <3dbce4ff-44ed-73ca-2ea1-97b126dd664e@oracle.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 10 May 2021 16:47:24 -0400
Message-ID: <CAEXW_YSX79vR9hdkjKcf08uZk85xhC8nOnesf8s6Cvp2kqKoFA@mail.gmail.com>
Subject: Re: [PATCH 17/19] sched: Inherit task cookie on fork()
To:     Chris Hyser <chris.hyser@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 12:23 PM Chris Hyser <chris.hyser@oracle.com> wrote:
>
> On 5/10/21 12:06 PM, Joel Fernandes wrote:
> > Hi Peter,
> >
> > On Thu, Apr 22, 2021 at 8:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> Note that sched_core_fork() is called from under tasklist_lock, and
> >> not from sched_fork() earlier. This avoids a few races later.
> >>
> >> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >> ---
> >>   include/linux/sched.h     |    2 ++
> >>   kernel/fork.c             |    3 +++
> >>   kernel/sched/core_sched.c |    6 ++++++
> >>   3 files changed, 11 insertions(+)
> >>
> >> --- a/include/linux/sched.h
> >> +++ b/include/linux/sched.h
> >> @@ -2172,8 +2172,10 @@ const struct cpumask *sched_trace_rd_spa
> >>
> >>   #ifdef CONFIG_SCHED_CORE
> >>   extern void sched_core_free(struct task_struct *tsk);
> >> +extern void sched_core_fork(struct task_struct *p);
> >>   #else
> >>   static inline void sched_core_free(struct task_struct *tsk) { }
> >> +static inline void sched_core_fork(struct task_struct *p) { }
> >>   #endif
> >>
> >>   #endif
> >> --- a/kernel/fork.c
> >> +++ b/kernel/fork.c
> >> @@ -2249,6 +2249,8 @@ static __latent_entropy struct task_stru
> >>
> >>          klp_copy_process(p);
> >>
> >> +       sched_core_fork(p);
> >> +
> >>          spin_lock(&current->sighand->siglock);
> >>
> >>          /*
> >> @@ -2336,6 +2338,7 @@ static __latent_entropy struct task_stru
> >>          return p;
> >>
> >>   bad_fork_cancel_cgroup:
> >> +       sched_core_free(p);
> >>          spin_unlock(&current->sighand->siglock);
> >>          write_unlock_irq(&tasklist_lock);
> >>          cgroup_cancel_fork(p, args);
> >> --- a/kernel/sched/core_sched.c
> >> +++ b/kernel/sched/core_sched.c
> >> @@ -100,6 +100,12 @@ static unsigned long sched_core_clone_co
> >>          return cookie;
> >>   }
> >>
> >> +void sched_core_fork(struct task_struct *p)
> >> +{
> >> +       RB_CLEAR_NODE(&p->core_node);
> >> +       p->core_cookie = sched_core_clone_cookie(current);
> >
> > Does this make sense also for !CLONE_THREAD forks?
>
> Yes. Given the absence of a cgroup interface, fork inheritance (clone the cookie) is the best way to create shared
> cookie hierarchies. The security issue you mentioned was handled in my original code by setting a unique cookie on
> 'exec', but Peter took that out for the reason mentioned above. It was part of the "lets get this in compromise" effort.

Thanks for sharing the history of it. I guess one can argue that this
policy is better to be hardcoded in userspace since core-scheduling
can be used for non-security usecases as well. Maybe one could simply
call the prctl(2) from userspace if they so desire, before calling
exec() ?

- Joel
