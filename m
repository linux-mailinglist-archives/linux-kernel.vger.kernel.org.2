Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B328433FC40
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 01:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCRAb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 20:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCRAa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 20:30:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A577C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 17:30:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w8so1994976pjf.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 17:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkuRWpW9bExkYFxOTvvebzKRarhbJmzTDiFRajMJb68=;
        b=Tw1JOhx9WMaxj2zgL2+u0rROy7M24TONLFY0jAeGeUZ8wvui68EopwXxn0qUW0MLd0
         7wDivc0uuetGtGIEBWlrqWFTBrilHFV2627ljgT263GE3RoDzgfyK5e5EBpYudqtz3dd
         /GlEBbuxEmry+CKUqSgiqaef06Dd3YyED+Uy8aI1BWqYM3LFXERUI3TDN2+wCbHzSCrC
         kocqgtsBmdIspMmdXpz5DCNo6LQRcOt+khcnBdBCVCCRtYuHidggrt5eRg0wTtuaDlgX
         W3kktFufFg0ZZSamAU5eWzJAmxbxOAlnl292ZmodwTRQBmd9GRSUIOVk5WemXVV5R2pn
         lMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkuRWpW9bExkYFxOTvvebzKRarhbJmzTDiFRajMJb68=;
        b=KGgIqHzNkgyywXX+7H+mf3tM6JGwS0p3TDNNBmAW8sFxI1Bn+i5idJWbVLjuoyyD/m
         UmAjmiiKA4XLoSnK7gW0P+D23iBuMwHVWSBvUL4QuCAXpKHYVQFXF0Rq2qrlDW2SDnDB
         70C2I8Lr2n3SqBs91CfKzo4WlZiQ6b0wegtbnD/X0lTf1vAUcRFgubbXbMz0QlEph8BD
         gfuRKdFmjCfMj4yU61nwNHDCNejWmKzNhCZodADRNzjHbHjXrEUTlf4HSUL0TJYY0vuP
         E6c9RS0eD8oWQYUrKKmtofig4PFzOlxLDKtJNKmo7sP+NDDHU/N61ZS4ZjqvQea0en7E
         kCcg==
X-Gm-Message-State: AOAM530pQF2oTEOzFEG0HJzG5yhAj4xIK06zID/fScHzSHO37zGXPZ9y
        d0GS2xmHaMaWlCqthh11fOul+vbUKdoYTyItV9UcAg==
X-Google-Smtp-Source: ABdhPJzesTshIrJdKNHCDmlj2OR3e0xSraSKUZZ3Bj14Xck17fx++XRNX8MVNVTQU2DyspV0entCrOLh4c3wfRmf7Lw=
X-Received: by 2002:a17:90a:a10c:: with SMTP id s12mr1413387pjp.166.1616027458725;
 Wed, 17 Mar 2021 17:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210316024410.19967-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20210316024410.19967-1-walter-zh.wu@mediatek.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 18 Mar 2021 01:30:47 +0100
Message-ID: <CAAeHK+xiNywqQOzB=FUYOBJdSSNXbO4p2SdOvk4WKfhp_jiKGQ@mail.gmail.com>
Subject: Re: [PATCH v2] task_work: kasan: record task_work_add() call stack
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 3:44 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> Why record task_work_add() call stack?
> Syzbot reports many use-after-free issues for task_work, see [1].
> After see the free stack and the current auxiliary stack, we think
> they are useless, we don't know where register the work, this work
> may be the free call stack, so that we miss the root cause and
> don't solve the use-after-free.
>
> Add task_work_add() call stack into KASAN auxiliary stack in
> order to improve KASAN report. It is useful for programmers
> to solve use-after-free issues.
>
> [1]: https://groups.google.com/g/syzkaller-bugs/search?q=kasan%20use-after-free%20task_work_run
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Oleg Nesterov <oleg@redhat.com>
> ---
>
> v2: Fix kasan_record_aux_stack() calling sequence issue.
>     Thanks for Dmitry's suggestion
>
> ---
>  kernel/task_work.c | 3 +++
>  mm/kasan/kasan.h   | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index 9cde961875c0..3d4852891fa8 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -34,6 +34,9 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>  {
>         struct callback_head *head;
>
> +       /* record the work call stack in order to print it in KASAN reports */
> +       kasan_record_aux_stack(work);
> +
>         do {
>                 head = READ_ONCE(task->task_works);
>                 if (unlikely(head == &work_exited))
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 3436c6bf7c0c..e4629a971a3c 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -146,7 +146,7 @@ struct kasan_alloc_meta {
>         struct kasan_track alloc_track;
>  #ifdef CONFIG_KASAN_GENERIC
>         /*
> -        * call_rcu() call stack is stored into struct kasan_alloc_meta.
> +        * The auxiliary stack is stored into struct kasan_alloc_meta.
>          * The free stack is stored into struct kasan_free_meta.
>          */
>         depot_stack_handle_t aux_stack[2];
> --

Acked-by: Andrey Konovalov <andreyknvl@google.com>
