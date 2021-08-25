Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847D03F7CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 21:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbhHYTm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 15:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbhHYTm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 15:42:56 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74E6C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 12:42:09 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s12so706069ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8bdCyvC7Uu9hJ+o7Jz6ECHUhPAIMpOORzVb26WnGxM=;
        b=fy7FSMFVhod+RQF9PxaNTXukhehzmnrw1oVvDT6ae1n1J2qALCG4+tGNP3gWGuP4TO
         EHapm1ur3TPgRbHJ4n4KixsoM/Og/0Hv1QyipQr8I9Gzo7NycATrc3EGLMCdllO2e5pR
         5C+VYFEX+Txbv5I9Bpxa4Hhud2zg+zRSP8ePynlDEmgWB2YkK06YIpQ7+dQ4/bGDQdEw
         +RzNQz2O5OCruiOJbcE8PFY5Knpx1aEH9X4LzfLcWCgWbB68/pqzg8Shu07RVYTpqzo4
         IGZMriF7cj5OC43E+/QyQcAJoE9gGaED08EjsBMgeZaSYJDnQVZ0cf0qOszhqrPOjOVi
         gh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8bdCyvC7Uu9hJ+o7Jz6ECHUhPAIMpOORzVb26WnGxM=;
        b=HH+IPS4pqS+636nW+KKDah1idfeq3bRkLtLIDXnuHQVJ6vfsy/Nut/irksB+qRMj0r
         AUT8Nu1PN23jF0fZxznlDXoNB3UNgcoo/c1p9lwMdHDOVxd6i5avJkJWfJ6nT8kVvcaD
         VLfuIhvETKjgwiBB9hKEfLMrerZ4whErLK9ZAbakHG/B1lqR+bthNp/C8TrP1aGiT5LN
         jQyw+rIeZ1fB11nV7GixEIT1oWc60I/clORTl7P4F8bkSySzWYkLmKA1mPNuY4dUdLRk
         YwxYIK87SBw8i21/zcO7WKsBXknsyOpZPDQQwShuQEk3q2pSuJ+pQ8FZw0VaLy+cB5q+
         Cowg==
X-Gm-Message-State: AOAM530ecu5NM9jv3A6DpYh93CA9/AUnybWLYsQzw0SHvM9n8SbzkubF
        YkMrmS/xLKC/MdQqsNbWaY/jAGYEGeJZ+7MHkSs/RA==
X-Google-Smtp-Source: ABdhPJwZnjnGR+4s5l/KVJUFTI3ve9z49umzxrFnkgYuE41CcXxbXBK+PWqEpd6EYW2goWod17qptKYPuxBC6zXhitk=
X-Received: by 2002:a2e:8008:: with SMTP id j8mr36245723ljg.233.1629920527830;
 Wed, 25 Aug 2021 12:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210822075122.864511-1-keescook@chromium.org> <20210822075122.864511-17-keescook@chromium.org>
In-Reply-To: <20210822075122.864511-17-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 12:41:56 -0700
Message-ID: <CAKwvOd=A+ueGV2ihdy5GtgR2fQbcXjjAtVxv3=cPjffpebZB7A@mail.gmail.com>
Subject: Re: [PATCH for-next 16/25] fortify: Explicitly disable Clang support
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 12:57 AM Kees Cook <keescook@chromium.org> wrote:
>
> Clang has never correctly compiled the FORTIFY_SOURCE defenses due to
> a couple bugs:
>
>         Eliding inlines with matching __builtin_* names
>         https://bugs.llvm.org/show_bug.cgi?id=50322
>
>         Incorrect __builtin_constant_p() of some globals
>         https://bugs.llvm.org/show_bug.cgi?id=41459
>
> In the process of making improvements to the FORTIFY_SOURCE defenses, the
> first (silent) bug (coincidentally) becomes worked around, but exposes
> the latter which breaks the build. As such, Clang must not be used with
> CONFIG_FORTIFY_SOURCE until at least latter bug is fixed (in Clang 13),
> and the fortify routines have been rearranged.
>
> Update the Kconfig to reflect the reality of the current situation.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  security/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/security/Kconfig b/security/Kconfig
> index 0ced7fd33e4d..fe6c0395fa02 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -191,6 +191,9 @@ config HARDENED_USERCOPY_PAGESPAN
>  config FORTIFY_SOURCE
>         bool "Harden common str/mem functions against buffer overflows"
>         depends on ARCH_HAS_FORTIFY_SOURCE
> +       # https://bugs.llvm.org/show_bug.cgi?id=50322
> +       # https://bugs.llvm.org/show_bug.cgi?id=41459
> +       depends on !CC_IS_CLANG
>         help
>           Detect overflows of buffers in common string and memory functions
>           where the compiler can determine and validate the buffer sizes.
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210822075122.864511-17-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
