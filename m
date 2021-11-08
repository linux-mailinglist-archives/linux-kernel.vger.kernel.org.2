Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877B4449F37
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 00:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241025AbhKHXze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 18:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbhKHXzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 18:55:33 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F05C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 15:52:48 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id br38so1577755lfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 15:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xQoakJHTcWwfHa/NS4KPgpKolL7O0uuBUoyy7jYi4UY=;
        b=FzgTBxK8H5tAEUhcqKWHyLjlpG0kfn/cnOAKtdSn7Jmclp+DBaVq4u5MvwU8+FUc7F
         XwgCxpxqFuiAHGrMf3JoRhyBBsxryXJLbMx3Ppd29nXMnTM3WVR2KmD8WAYb0y1YGGFO
         FO2kHEcqadQkuy8MhuElUx1FWI+oaCjeDBpHvkDsd0zK7Ts/zZn2iA/oGAfYBuFch95P
         zedUqHpdpXUFsbRiSGdVe9pxVKskLqNW3AXKdzKOM8fRRf6KoyLjLmOM+tDt17A+M+29
         KWBgPzKIdyy5KsZUzxJGGB/BBLx44ZXaViSkegJ2K/Lff0A6lo8mbxn6LllkhItoUw2I
         Dchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQoakJHTcWwfHa/NS4KPgpKolL7O0uuBUoyy7jYi4UY=;
        b=WS72lGa4h5MYLo3xUCjsE18OGeKuM74OAhH78IqjU3q3Ok+qxTPqgmFaZU2ArUgj42
         n5ynQhROUcJmMHSv7wnZBcEbB3NxjN/m2CQGhTMAL6uXsOs2wnvow4+y48D16jVUmH0v
         HNspFf80RPXxvF1Y+vvXAq/qxjlWpllUYkhFHV+OVKtJdyHNOxi9lzVs9r10u5B2Dh6p
         dZ0lY4ln0aYC94GMJ0EnePiOf3F6KED+KzT3NeltL4ciwPPwLKR00oWZZGj81sa++gn4
         9C0hckdRB0FGBE7beJYxS4ymHmNbhZBElVxWK/NUl3Xu1ZR/AYo+AZUYrXCAoZFTcslW
         79+A==
X-Gm-Message-State: AOAM530xiZ9HXlqpzzNOTknx12HEBvnmRhUw95O325jBI/0n00YYusiK
        CD7O9ZtH3XuLKB1Cf4mUFzDF4wao0K0qf968M0kLAg==
X-Google-Smtp-Source: ABdhPJz9Jal+DdJFxwcno3dBZUUGwwrzI6E+nDFqJAZgZew/jY4YcfEEOfxYGGFPwS0SI3bdktL6b+A7GK7Ucrt0TaU=
X-Received: by 2002:a05:6512:b29:: with SMTP id w41mr2875410lfu.240.1636415566309;
 Mon, 08 Nov 2021 15:52:46 -0800 (PST)
MIME-Version: 1.0
References: <20211107162641.324688-1-masahiroy@kernel.org> <20211107162641.324688-2-masahiroy@kernel.org>
In-Reply-To: <20211107162641.324688-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 8 Nov 2021 15:52:35 -0800
Message-ID: <CAKwvOdmCaXAMvouD7bsWqmgOUxQ9vpdt3LY7qWpzTVm-2gddEw@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/purgatory: remove -nostdlib compiler flag
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Fangrui Song <maskray@google.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        clang-built-linux@googlegroups.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 7, 2021 at 8:27 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The -nostdlib option requests the compiler to not use the standard
> system startup files or libraries when linking. It is effective only
> when $(CC) is used as a linker driver.

Is that right? ld.lld recognizes --nostdlib and has --help text for it.

>
> $(LD) is directly used for linking purgatory.{ro,chk} here, hence
> -nostdlib is unneeded.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/x86/purgatory/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 95ea17a9d20c..ae53d54d7959 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -16,7 +16,7 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
>
>  # When linking purgatory.ro with -r unresolved symbols are not checked,
>  # also link a purgatory.chk binary without -r to check for unresolved symbols.
> -PURGATORY_LDFLAGS := -e purgatory_start -nostdlib -z nodefaultlib
> +PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
>  LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
>  LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
>  targets += purgatory.ro purgatory.chk
> --
> 2.30.2

-- 
Thanks,
~Nick Desaulniers
