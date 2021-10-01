Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A356941F530
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 20:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhJASuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 14:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231510AbhJASur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 14:50:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB41561881
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 18:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633114142;
        bh=Bx8bikt8D/SqC4WgRhAep40YSZrd61378RH9MsoFItY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h4/Ll86J/ZxwNMrpkta/Y8YjsNLg0TutmshsSB7QmNqdeUmhaH8ppOld4rVlVVCz9
         yPSRKKlcfOom73FqgL5wLbCbWZMcnuA2z+64YZTqodynpGlaLbBp+Y9vB6QECsqz0P
         UbXhZlpxoo2Dja29UvxTFJ1PW61crdxX1J94eGGZX1K7/xPaCZ+0Xw9HTaSfEwOdOE
         qGmQOTE3GWe1RkeDj9ll84RYFY19Yygxv059ZbmSX224nB0+XrbxRMTZrZf7x3Uc88
         0KUC0oLuW1g1JZ1EZKEPSdYxskeaktFYc8CG/bpOBgNoxfG/YYGqK8rXIlCoju7KVK
         N6n/V47JPLykQ==
Received: by mail-ed1-f49.google.com with SMTP id v10so38434752edj.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 11:49:02 -0700 (PDT)
X-Gm-Message-State: AOAM532+00auL13ERPjWjyPIIB51g1mBSNmi/lAIBX4V1XHlU99FnaoO
        w9Eun85a5LuBRaH9PYDc7Adz0MSDprCHvMSMOtU1Kw==
X-Google-Smtp-Source: ABdhPJyED0i7ShRt9d88mzi9L8YStFHEdf+GApJYmRptOfcxhfkD3CUKmYttB5T2t7qTYb8C+LiLNOw8wXJTx/sW7Pk=
X-Received: by 2002:aa7:c945:: with SMTP id h5mr16158050edt.350.1633114141151;
 Fri, 01 Oct 2021 11:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210928122339.502270600@linutronix.de> <20210928122411.593486363@linutronix.de>
 <YVRT6QbX5zwiIJkI@hirez.programming.kicks-ass.net> <CALCETrVP3asoqWyNqEe+rDs+YECd9gnp9eFb1==X0140oMZ41g@mail.gmail.com>
 <87o8884q02.ffs@tglx>
In-Reply-To: <87o8884q02.ffs@tglx>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 1 Oct 2021 11:48:48 -0700
X-Gmail-Original-Message-ID: <CALCETrU7Fu7BA+DEk8HJPRkqsOSsC-NXR2tPsxW6VFF0pxSS6A@mail.gmail.com>
Message-ID: <CALCETrU7Fu7BA+DEk8HJPRkqsOSsC-NXR2tPsxW6VFF0pxSS6A@mail.gmail.com>
Subject: Re: [patch 4/5] sched: Delay task stack freeing on RT
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 10:24 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, Oct 01 2021 at 09:12, Andy Lutomirski wrote:
> > On Wed, Sep 29, 2021 at 4:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >> Having this logic split across two files seems unfortunate and prone to
> >> 'accidents'. Is there a real down-side to unconditionally doing it in
> >> delayed_put_task_struct() ?
> >>
> >> /me goes out for lunch... meanwhile tglx points at: 68f24b08ee89.
> >>
> >> Bah.. Andy?
> >
> > Could we make whatever we do here unconditional?
>
> Sure. I just was unsure about your reasoning in 68f24b08ee89.

Mmm, right.  The reasoning is that there are a lot of workloads that
frequently wait for a task to exit and immediately start a new task --
most shell scripts, for example.  I think I tested this with the
following amazing workload:

while true; do true; done

and we want to reuse the same stack each time from the cached stack
lookaside list instead of vfreeing and vmallocing a stack each time.
Deferring the release to the lookaside list breaks it.  Although I
suppose the fact that it works well right now is a bit fragile --
we're waking the parent (sh, etc) before releasing the stack, but
nothing gets to run until the stack is released.

>
> > And what actually causes the latency?  If it's vfree, shouldn't the
> > existing use of vfree_atomic() in free_thread_stack() handle it?  Or
> > is it the accounting?
>
> The accounting muck because it can go into the allocator and sleep in
> the worst case, which is nasty even on !RT kernels.

Wait, unaccounting memory can go into the allocator?  That seems quite nasty.

>
> But thinking some more, there is actually a way nastier issue on RT in
> the following case:
>
> CPU 0                           CPU 1
>   T1
>   spin_lock(L1)
>   rt_mutex_lock()
>       schedule()
>
>   T2
>      do_exit()
>      do_task_dead()             spin_unlock(L1)
>                                    wake(T1)
>      __schedule()
>        switch_to(T1)
>        finish_task_switch()
>          put_task_stack()
>            account()
>              ....
>              spin_lock(L2)
>
> So if L1 == L2 or L1 and L2 have a reverse dependency then this can just
> deadlock.
>
> We've never observed that, but the above case is obviously hard to
> hit. Nevertheless it's there.

Hmm.

ISTM it would be conceptually for do_exit() to handle its own freeing
in its own preemptible context.  Obviously that can't really work,
since we can't free a task_struct or a task stack while we're running
on it.  But I wonder if we could approximate it by putting this work
in a workqueue so that it all runs in a normal schedulable context.
To make the shell script case work nicely, we want to release the task
stack before notifying anyone waiting for the dying task to exit, but
maybe that's doable.  It could involve some nasty exit_signal hackery,
though.
