Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C908040D7AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbhIPKpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbhIPKpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:45:11 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371B7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 03:43:51 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id n2-20020a9d6f02000000b0054455dae485so2477114otq.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 03:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6eQIzAzVo2s4sy2RQ7zzgd6LAmuLkNzHqLQDH9kJDzc=;
        b=RnQk/0ye9mp6AE39VzPuIzwr6pb4Q3+mVnFLGo62H8Hkwbz46jvC7+U+PFWzu/2g63
         PO93EOgwGZkywg9tgIlR5FiR+22RuT6P5JcCf98wirP16Q2CUVKdQ+OukKAg2CjIEXO0
         cyjHs7gMrhJ5ibnGwqzS0pC9OY2js2ScPmu6NBnZSQ9x/K9TIKSoNdaTneheuOq6kOz6
         ziit5LMME0RyeHh3DsaeiJ07UOQjIkoBaKLxXHnpGCBfO3BTQ7uUxrAZIKxV+u+MDA+A
         lCEZXhvJXtZhJAif7PsFAbrZIbQQCEXVs1GvojEbt43v3jXqaDpa1L9fnVT1PuF1v2sQ
         yg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6eQIzAzVo2s4sy2RQ7zzgd6LAmuLkNzHqLQDH9kJDzc=;
        b=R1WcmuYqyGPoForlmTAPr6Hle7QBTF+DHbz+U3dF3QY556Gmp3uDKPXk2yQnMTEiP3
         M2rFfuVyKqiQPJxMcnjRqtgzZxR7fIRdckkSohMIbYNH1fmkFu40WuZwE/30JitZ4bmS
         PYJ5VwRcGPeZ8vU9deaI6XHN+CNs4LpNCcicP2etPYPvGds2UUplyAkj2aJ0AI5soNFL
         jNCtEvwpPhQj/d7O61Fl6CYSi9D3IhMrrJ7E9hIUgkuAbbj4IoAX/nJNLVVvancTwUhK
         ZywZOYVlmP/MZ06mMUvJjjJQzCBys8zRkiOu+LT/QoK78VGYpvsXZlp9Xle58SkPfv2T
         o4kg==
X-Gm-Message-State: AOAM531v5LlT6vb70t1knr2Ki7bGCHPIyUZDAAGN2nB+V6A4FapCPJJf
        xHWFKyE9lLSymlIIUZQsW8X+QC+gVpEqaVuVFUnw0g==
X-Google-Smtp-Source: ABdhPJyAFp6bzKVmPeRCarCGaeFegjqEFxGjA1sK7q3niDmFBkkGoB/u+daB0nlmy8mFhfK9mdhZW/vinOXkAt4nsq0=
X-Received: by 2002:a9d:71db:: with SMTP id z27mr4101897otj.292.1631789030313;
 Thu, 16 Sep 2021 03:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210913081424.48613-1-vincenzo.frascino@arm.com> <20210913081424.48613-6-vincenzo.frascino@arm.com>
In-Reply-To: <20210913081424.48613-6-vincenzo.frascino@arm.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 16 Sep 2021 12:43:38 +0200
Message-ID: <CANpmjNN5atO1u6+Y71EiEvr9V8+WhdOGzC_8gvviac+BDkP+sA@mail.gmail.com>
Subject: Re: [PATCH 5/5] kasan: Extend KASAN mode kernel parameter
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sept 2021 at 10:14, Vincenzo Frascino
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
> ---
>  Documentation/dev-tools/kasan.rst | 10 ++++++++--
>  mm/kasan/hw_tags.c                | 27 ++++++++++++++++++++++-----
>  mm/kasan/kasan.h                  |  5 +++++
>  3 files changed, 35 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 21dc03bc10a4..7f43e603bfbe 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -194,14 +194,20 @@ additional boot parameters that allow disabling KASAN or controlling features:
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
> +  Asymmetric mode: a bad access is detected immediately when a tag
> +  check fault occurs during a load operation and its detection is
> +  delayed during a store operation. For the store operations the kernel
> +  periodically checks the hardware and only reports tag faults during
> +  these checks.
>
>  - ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
>    traces collection (default: ``on``).
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
> index 3639e7c8bb98..a8be62058d32 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h

Shouldn't kasan.h also define kasan_asymm_mode_enabled() similar to
kasan_async_mode_enabled()?

And based on that, also use it where kasan_async_mode_enabled() is
used in tests to ensure the tests do not fail. Otherwise, there is no
purpose for kasan_flag_asymm.

Thanks,
-- Marco

> @@ -287,6 +287,9 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  #ifndef arch_enable_tagging_async
>  #define arch_enable_tagging_async()
>  #endif
> +#ifndef arch_enable_tagging_asymm
> +#define arch_enable_tagging_asymm()
> +#endif
>  #ifndef arch_force_async_tag_fault
>  #define arch_force_async_tag_fault()
>  #endif
> @@ -302,6 +305,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>
>  #define hw_enable_tagging_sync()               arch_enable_tagging_sync()
>  #define hw_enable_tagging_async()              arch_enable_tagging_async()
> +#define hw_enable_tagging_asymm()              arch_enable_tagging_asymm()
>  #define hw_force_async_tag_fault()             arch_force_async_tag_fault()
>  #define hw_get_random_tag()                    arch_get_random_tag()
>  #define hw_get_mem_tag(addr)                   arch_get_mem_tag(addr)
> @@ -312,6 +316,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>
>  #define hw_enable_tagging_sync()
>  #define hw_enable_tagging_async()
> +#define hw_enable_tagging_asymm()
>
>  #endif /* CONFIG_KASAN_HW_TAGS */
