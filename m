Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE79F33CDFC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 07:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhCPGfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 02:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhCPGez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 02:34:55 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26233C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 23:34:52 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id l15so9021506qvl.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 23:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SByyMFSlLntBAm8fHgqN+CmCCGC2J92yQYTbduz/8F4=;
        b=s+uLqyFrjkMmW5YeJaqvGeFwM5DpyLE4ZA0G18plRKW6nkBDny7Y1Hg1jB6l1VviZs
         iVQoYuy06c2imtqXONxNojwDzI11L8Qa06mrjwRw6EcTYvUlMhR+8Lp+oxxpVoz2r6MV
         HCP6FzftAUKiF/AxuYU1jXZbpbdmmwlN9PG7xFbZmfgZdYL+bi74iBxGEJEqwnRK4pu9
         Fe9EJOMXK2UxSnubdPd0khIQUofJ3iqj6+JDqsiJeis2fVUrcTajpg9ImNlmjB0Trox9
         sLfwQf7pNCciXu7qXbTOgcWM9gefBhaZEvrcyCTLdK787ft3FfHDgyoYYOzozCIKWYfd
         QtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SByyMFSlLntBAm8fHgqN+CmCCGC2J92yQYTbduz/8F4=;
        b=DJs7X165n4lUPTtDw2BTv531DEkJ1bxDgA93bhCEBsYjAWCDzYlEUpcS+7LXAlHCk/
         wbCBnvHwhl7NoBJtBwQRssAjqH/LletvtpMrAzPFY1RpgR0TdgixadmkewJ7OwiLkboK
         KQR5La1AJrF2V6GXAzjFF3zYW5S2PKGWVmkq4UUBfA2CxI4UFM5J86aNVKo0ix6jPsrm
         LqNbLbLNQstCfAoLYKLQStdVEBU8dov2BHWP9J53eeZiXCJbfWojUKS80j/uMk1xbPrq
         9c066Vq0rQJ6urjbkyrvILAX3lSGKxjIt7SD5TInaObJHbNi6Ldxw5LlEkVy3gh2vtJe
         iSdA==
X-Gm-Message-State: AOAM531n5b7TSJos9FndJPML68HGpBHz4rwC0XOOyuqZfdUl4TbTLMn5
        vxjurnwFj9M6JZzKBK9MWK0JJfNaEwrydcuk2z3s7A==
X-Google-Smtp-Source: ABdhPJwCeQcT66aWyysAq/F0mnL+lIXNOvkkdqOLUYYKOZSFIJs9a705sEfwv8vZeNPeivpqwej8TWOU/YNOMe3w00c=
X-Received: by 2002:a0c:8304:: with SMTP id j4mr14226424qva.18.1615876491060;
 Mon, 15 Mar 2021 23:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210316024410.19967-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20210316024410.19967-1-walter-zh.wu@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 16 Mar 2021 07:34:39 +0100
Message-ID: <CACT4Y+aMKH24F6DO=iKX0jDmxm4MCuJkA-OTkmgbfDm73LLKhQ@mail.gmail.com>
Subject: Re: [PATCH v2] task_work: kasan: record task_work_add() call stack
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

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

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
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210316024410.19967-1-walter-zh.wu%40mediatek.com.
