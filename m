Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB94420336
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 20:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhJCSGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 14:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhJCSGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 14:06:52 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE7EC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 11:05:04 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id y197so17676551iof.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 11:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0t/uC6UY+gZWkI7u9HEXsrryIwtnXmLh6shI3cfFXHw=;
        b=cB6WICj3ZrwgOR0Ic+R8lmr9MqGCJSjbqzjS/sDhbyud/r8u+UnfjPxTCJTSLWRt4+
         V6y5PAv6L4Yq4CsIjP35UkZ7PCt6QdkKRYUPTYH04s3mtu0sGObyz0XPpFcWpMtrp79D
         Rgqo+nD95CxYkJutsZiIUFKvP02dN0/JQnZRd5zW0bwO4SEUjjSJdDLmimfOuxqlMDA1
         Jo1gCyYZPpYEouHk0QUNmV2ciOagnuF8WJqWOlL+yvMD7LEqD6+XjGdodlNdIsZch40w
         cVUo7foe41DX1dcfeB04jXSdxKrtIpHy+WMW51vGTDUKxqz26DewSm5PQZ5gLJWXaOwh
         F5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0t/uC6UY+gZWkI7u9HEXsrryIwtnXmLh6shI3cfFXHw=;
        b=HU0uu/Dfa8ede/sjj9M7aQgvziYju+eyGX5MsENXYPYOI0s69Zs0ay2105vlvVweJU
         KVr+8IrncQfqoO2XZj+lCwvNVXcM+tay+tekUQqDgD2mBbrji8+4Xkwlg3PZ11P5ZW4U
         Zm8eWq2vy0xT+pT4e+etcrrjjljVeNfA31NnTCId3fUOTBPI8MthuD+jUwaWiPQGZoyb
         dLEBWz72dqhstgTAjXYUzvSHUo35si9pK0TruXWC6I6oTjw2KB6K1BV/Gcrlp+yylscZ
         jl0b0X8GhTyc9WXNidxGkxM+l5iDRlxFeEMw31yvhQcz03A6ccmxm7s9pqcTMszkL7wK
         r3QA==
X-Gm-Message-State: AOAM533ohNtQuwJAPm2rk8XkiVgyp7W4/SaHDzfpOFoptcUpHPge8AwG
        jYTONOOUhKYucxBmEg+LzH4zgb0SOevRjG1r2MlJOhClxCrY8A==
X-Google-Smtp-Source: ABdhPJwDVfrttSPm9m8jYxfYJ/qQN44t4XnSk0Jhu7W+St8ZuSLv9HUuBgDcghtNm0TzWUFmTK1FeeXxM4ShmSbA7k0=
X-Received: by 2002:a6b:c38d:: with SMTP id t135mr6528600iof.99.1633284304078;
 Sun, 03 Oct 2021 11:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210922205525.570068-1-nathan@kernel.org>
In-Reply-To: <20210922205525.570068-1-nathan@kernel.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 3 Oct 2021 20:04:53 +0200
Message-ID: <CA+fCnZdfMYvQ1o8n41dDzgJUArsUyhnb9Y_azgCVuzj6_KBifA@mail.gmail.com>
Subject: Re: [PATCH] kasan: Always respect CONFIG_KASAN_STACK
To:     Nathan Chancellor <nathan@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 10:55 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
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

This part of code always looked weird to me.

Shouldn't we be able to pull all these options out of the else section?

Then, the code structure would make sense: first, try applying
KASAN_SHADOW_OFFSET; if failed, use CFLAGS_KASAN_MINIMAL; and then try
applying all these options one by one.

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
