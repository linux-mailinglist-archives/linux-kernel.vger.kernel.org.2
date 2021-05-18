Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42F1388153
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbhERUZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbhERUZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:25:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F50FC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:24:23 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id v8so10809819lft.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTzibwfqe/I3SK7JBMJocK8xyPaFvCw7pMyszzKLlIs=;
        b=YO8cHWoDO4vPBgYmUp+0dBju6mZhv2DRYh+Lqs7cIq978egcft0xPAZimzWH+BNmKK
         oLcJC/iuwgC67k1xitJAgBGe2CY1V3G/+GX5dy+AXyfasDWU9QSqH7hSs0boBTOicCwv
         2KvsQ4joXs26HtfjkJFwClRqdWJv89XIva7ORN/9TyN1MN1EDgNA2oxXagOgRsaTPv2k
         J56wCJiCUSAT+0zENHHZZgyk6eVS9TcWt01cgDkwtroyidfXqZO0cxtwRqCRq+++YaXk
         rym0d7gG1hIDoomlm3d3Bhml4vFjL/7uPonl8sZI8TASgofgdZsFHsFm4Dp6tok4jMHE
         lMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTzibwfqe/I3SK7JBMJocK8xyPaFvCw7pMyszzKLlIs=;
        b=P7L/p22r5APnMri5CZ9lHf9lpQLbWL2FfyP4AUnduCkYLBYT9mzx0ffSD8+EULXBiM
         WyK4oBYQ5cyVv0kvPWINC44kOyxgwdmnk9LdBIersgQLG/y6ohghX3hwZIFy1Q0G9HEf
         z3tyRZFW/toNczuz2hm659QwS5hXSluZ83MXkiqwBFbk15L06w7+BAAiBo571FugyeyK
         EpvzjWz952XCGbXe/pWG5uTLwyP8fkbO+s8K7LifAS0AKzSti5BFUsiqd9oi2BmR49ud
         OHA23nA9JoIenM5Zkg/CLm3NgcX8NpqTOYxEh0aK0R7PTbMe1k+Ygnh3sdA4hgPfwZDd
         Yr5Q==
X-Gm-Message-State: AOAM530qx0nbINjw6qBuJaXv4VG4581cdwUaGjYxG6ZhfmwZL15nPSWJ
        mz5vHrCnKHtdP9wpiFOPqVHkv7G3PwXgOvZN5uVnWU0FDburbg==
X-Google-Smtp-Source: ABdhPJxa6Df4Z4UCpzKgvBDDgpa83C5L+ysBEOU+84l1MvBkl7Fc5kOhYYX1eOZKuqXIgcVn8Xr8zvtiu+OIUq1++ik=
X-Received: by 2002:ac2:5334:: with SMTP id f20mr5342424lfh.543.1621369461815;
 Tue, 18 May 2021 13:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210518190106.60935-1-nathan@kernel.org>
In-Reply-To: <20210518190106.60935-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 May 2021 13:24:10 -0700
Message-ID: <CAKwvOd=fJ-E04ixP0k1ehHdhikF4Zqr2FXa0+AQnWn1fL=tG5g@mail.gmail.com>
Subject: Re: [PATCH] x86: Fix location of '-plugin-opt=' flags
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Anthony Ruhier <aruhier@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 12:01 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Commit b33fff07e3e3 ("x86, build: allow LTO to be selected") added a
> couple of '-plugin-opt=' flags to KBUILD_LDFLAGS because the code model
> and stack alignment are not stored in LLVM bitcode. However, these flags
> were added to KBUILD_LDFLAGS prior to the emulation flag assignment,
> which uses ':=', so they were overwritten and never added to $(LD)
> invocations. The absence of these flags caused misalignment issues in
> the AMDGPU driver when compiling with CONFIG_LTO_CLANG, resulting in
> general protection faults.
>
> Shuffle the assignment below the initial one so that the flags are
> properly passed along and all of the linker flags stay together.
>
> At the same time, avoid any future issues with clobbering flags by
> changing the emulation flag assignment to '+=' since KBUILD_LDFLAGS is
> already defined with ':=' in the main Makefile before being exported for
> modification here as a result of commit ce99d0bf312d ("kbuild: clear
> LDFLAGS in the top Makefile").

Thanks for the patch file.  I will need to be more wary of `:=`
operator in kbuild changes in the future.

Ideally, we should encode these two flags in LLVM's IR so that we
don't need to respecify them when restarting optimizations from the
linker during LTO. I've filed
https://github.com/ClangBuiltLinux/linux/issues/1377 to follow up on
that idea.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Cc: stable@vger.kernel.org
> Fixes: b33fff07e3e3 ("x86, build: allow LTO to be selected")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1374
> Reported-by: Anthony Ruhier <aruhier@mailbox.org>
> Tested-by: Anthony Ruhier <aruhier@mailbox.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/x86/Makefile | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index c77c5d8a7b3e..307529417021 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -178,11 +178,6 @@ ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
>         KBUILD_CFLAGS += $(call cc-option,-maccumulate-outgoing-args,)
>  endif
>
> -ifdef CONFIG_LTO_CLANG
> -KBUILD_LDFLAGS += -plugin-opt=-code-model=kernel \
> -                  -plugin-opt=-stack-alignment=$(if $(CONFIG_X86_32),4,8)
> -endif
> -
>  # Workaround for a gcc prelease that unfortunately was shipped in a suse release
>  KBUILD_CFLAGS += -Wno-sign-compare
>  #
> @@ -202,7 +197,12 @@ ifdef CONFIG_RETPOLINE
>    endif
>  endif
>
> -KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
> +KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)
> +
> +ifdef CONFIG_LTO_CLANG
> +KBUILD_LDFLAGS += -plugin-opt=-code-model=kernel \
> +                  -plugin-opt=-stack-alignment=$(if $(CONFIG_X86_32),4,8)
> +endif
>
>  ifdef CONFIG_X86_NEED_RELOCS
>  LDFLAGS_vmlinux := --emit-relocs --discard-none
>
> base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
> --
> 2.32.0.rc0
>


-- 
Thanks,
~Nick Desaulniers
