Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFBD308E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 21:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhA2UTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 15:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhA2UTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:19:20 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385F5C061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:18:40 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r38so7398888pgk.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbueXA+6LAKEqi7EcdFvbT4ApZuFRwx0fLMBh/SPQ68=;
        b=qjZfIVZ7rnQ327LNQk4FWiGJjhTfcNYf2ObyWH9MuWWdYqS2ckfjMsXcq9zAVlG6fq
         cIDEh09xyWxgHS3neIx0/9DUjvWyPpqbI/7+8LPluQkkfYukBbgLSKenMfEmHSQLQGyp
         XEH76nAQgokQJ9KU20VaQBD8btUM9n3a5qt/K2NaGagYoQqHDmgqEEb4obf3plS6ONJE
         urM5oYoEy0mrWQBJJIJW1nvb/YljvnXtzMzt56Foq+rXgr8eTRJXMNiPLjml4ua1hfue
         H0edjXZaB3rAS8Sh2J0Zl8MWDboNUspSlEOP1F6dDG+agIogWHFnChdpoXo4a0yMHwig
         cdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbueXA+6LAKEqi7EcdFvbT4ApZuFRwx0fLMBh/SPQ68=;
        b=nK9mOYdidoPzMZUDQZZZWmHTAKsdcrCmgSFeUOMCGgdAv5THRUR2s0qgtNs4jX9mZn
         8N5Xfl/6UUdQoL70GtEPxKphv38S9PPM5nVZ1ojVdCk1iv834Xpsamv6FQxFStOniF0H
         Ir4SwdMsN0YIWiMccs7+LxmUD19kaBTVzGBHJshhV+5kJ6YtAtrUb2954rnhP7Fp++0P
         pmaveR+gLlg9WaX/qJ21QsAAUVf+CKyV5EBZvVHSZ2MxhFXu7sDjseWTO/xBWWZNfZfI
         RUCAvZISHjlU5VXZfMNCiFr2BpbxZ5oUtASX/wmdUaBG7S4fUoJRKzvb0wnP2zxQM3+V
         vdsA==
X-Gm-Message-State: AOAM532p8Qzbqrb9gSKuLqa9vaFkEhmEFHqC48ObLD3bObBYMesmKmJW
        Wyk6mHvV/jYndiLiXhV960MwfB4mYvw9ntV1lBn1+g==
X-Google-Smtp-Source: ABdhPJwnH24yfxy0owU137qegSh5ykaGflrsFWdaazhKbQaaKcCzelz+hqW7OQWBNwoDboYjIBU1arxuP0kkjLU5R9o=
X-Received: by 2002:a62:838d:0:b029:1ba:9b85:2eac with SMTP id
 h135-20020a62838d0000b02901ba9b852eacmr6012038pfe.36.1611951519350; Fri, 29
 Jan 2021 12:18:39 -0800 (PST)
MIME-Version: 1.0
References: <20210129201116.2658179-1-nathan@kernel.org>
In-Reply-To: <20210129201116.2658179-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Jan 2021 12:18:28 -0800
Message-ID: <CAKwvOdkoivL4+HjXi4aKQbQ7R2J_oKBcMKrSsdxuOGLpseQZcw@mail.gmail.com>
Subject: Re: [PATCH] vmlinux.lds.h: Define SANTIZER_DISCARDS with CONFIG_GCOV_KERNEL=y
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel test robot <lkp@intel.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 12:11 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> clang produces .eh_frame sections when CONFIG_GCOV_KERNEL is enabled,
> even when -fno-asynchronous-unwind-tables is in KBUILD_CFLAGS:
>
> $ make CC=clang vmlinux
> ...
> ld: warning: orphan section `.eh_frame' from `init/main.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/version.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/do_mounts.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/do_mounts_initrd.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/initramfs.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/calibrate.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/init_task.o' being placed in section `.eh_frame'
> ...
>
> $ rg "GCOV_KERNEL|GCOV_PROFILE_ALL" .config
> CONFIG_GCOV_KERNEL=y
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> CONFIG_GCOV_PROFILE_ALL=y
>
> This was already handled for a couple of other options in
> commit d812db78288d ("vmlinux.lds.h: Avoid KASAN and KCSAN's unwanted
> sections") and there is an open LLVM bug for this issue. Take advantage
> of that section for this config as well so that there are no more orphan
> warnings.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=46478
> Link: https://github.com/ClangBuiltLinux/linux/issues/1069
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

I suspect we're going to need to add module level attributes in LLVM
IR for these options, then check those when synthesizing new function
definitions within LLVM.  At least we'll be able to point to this file
and say "hey, this is a general problem in LLVM, and here are 3
specific cases now where it's a problem."  Not a large problem, but
would help us save some bytes in the final object.  LLVM is not
producing data in this section for all code, just these synthesized
routines.

> ---
>  include/asm-generic/vmlinux.lds.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b2b3d81b1535..f753fd449436 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -988,12 +988,13 @@
>  #endif
>
>  /*
> - * Clang's -fsanitize=kernel-address and -fsanitize=thread produce
> + * Clang's -fsanitize=kernel-address, -fsanitize=thread,
> + * and -fprofile-arcs -ftest-coverage produce unwanted
>   * unwanted sections (.eh_frame and .init_array.*), but
>   * CONFIG_CONSTRUCTORS wants to keep any .init_array.* sections.
>   * https://bugs.llvm.org/show_bug.cgi?id=46478
>   */
> -#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN)
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN) || defined(CONFIG_GCOV_KERNEL)
>  # ifdef CONFIG_CONSTRUCTORS
>  #  define SANITIZER_DISCARDS                                           \
>         *(.eh_frame)
>
> base-commit: bec4c2968fce2f44ce62d05288a633cd99a722eb
> --
> 2.30.0
>


-- 
Thanks,
~Nick Desaulniers
