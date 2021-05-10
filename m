Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A0A37935B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhEJQIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhEJQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:07:54 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B68C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:06:49 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e14so14492783ils.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PxqqCer+IeeRJCDgAJrrfihL9cwfN8A17gdEuU6rndo=;
        b=NZB2HAyywpOw1hApX6D0uLR9obHIePdesjgP+pedZ3eDZ6ta14b4yy+yMCI+oYoCzE
         GlkLDmhprJJGZ/qrd4LyKv74BYcG+RxMqdH1l4M/PBiAIrmbLDwwAgUUwrrYrHsM8OdX
         JPCbgbJrAq2WCYECeLFipTZAsE6OmSAond9mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxqqCer+IeeRJCDgAJrrfihL9cwfN8A17gdEuU6rndo=;
        b=G84tHl0uu/s/xR+mHYrvmmuajG/rvEa0sZI/ON/N0mSGo/dq/BJjpN5UsKxRaJZEAj
         k263Y3qtQC/o0lEnqwaAx/Ya+cqO1E0Q/FJk1SfaWuZcYSLTTLzGkMxs0Fg5B6FMiH46
         JW/TIONHzh6ZI9Arh3kkYxuG+2dhxrnQCl4SvapqvnCjuuez/Lo5LMLdW36i+f/dKy9H
         PdkMA3Mk9eH6chF2qXU3jenhNTuC6MEFVCRs/d0tUxUs/VPv44ROcYDLNd5b4VW2XIsQ
         jkvHRBHNMcq3kn+qup0WGqJxdOC6PxO0nmG7ovS7IDoEBc2Rm4t80Mm9+d+QeCzkV8II
         +auw==
X-Gm-Message-State: AOAM531HaCp+FFYFLZ/HXzn7QdHLhdhgK2aper7cB9WBJEPvsalo74to
        Yzx3nmTnahR4Bo7E8lCRT4Hidb2h1VF3crY4SVkLhA==
X-Google-Smtp-Source: ABdhPJwLMfeXcykAspytM/j8lddGRWSVMxS9Vyc2ympHv1gv3+Gku++l3buA/6fYe+uJtazAnb0JWY1X90K/OI133i0=
X-Received: by 2002:a92:6406:: with SMTP id y6mr22339949ilb.262.1620662809161;
 Mon, 10 May 2021 09:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.980003687@infradead.org>
In-Reply-To: <20210422123308.980003687@infradead.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 10 May 2021 12:06:38 -0400
Message-ID: <CAEXW_YTHZF69YHD-r=ST97sagjnxEDy6492nDKaaJtkKMoQN9Q@mail.gmail.com>
Subject: Re: [PATCH 17/19] sched: Inherit task cookie on fork()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Hyser,Chris" <chris.hyser@oracle.com>,
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

Hi Peter,

On Thu, Apr 22, 2021 at 8:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Note that sched_core_fork() is called from under tasklist_lock, and
> not from sched_fork() earlier. This avoids a few races later.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/sched.h     |    2 ++
>  kernel/fork.c             |    3 +++
>  kernel/sched/core_sched.c |    6 ++++++
>  3 files changed, 11 insertions(+)
>
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2172,8 +2172,10 @@ const struct cpumask *sched_trace_rd_spa
>
>  #ifdef CONFIG_SCHED_CORE
>  extern void sched_core_free(struct task_struct *tsk);
> +extern void sched_core_fork(struct task_struct *p);
>  #else
>  static inline void sched_core_free(struct task_struct *tsk) { }
> +static inline void sched_core_fork(struct task_struct *p) { }
>  #endif
>
>  #endif
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2249,6 +2249,8 @@ static __latent_entropy struct task_stru
>
>         klp_copy_process(p);
>
> +       sched_core_fork(p);
> +
>         spin_lock(&current->sighand->siglock);
>
>         /*
> @@ -2336,6 +2338,7 @@ static __latent_entropy struct task_stru
>         return p;
>
>  bad_fork_cancel_cgroup:
> +       sched_core_free(p);
>         spin_unlock(&current->sighand->siglock);
>         write_unlock_irq(&tasklist_lock);
>         cgroup_cancel_fork(p, args);
> --- a/kernel/sched/core_sched.c
> +++ b/kernel/sched/core_sched.c
> @@ -100,6 +100,12 @@ static unsigned long sched_core_clone_co
>         return cookie;
>  }
>
> +void sched_core_fork(struct task_struct *p)
> +{
> +       RB_CLEAR_NODE(&p->core_node);
> +       p->core_cookie = sched_core_clone_cookie(current);

Does this make sense also for !CLONE_THREAD forks?

With earlier versions of core scheduling, we have done the following
on ChromeOS. Basically, if it is a "thread clone", share the cookie
since memory is shared within a process (same address space within a
process). Otherwise, set the cookie to a new unique cookie so that the
new process does not share core with parent initially (since their
address space will be different).

Example Psedu-ocode in sched_fork():

        if (current->core_cookie && (clone_flags & CLONE_THREAD)) {
                    p->core_cookie = clone_cookie(current);
        } else {
                     p->core_cookie = create_new_cookie();
       }

In your version though, I don't see that it always clones the cookie
whether it is a CLONE_THREAD clone or not. Is that correct? I feel
that's a security issue.

-Joel
