Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4A138CFF4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 23:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhEUVfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 17:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhEUVfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 17:35:06 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6822AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:33:42 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s25so25575897ljo.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zyrprtW2QamK4gFOEunR1ZTMhYBbJ3wML0weQ98mhNY=;
        b=MI1rErf9yr8tQWYuoeDd3BajFPCY3TwGaUZR5YKGYwJ+i6HC8gYiR8FB82lpTW8T4D
         4zodJNQmFw7xgiQavKcTmqi2psJXhXXzCJieNv16dPt5UTxyFyEzOzgRNBeHxvdyj1KH
         1ZUp7jqTWNjWmbYBA/VlNWPgb3zzNk8xp5XLnHyHNyLYv8apiJIyspeAN4v81k26b0BD
         7tyf3IjAlfoMjNn0HkLKdWDFwM43AL5G4I4NMU7vz9NjqRdVzEYUJ7SMiJl9Bwz5vfmA
         NKoVe728Pdq8w2cnuo/4kkgAy+KyPPkhvBWz0EZ1K1wULJRjST6XW8JTgmE6eII/HA1N
         v8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyrprtW2QamK4gFOEunR1ZTMhYBbJ3wML0weQ98mhNY=;
        b=DbqhWw5CK8I1WBm8huT1H3ssSUty5xdxhm71Gcz0/vHQ1boVh/RseuxCsYZbwkecKT
         l6ErOcvXGDmjxVvNhOPl9FqkdhHIycv39BXsGleq7Ar7/tjasCAGSkp/+Bl/q4weqepL
         AT8PRsLvXcUUaaPdyAlNqKPBOXeQq+GlQtQLcVaBCTC862Jjfc8BLznA3iYUp6llxjL2
         1n4vyn6ISCy7KCqJa+eHc0uir47H5z2XNjPuAnnAzhbKhy2ExeTd+wUf5eqPyYz7ArT8
         NVRuXlgeOYjdF14ovUtFONbtwo4UO6ejTOyDrii6XF1x37n3aTl++PCoOStU73h2CnXl
         tKfA==
X-Gm-Message-State: AOAM531JLokS470IVZP/thYXPozs2OQ+iItwidFmiTiBSP0mpx47U9YX
        p3IAYnyqQdBagsc6eW2xgyqQ5QvB3Zty2u2xfi0zwQ==
X-Google-Smtp-Source: ABdhPJy2Eu6LAR7rUesSrhVFRu7IO9jL8LQWgwVuaF20M2SfbDBELb+5ks5r4SbdL+qUh8CqRGRoiaq01jPdtDHdbaM=
X-Received: by 2002:a2e:9c91:: with SMTP id x17mr8231363lji.385.1621632820496;
 Fri, 21 May 2021 14:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com> <20210520183614.1227046-5-posk@google.com>
In-Reply-To: <20210520183614.1227046-5-posk@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 21 May 2021 23:33:14 +0200
Message-ID: <CAG48ez3Ur61rpOZduQRFabB9R=RbSin9Th+=0=z9FUpcZ21C=w@mail.gmail.com>
Subject: Re: [RFC PATCH v0.1 4/9] sched/umcg: implement core UMCG API
To:     Peter Oskolkov <posk@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 8:36 PM Peter Oskolkov <posk@google.com> wrote:
> Implement version 1 of core UMCG API (wait/wake/swap).
>
> As has been outlined in
> https://lore.kernel.org/lkml/20200722234538.166697-1-posk@posk.io/,
> efficient and synchronous on-CPU context switching is key
> to enabling two broad use cases: in-process M:N userspace scheduling
> and fast X-process RPCs for security wrappers.
>
> High-level design considerations/approaches used:
> - wait & wake can race with each other;
> - offload as much work as possible to libumcg in tools/lib/umcg,
>   specifically:
>   - most state changes, e.g. RUNNABLE <=> RUNNING, are done in
>     the userspace (libumcg);
>   - retries are offloaded to the userspace.
[...]
> diff --git a/kernel/sched/umcg.c b/kernel/sched/umcg.c
[...]
> +static int get_state(struct umcg_task __user *ut, u32 *state)
> +{
> +       return get_user(*state, (u32 __user *)ut);

Why the cast instead of get_user(*state, &ut->state)?
And maybe do this inline instead of adding a separate helper for it?

> +}
> +
> +static int put_state(struct umcg_task __user *ut, u32 state)
> +{
> +       return put_user(state, (u32 __user *)ut);
> +}
[...]
> +static int do_context_switch(struct task_struct *next)
> +{
> +       struct umcg_task_data *utd = rcu_access_pointer(current->umcg_task_data);
> +
> +       /*
> +        * It is important to set_current_state(TASK_INTERRUPTIBLE) before
> +        * waking @next, as @next may immediately try to wake current back
> +        * (e.g. current is a server, @next is a worker that immediately
> +        * blocks or waits), and this next wakeup must not be lost.
> +        */
> +       set_current_state(TASK_INTERRUPTIBLE);
> +
> +       WRITE_ONCE(utd->in_wait, true);
> +
> +       if (!try_to_wake_up(next, TASK_NORMAL, WF_CURRENT_CPU))
> +               return -EAGAIN;
> +
> +       freezable_schedule();
> +
> +       WRITE_ONCE(utd->in_wait, false);
> +
> +       if (signal_pending(current))
> +               return -EINTR;

What is this -EINTR supposed to tell userspace? We can't tell whether
we were woken up by a signal or by do_context_switch() or the
umcg_wake syscall, right? If we're woken by another thread calling
do_context_switch() and then get a signal immediately afterwards,
can't that lead to a lost wakeup?

I don't know whether trying to track the origin of the wakeup is a
workable approach here; you might have to instead do cmpxchg() on the
->in_wait field and give it three states (default, waiting-for-wake
and successfully-woken)?
Or you give up on trying to figure out who woke you, just always
return zero, and let userspace deal with figuring out whether the
wakeup was real or not. I don't know whether that'd be acceptable.

> +       return 0;
> +}
> +
> +static int do_wait(void)
> +{
> +       struct umcg_task_data *utd = rcu_access_pointer(current->umcg_task_data);
> +
> +       if (!utd)
> +               return -EINVAL;
> +
> +       WRITE_ONCE(utd->in_wait, true);
> +
> +       set_current_state(TASK_INTERRUPTIBLE);
> +       freezable_schedule();
> +
> +       WRITE_ONCE(utd->in_wait, false);
> +
> +       if (signal_pending(current))
> +               return -EINTR;
> +
> +       return 0;
>  }
>
>  /**
> @@ -90,7 +228,23 @@ SYSCALL_DEFINE1(umcg_unregister_task, u32, flags)
>  SYSCALL_DEFINE2(umcg_wait, u32, flags,
>                 const struct __kernel_timespec __user *, timeout)
>  {
> -       return -ENOSYS;
> +       struct umcg_task_data *utd;
> +
> +       if (flags)
> +               return -EINVAL;
> +       if (timeout)
> +               return -EOPNOTSUPP;
> +
> +       rcu_read_lock();
> +       utd = rcu_dereference(current->umcg_task_data);
> +       if (!utd) {
> +               rcu_read_unlock();
> +               return -EINVAL;
> +       }
> +
> +       rcu_read_unlock();

rcu_access_pointer() instead of the locking and unlocking?

> +       return do_wait();
>  }
>
>  /**
> @@ -110,7 +264,39 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags,
>   */
>  SYSCALL_DEFINE2(umcg_wake, u32, flags, u32, next_tid)
>  {
> -       return -ENOSYS;
> +       struct umcg_task_data *next_utd;
> +       struct task_struct *next;
> +       int ret = -EINVAL;
> +
> +       if (!next_tid)
> +               return -EINVAL;
> +       if (flags)
> +               return -EINVAL;
> +
> +       next = find_get_task_by_vpid(next_tid);
> +       if (!next)
> +               return -ESRCH;
> +       rcu_read_lock();

Wouldn't it be more efficient to replace the last 4 lines with the following?

rcu_read_lock();
next = find_task_by_vpid(next_tid);
if (!next) {
  err = -ESRCH;
  goto out;
}

Then you don't need to use refcounting here...

> +       next_utd = rcu_dereference(next->umcg_task_data);
> +       if (!next_utd)
> +               goto out;
> +
> +       if (!READ_ONCE(next_utd->in_wait)) {
> +               ret = -EAGAIN;
> +               goto out;
> +       }
> +
> +       ret = wake_up_process(next);
> +       put_task_struct(next);

... and you'd be able to drop this put_task_struct(), too.

> +       if (ret)
> +               ret = 0;
> +       else
> +               ret = -EAGAIN;
> +
> +out:
> +       rcu_read_unlock();
> +       return ret;
>  }
>
>  /**
> @@ -139,5 +325,44 @@ SYSCALL_DEFINE2(umcg_wake, u32, flags, u32, next_tid)
>  SYSCALL_DEFINE4(umcg_swap, u32, wake_flags, u32, next_tid, u32, wait_flags,
>                 const struct __kernel_timespec __user *, timeout)
>  {
> -       return -ENOSYS;
> +       struct umcg_task_data *curr_utd;
> +       struct umcg_task_data *next_utd;
> +       struct task_struct *next;
> +       int ret = -EINVAL;
> +
> +       rcu_read_lock();
> +       curr_utd = rcu_dereference(current->umcg_task_data);
> +
> +       if (!next_tid || wake_flags || wait_flags || !curr_utd)
> +               goto out;
> +
> +       if (timeout) {
> +               ret = -EOPNOTSUPP;
> +               goto out;
> +       }
> +
> +       next = find_get_task_by_vpid(next_tid);
> +       if (!next) {
> +               ret = -ESRCH;
> +               goto out;
> +       }

There isn't any type of access check here, right? Any task can wake up
any other task? That feels a bit weird to me - and if you want to keep
it as-is, it should probably at least be documented that any task on
the system can send you spurious wakeups if you opt in to umcg.

In contrast, shared futexes can avoid this because they get their
access control implicitly from the VMA.

> +       next_utd = rcu_dereference(next->umcg_task_data);
> +       if (!next_utd) {
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       if (!READ_ONCE(next_utd->in_wait)) {
> +               ret = -EAGAIN;
> +               goto out;
> +       }
> +
> +       rcu_read_unlock();
> +
> +       return do_context_switch(next);

It looks like the refcount of the target task is incremented but never
decremented, so this probably currently leaks references?

I'd maybe try to split do_context_switch() into two parts, one that
does the non-blocking waking of another task and one that does the
sleeping. Then you can avoid taking a reference on the task as above -
this is supposed to be a really hot fastpath, so it's a good idea to
avoid atomic instructions if possible, right?



> +out:
> +       rcu_read_unlock();
> +       return ret;
>  }
