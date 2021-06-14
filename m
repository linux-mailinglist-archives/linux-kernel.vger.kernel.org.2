Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194D53A70CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 22:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhFNU5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 16:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbhFNU5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:57:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2089CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 13:55:02 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id c11so21982208ljd.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 13:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qBa3/WQ3AGZ6PKm/jM3ch14S6swJuVHrhcyrw+AJEwA=;
        b=plPsxy+9kEuGVZdGaNjNczNmZJ0tvHqF3H0S1tUuIqh7/xY432HUjpxYkrQFuUVHni
         V11wMaoN3lfHvndqx0GkwuPcks5mhAUb7sx2hlWE8hn7Lfp55uPTVNtjzC93MYzFe5vr
         G6Y1ioiUkY4+3H/iyYs/HQgUadwwcqWBmK8xLLldeHzrc5/tm8xOAmD5MRZyQK0WKtAT
         AHoma2r218DBdEcpt6Sc68FMcw0Q4cOvQ5jC3ujfDWxq1cnAutW/k/c5JPKEGDRZ70oC
         SER7qkXRrSvC7YiQN6BJqMG+gqGn3NvpxeblBjBhcyF91jlHPT2a2XFclZR1zKwwYUsL
         1Q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBa3/WQ3AGZ6PKm/jM3ch14S6swJuVHrhcyrw+AJEwA=;
        b=kpjWe9Rxv6Qm6xSTRH/8sILSOgC/YbbAbVVq8318Z7us8M7vX/RhcaPCAJUZI/zpDZ
         eCp4xGIHh0Qzz8mpA6Yxrx+VjCDoriUJsamI/kfrx2QAOzo9/jd7X22AH0GOB2KHhEfW
         er2GrfYeXOZb7ZH82YT9lJP5/nEH+ur/h3dryn9B3upwWrlUXzblPyhf/LQqelsVSKJT
         zO0S0ZD76T+GFvEb5SSqyF8ZBx6Cv0OWnqEedKHd2Z569PICKGbnly1Rf1ukT7stEEdK
         XXqI2Sea5SsIOh9+9tGRolwM7t9vvwZXYcO98XxwohST30sw9+2Zy4TV0Rbc8+2f2fo7
         tQQw==
X-Gm-Message-State: AOAM530nbERDeSvxJsd5hm6DgoOaIBGuZL/qTcsmsXq5UAQXDdZu3zkI
        DpSC4aZxZbMoQmLrqD0cpKgOEARSLjOTwjZj1qNdJw==
X-Google-Smtp-Source: ABdhPJziluN+Qde4u/nmKfseLf3GXYc4iUTl/Helm6ApNjM5cEdQz1WJWpT0G1fFxRHLZsFY6CJ7K66WzcjjLiyYUIg=
X-Received: by 2002:a2e:3c06:: with SMTP id j6mr14789034lja.495.1623704100254;
 Mon, 14 Jun 2021 13:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <7631bab7-a8ab-f884-ab54-f4198976125c@mailbox.org>
In-Reply-To: <7631bab7-a8ab-f884-ab54-f4198976125c@mailbox.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 14 Jun 2021 13:54:48 -0700
Message-ID: <CAKwvOdmWYuOqOp7BNjaLM5p+Tumvs+N2iLe23PYEz-WsXU=-fA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Makefile: Pass -warn-stack-size only on LLD < 13.0.0
To:     Tor Vic <torvic9@mailbox.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 6:07 AM Tor Vic <torvic9@mailbox.org> wrote:
>
> Since LLVM commit fc018eb, the '-warn-stack-size' flag has been dropped
> [1], leading to the following error message when building with Clang-13
> and LLD-13:
>
>     ld.lld: error: -plugin-opt=-: ld.lld: Unknown command line argument
>     '-warn-stack-size=2048'.  Try: 'ld.lld --help'
>     ld.lld: Did you mean '--asan-stack=2048'?
>
> In the same way as with commit 2398ce80152a ("x86, lto: Pass
> -stack-alignment only on LLD < 13.0.0") , make '-warn-stack-size'
> conditional on LLD < 13.0.0.
>
> [1] https://reviews.llvm.org/D103928
>
> Fixes: 24845dcb170e ("Makefile: LTO: have linker check -Wframe-larger-than")
> Cc: stable@vger.kernel.org
> Link: https://github.com/ClangBuiltLinux/linux/issues/1377
> Signed-off-by: Tor Vic <torvic9@mailbox.org>

Thanks for the patch!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 144d4f8b7eb3..51a1b6b2c2ab 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -929,11 +929,14 @@ CC_FLAGS_LTO      += -fvisibility=hidden
>  # Limit inlining across translation units to reduce binary size
>  KBUILD_LDFLAGS += -mllvm -import-instr-limit=5
>
> -# Check for frame size exceeding threshold during prolog/epilog insertion.
> +# Check for frame size exceeding threshold during prolog/epilog insertion
> +# when using lld < 13.0.0.
>  ifneq ($(CONFIG_FRAME_WARN),0)
> +ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 130000; echo $$?),0)
>  KBUILD_LDFLAGS += -plugin-opt=-warn-stack-size=$(CONFIG_FRAME_WARN)
>  endif
>  endif
> +endif
>
>  ifdef CONFIG_LTO
>  KBUILD_CFLAGS  += -fno-lto $(CC_FLAGS_LTO)
> --
> 2.32.0



-- 
Thanks,
~Nick Desaulniers
