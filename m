Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B9641C53B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 15:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344063AbhI2NLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 09:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344040AbhI2NLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 09:11:05 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7A1C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 06:09:23 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id s20so3010542ioa.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 06:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkEDSADHBvfevoxljJ4T1PZQMMJ1MoZGL9A5io5n/G4=;
        b=l65l906OE79blcJYbrneuky2sOG6RNx0kOJ44MNaSCkQhaBp0BrjIQsfK4cSY99FTz
         T/HvPXfhqpX5SDliwK1g0ge2M+XBiQ+rFsofcM2jrxF//j6T69DYNf1AiQF8f86tzjSC
         w1K81Bdpet7IrVmc9CzrhehQFXuRcr6zGckCskXQ0IIYm5P/sFQHQHf4UQbScFpyeue5
         H56ptcHwCkcuZ9uSjU0R1o12+rmmlGW3dAIwFsoyFM/QDaG7keH9e+OBanGPP1zghnFT
         IkJHgGDZ5XhC4S2phbNquiS+Nr2SD9MAD19SkzM9f/fNU+r3g/8X3xIBrZAKTKhcxGa+
         pTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkEDSADHBvfevoxljJ4T1PZQMMJ1MoZGL9A5io5n/G4=;
        b=SjKwGsis0RoQzhi8YI+QWf8Nfblo3MgK+B624KGLubba5bPDKjMIqwTbKo199I9z6J
         c5uOQo9j6O0A6isolRuzVTcffTx2NFN1dFmGvyNq6E9AwVVFGnDUFhB4EhNEOIzCpVZT
         Ma3AsAY4YiBhqWEyKwyQKvOn4UJGAZzQcrJfKQWDeIWEVO/x4sRJtrePSR8opHMsNq1J
         UxfJuN24hOY+0cEIXzo8vkyKuwkgPHcQvwit/aA69+hOoLqqgrtBtKy0T+5YXNq8UTnC
         WMrfS7mTU1i3LqZzKdZMSG2+pVvE76rtWb0Jd/mrapHXndyOxykc84noPIa56CGgrdAH
         vshw==
X-Gm-Message-State: AOAM5330mpMgSQVJjLDmJOKcKcLAHrL8my8/ps+cgwHE4Z7Se5eCeO2/
        cnRKqu/c/9LwwfCmZ1PZTC2iznUx1xBIPE44L5k=
X-Google-Smtp-Source: ABdhPJwC6af02XyBX0i/Tzr7sRtlymOVBbUwIAl6sroM70zqX6pibqgFpX8Svqos+HIcdkrooSzFGbztwMFdKMgc1ZI=
X-Received: by 2002:a05:6638:2722:: with SMTP id m34mr9515111jav.49.1632920963356;
 Wed, 29 Sep 2021 06:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210929115036.4851-1-laoar.shao@gmail.com> <20210929115036.4851-3-laoar.shao@gmail.com>
In-Reply-To: <20210929115036.4851-3-laoar.shao@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 29 Sep 2021 21:08:47 +0800
Message-ID: <CALOAHbBy60ik+Crf0E8spTyCqth0mPO7+u=ZsQRsbsJS7n6fGA@mail.gmail.com>
Subject: Re: [PATCH 2/5] kernel/fork: allocate task->comm dynamicly
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        Al Viro <viro@zeniv.linux.org.uk>, christian@brauner.io,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 7:51 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> task->comm is defined as an array embedded in struct task_struct before.
> This patch changes it to a char pointer. It will be allocated in the fork
> and freed when the task is freed.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/sched.h |  2 +-
>  kernel/fork.c         | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index e12b524426b0..b387b5943db4 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1051,7 +1051,7 @@ struct task_struct {
>          * - access it with [gs]et_task_comm()
>          * - lock it with task_lock()
>          */
> -       char                            comm[TASK_COMM_LEN];
> +       char                            *comm;
>
>         struct nameidata                *nameidata;
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 38681ad44c76..227aec240501 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -721,6 +721,20 @@ static void mmdrop_async(struct mm_struct *mm)
>         }
>  }
>
> +static int task_comm_alloc(struct task_struct *p)
> +{
> +       p->comm = kzalloc(TASK_COMM_LEN, GFP_KERNEL);
> +       if (!p->comm)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +static void task_comm_free(struct task_struct *p)
> +{
> +       kfree(p->comm);
> +}
> +
>  static inline void free_signal_struct(struct signal_struct *sig)
>  {
>         taskstats_tgid_free(sig);
> @@ -753,6 +767,7 @@ void __put_task_struct(struct task_struct *tsk)
>         bpf_task_storage_free(tsk);
>         exit_creds(tsk);
>         delayacct_tsk_free(tsk);
> +       task_comm_free(tsk);
>         put_signal_struct(tsk->signal);
>         sched_core_free(tsk);
>
> @@ -2076,6 +2091,10 @@ static __latent_entropy struct task_struct *copy_process(
>         if (data_race(nr_threads >= max_threads))
>                 goto bad_fork_cleanup_count;
>
> +       retval = task_comm_alloc(p);
> +       if (retval)
> +               goto bad_fork_cleanup_count;
> +
>         delayacct_tsk_init(p);  /* Must remain after dup_task_struct() */
>         p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE | PF_NO_SETAFFINITY);
>         p->flags |= PF_FORKNOEXEC;
> --
> 2.17.1
>

After sending the series, I find that I forget to move the
task_comm_alloc() to the end of fork().  Below is the updated one,

---
 include/linux/sched.h |  2 +-
 kernel/fork.c         | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e12b524426b0..b387b5943db4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1051,7 +1051,7 @@ struct task_struct {
         * - access it with [gs]et_task_comm()
         * - lock it with task_lock()
         */
-       char                            comm[TASK_COMM_LEN];
+       char                            *comm;

        struct nameidata                *nameidata;

diff --git a/kernel/fork.c b/kernel/fork.c
index 38681ad44c76..d1e0c38464ed 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -721,6 +721,20 @@ static void mmdrop_async(struct mm_struct *mm)
        }
 }

+static int task_comm_alloc(struct task_struct *p)
+{
+       p->comm = kzalloc(TASK_COMM_LEN, GFP_KERNEL);
+       if (!p->comm)
+               return -ENOMEM;
+
+       return 0;
+}
+
+static void task_comm_free(struct task_struct *p)
+{
+       kfree(p->comm);
+}
+
 static inline void free_signal_struct(struct signal_struct *sig)
 {
        taskstats_tgid_free(sig);
@@ -753,6 +767,7 @@ void __put_task_struct(struct task_struct *tsk)
        bpf_task_storage_free(tsk);
        exit_creds(tsk);
        delayacct_tsk_free(tsk);
+       task_comm_free(tsk);
        put_signal_struct(tsk->signal);
        sched_core_free(tsk);

@@ -2352,6 +2367,10 @@ static __latent_entropy struct task_struct *copy_process(
                goto bad_fork_cancel_cgroup;
        }

+       retval = task_comm_alloc(p);
+       if (retval)
+               goto bad_fork_cancel_cgroup;
+
        /* past the last point of failure */
        if (pidfile)
                fd_install(pidfd, pidfile);


-- 
Thanks
Yafang
