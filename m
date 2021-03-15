Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2832333ABDD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 07:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhCOG7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 02:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhCOG64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 02:58:56 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55F3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 23:58:56 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id 73so8409910qtg.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 23:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IU5V4mabE/n2VCRh3kSmfdhuEAACW74e/YNmNcSi3W8=;
        b=QdhmEyhcxyXwVDR8NjUH/7ppDoyROqwTDE670AXXQmtFChEdYuZki5fhCpd6P68hxZ
         Y21sjoK48mK/a62E28b9/N+oxL/IEol2w/iP1zkhiAdn4neTjw73fwdorPEw5nYIcTM9
         zGD0rVhMCXMIVVfIgUGJmliNYgomQ4uJVgZlLpvGiHumU2YbVPgMeONAzOcg0IXcfM+K
         e8XrSRfdRxTRdGgP5J+jYYWn5FhDqA5RBQbqLLymakk+zSwGoixcNubo3YIP1GwbdVzO
         ieLO4B1Dl7xRtri8oGKJz0PqFAhMkm6FB6sex6h/t1EESM4HYClp59EF09NSorHVK12H
         jNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IU5V4mabE/n2VCRh3kSmfdhuEAACW74e/YNmNcSi3W8=;
        b=hOWiGTTt1RPPZjtgNhfyYws0pmqVVfRKcTHRSoYih6W+B7ZyZ6WVT7HGH2/LDhfJQb
         sDJbOZYT1rTIS7Cr+JibI7Ko06OXmjsuJPPedjcMPER5ri4rR2D6YKqenpY1lIyxB5Sc
         VlOgr6m35P3M/ZbbhVbinXNtQfyOO/B/QpUj8Px9z+rX60I1n/SU9baXLo43RGxswLer
         S+jwP/6NsSkhTeTiRq+fvqpn2wc99WygR2Gtpx9lEi74zOvOUUs2Vhp581DuO6HO9cDV
         37BATqm736j0Tbh3RZNAFHMXeVo24JuszN/wwSx79WOVUsEZgs4M61y7rKD87D6YtEVe
         BvEg==
X-Gm-Message-State: AOAM531ftr8rL0TwFk6cyBthbsu+jo2qCW5tXsitvi9xyoA1LEbFQkAj
        V6byKayJaa2beOuGNyxBsFpJozufoE8HYj0qGgeMHg==
X-Google-Smtp-Source: ABdhPJw1nDPMaGuD+I/Gyg5vA/5WTioXa+s8ugiYlPtLXZ1fT5Oc3wV3ImBGwIyFbtBVjuIobFZYNfiGA87XfCiM7TY=
X-Received: by 2002:ac8:7318:: with SMTP id x24mr21525417qto.67.1615791535245;
 Sun, 14 Mar 2021 23:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210315015940.11788-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20210315015940.11788-1-walter-zh.wu@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 15 Mar 2021 07:58:44 +0100
Message-ID: <CACT4Y+YrFeRQkw+M8rpOF5169LFn9+puL3Dh1Kk1AOoKV-nyrQ@mail.gmail.com>
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

On Mon, Mar 15, 2021 at 3:00 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
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
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/task_work.c | 3 +++
>  mm/kasan/kasan.h   | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index 9cde961875c0..f255294377da 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -55,6 +55,9 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>                 break;
>         }
>
> +       /* record the work call stack in order to print it in KASAN reports */
> +       kasan_record_aux_stack(work);

I think this call should be done _before_ we actually queue the work,
because this function may operate on non-current task.
Consider, we queue the work, the other task already executes it and
triggers use-after-free, now only now we record the stack.
Moreover, I think we can trigger use-after-free here ourselves while
recording the aux stack. We queued the work, and the work can cause
own free, so it's not necessary live by now.

>         return 0;
>  }
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 3436c6bf7c0c..d300fe9415bd 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -146,7 +146,7 @@ struct kasan_alloc_meta {
>         struct kasan_track alloc_track;
>  #ifdef CONFIG_KASAN_GENERIC
>         /*
> -        * call_rcu() call stack is stored into struct kasan_alloc_meta.
> +        * Auxiliary stack is stored into struct kasan_alloc_meta.
>          * The free stack is stored into struct kasan_free_meta.
>          */
>         depot_stack_handle_t aux_stack[2];
> --
> 2.18.0
