Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36C0352BFF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbhDBOxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 10:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBOxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 10:53:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAEFC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 07:53:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f8so1670220edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 07:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/1WuCFaVg2qZDoIsLGEvJzgk8evknJYEFhCJTn/Qj0=;
        b=n8v/eyMafFStBbaqzhdb42dXlDzaKbInNwLUMNfmfb5+dLoFjX4uOtaxhYby4ehVuG
         9yJtN3Y2cags3svVbaGrhNSGQpcDStwJ3rIIcnb46jGKNWuQugmWUYhhVaSkQ+233H4F
         c4Z05XBMAQTK35YlxDWHSxlSlLx45Rdc6sw/YjwdhMQcNWy4vlkyMCU/N/ZSrGbg5Jtk
         mJMDvAWIF17QWfYZYaw/sGnGuaUKhwMEqvWWd0cmTn36ZhvbFpjP3HYhTDKbfJEqLbrG
         jmhtMcUcxaHpcKqe/rpJxs3kKfWkSDI2n2zmdVs4TvmVJTaJBP2DECyWS43l/0oZ+ldt
         IVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/1WuCFaVg2qZDoIsLGEvJzgk8evknJYEFhCJTn/Qj0=;
        b=He5a0D9IxKC48FE4z5JMjgQw3BKYEesJIPsLLQlFEIl+BO0tWsOZlZxQiIWzZjR0EN
         nrWkteTv3MwDzsKewnsrYrx6TfAY3ck0cuT4dCubS6RbJ32rR/mrk4nRdfLFFlLF5Nab
         kQ3z9cVfqQIQg30na3mXr0aU/XO02qMAswVygTNWv18hRG201WqyrujRh4qWCs1tQkVG
         ZZVRp5xNqbPu+nrP4JpK06YYoEqZibcEIOo2MoPruXppn4jmLunFnBLtD+NZqq7/j2jc
         QRoQLCQhaTNYj1c8KvLnfFX6sowm7ow6dhybxVbRnCj4s40tWE1SDu6EbAYcW/xSdJ9e
         ZVdg==
X-Gm-Message-State: AOAM530TUCGjZZ+/g5YZw57Z+u48csHy6mSBpeHr35awLBezmXMDX/rF
        sQxvPc/ACP+o06BOFxLnerTlCjmFmzTNCyupde0=
X-Google-Smtp-Source: ABdhPJwUI+XuPAxAnx/5rc8SbceaMN6W/YCfefKDQok1UFcLU3uM9VDW5sYH1zYPw28s2LtOcFI7qpi5f83kK+ItZqE=
X-Received: by 2002:aa7:ce16:: with SMTP id d22mr15679489edv.95.1617375190744;
 Fri, 02 Apr 2021 07:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210331063202.28770-1-qiang.zhang@windriver.com>
In-Reply-To: <20210331063202.28770-1-qiang.zhang@windriver.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 2 Apr 2021 16:52:59 +0200
Message-ID: <CA+fCnZd01XGoVVRwGZnNYDrVPxuWJ_yf7tuNcW-HXfG69fKTbw@mail.gmail.com>
Subject: Re: [PATCH] irq_work: record irq_work_queue() call stack
To:     qiang.zhang@windriver.com
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, matthias.bgg@gmail.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, oleg@redhat.com,
        walter-zh.wu@mediatek.com, frederic@kernel.org,
        kasan-dev@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
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

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>
