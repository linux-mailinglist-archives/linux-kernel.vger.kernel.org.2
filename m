Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572374131EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhIUKti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhIUKte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:49:34 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFC1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:48:05 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 67-20020a9d0449000000b00546e5a8062aso15648451otc.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2DaWAIvqIvKGgWien1JtzLRCFsCI+adGg6lemtVNxaQ=;
        b=PVwaMyY2SzYiYojjnC0LgwVE2ZPee1JP+KQ6wUOJiF2MSjNnN/F9fkoiXW1LzXX6c8
         sYasmYqKkBuipBwOVwbsMPa4TLgwWqVCcad3ksy9nQyEBh2S3fIrUKWEgzSW43tOvN/4
         XVPeIJvxZowqjAFKVvP+jAu/32o8Nns0EAB69gU8PI13oUwQHQk6kwC2zP9fgC5/2AuF
         uhrUkdCTXDO0m3AB7ixP0F6J42P3lOaTriDdIuSdMa0hdMmllwTzvLvmgtsnjmlvUHnn
         XUlw3LzdlGhw6+QXAbHtn1xBDD2W/yHOtspMhQNrbHKlcHakQjUX4HnfegQ4RPibQ7mc
         H/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DaWAIvqIvKGgWien1JtzLRCFsCI+adGg6lemtVNxaQ=;
        b=62q32/rpCoBop4ODenC81LQnrH6XVlbeshBlrzn1DtMxPV36mFUnkLMGb/DssPc/Ld
         1jDvUeV236MpxswPeDgMyfXZdM5U2wEsQ6dpSYdg9+Zf8/LxZl9q3PyNuO7vlsv1eUfo
         M/u5ZkbYE7lKermAf/ANgV/rFT8ogpFC4MGGVzpjJU/uwgyNCyNPP9CnEhr0cXP7ILXI
         xZXWXWCfAtZO+OccWoXQCMYAapXbD5rsJzYZqyFzmlFc9HPxgpfd8rB4r2eI3HQNIXdp
         62JXbeJRBwhIwac50JPgucQizxHbzplpVmqL4VAW6F4r6JsM4SzfOxzXc3r+X14i/t8x
         3tvQ==
X-Gm-Message-State: AOAM532mV6b7uwvfysL7cgdbLrLzrzaIkL44fo84+8mqX74+SHHPdS52
        N/wpYfLA+qpfeRwoNPAkLkcZaLg2dmcAMhelKehh4A==
X-Google-Smtp-Source: ABdhPJxsKLnog/IpynJxdJiHfWXbirlaW0ZuG294oHp7aBPrZTB/Yt9jhgHmw77UTwMRA5R0tLpfwjnTWxV9FWRlTH0=
X-Received: by 2002:a9d:7244:: with SMTP id a4mr25928089otk.137.1632221283883;
 Tue, 21 Sep 2021 03:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210921101014.1938382-1-elver@google.com>
In-Reply-To: <20210921101014.1938382-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 21 Sep 2021 12:47:52 +0200
Message-ID: <CACT4Y+aUD=hRR0oJH7Spcs375RNuRxga=umSzgN7PsZG4kX4BQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] stacktrace: move filter_irq_stacks() to kernel/stacktrace.c
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sept 2021 at 12:10, Marco Elver <elver@google.com> wrote:
>
> filter_irq_stacks() has little to do with the stackdepot implementation,
> except that it is usually used by users (such as KASAN) of stackdepot to
> reduce the stack trace.
>
> However, filter_irq_stacks() itself is not useful without a stack trace
> as obtained by stack_trace_save() and friends.
>
> Therefore, move filter_irq_stacks() to kernel/stacktrace.c, so that new
> users of filter_irq_stacks() do not have to start depending on
> STACKDEPOT only for filter_irq_stacks().
>
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> v2:
> * New patch.
> ---
>  include/linux/stackdepot.h |  2 --
>  include/linux/stacktrace.h |  1 +
>  kernel/stacktrace.c        | 30 ++++++++++++++++++++++++++++++
>  lib/stackdepot.c           | 24 ------------------------
>  4 files changed, 31 insertions(+), 26 deletions(-)
>
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index 6bb4bc1a5f54..22919a94ca19 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -19,8 +19,6 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
>  unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>                                unsigned long **entries);
>
> -unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_entries);
> -
>  #ifdef CONFIG_STACKDEPOT
>  int stack_depot_init(void);
>  #else
> diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
> index 9edecb494e9e..bef158815e83 100644
> --- a/include/linux/stacktrace.h
> +++ b/include/linux/stacktrace.h
> @@ -21,6 +21,7 @@ unsigned int stack_trace_save_tsk(struct task_struct *task,
>  unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
>                                    unsigned int size, unsigned int skipnr);
>  unsigned int stack_trace_save_user(unsigned long *store, unsigned int size);
> +unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_entries);
>
>  /* Internal interfaces. Do not use in generic code */
>  #ifdef CONFIG_ARCH_STACKWALK
> diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
> index 9f8117c7cfdd..9c625257023d 100644
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -13,6 +13,7 @@
>  #include <linux/export.h>
>  #include <linux/kallsyms.h>
>  #include <linux/stacktrace.h>
> +#include <linux/interrupt.h>
>
>  /**
>   * stack_trace_print - Print the entries in the stack trace
> @@ -373,3 +374,32 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
>  #endif /* CONFIG_USER_STACKTRACE_SUPPORT */
>
>  #endif /* !CONFIG_ARCH_STACKWALK */
> +
> +static inline bool in_irqentry_text(unsigned long ptr)
> +{
> +       return (ptr >= (unsigned long)&__irqentry_text_start &&
> +               ptr < (unsigned long)&__irqentry_text_end) ||
> +               (ptr >= (unsigned long)&__softirqentry_text_start &&
> +                ptr < (unsigned long)&__softirqentry_text_end);
> +}
> +
> +/**
> + * filter_irq_stacks - Find first IRQ stack entry in trace
> + * @entries:   Pointer to stack trace array
> + * @nr_entries:        Number of entries in the storage array
> + *
> + * Return: Number of trace entries until IRQ stack starts.
> + */
> +unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_entries)
> +{
> +       unsigned int i;
> +
> +       for (i = 0; i < nr_entries; i++) {
> +               if (in_irqentry_text(entries[i])) {
> +                       /* Include the irqentry function into the stack. */
> +                       return i + 1;
> +               }
> +       }
> +       return nr_entries;
> +}
> +EXPORT_SYMBOL_GPL(filter_irq_stacks);
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 0a2e417f83cb..e90f0f19e77f 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -20,7 +20,6 @@
>   */
>
>  #include <linux/gfp.h>
> -#include <linux/interrupt.h>
>  #include <linux/jhash.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> @@ -341,26 +340,3 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
>         return retval;
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_save);
> -
> -static inline int in_irqentry_text(unsigned long ptr)
> -{
> -       return (ptr >= (unsigned long)&__irqentry_text_start &&
> -               ptr < (unsigned long)&__irqentry_text_end) ||
> -               (ptr >= (unsigned long)&__softirqentry_text_start &&
> -                ptr < (unsigned long)&__softirqentry_text_end);
> -}
> -
> -unsigned int filter_irq_stacks(unsigned long *entries,
> -                                            unsigned int nr_entries)
> -{
> -       unsigned int i;
> -
> -       for (i = 0; i < nr_entries; i++) {
> -               if (in_irqentry_text(entries[i])) {
> -                       /* Include the irqentry function into the stack. */
> -                       return i + 1;
> -               }
> -       }
> -       return nr_entries;
> -}
> -EXPORT_SYMBOL_GPL(filter_irq_stacks);
> --
> 2.33.0.464.g1972c5931b-goog
>
