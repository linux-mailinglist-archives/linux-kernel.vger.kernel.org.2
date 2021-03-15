Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA57433AF86
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCOKDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhCOKDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:03:42 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779ECC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:03:42 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id n79so31012408qke.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mMMrIgwms1m+PweB3p+oJVkXrLd9T+PU+71ztQbJ0Ac=;
        b=aZC06iXV6XMrwbpZSotpoDsmfhDR/0tSMJsRNMD+rAn7gq9HZCCG7AmDSGiTdf1I06
         srVTFqSwXc3krmqezFQRz9Ox8TRKFukQLJeL0OAKJoT7HmtARcSNq1hIcS0SoqjvwM4x
         EeO8DVCIiESDGwwc3kVAQ31Sig7EKZGy9M0DjKoBT0oDYRWq+J0ZnU74FXqDZlV6XJGH
         HIelKK/Fii1H+N7+GG6PMiQZGYbN68Zi99IHngEgKCWuXlAu2cFTd+XNpSZandeYCbAs
         UAN1OfLGllXjI+rK14NWNmeXLMoHiVcCekXjaPTlpeQdPinpSJQXYFcgNX45CoD2Boo8
         xpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mMMrIgwms1m+PweB3p+oJVkXrLd9T+PU+71ztQbJ0Ac=;
        b=VYMIg8jy7sEvWS7hnnnwJVcKMOPXmxiRpCx3Cxit9mKoQ4jSl3ONRsRrQz8tauMmwl
         /zcwdv6sr8IX6faYwYmiObbQSIG87kEnrwfasb0R2cqmsa8ZKEruPcTDvo4pSu67S3hC
         IIr4M8HgKoM2e9RN0rRhRkWKzzPFC9o5Hh2n1AYTeIaQMWriMgFlJ/DDsto6RXr1M0AG
         r/QaT2UHrR6NMeYk9B/P6mUOrYxAZVOJpgUTRpiOky/OkmmEp71eBqPeNWaO2Km49Q1y
         6un9UJUTHZSL2td0YxkbASwYVoY7f6z/Q6FQHlEyu2qqgFdqC9Gnyd30cqvWbLfj8hF2
         alRA==
X-Gm-Message-State: AOAM530JcXoK92WgJB7UQCCfia3vzavVX+ZpFfAZ39Jds15PUfpCHxsl
        5AWSG7hRsg7E9k+oYn6/G9HKHrMCliOYMQJtqkxIvqw5f3DosQ==
X-Google-Smtp-Source: ABdhPJzY/L1jlGeYpP4Qy4eRAiBR0q+Dk04B5WMHyL4Ix2K+M5KfPSB3dABKvPXaix89rpkulv6KdXUAErdMrigRvQU=
X-Received: by 2002:a37:a7cb:: with SMTP id q194mr523293qke.350.1615802621496;
 Mon, 15 Mar 2021 03:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210315015940.11788-1-walter-zh.wu@mediatek.com>
 <CACT4Y+YrFeRQkw+M8rpOF5169LFn9+puL3Dh1Kk1AOoKV-nyrQ@mail.gmail.com> <1615801102.24887.4.camel@mtksdccf07>
In-Reply-To: <1615801102.24887.4.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 15 Mar 2021 11:03:30 +0100
Message-ID: <CACT4Y+YtenynUES2Kb6jSjfw_wT4NMeyX+uG5KdCe3SHhq1qsw@mail.gmail.com>
Subject: Re: [PATCH] task_work: kasan: record task_work_add() call stack
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 10:38 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Mon, 2021-03-15 at 07:58 +0100, 'Dmitry Vyukov' via kasan-dev wrote:
> > On Mon, Mar 15, 2021 at 3:00 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > >
> > > Why record task_work_add() call stack?
> > > Syzbot reports many use-after-free issues for task_work, see [1].
> > > After see the free stack and the current auxiliary stack, we think
> > > they are useless, we don't know where register the work, this work
> > > may be the free call stack, so that we miss the root cause and
> > > don't solve the use-after-free.
> > >
> > > Add task_work_add() call stack into KASAN auxiliary stack in
> > > order to improve KASAN report. It is useful for programmers
> > > to solve use-after-free issues.
> > >
> > > [1]: https://groups.google.com/g/syzkaller-bugs/search?q=kasan%20use-after-free%20task_work_run
> > >
> > > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> > > Cc: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: Andrey Konovalov <andreyknvl@google.com>
> > > Cc: Alexander Potapenko <glider@google.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: Jens Axboe <axboe@kernel.dk>
> > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > ---
> > >  kernel/task_work.c | 3 +++
> > >  mm/kasan/kasan.h   | 2 +-
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/task_work.c b/kernel/task_work.c
> > > index 9cde961875c0..f255294377da 100644
> > > --- a/kernel/task_work.c
> > > +++ b/kernel/task_work.c
> > > @@ -55,6 +55,9 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
> > >                 break;
> > >         }
> > >
> > > +       /* record the work call stack in order to print it in KASAN reports */
> > > +       kasan_record_aux_stack(work);
> >
> > I think this call should be done _before_ we actually queue the work,
> > because this function may operate on non-current task.
> > Consider, we queue the work, the other task already executes it and
> > triggers use-after-free, now only now we record the stack.
>
> agree, what do you think below change?
>
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -34,6 +34,9 @@ int task_work_add(struct task_struct *task, struct
> callback_head *work,
>  {
>     struct callback_head *head;
>
> +   /* record the work call stack in order to print it in KASAN reports
> */
> +   kasan_record_aux_stack(work);
> +

This looks good to me.


>     do {
>         head = READ_ONCE(task->task_works);
>         if (unlikely(head == &work_exited))
> @@ -55,9 +58,6 @@ int task_work_add(struct task_struct *task, struct
> callback_head *work,
>         break;
>     }
>
> -   /* record the work call stack in order to print it in KASAN reports
> */
> -   kasan_record_aux_stack(work);
> -
>     return 0;
>  }
>
> > Moreover, I think we can trigger use-after-free here ourselves while
> > recording the aux stack. We queued the work, and the work can cause
> > own free, so it's not necessary live by now.
>
> Sorry, I don't fully know your meaning, do you mean we should add an
> abort when detect use-after-free?

I meant that where we had the kasan_record_aux_stack(work) call in the
first version of the patch, work can be already freed. We must not
access work after queueing it.

> > >         return 0;
> > >  }
> > >
> > > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > > index 3436c6bf7c0c..d300fe9415bd 100644
> > > --- a/mm/kasan/kasan.h
> > > +++ b/mm/kasan/kasan.h
> > > @@ -146,7 +146,7 @@ struct kasan_alloc_meta {
> > >         struct kasan_track alloc_track;
> > >  #ifdef CONFIG_KASAN_GENERIC
> > >         /*
> > > -        * call_rcu() call stack is stored into struct kasan_alloc_meta.
> > > +        * Auxiliary stack is stored into struct kasan_alloc_meta.
> > >          * The free stack is stored into struct kasan_free_meta.
> > >          */
> > >         depot_stack_handle_t aux_stack[2];
> > > --
> > > 2.18.0
> >
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/1615801102.24887.4.camel%40mtksdccf07.
