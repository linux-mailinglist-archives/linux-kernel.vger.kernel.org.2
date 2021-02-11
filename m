Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19748319201
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhBKSOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbhBKRwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:52:35 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9A8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:51:12 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id t25so4431777pga.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vt7Fl48/IoYwLXAX21jt2ptSlKZXuflqfasvRCaCF+Y=;
        b=DIVMD1rwgjQmYjOJCUj6HaRTbueN+PkXXCN4qUJInpkrSOVfA2P6HJzyO8szlbTqka
         0yUmNYAnufAlZoPyoASx/jmvy7iWiGJvwSLhq4wOZ5RU/CuEuF2C58CaAX7jg1nxaZgh
         wtNciudgT7JCg/Ds3DEWodKaIfqnj13OSaDAUMXGBLdrIz2XlavLU/emJBmSS5e3iOfn
         jN9lu1uzth6ChUwIUEy89ulyBeDlbR67yyBn0bapA62sFc9UDgNDJi3f6QkSMmOn6RaF
         CDI9sqAwTki4w3e/H1yclJ1Srlb7EstCSFDepHtRW7A7QEgagQmTYvtHSleqyqLZlGlM
         0Hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vt7Fl48/IoYwLXAX21jt2ptSlKZXuflqfasvRCaCF+Y=;
        b=YKKJUxUvnc9yqtqk55VI0xWgt7o/4XIhEXUujqH6zi0jpoyqB1gESVVnQ6g0sxqzHA
         NTfhLNtMPCUU5yeJMTNIL/1ZW1tts44K0yYk+e1VxblvqQ1LTiG7O47QWvpq136lQcUL
         TLdIM6O3lewcNn/HaOKWLvRdle/AsyXPtTnwV0R9yWDfqgT51lSykhYZpf3SlQH3ux2a
         pSDJH0f628Z3g5mOsIskh9rc9xuRZtL8rElMaoaaY2ZBlOU/CO0Rr+AFovCtveIganP8
         wPMj/nC9Ys+8jpsXcG5UW69HCcP16vUTCOViYVzzgi8laEEMQpYcnKJ7Ln6ZH8nrlSyW
         uDfQ==
X-Gm-Message-State: AOAM533Goym0ho0OinZUcjJSuf/5sVGjS4GKm310kVRt55wcPJ7iW18p
        wbF5cqY39b/TfvPykwk3Y0vas45CL6kQk70zrL0ghA==
X-Google-Smtp-Source: ABdhPJxXhuJedJFu0MWm0PxqK73boNu2397jcxs3XgkyT9xy65AhgOe6pu5E29KsgWmKzDv9vkY7b/KcStNytTHra5Y=
X-Received: by 2002:a63:416:: with SMTP id 22mr9063460pge.286.1613065871687;
 Thu, 11 Feb 2021 09:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20210211153353.29094-1-vincenzo.frascino@arm.com> <20210211153353.29094-3-vincenzo.frascino@arm.com>
In-Reply-To: <20210211153353.29094-3-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 11 Feb 2021 18:50:59 +0100
Message-ID: <CAAeHK+zefPsq6pzO-bTz-xOXQrNkwuCS8i9L7EXLxH=SkKAgJw@mail.gmail.com>
Subject: Re: [PATCH v13 2/7] kasan: Add KASAN mode kernel parameter
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 4:34 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Architectures supported by KASAN_HW_TAGS can provide a sync or async mode
> of execution. On an MTE enabled arm64 hw for example this can be identified
> with the synchronous or asynchronous tagging mode of execution.
> In synchronous mode, an exception is triggered if a tag check fault occurs.
> In asynchronous mode, if a tag check fault occurs, the TFSR_EL1 register is
> updated asynchronously. The kernel checks the corresponding bits
> periodically.
>
> KASAN requires a specific kernel command line parameter to make use of this
> hw features.
>
> Add KASAN HW execution mode kernel command line parameter.
>
> Note: This patch adds the kasan.mode kernel parameter and the
> sync/async kernel command line options to enable the described features.
>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> [ Add a new var instead of exposing kasan_arg_mode to be consistent with
>   flags for other command line arguments. ]
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  Documentation/dev-tools/kasan.rst |  9 ++++++
>  lib/test_kasan.c                  |  2 +-
>  mm/kasan/hw_tags.c                | 52 ++++++++++++++++++++++++++++++-
>  mm/kasan/kasan.h                  |  7 +++--
>  4 files changed, 66 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index ddf4239a5890..6f6ab3ed7b79 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -161,6 +161,15 @@ particular KASAN features.
>
>  - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
>
> +- ``kasan.mode=sync`` or ``=async`` controls whether KASAN is configured in
> +  synchronous or asynchronous mode of execution (default: ``sync``).
> +  Synchronous mode: a bad access is detected immediately when a tag
> +  check fault occurs.
> +  Asynchronous mode: a bad access detection is delayed. When a tag check
> +  fault occurs, the information is stored in hardware (in the TFSR_EL1
> +  register for arm64). The kernel periodically checks the hardware and
> +  only reports tag faults during these checks.
> +
>  - ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
>    traces collection (default: ``on``).
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 1328c468fdb5..f8c72d3aed64 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -97,7 +97,7 @@ static void kasan_test_exit(struct kunit *test)
>                         READ_ONCE(fail_data.report_found));     \
>         if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {                 \
>                 if (READ_ONCE(fail_data.report_found))          \
> -                       hw_enable_tagging();                    \
> +                       hw_enable_tagging_sync();               \
>                 migrate_enable();                               \
>         }                                                       \
>  } while (0)
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 1dfe4f62a89e..bd249d1f6cdc 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -25,6 +25,12 @@ enum kasan_arg {
>         KASAN_ARG_ON,
>  };
>
> +enum kasan_arg_mode {
> +       KASAN_ARG_MODE_DEFAULT,
> +       KASAN_ARG_MODE_SYNC,
> +       KASAN_ARG_MODE_ASYNC,
> +};
> +
>  enum kasan_arg_stacktrace {
>         KASAN_ARG_STACKTRACE_DEFAULT,
>         KASAN_ARG_STACKTRACE_OFF,
> @@ -38,6 +44,7 @@ enum kasan_arg_fault {
>  };
>
>  static enum kasan_arg kasan_arg __ro_after_init;
> +static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
>  static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
>  static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
>
> @@ -45,6 +52,10 @@ static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
>  DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
>  EXPORT_SYMBOL(kasan_flag_enabled);
>
> +/* Whether the asynchronous mode is enabled. */
> +bool kasan_flag_async __ro_after_init;
> +EXPORT_SYMBOL_GPL(kasan_flag_async);
> +
>  /* Whether to collect alloc/free stack traces. */
>  DEFINE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
>
> @@ -68,6 +79,21 @@ static int __init early_kasan_flag(char *arg)
>  }
>  early_param("kasan", early_kasan_flag);
>
> +/* kasan.mode=sync/async */
> +static int __init early_kasan_mode(char *arg)
> +{
> +       /* If arg is not set the default mode is sync */
> +       if ((!arg) || !strcmp(arg, "sync"))

Let's default to KASAN_ARG_MODE_DEFAULT like for other args:

if (!arg)
  return -EINVAL;

kasan_init_hw_tags_cpu()/kasan_init_hw_tags() already handle
KASAN_ARG_MODE_DEFAULT properly.

> +               kasan_arg_mode = KASAN_ARG_MODE_SYNC;
> +       else if (!strcmp(arg, "async"))
> +               kasan_arg_mode = KASAN_ARG_MODE_ASYNC;
> +       else
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +early_param("kasan.mode", early_kasan_mode);
> +
>  /* kasan.stacktrace=off/on */
>  static int __init early_kasan_flag_stacktrace(char *arg)
>  {
> @@ -115,7 +141,15 @@ void kasan_init_hw_tags_cpu(void)
>                 return;
>
>         hw_init_tags(KASAN_TAG_MAX);
> -       hw_enable_tagging();
> +
> +       /*
> +        * Enable async mode only when explicitly requested through
> +        * the command line.
> +        */
> +       if (kasan_arg_mode == KASAN_ARG_MODE_ASYNC)
> +               hw_enable_tagging_async();
> +       else
> +               hw_enable_tagging_sync();
>  }
>
>  /* kasan_init_hw_tags() is called once on boot CPU. */
> @@ -132,6 +166,22 @@ void __init kasan_init_hw_tags(void)
>         /* Enable KASAN. */
>         static_branch_enable(&kasan_flag_enabled);
>
> +       switch (kasan_arg_mode) {
> +       case KASAN_ARG_MODE_DEFAULT:
> +               /*
> +                * Default to sync mode.
> +                * Do nothing, kasan_flag_async keeps its default value.
> +                */
> +               break;
> +       case KASAN_ARG_MODE_SYNC:
> +               /* Do nothing, kasan_flag_async keeps its default value. */
> +               break;
> +       case KASAN_ARG_MODE_ASYNC:
> +               /* Async mode enabled. */
> +               kasan_flag_async = true;
> +               break;
> +       }
> +
>         switch (kasan_arg_stacktrace) {
>         case KASAN_ARG_STACKTRACE_DEFAULT:
>                 /* Default to enabling stack trace collection. */
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index cc787ba47e1b..98f70ffc9e1c 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -21,6 +21,7 @@ static inline bool kasan_stack_collection_enabled(void)
>  #endif
>
>  extern bool kasan_flag_panic __ro_after_init;
> +extern bool kasan_flag_async __ro_after_init;
>
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  #define KASAN_GRANULE_SIZE     (1UL << KASAN_SHADOW_SCALE_SHIFT)
> @@ -294,7 +295,8 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  #define arch_set_mem_tag_range(addr, size, tag) ((void *)(addr))
>  #endif
>
> -#define hw_enable_tagging()                    arch_enable_tagging()
> +#define hw_enable_tagging_sync()               arch_enable_tagging_sync()
> +#define hw_enable_tagging_async()              arch_enable_tagging_async()
>  #define hw_init_tags(max_tag)                  arch_init_tags(max_tag)
>  #define hw_set_tagging_report_once(state)      arch_set_tagging_report_once(state)
>  #define hw_get_random_tag()                    arch_get_random_tag()
> @@ -303,7 +305,8 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>
>  #else /* CONFIG_KASAN_HW_TAGS */
>
> -#define hw_enable_tagging()
> +#define hw_enable_tagging_sync()
> +#define hw_enable_tagging_async()
>  #define hw_set_tagging_report_once(state)
>
>  #endif /* CONFIG_KASAN_HW_TAGS */
> --
> 2.30.0
>
