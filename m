Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A621534D2EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhC2Oyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhC2Oyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:54:39 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E02C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:54:38 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id i6so2401530pgs.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5MEBgMlFtr+qxbmpKO8IW3rS99OFMlWLKykyxAuuxkw=;
        b=iSXU1lHcTUj38J05Z9GV3nilDz0wRKt476JZoxbOrRSXRik4PcbqdzYYeizLtVJCNY
         sNQuslsEuyQ+XvlSULwLKyM5SNpTDb+IQf44HVuPfuYF+Hf4g/UhPkxgU47vp42B075o
         kSXlNLW0Jtyl+JpT3lE0f3ZT5GXevf5Mhqgxkj22S8EvOwzwU1iWALW5gD/xxxWXnnnk
         C0UeWW5kA2Qq6A4UOaY+OFnBLd5rQT/vMrD59FriEiw7FmpwVUq2H9iHYvII6vFLCDuz
         NpI2Nmh3L7jVUVNzBi9hY0iSdHshQ0PtAkfriQhzpTMMx6x4nPxhjVlDXV4GanaBEX5v
         NUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5MEBgMlFtr+qxbmpKO8IW3rS99OFMlWLKykyxAuuxkw=;
        b=fxHWNXdc4HxkEeIwjrmiv20OeCjm+I4UTCcW9OnWcdMvyGD67il9/zjLy1Aac18LQt
         bLAyljUiu65G1gCZlHTti11nh5l5CrkXejXWcjjOo0TESjCS1NxBnLnuL67xK2nAAf6w
         Ebj8cHFGAl7G0XVzijQTGmWvh4DHIiDUinYm8HZmO6pIDYSE759wBE7rkAGxmcNEZTFF
         WEU35yzlqEH49mlAtXBGbfEU/N81nKJPhncC47iQJEk+njQLi3NUMMHisJfHYSKvRU1P
         W1xqiPLaQ0PReF2jlOp/66A/tXsH1Exw+12eidY3vMxL/oxTAJxc7IRb4d6/M7vauuOm
         lKJA==
X-Gm-Message-State: AOAM531qUxAcOQ/kSpN6K0SO3i2yUMBM3eQQ2gw0Nkh97CMiF/l7AMJ3
        NjgaH/0V4Fvi9XcPWhycbdIqQmY+vLKhrwNvhzwhEg==
X-Google-Smtp-Source: ABdhPJzzV8lmH/853u2GQr5Sdz0U+AIsZJ78rGGmOSXdGUQCGk3zpC0zStZZ2upiaJ1Nge2MqpdgwsXK218jh4upu8o=
X-Received: by 2002:a63:d841:: with SMTP id k1mr9886568pgj.440.1617029678142;
 Mon, 29 Mar 2021 07:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210226012531.29231-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20210226012531.29231-1-walter-zh.wu@mediatek.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 29 Mar 2021 16:54:26 +0200
Message-ID: <CAAeHK+zyv1=kXtKAynnJN-77dwmPG4TXpJOLv_3W0nxXe5NjXA@mail.gmail.com>
Subject: Re: [PATCH v4] kasan: remove redundant config option
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 2:25 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> CONFIG_KASAN_STACK and CONFIG_KASAN_STACK_ENABLE both enable KASAN stack
> instrumentation, but we should only need one config, so that we remove
> CONFIG_KASAN_STACK_ENABLE and make CONFIG_KASAN_STACK workable.  see [1].
>
> When enable KASAN stack instrumentation, then for gcc we could do no
> prompt and default value y, and for clang prompt and default value n.
>
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=210221
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>
> v4: After this patch sent, someone had modification about KASAN_STACK,
>     so I need to rebase codebase. Thank Andrey for your pointing.
>
> ---
>  arch/arm64/kernel/sleep.S        |  2 +-
>  arch/x86/kernel/acpi/wakeup_64.S |  2 +-
>  include/linux/kasan.h            |  2 +-
>  lib/Kconfig.kasan                |  8 ++------
>  mm/kasan/common.c                |  2 +-
>  mm/kasan/kasan.h                 |  2 +-
>  mm/kasan/report_generic.c        |  2 +-
>  scripts/Makefile.kasan           | 10 ++++++++--
>  security/Kconfig.hardening       |  4 ++--
>  9 files changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> index 5bfd9b87f85d..4ea9392f86e0 100644
> --- a/arch/arm64/kernel/sleep.S
> +++ b/arch/arm64/kernel/sleep.S
> @@ -134,7 +134,7 @@ SYM_FUNC_START(_cpu_resume)
>          */
>         bl      cpu_do_resume
>
> -#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
> +#if defined(CONFIG_KASAN) && defined(CONFIG_KASAN_STACK)
>         mov     x0, sp
>         bl      kasan_unpoison_task_stack_below
>  #endif
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index 56b6865afb2a..d5d8a352eafa 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -115,7 +115,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
>         movq    pt_regs_r14(%rax), %r14
>         movq    pt_regs_r15(%rax), %r15
>
> -#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
> +#if defined(CONFIG_KASAN) && defined(CONFIG_KASAN_STACK)
>         /*
>          * The suspend path may have poisoned some areas deeper in the stack,
>          * which we now need to unpoison.
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index b91732bd05d7..14f72ec96492 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -330,7 +330,7 @@ static inline bool kasan_check_byte(const void *address)
>
>  #endif /* CONFIG_KASAN */
>
> -#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
> +#if defined(CONFIG_KASAN) && defined(CONFIG_KASAN_STACK)
>  void kasan_unpoison_task_stack(struct task_struct *task);
>  #else
>  static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 624ae1df7984..cffc2ebbf185 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -138,9 +138,10 @@ config KASAN_INLINE
>
>  endchoice
>
> -config KASAN_STACK_ENABLE
> +config KASAN_STACK
>         bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
>         depends on KASAN_GENERIC || KASAN_SW_TAGS
> +       default y if CC_IS_GCC
>         help
>           The LLVM stack address sanitizer has a know problem that
>           causes excessive stack usage in a lot of functions, see
> @@ -154,11 +155,6 @@ config KASAN_STACK_ENABLE
>           CONFIG_COMPILE_TEST.  On gcc it is assumed to always be safe
>           to use and enabled by default.
>
> -config KASAN_STACK
> -       int
> -       default 1 if KASAN_STACK_ENABLE || CC_IS_GCC
> -       default 0
> -
>  config KASAN_SW_TAGS_IDENTIFY
>         bool "Enable memory corruption identification"
>         depends on KASAN_SW_TAGS
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index b5e08d4cefec..7b53291dafa1 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -63,7 +63,7 @@ void __kasan_unpoison_range(const void *address, size_t size)
>         kasan_unpoison(address, size);
>  }
>
> -#if CONFIG_KASAN_STACK
> +#ifdef CONFIG_KASAN_STACK
>  /* Unpoison the entire stack for a task. */
>  void kasan_unpoison_task_stack(struct task_struct *task)
>  {
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 8c55634d6edd..3436c6bf7c0c 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -231,7 +231,7 @@ void *kasan_find_first_bad_addr(void *addr, size_t size);
>  const char *kasan_get_bug_type(struct kasan_access_info *info);
>  void kasan_metadata_fetch_row(char *buffer, void *row);
>
> -#if defined(CONFIG_KASAN_GENERIC) && CONFIG_KASAN_STACK
> +#if defined(CONFIG_KASAN_GENERIC) && defined(CONFIG_KASAN_STACK)
>  void kasan_print_address_stack_frame(const void *addr);
>  #else
>  static inline void kasan_print_address_stack_frame(const void *addr) { }
> diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> index 41f374585144..de732bc341c5 100644
> --- a/mm/kasan/report_generic.c
> +++ b/mm/kasan/report_generic.c
> @@ -128,7 +128,7 @@ void kasan_metadata_fetch_row(char *buffer, void *row)
>         memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);
>  }
>
> -#if CONFIG_KASAN_STACK
> +#ifdef CONFIG_KASAN_STACK
>  static bool __must_check tokenize_frame_descr(const char **frame_descr,
>                                               char *token, size_t max_tok_len,
>                                               unsigned long *value)
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index 1e000cc2e7b4..abf231d209b1 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -2,6 +2,12 @@
>  CFLAGS_KASAN_NOSANITIZE := -fno-builtin
>  KASAN_SHADOW_OFFSET ?= $(CONFIG_KASAN_SHADOW_OFFSET)
>
> +ifdef CONFIG_KASAN_STACK
> +       stack_enable := 1
> +else
> +       stack_enable := 0
> +endif
> +
>  ifdef CONFIG_KASAN_GENERIC
>
>  ifdef CONFIG_KASAN_INLINE
> @@ -27,7 +33,7 @@ else
>         CFLAGS_KASAN := $(CFLAGS_KASAN_SHADOW) \
>          $(call cc-param,asan-globals=1) \
>          $(call cc-param,asan-instrumentation-with-call-threshold=$(call_threshold)) \
> -        $(call cc-param,asan-stack=$(CONFIG_KASAN_STACK)) \
> +        $(call cc-param,asan-stack=$(stack_enable)) \
>          $(call cc-param,asan-instrument-allocas=1)
>  endif
>
> @@ -42,7 +48,7 @@ else
>  endif
>
>  CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
> -               -mllvm -hwasan-instrument-stack=$(CONFIG_KASAN_STACK) \
> +               -mllvm -hwasan-instrument-stack=$(stack_enable) \
>                 -mllvm -hwasan-use-short-granules=0 \
>                 $(instrumentation_flags)
>
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 269967c4fc1b..a56c36470cb1 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -64,7 +64,7 @@ choice
>         config GCC_PLUGIN_STRUCTLEAK_BYREF
>                 bool "zero-init structs passed by reference (strong)"
>                 depends on GCC_PLUGINS
> -               depends on !(KASAN && KASAN_STACK=1)
> +               depends on !(KASAN && KASAN_STACK)
>                 select GCC_PLUGIN_STRUCTLEAK
>                 help
>                   Zero-initialize any structures on the stack that may
> @@ -82,7 +82,7 @@ choice
>         config GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
>                 bool "zero-init anything passed by reference (very strong)"
>                 depends on GCC_PLUGINS
> -               depends on !(KASAN && KASAN_STACK=1)
> +               depends on !(KASAN && KASAN_STACK)
>                 select GCC_PLUGIN_STRUCTLEAK
>                 help
>                   Zero-initialize any stack variables that may be passed
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210226012531.29231-1-walter-zh.wu%40mediatek.com.

Hi Andrew,

Looks like my patch "kasan: fix KASAN_STACK dependency for HW_TAGS"
that was merged into 5.12-rc causes a build time warning:

include/linux/kasan.h:333:30: warning: 'CONFIG_KASAN_STACK' is not
defined, evaluates to 0 [-Wundef]
#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK

The fix for it would either be reverting the patch (which would leave
the initial issue unfixed) or applying this "kasan: remove redundant
config option" patch.

Would it be possible to send this patch (with the fix-up you have in
mm) for the next 5.12-rc?

Here are the required tags:

Fixes: d9b571c885a8 ("kasan: fix KASAN_STACK dependency for HW_TAGS")
Cc: stable@vger.kernel.org

Thanks!
