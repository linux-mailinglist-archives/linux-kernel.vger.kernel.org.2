Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8AE30943C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 11:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhA3KRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 05:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhA3Avi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 19:51:38 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E344C061574
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 16:39:40 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id u8so6151830ior.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 16:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=fN/7Srg6RMZMQg+Pj363TOFpYds2LIdsI9psnGjzFYE=;
        b=fb7p3r/ds4x8s7jJf31ZDRFbKZ41gXnw4ZYnxd1jg/SuCldUI916puxQCnO3gCQJe1
         75pfJn+OSw4qjlcI37TOVTkEqat4aouzCuxGYddrF2jBKREiLskoGQTwjuUKKWkcIuK1
         kQl96LUnMh3HQudBnrElxiG88lmFbwCgUBUDv14xO2WWgu2z6R7LjCNCOyD2DGGT1PFm
         Z3TvHJ2g+6hywt1ybJ3Q0GgtLjPPwM1jERnKbrWtziJWd7Z66eKHfwNiczFe5YSgiyCc
         qgrUjTMVDO+UWS8iYEE1b26oH9Cujg/dOtB82+B/JEpOOn257L589ULsEfgHZraTmALF
         RGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=fN/7Srg6RMZMQg+Pj363TOFpYds2LIdsI9psnGjzFYE=;
        b=nChNx0viCBfHVUHsqIveKBZV8UI+UIIhXNVK0ZREc3yyh2qP8+XJxJEkODyuaan3zv
         gvtrI+UiKAuzfl1tgaIPQNJobfOfBXFNVZlUO6/DOzcBdIJxohJyeim1jC7K/Ijbz/p1
         DWRYMg8OaNQi/pXOHmVjSEyNswAb+azQP11Qy0tQjw8ydWyTBawr/ND2/SJafx2CrvPL
         H7lmGFJHT/itiywH8EjIf0Kkq28MbNT9VgHJmCdGBcJpEs2sRyrpXgoTUjFJuff1f+5r
         dCsdY3Npx7+xWcbsybFx91PTkpj/wmhM6+fNyV3gXPNbsc6pXf5+8KV6ZyQwtj2Jc/Qp
         6xdw==
X-Gm-Message-State: AOAM533Rzsl6VG/c8Usa5suURWMopYuwTzXM1wLEuLGZMPNR1vhoR4bk
        cOtxtfSWdHerqDpAIqkb/jlfGc1Inc3nLS3yhKY=
X-Google-Smtp-Source: ABdhPJz0/Xdae21G738J+8lH63T3xlG01FAfnnaL9aIUyVhj0pD+w93hb+c8M4Xmr+MHhs2Cz2+rmn6Aix4oaIAf2Jg=
X-Received: by 2002:a05:6602:1806:: with SMTP id t6mr5393733ioh.171.1611967179623;
 Fri, 29 Jan 2021 16:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20210129201116.2658179-1-nathan@kernel.org> <20210130002557.2681512-1-nathan@kernel.org>
In-Reply-To: <20210130002557.2681512-1-nathan@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 30 Jan 2021 01:39:28 +0100
Message-ID: <CA+icZUWQVE1mAL8v1DjWziAFtY7FLBTawv3voVG8KB6sWFHaOg@mail.gmail.com>
Subject: Re: [PATCH v2] vmlinux.lds.h: Define SANTIZER_DISCARDS with CONFIG_GCOV_KERNEL=y
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        kernel test robot <lkp@intel.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 1:27 AM Nathan Chancellor <nathan@kernel.org> wrote:
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
> Reviewed-by: Fangrui Song <maskray@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>
> v1 -> v2:
>
> * Keep configs and flag names alphabetized.
>
> * Drop mention of -ftest-coverage since it does not cause this issue per
>   Fangrui.
>
> * Pick up review tags from Fangrui and Nick.
>
>  include/asm-generic/vmlinux.lds.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b2b3d81b1535..0e6c5da667a7 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -988,12 +988,13 @@
>  #endif
>
>  /*
> - * Clang's -fsanitize=kernel-address and -fsanitize=thread produce
> - * unwanted sections (.eh_frame and .init_array.*), but
> - * CONFIG_CONSTRUCTORS wants to keep any .init_array.* sections.
> + * Clang's -fprofile-arcs, -fsanitize=kernel-address, and
> + * -fsanitize=thread produce unwanted unwanted sections

Typo: double "unwanted".

- Sedat -

> + * (.eh_frame and .init_array.*), but CONFIG_CONSTRUCTORS
> + * wants to keep any .init_array.* sections.
>   * https://bugs.llvm.org/show_bug.cgi?id=46478
>   */
> -#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN)
> +#if defined(CONFIG_GCOV_KERNEL) || defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN)
>  # ifdef CONFIG_CONSTRUCTORS
>  #  define SANITIZER_DISCARDS                                           \
>         *(.eh_frame)
>
> base-commit: bec4c2968fce2f44ce62d05288a633cd99a722eb
> --
> 2.30.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210130002557.2681512-1-nathan%40kernel.org.
