Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01829415C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 13:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbhIWLQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 07:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240448AbhIWLQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 07:16:46 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B83C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 04:15:14 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c19so5752350qte.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 04:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lqxtxP5+e+pk1U3fha6q3vivDTvYwQzQQPvtliibVDE=;
        b=L4y/1Lm4ytNJF6JNKYdVL8tcAFh1WWnHlnFZtx8mQFlyjrIPxYhsCO2n1NhBJ1z96f
         toZvW/UeILZLfvF/s/CmZgWt6xT9FmAtDOlnfIM8UrgJKSTI5CXLLYIraUilr6wMl+kj
         wpYLx8yY0b0E6xRlwbWKPSz6JGD2DbAG0jnWjv+luUgLxUZqnvBxb0zWBDI/2Y/p/wAb
         ZTQPfyU1W10X8q5pTuJOa9nes1SdHsi3Fh/ZfjkCYtKMhnOmFAz4l5TmF3VojI4i/Mdq
         WZWr7lUn3R8zD8uegvHMnHXszFAp0WnbV/73soEd0jWhcF2mNKf2lb1puj5M+TaTfp6u
         7FCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lqxtxP5+e+pk1U3fha6q3vivDTvYwQzQQPvtliibVDE=;
        b=GaXt4joePUANgjEw5tsZZT2tKq3APoq+IyLzFx1y0eJKBT3Q9rlCalTRmEixBBXTOq
         m5bs3bpAvHU8B6kxUT1ly8vQjC+dJex29qc+cjrWjJnbk8F5th5jP9iCXh4sP7zBsExF
         JLxHcsL2GM+27cyFqm1aQXsfhPaoCOJMWEG22SfJDAerwPVecn4ak0kDy7nnnzFrlftN
         MB5GxV2Xg88ke0lKxmsxUZ5GPC++MBxjqNfWkiVvx680lb8GECeLn6EMhAA2koZmFheG
         LJM4qlkVtYDtbr9vgHoIBJ/C6PmShMij/rTEjfY9y+FQrhG1cWk8kV6f5ofLDJkQBEH0
         xaKQ==
X-Gm-Message-State: AOAM532Ph7G3ctqVo0WHUkANkpSh6MP/V+iBi8Qs9R9vahe0pcLMUelK
        mPzyZFfajQ/P3+TtW2DaZRV4Gh7gEG+Y5PG5BBSjkg==
X-Google-Smtp-Source: ABdhPJz2u4j3X9ahIq9/HugIftpzeYB9Ri1uDJLz8KEDeMWAQCFa8lxV7bqUe/nJi++C9NGOnPwR6sGUN1fF7d4Qb9c=
X-Received: by 2002:ac8:5c49:: with SMTP id j9mr4078733qtj.246.1632395713528;
 Thu, 23 Sep 2021 04:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210923104803.2620285-1-elver@google.com>
In-Reply-To: <20210923104803.2620285-1-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 23 Sep 2021 13:14:36 +0200
Message-ID: <CAG_fn=Vr7CJiug+C2LT2U5wdmysG5BbTFwU2-yaz-pe0kvaXPw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] stacktrace: move filter_irq_stacks() to kernel/stacktrace.c
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 12:48 PM Marco Elver <elver@google.com> wrote:
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
> Acked-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Alexander Potapenko <glider@google.com>

> ---
> v3:
> * Rebase to -next due to conflicting stackdepot changes.
>
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
> index ee03f11bb51a..c34b55a6e554 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -30,8 +30,6 @@ int stack_depot_snprint(depot_stack_handle_t handle, ch=
ar *buf, size_t size,
>
>  void stack_depot_print(depot_stack_handle_t stack);
>
> -unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_e=
ntries);
> -
>  #ifdef CONFIG_STACKDEPOT
>  int stack_depot_init(void);
>  #else
> diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
> index 9edecb494e9e..bef158815e83 100644
> --- a/include/linux/stacktrace.h
> +++ b/include/linux/stacktrace.h
> @@ -21,6 +21,7 @@ unsigned int stack_trace_save_tsk(struct task_struct *t=
ask,
>  unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *=
store,
>                                    unsigned int size, unsigned int skipnr=
);
>  unsigned int stack_trace_save_user(unsigned long *store, unsigned int si=
ze);
> +unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_e=
ntries);
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
> @@ -373,3 +374,32 @@ unsigned int stack_trace_save_user(unsigned long *st=
ore, unsigned int size)
>  #endif /* CONFIG_USER_STACKTRACE_SUPPORT */
>
>  #endif /* !CONFIG_ARCH_STACKWALK */
> +
> +static inline bool in_irqentry_text(unsigned long ptr)
> +{
> +       return (ptr >=3D (unsigned long)&__irqentry_text_start &&
> +               ptr < (unsigned long)&__irqentry_text_end) ||
> +               (ptr >=3D (unsigned long)&__softirqentry_text_start &&
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
> +unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_e=
ntries)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < nr_entries; i++) {
> +               if (in_irqentry_text(entries[i])) {
> +                       /* Include the irqentry function into the stack. =
*/
> +                       return i + 1;
> +               }
> +       }
> +       return nr_entries;
> +}
> +EXPORT_SYMBOL_GPL(filter_irq_stacks);
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 69c8c9b0d8d7..b437ae79aca1 100644
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
> @@ -417,26 +416,3 @@ depot_stack_handle_t stack_depot_save(unsigned long =
*entries,
>         return __stack_depot_save(entries, nr_entries, alloc_flags, true)=
;
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_save);
> -
> -static inline int in_irqentry_text(unsigned long ptr)
> -{
> -       return (ptr >=3D (unsigned long)&__irqentry_text_start &&
> -               ptr < (unsigned long)&__irqentry_text_end) ||
> -               (ptr >=3D (unsigned long)&__softirqentry_text_start &&
> -                ptr < (unsigned long)&__softirqentry_text_end);
> -}
> -
> -unsigned int filter_irq_stacks(unsigned long *entries,
> -                                            unsigned int nr_entries)
> -{
> -       unsigned int i;
> -
> -       for (i =3D 0; i < nr_entries; i++) {
> -               if (in_irqentry_text(entries[i])) {
> -                       /* Include the irqentry function into the stack. =
*/
> -                       return i + 1;
> -               }
> -       }
> -       return nr_entries;
> -}
> -EXPORT_SYMBOL_GPL(filter_irq_stacks);
> --
> 2.33.0.464.g1972c5931b-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
