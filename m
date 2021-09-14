Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B03640B7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhINTX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbhINTX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:23:57 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB7EC061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:22:37 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id o11so582085ljp.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RgqPc9G3kEzrx4a9xU6WJRNLMMqujZAV7WWA24EODcg=;
        b=B7a2T/vWkandCsB27/jpPgZImnu46XBPtNlUpD22KxdbM1FhOhF2vGT8afNq9gpWHP
         sJqxZ0BJNT5KcVCN04TGHBAIsa+zsxMVuSEbUMXiA+1WdMk1cjTcoTobbohQ7RgeZbrO
         qY+SR583jpL9bTsYAfVzwqcrCgh9HG79xO7zdBNmaGL7nXHan6i4zEtmqtLcOClJxH9d
         VbVzZj6tQBwXRjJkcB4j48au/AVdL0rRFGLYEu55uSc1sN1fvT+6QEsKRe31OWaRwzo2
         kP1zz5FCzcfmVGOMkk2kTTnT3L8mgJxYU4HSMozh5gkA4UABdF5OJIYR0xGk+gnsB1ci
         Fheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RgqPc9G3kEzrx4a9xU6WJRNLMMqujZAV7WWA24EODcg=;
        b=CP2O1I/u6+2Xz2XB7+dsG5OlV1YELQ8Crt1k+wXOc+O6ffIkXR3iXSox8r/+ij+ZiN
         LY1i/oodBk4OX3dQhcUWw9nQ826ImODBAFqFDlLJwkgkYHPMFd4y4tW+RoUOMPaVHNok
         XYTS719H2kksViR9QsoxZI7pAGyd4qhsKgIyWu2JgRS2AQ248aOCPY93BYzsyA2zYDe9
         bebJCMbfcc91FNJbcQ3o2RLZ94ZTF8YuZ7ujx8x8IEKR5HhI/tt5ZvJMb9L6cUxHpthH
         qV2vBIwR20M9BhHn4xlACD5+q/0+jI+JaTkrmryEjXh2Qff3D5EW+CYZwk8Umhk1aTqm
         LJOg==
X-Gm-Message-State: AOAM532sGLF/rtBKR7JlfAc03FZEgLlJbvOE4IePjIV6fN5DLwb03A9G
        tHPW210l6Cnd6Wx4YBtLFXn0Frpnv5VS5Y3eSYw/dg==
X-Google-Smtp-Source: ABdhPJwa7yL3vXUNDq0XxlCpymQppX1uWzQS6zEjAC1wqfD6PUQ6AH9Jk8yNqHqbph8WiBjGBnSH7AOvrA/KuPEzBR8=
X-Received: by 2002:a05:651c:54d:: with SMTP id q13mr17337321ljp.526.1631647355826;
 Tue, 14 Sep 2021 12:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210914102837.6172-1-will@kernel.org> <01f572ab-bea2-f246-2f77-2f119056db84@kernel.org>
 <202109140958.11DCC6B6@keescook> <CAKwvOdnrO7X8h-g9Pn8RmfJhqj2zn3HJwpQ0p2EONNtFF0w-uA@mail.gmail.com>
 <202109141214.630BB3A@keescook>
In-Reply-To: <202109141214.630BB3A@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 12:22:24 -0700
Message-ID: <CAKwvOdmP6mYwZ+0Z5iXFv5dtd_96SxYsUn469ZC=C=SFw-Hs-A@mail.gmail.com>
Subject: Re: [PATCH] hardening: Default to INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_ZERO
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:14 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Sep 14, 2021 at 11:53:38AM -0700, Nick Desaulniers wrote:
> > Rather than create 2 new kconfigs with 1 new invocation of the
> > compiler via cc-option, how about just adding an `ifdef
> > CONFIG_CC_IS_CLANG` guard around adding the obnoxious flag to
> > `KBUILD_CFLAGS` in the top level Makefile?
>
> v2:

LGTM
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

I think the formal patch should have Will's Suggested-by on it.

>
> diff --git a/Makefile b/Makefile
> index 34a0afc3a8eb..72d165ffabdb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -831,12 +831,12 @@ endif
>
>  # Initialize all stack variables with a zero value.
>  ifdef CONFIG_INIT_STACK_ALL_ZERO
> -# Future support for zero initialization is still being debated, see
> -# https://bugs.llvm.org/show_bug.cgi?id=45497. These flags are subject to being
> -# renamed or dropped.
>  KBUILD_CFLAGS  += -ftrivial-auto-var-init=zero
> +ifdef CONFIG_CC_IS_CLANG
> +# https://bugs.llvm.org/show_bug.cgi?id=45497
>  KBUILD_CFLAGS  += -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
>  endif
> +endif
>
>  # While VLAs have been removed, GCC produces unreachable stack probes
>  # for the randomize_kstack_offset feature. Disable it for all compilers.
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 90cbaff86e13..ded17b8abce2 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -23,13 +23,16 @@ config CC_HAS_AUTO_VAR_INIT_PATTERN
>         def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
>
>  config CC_HAS_AUTO_VAR_INIT_ZERO
> +       # GCC ignores the -enable flag, so we can test for the feature with
> +       # a single invocation using the flag, but drop it as appropriate in
> +       # the Makefile, depending on the presence of Clang.
>         def_bool $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
>
>  choice
>         prompt "Initialize kernel stack variables at function entry"
>         default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
>         default INIT_STACK_ALL_PATTERN if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT_PATTERN
> -       default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_PATTERN
> +       default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_ZERO
>         default INIT_STACK_NONE
>         help
>           This option enables initialization of stack variables at
>
> --
> Kees Cook



-- 
Thanks,
~Nick Desaulniers
