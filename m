Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B345941DA10
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351034AbhI3MoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350736AbhI3Mn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:43:59 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A522EC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:42:16 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id q205so7308382iod.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SFMbuda0Dk9sjkU1tNsSxuYlVqPZvVPogDDokKwo7f4=;
        b=mmdUlGxQuAzuCVK2mtAwoJLafNpXEudZ1PwWgeoQ0BBGa1+ykfAdpbqQT8vqgnIJb8
         NHEVrK2IcnR/gt2KXr/qcoYE4VCwpDOZGGFm9/yesf1C+RJkgK0TB/xCPO1wNAtjJTil
         NTUWb/U8cH5CZV7/uGG9gawEy5IQbgf5blGgRfBJ3X1srAvk1z3ZIvJ7C8Zj68C19hG0
         SsHnbMpSAtPNgBVdNP9EYnpOyH5iO1qMyU4PxQFh7IBi/o6fY0uCKQUxANzPaRRtZeE+
         g5uJpKu6JINFz3Qd1iIY6XO1SnW9X0W8H19dETh1hVg78jii/05MFZ7xGb5s8lmn+9Ab
         5JNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFMbuda0Dk9sjkU1tNsSxuYlVqPZvVPogDDokKwo7f4=;
        b=eSennDwQk8JY2LX99vXXGcGvQQRMgn98HLzfJ9I0Xp101NZJHRso8hs9X/MDuKLzMK
         zLOSmbPtclwiq1ZTPcvtQuMPUxtLILh1N9vhGA38TiiO1778JdIgYHs1TLlZsdy9bWBD
         wBIuyO1LLFJ4knwHqHZeMVJYzgQA2goB8Kyz+plYDGCUTgOUn4vNXJCl10wDiuDX63FC
         7zK+El26bJGEf/Gnpo42TNQ4Pz2ZcUW+6k50QnEbhICqEAlyEdJxusV+fNGzkdlwxfha
         LATpXjOJhD9Mun2LpDJX4WwXphSpKdlwn69BUzBSKMIJ77d20E/mVaLfr+9uT0U+JJRR
         xEgQ==
X-Gm-Message-State: AOAM532OKBaGtbvTsCAbB3cOq438oN9K0qDfzTRUjUSPSiSOv9IntkVm
        b4Be5Io0yiS3LLhjVy+0dtTorbsCxBpKL/hDkxc=
X-Google-Smtp-Source: ABdhPJyfhSQEh8RWdMzkRKhW9bqqAnDBZfA/+R/CYEP8yhnvGQbJlAEwcv/Ei55UWl6dB0I62ZeqY0YL9Yp/58f/o/k=
X-Received: by 2002:a5d:9493:: with SMTP id v19mr3640656ioj.34.1633005736112;
 Thu, 30 Sep 2021 05:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210929115036.4851-1-laoar.shao@gmail.com> <20210929115036.4851-3-laoar.shao@gmail.com>
 <202109291109.FAF3F47BA@keescook>
In-Reply-To: <202109291109.FAF3F47BA@keescook>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 30 Sep 2021 20:41:40 +0800
Message-ID: <CALOAHbB3_q0stoUyqZdScZR3_edJE5ncmys6HNiQrBZTEgGVMw@mail.gmail.com>
Subject: Re: [PATCH 2/5] kernel/fork: allocate task->comm dynamicly
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
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

On Thu, Sep 30, 2021 at 2:11 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Sep 29, 2021 at 11:50:33AM +0000, Yafang Shao wrote:
> > task->comm is defined as an array embedded in struct task_struct before.
> > This patch changes it to a char pointer. It will be allocated in the fork
> > and freed when the task is freed.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/linux/sched.h |  2 +-
> >  kernel/fork.c         | 19 +++++++++++++++++++
> >  2 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index e12b524426b0..b387b5943db4 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1051,7 +1051,7 @@ struct task_struct {
> >        * - access it with [gs]et_task_comm()
> >        * - lock it with task_lock()
> >        */
> > -     char                            comm[TASK_COMM_LEN];
> > +     char                            *comm;
>
> This, I think, is basically a non-starter. It adds another kmalloc to
> the fork path without a well-justified reason. TASK_COMM_LEN is small,
> yes, but why is growing it valuable enough to slow things down?
>
> (Or, can you prove that this does NOT slow things down? It seems like
> it would.)
>

Right, the new kmalloc would take some extra latency.
Seems it is not easy to measure which one is more valuable.

>
> >
> >       struct nameidata                *nameidata;
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 38681ad44c76..227aec240501 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -721,6 +721,20 @@ static void mmdrop_async(struct mm_struct *mm)
> >       }
> >  }
> >
> > +static int task_comm_alloc(struct task_struct *p)
> > +{
> > +     p->comm = kzalloc(TASK_COMM_LEN, GFP_KERNEL);
> > +     if (!p->comm)
> > +             return -ENOMEM;
> > +
> > +     return 0;
> > +}
> > +
> > +static void task_comm_free(struct task_struct *p)
> > +{
> > +     kfree(p->comm);
> > +}
> > +
> >  static inline void free_signal_struct(struct signal_struct *sig)
> >  {
> >       taskstats_tgid_free(sig);
> > @@ -753,6 +767,7 @@ void __put_task_struct(struct task_struct *tsk)
> >       bpf_task_storage_free(tsk);
> >       exit_creds(tsk);
> >       delayacct_tsk_free(tsk);
> > +     task_comm_free(tsk);
> >       put_signal_struct(tsk->signal);
> >       sched_core_free(tsk);
> >
> > @@ -2076,6 +2091,10 @@ static __latent_entropy struct task_struct *copy_process(
> >       if (data_race(nr_threads >= max_threads))
> >               goto bad_fork_cleanup_count;
> >
> > +     retval = task_comm_alloc(p);
> > +     if (retval)
> > +             goto bad_fork_cleanup_count;
> > +
> >       delayacct_tsk_init(p);  /* Must remain after dup_task_struct() */
> >       p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE | PF_NO_SETAFFINITY);
> >       p->flags |= PF_FORKNOEXEC;
> > --
> > 2.17.1
> >
>
> --
> Kees Cook



-- 
Thanks
Yafang
