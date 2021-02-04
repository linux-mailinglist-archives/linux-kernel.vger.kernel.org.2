Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAF630F381
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhBDMyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbhBDMyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:54:53 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F398C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 04:54:12 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id a7so3068721qkb.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0F1TBkXpMX0IucoBuNA8ldZVsBCuebezx1/Z88WfEdk=;
        b=QG5kXWr7nX50l4I2Y7bPaLQ22JCOcj5PYP6YBUlhFer9V7SrrzFGzAKFq3yM6qQshw
         tQHUwUZghyzRCMnISQRQ2I/ksF8qBEbzVZOvEbxmVap3QAeVnYpCXmkFnyiOMY1picIx
         U+Dm28KouHb0C3WTS01cQH/da0IGtoXX25P/fghile0BYr6nYQftrSlg+wJFT/jK/Fm/
         54YYhjsOqAI+Rluu63cefSWvNOMxG4bkBGlyj6pFDbXTDd6F9eHeqP7ZQQMf+XP79cx3
         wcjnuR5YyiJwa0mJsDvQg3y2SrpIDeudsFQf7+w7XJ3hcfOYJTA8ow85pV1yLk2Sik1P
         EZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0F1TBkXpMX0IucoBuNA8ldZVsBCuebezx1/Z88WfEdk=;
        b=QP7ytip28a+aDcK88ZqCcwjJ/9f7zMLahF6hkJE6xypoGVcPrM9PJBXY2tzUpS1Qy6
         tpuHyxvlbTm8SXFhuY27EVt89qxnxxCualSFhCMM0laE6JVhE5xWxPjPFxuWp/tF2+ZE
         ssQNL1EMLmb4eGjfgpmwFjSM4MZ9BvQrQNZllhhRu5O2hz/nq0NMZnOz1/w6VCmo6dtE
         9Qd//tTuUyd4v7eeFNPqU4fVE9uNnizxwaY/dIetQLB5V3iCjxt2cDAGsUEDtPB3p610
         hGzFmPB644t6oN9KGi1tuiQcffbaBwd9R3iuFg8xoxlJBMh6ePJyulTqAiKCTzY80DXu
         zHbg==
X-Gm-Message-State: AOAM530wyP+CniE/OvXYEau5vu9I4GUevbLEPE94ze4Euq1et5YbDUDr
        FVwhTAX6kVArBFTnCkBIFxbbYJZ+knEL4r/jkSwfwg==
X-Google-Smtp-Source: ABdhPJw4RXJp0aVQaWh8r1jWTbZBCTiuJXoVJRbAqG1GxOzfE0e55PpjKBbe4VUWC1HKzLOhCzrJ8wGjEfItvCOv3NY=
X-Received: by 2002:a05:620a:711:: with SMTP id 17mr7061519qkc.501.1612443251090;
 Thu, 04 Feb 2021 04:54:11 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+ayRHua-6UyRwSM3=_oi+NkXbaO3-zZ1mpDmWonbybkeA@mail.gmail.com>
 <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com>
 <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
 <CACT4Y+YeRtOTsMQ8xxZg-=nbv+yuJvYYhBErT46M8jtSHmiw6g@mail.gmail.com>
 <YBqXPmbpXf4hnlj3@hirez.programming.kicks-ass.net> <CACT4Y+a-9kqX0ZkNz-ygib+ERn41HVo_8Wx6oYMQmPjTC06j7g@mail.gmail.com>
 <YBqnAYVdNM4uyGny@hirez.programming.kicks-ass.net> <CACT4Y+btOt5QFKH9Q=81EnpDHoidJUHE2s0oZ8v65t-b__awuw@mail.gmail.com>
 <YBvAsku9OWM7KUno@hirez.programming.kicks-ass.net> <CACT4Y+ZLSyVMkPfh3PftEWKC1kC+o1XLxo_o6i4BiyRuPig27g@mail.gmail.com>
 <YBvj6eJR/DY2TsEB@hirez.programming.kicks-ass.net>
In-Reply-To: <YBvj6eJR/DY2TsEB@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 4 Feb 2021 13:53:59 +0100
Message-ID: <CACT4Y+a17L2pUY1kkRB_v_y3P_sbMpSLb6rVfXmGM7LkbAvj5Q@mail.gmail.com>
Subject: Re: Process-wide watchpoints
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 1:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 04, 2021 at 10:54:42AM +0100, Dmitry Vyukov wrote:
> > On Thu, Feb 4, 2021 at 10:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > OTOH, we're using ptrace permission checks, and ptrace() can inject
> > > signals just fine. But it's a fairly big departure from what perf set
> > > out to be.
> >
> > Oh, I see, I did not think about this.
> >
> > FWIW it's doable today by attaching a BPF program.
>
> Sorta. For one, I can't operate BPF to save my life. Secondly, BPF has
> some very dodgy recursion rules and it's trivial to loose BPF
> invocations because another BPF is already running.
>
> > Will it help if this mode is restricted to monitoring the current
> > process? Sending signals indeed usually requires cooperation, so doing
> > it for the current process looks like a reasonable restriction.
> > This may be not a fundamental restriction, but rather "we don't have
> > any use cases and are not sure about implications, so this is a
> > precaution measure, may be relaxed in future".
>
> Yeah, limiting it might help. I can trivially add attr::thread_only,
> that requires attr::inherit and will limit it to CLONE_THREAD (find
> below).
>
> What do we do then? The advantage of IOC_REFRESH is that it disables the
> event until it gets explicitly re-armed, avoiding recursion issues etc.
> Do you want those semantics? If so, we'd need to have IOC_REFRESH find
> the actual event for the current task, which should be doable I suppose.

Frankly, I don't know. I didn't use it in my prototype, nor I fully
understand what it's doing. Does it make sense for breakpoints?
I see IOC_REFRESH has a check for !attr.inherit, so it will fail for
my use case currently. I would say we just leave it as is for now.


> And I need to dig into that fcntl() crud again, see if that's capable of
> doing a SIGTRAP and if it's possible to target that to the task raising
> it, instead of doing a process wide signal delivery.
>
> Lemme rummage about a bit.

Note if we do this, I would also need an address and FAULT_FLAG_WRITE.
AFAIU the current code sends SIGTRAP w/o any arguments.

> ---
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -955,7 +955,7 @@ extern void __perf_event_task_sched_in(s
>                                        struct task_struct *task);
>  extern void __perf_event_task_sched_out(struct task_struct *prev,
>                                         struct task_struct *next);
> -extern int perf_event_init_task(struct task_struct *child);
> +extern int perf_event_init_task(struct task_struct *child, unsigned long clone_flags);
>  extern void perf_event_exit_task(struct task_struct *child);
>  extern void perf_event_free_task(struct task_struct *task);
>  extern void perf_event_delayed_put(struct task_struct *task);
> @@ -1446,7 +1446,8 @@ perf_event_task_sched_in(struct task_str
>  static inline void
>  perf_event_task_sched_out(struct task_struct *prev,
>                           struct task_struct *next)                     { }
> -static inline int perf_event_init_task(struct task_struct *child)      { return 0; }
> +static inline int perf_event_init_task(struct task_struct *child,
> +                                      unsigned long clone_flags)       { return 0; }
>  static inline void perf_event_exit_task(struct task_struct *child)     { }
>  static inline void perf_event_free_task(struct task_struct *task)      { }
>  static inline void perf_event_delayed_put(struct task_struct *task)    { }
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -388,7 +388,8 @@ struct perf_event_attr {
>                                 aux_output     :  1, /* generate AUX records instead of events */
>                                 cgroup         :  1, /* include cgroup events */
>                                 text_poke      :  1, /* include text poke events */
> -                               __reserved_1   : 30;
> +                               thread_only    :  1, /* only inherit on threads */
> +                               __reserved_1   : 29;
>
>         union {
>                 __u32           wakeup_events;    /* wakeup every n events */
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -12776,12 +12776,13 @@ static int
>  inherit_task_group(struct perf_event *event, struct task_struct *parent,
>                    struct perf_event_context *parent_ctx,
>                    struct task_struct *child, int ctxn,
> -                  int *inherited_all)
> +                  unsigned long clone_flags, int *inherited_all)
>  {
>         int ret;
>         struct perf_event_context *child_ctx;
>
> -       if (!event->attr.inherit) {
> +       if (!event->attr.inherit ||
> +           (event->attr.thread_only && !(clone_flags & CLONE_THREAD))) {
>                 *inherited_all = 0;
>                 return 0;
>         }
> @@ -12813,7 +12814,7 @@ inherit_task_group(struct perf_event *ev
>  /*
>   * Initialize the perf_event context in task_struct
>   */
> -static int perf_event_init_context(struct task_struct *child, int ctxn)
> +static int perf_event_init_context(struct task_struct *child, int ctxn, unsigned long clone_flags)
>  {
>         struct perf_event_context *child_ctx, *parent_ctx;
>         struct perf_event_context *cloned_ctx;
> @@ -12853,7 +12854,8 @@ static int perf_event_init_context(struc
>          */
>         perf_event_groups_for_each(event, &parent_ctx->pinned_groups) {
>                 ret = inherit_task_group(event, parent, parent_ctx,
> -                                        child, ctxn, &inherited_all);
> +                                        child, ctxn, clone_flags,
> +                                        &inherited_all);
>                 if (ret)
>                         goto out_unlock;
>         }
> @@ -12869,7 +12871,8 @@ static int perf_event_init_context(struc
>
>         perf_event_groups_for_each(event, &parent_ctx->flexible_groups) {
>                 ret = inherit_task_group(event, parent, parent_ctx,
> -                                        child, ctxn, &inherited_all);
> +                                        child, ctxn, clone_flags,
> +                                        &inherited_all);
>                 if (ret)
>                         goto out_unlock;
>         }
> @@ -12911,7 +12914,7 @@ static int perf_event_init_context(struc
>  /*
>   * Initialize the perf_event context in task_struct
>   */
> -int perf_event_init_task(struct task_struct *child)
> +int perf_event_init_task(struct task_struct *child, unsigned long clone_flags)
>  {
>         int ctxn, ret;
>
> @@ -12920,7 +12923,7 @@ int perf_event_init_task(struct task_str
>         INIT_LIST_HEAD(&child->perf_event_list);
>
>         for_each_task_context_nr(ctxn) {
> -               ret = perf_event_init_context(child, ctxn);
> +               ret = perf_event_init_context(child, ctxn, clone_flags);
>                 if (ret) {
>                         perf_event_free_task(child);
>                         return ret;
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2068,7 +2068,7 @@ static __latent_entropy struct task_stru
>         if (retval)
>                 goto bad_fork_cleanup_policy;
>
> -       retval = perf_event_init_task(p);
> +       retval = perf_event_init_task(p, clone_flags);
>         if (retval)
>                 goto bad_fork_cleanup_policy;
>         retval = audit_alloc(p);


Humm... I was thinking of perf_event_open(pid == 0).
It does not make sense to send SIGTRAP in a remote process, because it
does not necessarily cooperate with us.

But is there any problem with clone w/o CLONE_THREAD? Assuming the
current process has setup the signal handler, the child will have the
same handler and the same code/address space. So delivery of SIGTRAP
should work the same way in the child.
I see how it may cause problems for exec, though. We don't have the
same signal handler in address space (I assume exec resets all signal
handlers). So in this case SIGTRAP will cause problems.

                               disable_on_exec    :  1, /* disable after exec */

which would be complementary to the current:

                               enable_on_exec : 1,   /* next exec enables */
