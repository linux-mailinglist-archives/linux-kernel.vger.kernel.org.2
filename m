Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7091C37028D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 23:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbhD3VAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 17:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbhD3VAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 17:00:01 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A53CC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:59:11 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id d15so31132683ljo.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HAJvDe27ES5agMJYGZiW84oZ89WkJPUuwlQYefRHJ9A=;
        b=UqamODUwFRG2FrkEIYdEZn1wRRagNOVajEI9q2jkrA4yBAq1P9/sECdNqvRKd96U2u
         6jUWrILqzHpNCI2SChput1UHjcA3bWlaaWDRR+upSDERf5pp42RICkm8rvnZgGL4QZ+e
         x2YZoe5yaAiu+zERWTR95H2TmpcM8grhDSQyCm4d6rOvbwQ10dUZ8hQTAtcvfCPgvJtv
         7e7KYjtsvKwY9Kl9NuCEbjqwZupuKMAlZ8I1pXWgz+RzOimTRaEjt2czwmeXn+KeupEN
         y8TPcc8Wg+0Oizh6lluYceQfb3h0gM/THs62jLeVTMWjuHugMV3zGjmnsss+sCCOxkFl
         ImeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HAJvDe27ES5agMJYGZiW84oZ89WkJPUuwlQYefRHJ9A=;
        b=Wmt4+21Hyjav0fbzZIWlh8jZQ1TCxnHrREZjzebj3/6v/VoHuI+omDzI8ptKgQEY0M
         BZp4WhInmVeVNxQLMMrSUqHxRytJjGm+qkvn/1cdA8YNJRMqxEsj/Ei7/VhnBcmktUC5
         16cJhvWo5D5CXvFvtWtdTJkr6eNC/dYQl19Hi60Ug7Tf0ggxAKMbIOF6pQaR0rT8RL1I
         P7tcmeVLUv4mBoyFSmR3HYW3R8PMSEmIOpE70fBMoA6cNzwdo0yW0Lh5pcQHD/eoOUpv
         9YrNJlmIgSWgrjRO+JHhjvVIzlVZZQJf5MuLoMkC/Yz9NehHEYw1uHzA3yTmg8F9e2g4
         nJbA==
X-Gm-Message-State: AOAM531yfTwZq9t2+t59zOdCBabRy69enCqYQH+kbKUUxRHE8hTX9r+u
        Fv+ahoHdLIambcz2MaAaS4z+yBXWPw2rAM4pl3b/Vw==
X-Google-Smtp-Source: ABdhPJz7obEB7pIrgZ19ShpH2n8FDh5rXsMA7SCWlQFIUI3llFolNF53I4FkhwucJdqKT93+InB21cjVR61pPGbsx3w=
X-Received: by 2002:a2e:9211:: with SMTP id k17mr4968737ljg.495.1619816349345;
 Fri, 30 Apr 2021 13:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210429232611.3966964-1-nathan@kernel.org>
In-Reply-To: <20210429232611.3966964-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Apr 2021 13:58:57 -0700
Message-ID: <CAKwvOdngd5inT_sQP-PgqaMpVzfSdwoyhCcUSdS+09u=PKUEyA@mail.gmail.com>
Subject: Re: [PATCH] x86: Enable clang LTO for 32-bit as well
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 4:26 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Commit b33fff07e3e3 ("x86, build: allow LTO to be selected") enabled
> support for LTO for x86_64 but 32-bit works fine as well.
>
> I tested the following config combinations:
>
> * i386_defconfig + CONFIG_LTO_CLANG_FULL=y
>
> * i386_defconfig + CONFIG_LTO_CLANG_THIN=y
>
> * ARCH=i386 allmodconfig + CONFIG_LTO_CLANG_THIN=y

For allmodconfig
HAS_LTO_CLANG cannot be selected unless
FTRACE
GCOV_KERNEL
are disabled.

I was able to run through similar tests, though I only did so for ToT LLVM.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

I additionally tried full LTO allmodconfig.  Full LTO allmodconfig can
be tested by disabling CONFIG_COMPILE_TEST (in addition to the above),
though I hit https://github.com/ClangBuiltLinux/linux/issues/1215 (the
xfs tests aren't building under LTO).  I think this change though is
fine, and enables another avenue to help us debug that failure.

>
> with LLVM 11.1.0, 12.0.0, and 13.0.0 from git without any build
> failures. The defconfigs boot in QEMU with no new warnings.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/x86/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 0fc82237414d..d8a919d9535e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -97,8 +97,8 @@ config X86
>         select ARCH_SUPPORTS_DEBUG_PAGEALLOC
>         select ARCH_SUPPORTS_NUMA_BALANCING     if X86_64
>         select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP       if NR_CPUS <= 4096
> -       select ARCH_SUPPORTS_LTO_CLANG          if X86_64
> -       select ARCH_SUPPORTS_LTO_CLANG_THIN     if X86_64
> +       select ARCH_SUPPORTS_LTO_CLANG
> +       select ARCH_SUPPORTS_LTO_CLANG_THIN
>         select ARCH_USE_BUILTIN_BSWAP
>         select ARCH_USE_QUEUED_RWLOCKS
>         select ARCH_USE_QUEUED_SPINLOCKS
>
> base-commit: d8201efe75e13146ebde433745c7920e15593baf
> --
> 2.31.1.362.g311531c9de
>


-- 
Thanks,
~Nick Desaulniers
