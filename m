Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1115415BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbhIWKJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbhIWKJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:09:01 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3404FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:07:30 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so7777512otb.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGizDeLzRGbblNybKFZtNPTDc7twErSudSG0K9dzTyI=;
        b=gx9iJmpVsc8VC7E6X1G9/vtVS9wUZJ2aHfzCzL7eNrFi4amBr08Tu0xEQNKip8IsdA
         YjmRTgXS+h66ufU2hH5mhyxN5jO0or5XLeCWMv3NtTu2wyzkvc70MJ6V12gyA9j7apsL
         G+Z0RVYZZGA+S3Y+iB2aBV3/vIhZvnWYv7yRfvmqiA+cIb7tGYhXhI5HIZx4Jvpxcy1y
         QlLHQZ+48XfbYmXAhLkxdB8Gihog2WYby21ipIwlaBn52KE8RXWW7ieJnVhk6l7/H8Te
         Sh+fML80EampCLvZLhfkdQ+YLLf1R5M57FlcqEcrS2c8P2mIwi8TJH6Yr65FeCpanA6x
         PyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGizDeLzRGbblNybKFZtNPTDc7twErSudSG0K9dzTyI=;
        b=vaTdVcORVOnUGDGblot4+feqfvLs3U1YU4wmIRmcGX6kTYf2eEtiZoo87xE5DOLwHE
         MFYgfNtu3zWdAlvGch8nhFTHnCBhDlNt7rSiBcg7KYBwhwTE5s/lmzJCmX8ZH0GC3hxb
         KA+pXhNVyuwYBvNHZafHpGkxtggEw9iETvHQfxUCEYH1JJusj743BgWrUiEUfo1jdH80
         7OZhKkz74/uZ5nrSmG2dSX32y9MmAUsn+vf5YUFYI8nwByqDBOfn3NJmj8x2wTapBYCy
         x9mtI2SEOAOEH/RPqMo/su6awJ5RIG4yt3gr0rTp9QLp6/G0xofxVW1sglbl0DIkIvV2
         apfA==
X-Gm-Message-State: AOAM530ikslAOxhI8fpIom4L+ip62aNqsqbTq29tTCkkrFzE8jEOWJae
        dBE6g7fF/wArLjqC/R7sM0K6wN4eqby581sU7vxCig==
X-Google-Smtp-Source: ABdhPJxQcNl+E0hqlYvj6R3nzKpFx4Yhh0lkCFH7MUOEbWh5g8rHrqts6FdpO0TwI0sRMnxa8VbR/CKkCmzDr0KiJOg=
X-Received: by 2002:a9d:135:: with SMTP id 50mr3469525otu.295.1632391649222;
 Thu, 23 Sep 2021 03:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210922205525.570068-1-nathan@kernel.org>
In-Reply-To: <20210922205525.570068-1-nathan@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Thu, 23 Sep 2021 12:07:17 +0200
Message-ID: <CANpmjNNqgUSbiPHOpD8z5JAv2aiujxAMiO4siymYdU6zpid_2g@mail.gmail.com>
Subject: Re: [PATCH] kasan: Always respect CONFIG_KASAN_STACK
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sept 2021 at 22:55, Nathan Chancellor <nathan@kernel.org> wrote:
> Currently, the asan-stack parameter is only passed along if
> CFLAGS_KASAN_SHADOW is not empty, which requires KASAN_SHADOW_OFFSET to
> be defined in Kconfig so that the value can be checked. In RISC-V's
> case, KASAN_SHADOW_OFFSET is not defined in Kconfig, which means that
> asan-stack does not get disabled with clang even when CONFIG_KASAN_STACK
> is disabled, resulting in large stack warnings with allmodconfig:
>
> drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c:117:12:
> error: stack frame size (14400) exceeds limit (2048) in function
> 'lb035q02_connect' [-Werror,-Wframe-larger-than]
> static int lb035q02_connect(struct omap_dss_device *dssdev)
>            ^
> 1 error generated.
>
> Ensure that the value of CONFIG_KASAN_STACK is always passed along to
> the compiler so that these warnings do not happen when
> CONFIG_KASAN_STACK is disabled.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1453
> References: 6baec880d7a5 ("kasan: turn off asan-stack for clang-8 and earlier")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Marco Elver <elver@google.com>

[ Which tree are you planning to take it through? ]

Note, arch/riscv/include/asm/kasan.h mentions KASAN_SHADOW_OFFSET in
comment (copied from arm64). Did RISC-V just forget to copy over the
Kconfig option?


> ---
>  scripts/Makefile.kasan | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index 801c415bac59..b9e94c5e7097 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -33,10 +33,11 @@ else
>         CFLAGS_KASAN := $(CFLAGS_KASAN_SHADOW) \
>          $(call cc-param,asan-globals=1) \
>          $(call cc-param,asan-instrumentation-with-call-threshold=$(call_threshold)) \
> -        $(call cc-param,asan-stack=$(stack_enable)) \
>          $(call cc-param,asan-instrument-allocas=1)
>  endif
>
> +CFLAGS_KASAN += $(call cc-param,asan-stack=$(stack_enable))
> +
>  endif # CONFIG_KASAN_GENERIC
>
>  ifdef CONFIG_KASAN_SW_TAGS
>
> base-commit: 4057525736b159bd456732d11270af2cc49ec21f
> --
> 2.33.0.514.g99c99ed825
>
>
