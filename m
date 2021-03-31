Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEBC34FDBA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbhCaKCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbhCaKCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:02:14 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08357C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 03:02:14 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id by2so9599999qvb.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWD91za5LG36WAQIn/p+7RREk6zwz1h7XL1Oim6J9qY=;
        b=LVlkGVX7a2VI37K3YH8qsB0LMs6+9lP/T8/ChRvNv5gQlLtTeF2eBrB9RbzL9IDf1i
         iwAjj+zoFw4rneFK53TqkJagZHrVQ2HCk6+2zICdOvFphCwwD1JYVRZnk0RPEoxsTo8w
         FyxEcFrWcGP/3AW+3dpU1QwnjOl5b4Toe7/DVLOj1c2zh6TuhYYTHfKJcIE2rENd9X1R
         TjAdHKYxv43rlZJQYmIqooWSWv0qK53m7LwaZZ18WrQcsnarRwxApeAFsp1eKIsoLy8i
         IgrllrCaxLkfw80NwgQA/L1OoZ97KW4Adj94LvgkWBkKovUKYIvzFtEyh9hk3xsCubQP
         WvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWD91za5LG36WAQIn/p+7RREk6zwz1h7XL1Oim6J9qY=;
        b=aeaZTPOSfGUpsV+oqRklMnr6rEE4YDt8WHKJLzcVkIN0jAxX4Oo0w5+UiEnvC7GLzT
         /0/RCQmo1ZV8keQehMySED1VxjZshRaHgaRtx4qrh70uj3YLf48At7QP8oRufmJ2v/bB
         ETPhkcPNwMQwW+MKsdo3+qqCZgunZwGmACfvOjN8wfi/4LGKLjf4iCYtplAbp7NAyloh
         Ul6djVHYpcIenzMvm8PxrsdeWxZtAM0L9fBZ3iobqMmm4gNBzf37PkabKXZAwUMSm567
         GLQ7y9e/Vp5zHZw1cn9T9N8IgGfKooyIlFV0bp+Wc03mDK5qU5Bjdrg+86gBdoNpAPrJ
         Ekqw==
X-Gm-Message-State: AOAM530Bo+UlkoQjd8//GECDxNL0ev8aXY2viGVMGZykM46gcf4vx2lO
        TXnJFsO7l5fTF0hQFZ6C0Nv5m0iMcAWV8Ix3FnRVyg==
X-Google-Smtp-Source: ABdhPJzgQAWP0UVeNClXBXz5HZWlyCLW/W0sYvvVfOIMPmCCczj7Jsc6Zz0Xghy5x1WchfQK5szKqfBJ0qz3qaHvV+Q=
X-Received: by 2002:a05:6214:2607:: with SMTP id gu7mr2176202qvb.18.1617184932943;
 Wed, 31 Mar 2021 03:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210331063202.28770-1-qiang.zhang@windriver.com>
In-Reply-To: <20210331063202.28770-1-qiang.zhang@windriver.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 31 Mar 2021 12:02:01 +0200
Message-ID: <CACT4Y+b91FHrbgqSzhmZ6j_u9v2B4YrWU9GMomQp9rS-sGM5SQ@mail.gmail.com>
Subject: Re: [PATCH] irq_work: record irq_work_queue() call stack
To:     "Zhang, Qiang" <qiang.zhang@windriver.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 8:32 AM <qiang.zhang@windriver.com> wrote:
>
> From: Zqiang <qiang.zhang@windriver.com>
>
> Add the irq_work_queue() call stack into the KASAN auxiliary
> stack in order to improve KASAN reports. this will let us know
> where the irq work be queued.
>
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  kernel/irq_work.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index e8da1e71583a..23a7a0ba1388 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -19,7 +19,7 @@
>  #include <linux/notifier.h>
>  #include <linux/smp.h>
>  #include <asm/processor.h>
> -
> +#include <linux/kasan.h>
>
>  static DEFINE_PER_CPU(struct llist_head, raised_list);
>  static DEFINE_PER_CPU(struct llist_head, lazy_list);
> @@ -70,6 +70,9 @@ bool irq_work_queue(struct irq_work *work)
>         if (!irq_work_claim(work))
>                 return false;
>
> +       /*record irq_work call stack in order to print it in KASAN reports*/
> +       kasan_record_aux_stack(work);
> +
>         /* Queue the entry and raise the IPI if needed. */
>         preempt_disable();
>         __irq_work_queue_local(work);
> @@ -98,6 +101,8 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
>         if (!irq_work_claim(work))
>                 return false;
>
> +       kasan_record_aux_stack(work);
> +
>         preempt_disable();
>         if (cpu != smp_processor_id()) {
>                 /* Arch remote IPI send/receive backend aren't NMI safe */
> --
> 2.17.1
>
