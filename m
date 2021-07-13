Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8CF3C6B19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhGMHWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhGMHWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:22:20 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6103AC0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 00:19:30 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so21531198otq.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 00:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1rkHHVlFsycr+ncfeipxll+Ui5VSi+Znz668tHLipE=;
        b=nMXBQToFFEFymsB5XNhqwtVkR257GQFVgSRjF4orL444VaxpPKWW8VI2v5/A0c426Y
         U5vS6+pvFywOTkR514OT5tfyrQiJsHC9zm+VOevSyO3ZnVGgYRAv3wEopcOl4kMNB0JW
         5ZQrjyF4+f3fkJ3wvyXqsYCxQB19cy5QkiJqYVoXF2bt4lCyYcIRuVF3HoxAAQiYO20w
         QNirJCnwFVUed3PSOPIGVhmOL/Em96JzVxAsEN0AkbnxM7RajGjyuc/qZHXFGDS8X7ly
         xo8gGvGRLLfT0mkC9eTVmv1/nM4fVVd1VA9iupJ5Wpwqxpkl/AdxwW7+vFL54/gXibva
         Ik4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1rkHHVlFsycr+ncfeipxll+Ui5VSi+Znz668tHLipE=;
        b=DhfavrudGj3E/M9fzxpmYu1cJ/sHc/GWeqzt1mCUS+MyoeYGVYedcgeuZlKNJuPnzY
         K7/hgK0qF+XfmmTABcypZJFEu5rfkex3PyO5vpsPp31H+ZvRAEocH+dm7LcxR9L/UTfP
         zkS28emcywjTC0PcItF/ehNeqB/OGBw7gSuyU14CXkVDYbvQN6g0TtLQM2wlbYhnm7Nr
         UBTNqvAGymJeqj6n8p38IBmWiFE6cW6JDV0pkP6NRsLuUJIEKHqAzBjo30Mf1KsqCBVI
         q3DKh6VWPvIU7a7f6PC2I7ApTNefx0W3Ty9nC6khR/zrvgDLRVnv5nK0awhCEJlMk0uV
         dHBg==
X-Gm-Message-State: AOAM533MaSxk6mb+6+amecWca2qX1UqwL/9Pa6OUL0LvkcaDrB5xG1UZ
        D7uyaV67rFFLDB/ZpsaCHCg1iqZOCLAm00qLtiiOdw==
X-Google-Smtp-Source: ABdhPJyPaQeMtZDXeQNmWo6uozqbiySG7yWTRvaWZhVVKK/yxp6zoLFEnvRLWkUIDi1po6YDhi4+c4P0+QWDGXTtqTU=
X-Received: by 2002:a05:6830:905:: with SMTP id v5mr2485146ott.17.1626160769409;
 Tue, 13 Jul 2021 00:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210713010536.3161822-1-woodylin@google.com>
In-Reply-To: <20210713010536.3161822-1-woodylin@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 13 Jul 2021 09:19:17 +0200
Message-ID: <CANpmjNPH9TcZL9bNdNFqMGQpHMyAQAGWrWvAA6XzuYeO=VocEg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/kasan: move kasan.fault to mm/kasan/report.c
To:     Woody Lin <woodylin@google.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2021 at 03:07, Woody Lin <woodylin@google.com> wrote:
> Move the boot parameter 'kasan.fault' from hw_tags.c to report.c, so it
> can support all KASAN modes - generic, and both tag-based.
>
> Signed-off-by: Woody Lin <woodylin@google.com>

Reviewed-by: Marco Elver <elver@google.com>

Thank you.

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
