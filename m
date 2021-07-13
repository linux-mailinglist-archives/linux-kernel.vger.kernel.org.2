Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868AB3C7695
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 20:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhGMSnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 14:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhGMSnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 14:43:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D833BC0613DD;
        Tue, 13 Jul 2021 11:40:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dt7so13481282ejc.12;
        Tue, 13 Jul 2021 11:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQpf5xOaOqo0s/plb1U3NgMNZX1Ph8Dt44evAisR+l0=;
        b=gI7n/qI/DkL7SIT4shqKYtKHWdM176gJQ3/2RrZOVcCXPfG3EbUy0bDedEoBuILbpr
         CORECQF9iy1EkOD3hP9IHmXZ44XRBdjIs8sBXI2ozzNvMcmlMTmrdANT4RNAU+w8xj8G
         J7eUfJnhuD343zLi1dXayV9MAKCc3KSG1f9wePXJfVqfeVIb7OUS4KYYUZMd8EQxsX/H
         wWUc0Qhpve1BBC1OconHChBafgEAEQ27DJIul2rLsMOyDgWl4upMFHXuURFasV4lT56Y
         Z5LoII4Nkvv594aDEvDTbKWa51/5nk67U4dBgAYdty4lCqqvATA4epnFmJoN3qk7B6CQ
         S5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQpf5xOaOqo0s/plb1U3NgMNZX1Ph8Dt44evAisR+l0=;
        b=kITSwvR4n3NXAQQUzLXJeHXhGauWAvZy8CPcLzAIQ8g7eLdcNUO/HC0prtT1H+Zprp
         4IdZ67oXcUWwQs3NKWw1E9DvzjLVOgI5IEA5gRNFcd4KL6JkFUrwmHRlAodV0LT9/aus
         J+s5I6obDTzmtCjDqtrRu9XeiYG4fuBGEL3SrgQN+HreYv/5piK+7KibVXekJeseC3Ix
         eVcDhQZnpXiGC0BuksI8NM9fgftH5LsTQgdRg3pihLGlvdkp0kTPnfiEIrYWcaV/quVY
         vhdA6qxOXFr62/hpgDt26hm8g3rrxEkDENICZJ3RPYmd9SBELlMZBqjoc8D1dK8wEXs2
         rnug==
X-Gm-Message-State: AOAM5310ntfcFpaXhJXh7ACK+A7lMM75u3XfUsODs7K5UJnRv+7yL6gr
        5Q3mCiRzQ1NnZFcKPdIvlJGd8Dy5xBWZGt14pWw=
X-Google-Smtp-Source: ABdhPJxK71IKMduWW2mt+NCXshKS0E6oF7WxzwUQNmcLDT/A9YHEAOZfzeyoku38PmMUvK3HNH6Eh6lXLoPNYPUF9BA=
X-Received: by 2002:a17:907:7d94:: with SMTP id oz20mr7376635ejc.333.1626201657390;
 Tue, 13 Jul 2021 11:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210713010536.3161822-1-woodylin@google.com>
In-Reply-To: <20210713010536.3161822-1-woodylin@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 13 Jul 2021 20:40:46 +0200
Message-ID: <CA+fCnZdycHhs1fQyn1uZKhPv8T3EhE_ckQ7tVbELyMSEJGJE7Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm/kasan: move kasan.fault to mm/kasan/report.c
To:     Woody Lin <woodylin@google.com>
Cc:     Marco Elver <elver@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 3:07 AM Woody Lin <woodylin@google.com> wrote:
>
> Move the boot parameter 'kasan.fault' from hw_tags.c to report.c, so it
> can support all KASAN modes - generic, and both tag-based.
>
> Signed-off-by: Woody Lin <woodylin@google.com>
> ---
>  Documentation/dev-tools/kasan.rst | 13 ++++++----
>  mm/kasan/hw_tags.c                | 43 -------------------------------
>  mm/kasan/kasan.h                  |  1 -
>  mm/kasan/report.c                 | 29 ++++++++++++++++++---
>  4 files changed, 34 insertions(+), 52 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 83ec4a556c19..21dc03bc10a4 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -181,9 +181,16 @@ By default, KASAN prints a bug report only for the first invalid memory access.
>  With ``kasan_multi_shot``, KASAN prints a report on every invalid access. This
>  effectively disables ``panic_on_warn`` for KASAN reports.
>
> +Alternatively, independent of ``panic_on_warn`` the ``kasan.fault=`` boot
> +parameter can be used to control panic and reporting behaviour:
> +
> +- ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
> +  report or also panic the kernel (default: ``report``). The panic happens even
> +  if ``kasan_multi_shot`` is enabled.
> +
>  Hardware tag-based KASAN mode (see the section about various modes below) is
>  intended for use in production as a security mitigation. Therefore, it supports
> -boot parameters that allow disabling KASAN or controlling its features.
> +additional boot parameters that allow disabling KASAN or controlling features:
>
>  - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
>
> @@ -199,10 +206,6 @@ boot parameters that allow disabling KASAN or controlling its features.
>  - ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
>    traces collection (default: ``on``).
>
> -- ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
> -  report or also panic the kernel (default: ``report``). The panic happens even
> -  if ``kasan_multi_shot`` is enabled.
> -
>  Implementation details
>  ----------------------
>
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 4ea8c368b5b8..51903639e55f 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -37,16 +37,9 @@ enum kasan_arg_stacktrace {
>         KASAN_ARG_STACKTRACE_ON,
>  };
>
> -enum kasan_arg_fault {
> -       KASAN_ARG_FAULT_DEFAULT,
> -       KASAN_ARG_FAULT_REPORT,
> -       KASAN_ARG_FAULT_PANIC,
> -};
> -
>  static enum kasan_arg kasan_arg __ro_after_init;
>  static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
>  static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
> -static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
>
>  /* Whether KASAN is enabled at all. */
>  DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
> @@ -59,9 +52,6 @@ EXPORT_SYMBOL_GPL(kasan_flag_async);
>  /* Whether to collect alloc/free stack traces. */
>  DEFINE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
>
> -/* Whether to panic or print a report and disable tag checking on fault. */
> -bool kasan_flag_panic __ro_after_init;
> -
>  /* kasan=off/on */
>  static int __init early_kasan_flag(char *arg)
>  {
> @@ -113,23 +103,6 @@ static int __init early_kasan_flag_stacktrace(char *arg)
>  }
>  early_param("kasan.stacktrace", early_kasan_flag_stacktrace);
>
> -/* kasan.fault=report/panic */
> -static int __init early_kasan_fault(char *arg)
> -{
> -       if (!arg)
> -               return -EINVAL;
> -
> -       if (!strcmp(arg, "report"))
> -               kasan_arg_fault = KASAN_ARG_FAULT_REPORT;
> -       else if (!strcmp(arg, "panic"))
> -               kasan_arg_fault = KASAN_ARG_FAULT_PANIC;
> -       else
> -               return -EINVAL;
> -
> -       return 0;
> -}
> -early_param("kasan.fault", early_kasan_fault);
> -
>  /* kasan_init_hw_tags_cpu() is called for each CPU. */
>  void kasan_init_hw_tags_cpu(void)
>  {
> @@ -197,22 +170,6 @@ void __init kasan_init_hw_tags(void)
>                 break;
>         }
>
> -       switch (kasan_arg_fault) {
> -       case KASAN_ARG_FAULT_DEFAULT:
> -               /*
> -                * Default to no panic on report.
> -                * Do nothing, kasan_flag_panic keeps its default value.
> -                */
> -               break;
> -       case KASAN_ARG_FAULT_REPORT:
> -               /* Do nothing, kasan_flag_panic keeps its default value. */
> -               break;
> -       case KASAN_ARG_FAULT_PANIC:
> -               /* Enable panic on report. */
> -               kasan_flag_panic = true;
> -               break;
> -       }
> -
>         pr_info("KernelAddressSanitizer initialized\n");
>  }
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 98e3059bfea4..9d57383ce1fa 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -36,7 +36,6 @@ static inline bool kasan_async_mode_enabled(void)
>
>  #endif
>
> -extern bool kasan_flag_panic __ro_after_init;
>  extern bool kasan_flag_async __ro_after_init;
>
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 8fff1825b22c..884a950c7026 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -39,6 +39,31 @@ static unsigned long kasan_flags;
>  #define KASAN_BIT_REPORTED     0
>  #define KASAN_BIT_MULTI_SHOT   1
>
> +enum kasan_arg_fault {
> +       KASAN_ARG_FAULT_DEFAULT,
> +       KASAN_ARG_FAULT_REPORT,
> +       KASAN_ARG_FAULT_PANIC,
> +};
> +
> +static enum kasan_arg_fault kasan_arg_fault __ro_after_init = KASAN_ARG_FAULT_DEFAULT;
> +
> +/* kasan.fault=report/panic */
> +static int __init early_kasan_fault(char *arg)
> +{
> +       if (!arg)
> +               return -EINVAL;
> +
> +       if (!strcmp(arg, "report"))
> +               kasan_arg_fault = KASAN_ARG_FAULT_REPORT;
> +       else if (!strcmp(arg, "panic"))
> +               kasan_arg_fault = KASAN_ARG_FAULT_PANIC;
> +       else
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +early_param("kasan.fault", early_kasan_fault);
> +
>  bool kasan_save_enable_multi_shot(void)
>  {
>         return test_and_set_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags);
> @@ -102,10 +127,8 @@ static void end_report(unsigned long *flags, unsigned long addr)
>                 panic_on_warn = 0;
>                 panic("panic_on_warn set ...\n");
>         }
> -#ifdef CONFIG_KASAN_HW_TAGS
> -       if (kasan_flag_panic)
> +       if (kasan_arg_fault == KASAN_ARG_FAULT_PANIC)
>                 panic("kasan.fault=panic set ...\n");
> -#endif
>         kasan_enable_current();
>  }
>
> --
> 2.32.0.93.g670b81a890-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
