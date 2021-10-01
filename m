Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D292141ECAC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 13:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354161AbhJAMAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354153AbhJAMAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:00:45 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC3DC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 04:59:01 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p80so11274133iod.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 04:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/aOMTE1CqXH2vambpaRWGG2/ICwA8xyh0LOnA2Jcahc=;
        b=cHggjHQJOWaNWuCUG9m7Q9n1kbSjuAfuoCNfMu0UMfTYEZob5nTch2Q2Swo6CDbTeA
         3wD+tTWgtaE66J9upPhiqkvIOzJknPZPEI9BOG2BzT6x5Ck83c9ulf5JeBFzXAYn+wD7
         OOVO8tGkqdDYC5Qadg9GMfiF3IUUjD2r2UD7q3aZ5CQYGK5ST6STBhKTRjRF0bE7Apof
         Kpf51w/bQQFkMUwSUljcida7XU3L0mT0hA2lIo0CFBdKHwIN4QOGmXQyYbji29LXDOnr
         0zJjvVl6Y+JlFeCCkyYr0fEFvjiYgS/WA2/BFZV0nRjwIvIIbW1zOlv2maOlIWI69A6J
         NZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/aOMTE1CqXH2vambpaRWGG2/ICwA8xyh0LOnA2Jcahc=;
        b=vmpTQOFuXHbGp4Scr1Wh6q+kAEuJPMNbMBUw6gPlvq4QHWlvv+A72Er21zNeGvruI1
         ApWTZ+ZecuH2idw+pX0GyHeMYuzDOHoLZ49m3WuvdJEGq6Jxx2HAC2CaHNqL5IgSAAJX
         misaIk0qwcmzz++uq1x9/SHuKMkYo0hUSl1pYuTZBZyC9MeBnAl1F8lUtihubsnzvOqw
         JVdrQ3htQHNjbmUGAPdtxgbDAuzwtm0S4bzmLLHGSqnICJJKkXyPyx8DtEnGE2yv//2d
         d0xSqUAd4SK/TT/34O6Ed+lklHBxLasREx4v+xbetdTLQFpFRQgZzpq3KN7RIRt6Fem2
         /MWA==
X-Gm-Message-State: AOAM533UQH55RCq0QFkp8VCHg0mrIaGeUIensU4rABTfp/b2KyMyMaDF
        S99HwASv41/NlBJwJCvkLw9p+sI49MzR0WV92jU=
X-Google-Smtp-Source: ABdhPJw0VYTN+YKIaLh2QRhuWnRO/Ori32NZfmtK3CuztvzJgwXuFahC50D/cVdSB/fJ4SvrqoW6GFE2RkI0g2LMVec=
X-Received: by 2002:a5d:9493:: with SMTP id v19mr7670233ioj.34.1633089540625;
 Fri, 01 Oct 2021 04:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210929115036.4851-1-laoar.shao@gmail.com> <20210929115036.4851-3-laoar.shao@gmail.com>
 <202109291109.FAF3F47BA@keescook> <CALOAHbB3_q0stoUyqZdScZR3_edJE5ncmys6HNiQrBZTEgGVMw@mail.gmail.com>
 <YVXO/hsDJQh1FOgy@alley>
In-Reply-To: <YVXO/hsDJQh1FOgy@alley>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 1 Oct 2021 19:58:24 +0800
Message-ID: <CALOAHbA0t6XTvTX2b=1JZY-QBx-Ji9A6r05-y07T0e962iHdNw@mail.gmail.com>
Subject: Re: [PATCH 2/5] kernel/fork: allocate task->comm dynamicly
To:     Petr Mladek <pmladek@suse.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        Al Viro <viro@zeniv.linux.org.uk>, christian@brauner.io,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 10:51 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2021-09-30 20:41:40, Yafang Shao wrote:
> > On Thu, Sep 30, 2021 at 2:11 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Wed, Sep 29, 2021 at 11:50:33AM +0000, Yafang Shao wrote:
> > > > task->comm is defined as an array embedded in struct task_struct before.
> > > > This patch changes it to a char pointer. It will be allocated in the fork
> > > > and freed when the task is freed.
> > > >
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > > >  include/linux/sched.h |  2 +-
> > > >  kernel/fork.c         | 19 +++++++++++++++++++
> > > >  2 files changed, 20 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > index e12b524426b0..b387b5943db4 100644
> > > > --- a/include/linux/sched.h
> > > > +++ b/include/linux/sched.h
> > > > @@ -1051,7 +1051,7 @@ struct task_struct {
> > > >        * - access it with [gs]et_task_comm()
> > > >        * - lock it with task_lock()
> > > >        */
> > > > -     char                            comm[TASK_COMM_LEN];
> > > > +     char                            *comm;
> > >
> > > This, I think, is basically a non-starter. It adds another kmalloc to
> > > the fork path without a well-justified reason. TASK_COMM_LEN is small,
> > > yes, but why is growing it valuable enough to slow things down?
> > >
> > > (Or, can you prove that this does NOT slow things down? It seems like
> > > it would.)
> > >
> >
> > Right, the new kmalloc would take some extra latency.
> > Seems it is not easy to measure which one is more valuable.
>
> Honestly, I do not think that this exercise is worth it. The patchset
> adds a lot of complexity and potential problems just to extend
> comm from 16 to 24 for kthreads.
>
> Is the problem real or just cosmetic?
>

It is a problem, but not a critical problem.

Take the "cfs_migration/%u" for example.
It will be truncated to "cfs_migration/1" for CPU 10~19, which will
make the user confused.  But as it is a per-cpu thread, the user can
get its CPU information from its cpu mask.  And we can also shorten
its name to work around this issue.

But for kthreads corresponding to some other hardware devices, it may
not be easy to get the detailed information from the task's comm. For
example,
    jbd2/nvme0n1p2-
    nvidia-modeset/


> If you really want it then it would be much easier to increase
> TASK_COMM_LEN. task_struct is growing rather regularly. Extra
> 8 bytes should be acceptable.
>
> If you want to make it more acceptable then keep 16 for
> CONFIG_BASE_SMALL.
>

That seems to be a possible solution.

>
> > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > index 38681ad44c76..227aec240501 100644
> > > > --- a/kernel/fork.c
> > > > +++ b/kernel/fork.c
> > > > @@ -753,6 +767,7 @@ void __put_task_struct(struct task_struct *tsk)
> > > >       bpf_task_storage_free(tsk);
> > > >       exit_creds(tsk);
> > > >       delayacct_tsk_free(tsk);
> > > > +     task_comm_free(tsk);
>
> Just one example of the potential problems. Are you sure that nobody
> will access tsk->comm after this point?
>

That is a risk.
Should free it in free_task(), just before free_task_struct().

> task->comm is widely used to describe the affected task_struct because
> it is user friendly.
>
> Also __put_task_struct() later calls also profile_handoff_task() that might
> get registered even by some external module.
>
> Best Regards,
> Petr
>
> PS: I think that the fork performance is important. It is tested by
> benchmarks, for example, lmbench. But for me, the reliability is even
> more important and any pointer/alloc/free just adds another weak
> point.

Many thanks for the explanation.

-- 
Thanks
Yafang
