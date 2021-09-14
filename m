Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3F340B834
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhINThs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhINThn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:37:43 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54519C061766
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:36:24 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r3so749979ljc.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRm0lqiAbi6ssQDGfy8o0TiHXCZIhqN7Pmc2NlxMpy8=;
        b=F83eSKq4GiQioqeodNpvZ8dTsI0osaxb7TKxXWF1RND2pTqkw9RYtDrG8Fp/3irrKv
         q+5MmSAXauGqbvutu2IUoy4le3OWZaU3gO1pPyZep53bf8CG6XRZiLkQE81J+Qzbqp6B
         beI6W3XSL7dp2JG+/iDVcGkIFQrxBvHqSEJpYE1mdJJXUHMsv+YUMdvs1JyziY+yRWm5
         T0Ie5JjJrAcSzGBztmg5JbinjwLMZOuAmNoUo8jtFNbC576gGFIPym3KorPkm4UGEz8q
         Uc7NElra0NWCOSIL7kv99y2mGpb/B1/41CVdecVE078RmN/JKffsqJ5e9v/nh3QOw1NW
         yERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRm0lqiAbi6ssQDGfy8o0TiHXCZIhqN7Pmc2NlxMpy8=;
        b=j89cgrH7StAwms7HCriDZoLNODtrAM3EAS1z9vxR+ArUZLFGNV4nnPCkn19vhVh+D5
         cmshVmDCxRLp4ek7S8II9srNjjfVkQrtbz71ZR76Vu77PusLAIFiKrSEmqA318Ny5Ray
         dOv1pctmkNDs8TYonRyxJTINhSh2qEzRGd0spDpwyBnig/WT1Gap6GUqf/MU5MSXRCw1
         okAJ2yloxJTg5fj93Q8K1P7UtkJBJYF/ocXlOwdUydfrPF84n5CUPuA3HIYfCUooSggt
         xFGAc0t4oxUadgmgc4K3qgPGoUX5tJkYkJig39hgnDHJAwyWAG51kUEf4hDlgItMo/Um
         /1xw==
X-Gm-Message-State: AOAM532eNxIw95uweGcUNVOlA/FY64IB5IV5orDyxXJrp3I8l7MW57oL
        PDrnr+lmHEBBSTZZtKYb+7Ww26cxH8HzMOtZ2ij5kw==
X-Google-Smtp-Source: ABdhPJzWasbt1nSfH/aTZ2tmWuYt7/AFbrlD8TfBLIlAmysS8NukT3vJ2wb3/b9J986Ft01zofIXZpJXDpApNHIwqf4=
X-Received: by 2002:a2e:750e:: with SMTP id q14mr16681926ljc.338.1631648182493;
 Tue, 14 Sep 2021 12:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com> <20210914191045.2234020-5-samitolvanen@google.com>
In-Reply-To: <20210914191045.2234020-5-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 12:36:11 -0700
Message-ID: <CAKwvOdnTeTLcrjPy5QcshSLr0Cc2uj7_hTt70j37eEBZzxr=PA@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:10 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> This change introduces the DEFINE_CFI_IMMEDIATE_RETURN_STUB macro,
> which defines a stub function that immediately returns and when
> defined in the core kernel, always passes indirect call checking
> with CONFIG_CFI_CLANG. Note that this macro should only be used when
> a stub cannot be called using the correct function type.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 11 +++++++++++
>  include/linux/cfi.h               | 14 ++++++++++++++
>  kernel/cfi.c                      | 24 +++++++++++++++++++++++-
>  3 files changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index f2984af2b85b..5b77284f7221 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -407,6 +407,16 @@
>         KEEP(*(.static_call_tramp_key))                                 \
>         __stop_static_call_tramp_key = .;
>
> +#ifdef CONFIG_CFI_CLANG
> +#define CFI_EXCLUDED_DATA                                              \
> +       . = ALIGN(8);                                                   \
> +       __start_cfi_excluded = .;                                       \
> +       KEEP(*(.cfi_excluded_stubs))                                    \
> +       __stop_cfi_excluded = .;
> +#else
> +#define CFI_EXCLUDED_DATA
> +#endif
> +
>  /*
>   * Allow architectures to handle ro_after_init data on their
>   * own by defining an empty RO_AFTER_INIT_DATA.
> @@ -430,6 +440,7 @@
>                 __start_rodata = .;                                     \
>                 *(.rodata) *(.rodata.*)                                 \
>                 SCHED_DATA                                              \
> +               CFI_EXCLUDED_DATA                                       \
>                 RO_AFTER_INIT_DATA      /* Read only after init */      \
>                 . = ALIGN(8);                                           \
>                 __start___tracepoints_ptrs = .;                         \
> diff --git a/include/linux/cfi.h b/include/linux/cfi.h
> index 879744aaa6e0..9ebf67a0d421 100644
> --- a/include/linux/cfi.h
> +++ b/include/linux/cfi.h
> @@ -20,6 +20,18 @@ extern void __cfi_check(uint64_t id, void *ptr, void *diag);
>  #define __CFI_ADDRESSABLE(fn, __attr) \
>         const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
>
> +/*
> + * Defines a stub function that returns immediately, and when defined and
> + * referenced in the core kernel, always passes CFI checking. This should
> + * be used only for stubs that cannot be called using the correct function
> + * pointer type, which should be rare.
> + */
> +#define DEFINE_CFI_IMMEDIATE_RETURN_STUB(fn) \
> +       void fn(void) { return; } \
> +       const void *__cfi_excl_ ## fn __visible \
> +               __attribute__((__section__(".cfi_excluded_stubs"))) \

Can we use __section from include/linux/compiler_attributes.h here
rather than open coding the function attribute?

> +               = (void *)&fn
> +
>  #ifdef CONFIG_CFI_CLANG_SHADOW
>
>  extern void cfi_module_add(struct module *mod, unsigned long base_addr);
> @@ -35,6 +47,8 @@ static inline void cfi_module_remove(struct module *mod, unsigned long base_addr
>  #else /* !CONFIG_CFI_CLANG */
>
>  #define __CFI_ADDRESSABLE(fn, __attr)
> +#define DEFINE_CFI_IMMEDIATE_RETURN_STUB(fn) \
> +       void fn(void) { return; }
>
>  #endif /* CONFIG_CFI_CLANG */
>
> diff --git a/kernel/cfi.c b/kernel/cfi.c
> index 9594cfd1cf2c..8d931089141b 100644
> --- a/kernel/cfi.c
> +++ b/kernel/cfi.c
> @@ -278,12 +278,34 @@ static inline cfi_check_fn find_module_check_fn(unsigned long ptr)
>         return fn;
>  }
>
> +extern unsigned long __start_cfi_excluded[];
> +extern unsigned long __stop_cfi_excluded[];
> +
> +static inline bool is_cfi_excluded(unsigned long ptr)
> +{
> +       unsigned long *p = __start_cfi_excluded;
> +
> +       for ( ; p < __stop_cfi_excluded; ++p)
> +               if (*p == ptr)
> +                       return true;
> +
> +       return false;
> +}
> +
> +static void __cfi_pass(uint64_t id, void *ptr, void *diag)
> +{
> +}
> +
>  static inline cfi_check_fn find_check_fn(unsigned long ptr)
>  {
>         cfi_check_fn fn = NULL;
>
> -       if (is_kernel_text(ptr))
> +       if (is_kernel_text(ptr)) {
> +               if (unlikely(is_cfi_excluded(ptr)))
> +                       return __cfi_pass;
> +
>                 return __cfi_check;
> +       }
>
>         /*
>          * Indirect call checks can happen when RCU is not watching. Both
> --
> 2.33.0.309.g3052b89438-goog
>


-- 
Thanks,
~Nick Desaulniers
