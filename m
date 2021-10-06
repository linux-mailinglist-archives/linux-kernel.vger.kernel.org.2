Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3542E423D9B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbhJFMVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238105AbhJFMVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:21:31 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D454C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 05:19:39 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id b6so2703815ilv.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 05:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EPyyphJxeyPemnnSLcLAKB5S740xdXOZ+FC+Ivvdl7M=;
        b=hqCNaDzbEICZVdnPNQH57Q9f7GpbbVsmUY8YOPQTzLYL0DB7A4udnqGzNQZ2TfXF3p
         ShwNVSjLyT2gyEcTpMsO3vehnfMBUBx1C0LkMXPm9FrOWYT7lkTk4EBgAZgX6ggO8hcJ
         Qf0u/CNTsNQ5PlF5wEYkj8ivKay1/y7aBlu7zPv17rE2L+zTBUhMkJfop3k5azU17jdw
         2a5j7u6Xp40eyRg7msINaAfaArb5G3r3kriPqMpKvD8FPyaqtd30NY3kXqjK4vNFcI8E
         FdtYTaXVOJrEifLwmdex+kU6IdQCHYVmZlxmy+STQS6aehq5YmY2juwENWDyiLm/HFDf
         TH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPyyphJxeyPemnnSLcLAKB5S740xdXOZ+FC+Ivvdl7M=;
        b=HMKGSP3s4t11qcsAIL7n5qnfzzSGWmMNZKALjspzFsW/VPNiFgD4KFdpLzOFd3yPYn
         CojAgspq1ZpRVrrGJ6sqzPdVao4qx15MZ/kSMHQNT2wpZ4s7+sPY6coys5vZecId0+6F
         eYZq0e8NByU0CU45l1TCpa/Kv90D8OM6O8yowP3Y576urcOCqwZCyBzV6x7fQxqrJp9f
         HGwt9kisYO+MOO5yEvbs5fDpSMzNzRo7dD8vlnvgqgnFbBs7IaXatKFVen16cjjGg4Gm
         yYa5GXoyV6YDWnaJ9UdLelSLXB/jJlWI9rL8HtT2I+35z9Dqry2eDXB43wihJDzHQu/t
         qSGw==
X-Gm-Message-State: AOAM533U+bhMMiJa9TVUpWAI5EzGjh49Moj4CgYqEgueMyAyHbfyvW2B
        ENhyz2egAylmYoWFOrCPh1wLP3S4RI2N6Y3rKSI=
X-Google-Smtp-Source: ABdhPJznSuFEu7/zn4CRaZy2Zc1UWPbVnvujzY3lpvfSDctC4X+sclsiXKcOj036k0hLNiKfMo0bGmznV4MJuSazfUU=
X-Received: by 2002:a05:6e02:1d1e:: with SMTP id i30mr7393102ila.248.1633522778960;
 Wed, 06 Oct 2021 05:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211004202253.27857-1-vincenzo.frascino@arm.com> <20211004202253.27857-6-vincenzo.frascino@arm.com>
In-Reply-To: <20211004202253.27857-6-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 6 Oct 2021 14:19:28 +0200
Message-ID: <CA+fCnZfuu3MLgeSJONqKaXMzkBsGxTQYjTtF0_=fMf4dGGQZCw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] kasan: Extend KASAN mode kernel parameter
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

On Mon, Oct 4, 2021 at 10:23 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Architectures supported by KASAN_HW_TAGS can provide an asymmetric mode
> of execution. On an MTE enabled arm64 hw for example this can be
> identified with the asymmetric tagging mode of execution. In particular,
> when such a mode is present, the CPU triggers a fault on a tag mismatch
> during a load operation and asynchronously updates a register when a tag
> mismatch is detected during a store operation.
>
> Extend the KASAN HW execution mode kernel command line parameter to
> support asymmetric mode.
>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  Documentation/dev-tools/kasan.rst |  7 +++++--
>  lib/test_kasan.c                  |  2 +-
>  mm/kasan/hw_tags.c                | 27 ++++++++++++++++++++++-----
>  mm/kasan/kasan.h                  | 22 +++++++++++++++++++---
>  mm/kasan/report.c                 |  2 +-
>  5 files changed, 48 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 21dc03bc10a4..8089c559d339 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -194,14 +194,17 @@ additional boot parameters that allow disabling KASAN or controlling features:
>
>  - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
>
> -- ``kasan.mode=sync`` or ``=async`` controls whether KASAN is configured in
> -  synchronous or asynchronous mode of execution (default: ``sync``).
> +- ``kasan.mode=sync``, ``=async`` or ``=asymm`` controls whether KASAN
> +  is configured in synchronous, asynchronous or asymmetric mode of
> +  execution (default: ``sync``).
>    Synchronous mode: a bad access is detected immediately when a tag
>    check fault occurs.
>    Asynchronous mode: a bad access detection is delayed. When a tag check
>    fault occurs, the information is stored in hardware (in the TFSR_EL1
>    register for arm64). The kernel periodically checks the hardware and
>    only reports tag faults during these checks.
> +  Asymmetric mode: a bad access is detected synchronously on reads and
> +  asynchronously on writes.
>
>  - ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
>    traces collection (default: ``on``).
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 8835e0784578..ebed755ebf34 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -88,7 +88,7 @@ static void kasan_test_exit(struct kunit *test)
>   */
>  #define KUNIT_EXPECT_KASAN_FAIL(test, expression) do {                 \
>         if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&                         \
> -           !kasan_async_mode_enabled())                                \
> +           kasan_sync_fault_possible())                                \
>                 migrate_disable();                                      \
>         KUNIT_EXPECT_FALSE(test, READ_ONCE(fail_data.report_found));    \
>         barrier();                                                      \
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 05d1e9460e2e..87eb7aa13918 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -29,6 +29,7 @@ enum kasan_arg_mode {
>         KASAN_ARG_MODE_DEFAULT,
>         KASAN_ARG_MODE_SYNC,
>         KASAN_ARG_MODE_ASYNC,
> +       KASAN_ARG_MODE_ASYMM,
>  };
>
>  enum kasan_arg_stacktrace {
> @@ -49,6 +50,10 @@ EXPORT_SYMBOL(kasan_flag_enabled);
>  bool kasan_flag_async __ro_after_init;
>  EXPORT_SYMBOL_GPL(kasan_flag_async);
>
> +/* Whether the asymmetric mode is enabled. */
> +bool kasan_flag_asymm __ro_after_init;
> +EXPORT_SYMBOL_GPL(kasan_flag_asymm);
> +
>  /* Whether to collect alloc/free stack traces. */
>  DEFINE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
>
> @@ -69,7 +74,7 @@ static int __init early_kasan_flag(char *arg)
>  }
>  early_param("kasan", early_kasan_flag);
>
> -/* kasan.mode=sync/async */
> +/* kasan.mode=sync/async/asymm */
>  static int __init early_kasan_mode(char *arg)
>  {
>         if (!arg)
> @@ -79,6 +84,8 @@ static int __init early_kasan_mode(char *arg)
>                 kasan_arg_mode = KASAN_ARG_MODE_SYNC;
>         else if (!strcmp(arg, "async"))
>                 kasan_arg_mode = KASAN_ARG_MODE_ASYNC;
> +       else if (!strcmp(arg, "asymm"))
> +               kasan_arg_mode = KASAN_ARG_MODE_ASYMM;
>         else
>                 return -EINVAL;
>
> @@ -116,11 +123,13 @@ void kasan_init_hw_tags_cpu(void)
>                 return;
>
>         /*
> -        * Enable async mode only when explicitly requested through
> -        * the command line.
> +        * Enable async or asymm modes only when explicitly requested
> +        * through the command line.
>          */
>         if (kasan_arg_mode == KASAN_ARG_MODE_ASYNC)
>                 hw_enable_tagging_async();
> +       else if (kasan_arg_mode == KASAN_ARG_MODE_ASYMM)
> +               hw_enable_tagging_asymm();
>         else
>                 hw_enable_tagging_sync();
>  }
> @@ -143,16 +152,24 @@ void __init kasan_init_hw_tags(void)
>         case KASAN_ARG_MODE_DEFAULT:
>                 /*
>                  * Default to sync mode.
> -                * Do nothing, kasan_flag_async keeps its default value.
> +                * Do nothing, kasan_flag_async and kasan_flag_asymm keep
> +                * their default values.
>                  */
>                 break;
>         case KASAN_ARG_MODE_SYNC:
> -               /* Do nothing, kasan_flag_async keeps its default value. */
> +               /*
> +                * Do nothing, kasan_flag_async and kasan_flag_asymm keep
> +                * their default values.
> +                */
>                 break;
>         case KASAN_ARG_MODE_ASYNC:
>                 /* Async mode enabled. */
>                 kasan_flag_async = true;
>                 break;
> +       case KASAN_ARG_MODE_ASYMM:
> +               /* Asymm mode enabled. */
> +               kasan_flag_asymm = true;
> +               break;
>         }
>
>         switch (kasan_arg_stacktrace) {
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 3639e7c8bb98..1d331ce67dec 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -14,15 +14,21 @@
>
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
>  extern bool kasan_flag_async __ro_after_init;
> +extern bool kasan_flag_asymm __ro_after_init;
>
>  static inline bool kasan_stack_collection_enabled(void)
>  {
>         return static_branch_unlikely(&kasan_flag_stacktrace);
>  }
>
> -static inline bool kasan_async_mode_enabled(void)
> +static inline bool kasan_async_fault_possible(void)
>  {
> -       return kasan_flag_async;
> +       return kasan_flag_async | kasan_flag_asymm;
> +}
> +
> +static inline bool kasan_sync_fault_possible(void)
> +{
> +       return !kasan_flag_async | kasan_flag_asymm;

This should be just !kasan_flag_async.

It seems that choosing one exclusive option out of 3 via two bools is
confusing. How about an enum?

enum kasan_mode {
  KASAN_MODE_SYNC,
  KASAN_MODE_ASYNC,
  KASAN_MODE_ASYMM,
};

enum kasan_mode kasan_mode __ro_after_init;
EXPORT_SYMBOL_GPL(kasan_mode);

I also agree with Marco re using || instead of |.


>  }
>  #else
>
> @@ -31,11 +37,16 @@ static inline bool kasan_stack_collection_enabled(void)
>         return true;
>  }
>
> -static inline bool kasan_async_mode_enabled(void)
> +static inline bool kasan_async_fault_possible(void)
>  {
>         return false;
>  }
>
> +static inline bool kasan_sync_fault_possible(void)
> +{
> +       return true;
> +}
> +
>  #endif
>
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> @@ -287,6 +298,9 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  #ifndef arch_enable_tagging_async
>  #define arch_enable_tagging_async()
>  #endif
> +#ifndef arch_enable_tagging_asymm
> +#define arch_enable_tagging_asymm()
> +#endif
>  #ifndef arch_force_async_tag_fault
>  #define arch_force_async_tag_fault()
>  #endif
> @@ -302,6 +316,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>
>  #define hw_enable_tagging_sync()               arch_enable_tagging_sync()
>  #define hw_enable_tagging_async()              arch_enable_tagging_async()
> +#define hw_enable_tagging_asymm()              arch_enable_tagging_asymm()
>  #define hw_force_async_tag_fault()             arch_force_async_tag_fault()
>  #define hw_get_random_tag()                    arch_get_random_tag()
>  #define hw_get_mem_tag(addr)                   arch_get_mem_tag(addr)
> @@ -312,6 +327,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>
>  #define hw_enable_tagging_sync()
>  #define hw_enable_tagging_async()
> +#define hw_enable_tagging_asymm()
>
>  #endif /* CONFIG_KASAN_HW_TAGS */
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 884a950c7026..9da071ad930c 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -112,7 +112,7 @@ static void start_report(unsigned long *flags)
>
>  static void end_report(unsigned long *flags, unsigned long addr)
>  {
> -       if (!kasan_async_mode_enabled())
> +       if (!kasan_async_fault_possible())
>                 trace_error_report_end(ERROR_DETECTOR_KASAN, addr);
>         pr_err("==================================================================\n");
>         add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> --
> 2.33.0
>
