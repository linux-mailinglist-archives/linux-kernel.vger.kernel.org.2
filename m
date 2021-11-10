Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6770D44CA1C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 21:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhKJUJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 15:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhKJUJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 15:09:52 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BEBC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 12:07:03 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bi37so3802301lfb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 12:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSrurhuXGQeaKHb8L3Yt2wYxJhfQZQU1Ci3KEYdxsXE=;
        b=T0mA82S9aS7nOrIgd2qcqEul9JjHQUoU8HzJ21m8sjnbL/1TejZ8J0/l2r0yz9N1DV
         7KYYQVEDM8dWNgM3GSDzkJBB8+QLDEYCo4t8KXCj70Xix1uwk8aJgyH8o+/RP047yAtX
         CS/TrfUb0a2v260PfJmBUEuDyMFrPdhqFB/5qsQubgoE7AIhFracdruNroW5PlM+CJdL
         ETdegyJVHjt7c/VPVSFJLlW4u2Vy7lygSusXao2RpYU65stYwbEnIJMNKDbHohef6aWu
         wTe5jioJN7ugIrQwbs2FTrSt50LCBDDyom9qlMzW0+BqccXNEBGeSI5TE/AhrqwKWCM7
         ibxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSrurhuXGQeaKHb8L3Yt2wYxJhfQZQU1Ci3KEYdxsXE=;
        b=l0leNZgytnNpJlXrBysNAOzBvcQc+LZGkuj5137Hdk868/3jIl2vcVdKYi3lAZGsOc
         +bWFVO9RUvU9HsPIu+eAZUOwHguIvl68gMBAGVzQsV5dXjgJCzDaVMEg6B6Y9VwRrUi4
         Gnc866pv1GWL1+qjZK1JQ+8f5LRTfDWFsw/WFtVT+jZYbCpE49TIT0PqWiAQw7Krfy9b
         WD2XnFV6eZJLoJ/Vyos0UZl/khQQXSTTOETw4Hxe5PElmGwQlQSbCi5+iFSK1nj297sm
         ZQVItlxwvcuZqfgO6f4qutDZMhlt3SyuNGmmLvR3YzxKmvAZHIlWXSM1zZA55TO0CQ5K
         N26A==
X-Gm-Message-State: AOAM533OAIXRGmP8H2FSJ26q1jh4B/zOXjnltFuFyxITg4rTzzO8lbkB
        qWZIY4mZpeqaxsJy2Dg1dJegsqPGnAp94jElSSWJlw==
X-Google-Smtp-Source: ABdhPJw9k0mLRxwBuj7rQyxiIB+48oYQHmhvLoAw9ksWTcNXj7BksXRDsC7flJmlS7jyiEBX3R0vvvviT8js4Q+rUf0=
X-Received: by 2002:a05:6512:607:: with SMTP id b7mr1598868lfe.489.1636574822075;
 Wed, 10 Nov 2021 12:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20211107161855.323312-1-masahiroy@kernel.org>
In-Reply-To: <20211107161855.323312-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Nov 2021 12:06:50 -0800
Message-ID: <CAKwvOd=jgJhkehw2M6edkbJb-h_gSDDv+gZ2Ycra1LCr-x-4qQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: vdso: remove -nostdlib compiler flag
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        clang-built-linux@googlegroups.com,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 7, 2021 at 8:19 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The -nostdlib option requests the compiler to not use the standard
> system startup files or libraries when linking. It is effective only
> when $(CC) is used as a linker driver.
>
> Since commit fe00e50b2db8 ("ARM: 8858/1: vdso: use $(LD) instead of
> $(CC) to link VDSO"), $(LD) is directly used, hence -nostdlib is
> unneeded.

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/arm/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index 7c9e395b77f7..ec52b776f926 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -18,7 +18,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO32
>
>  ldflags-$(CONFIG_CPU_ENDIAN_BE8) := --be8
>  ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
> -           -z max-page-size=4096 -nostdlib -shared $(ldflags-y) \
> +           -z max-page-size=4096 -shared $(ldflags-y) \
>             --hash-style=sysv --build-id=sha1 \
>             -T
>
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20211107161855.323312-1-masahiroy%40kernel.org.



-- 
Thanks,
~Nick Desaulniers
