Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AA037BCA4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhELMiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:38:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231516AbhELMiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:38:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB5E9613EE
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 12:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823033;
        bh=XkOhrOWbN9AlYoHRLs0Z4W6MIbYTlTq+5/csJR2U03A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t3bGUj80jB8H9p4PREvCYiG4tWPnv6JRlOjATU9c5/ex3XJq+UyMYKn1OVa0phTR5
         XHH+UY/FbEdTcki5qBmufoWDFxHLTQsudfsxZ+JSugKHC0YUUt8cNxxOpPYUna+RAe
         OL7d4+4aOENJXqGKlRAWZtiFqgXW7/wGZN9GZC1NY4KGddecaAMMA5ZP+xCpctEeeD
         tQ3bdG7IgxyYGhsdmSK2Xapx562PcMhfl5HGMJIgI7P7nXYFlhyWGOfO4Z0hd7BRW6
         F644u2AgRj2ynO6S+mpN40Gk4OKWIQdiIFzHME4bZy6THx1ne87JRypHRbrqSkWENj
         wJZPkZxde3AIQ==
Received: by mail-oo1-f41.google.com with SMTP id h9-20020a4a94090000b02901f9d4f64172so4904774ooi.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 05:37:12 -0700 (PDT)
X-Gm-Message-State: AOAM531BnfdAksvj0F5BeAK9K3wTO84iZzi27oPuJkxJQoHBWNLPHweW
        hIlF/ijASnx1ivyR+Xrhey/nnZKAFWGr3L/qjXA=
X-Google-Smtp-Source: ABdhPJyDJ7BgqLKYiSXC59m2GFplOiaAnO5/BuuTIvDmpCdFpzwnsYtfZSDUJz0LA73a/vGe9quNnNZR1/9Jrx+x5W4=
X-Received: by 2002:a4a:8706:: with SMTP id z6mr9894765ooh.41.1620823032122;
 Wed, 12 May 2021 05:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210512090047.2069033-1-arnd@kernel.org>
In-Reply-To: <20210512090047.2069033-1-arnd@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 May 2021 14:37:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH8o_xF5OyWSG297niUz4NFj+qTW6Vwn_U_x9eSzmkqkQ@mail.gmail.com>
Message-ID: <CAMj1kXH8o_xF5OyWSG297niUz4NFj+qTW6Vwn_U_x9eSzmkqkQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] ARM: mark prepare_page_table as __init
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 at 11:01, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> In some configurations when building with gcc-11, prepare_page_table
> does not get inline, which causes a build time warning for a section
> mismatch:
>
> WARNING: modpost: vmlinux.o(.text.unlikely+0xce8): Section mismatch in reference from the function prepare_page_table() to the (unknown reference) .init.data:(unknown)
> The function prepare_page_table() references
> the (unknown reference) __initdata (unknown).
> This is often because prepare_page_table lacks a __initdata
> annotation or the annotation of (unknown) is wrong.
>
> Mark the function as __init to avoid the warning regardless of the
> inlining, and remove the 'inline' keyword. The compiler is
> free to ignore the 'inline' here and it doesn't result in better
> object code or more readable source.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
> v2: remove 'inline', as suggested by Russell and Ard
> ---
>  arch/arm/mm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 051f4f82414b..40a1fa5ec93b 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1246,7 +1246,7 @@ void __init adjust_lowmem_bounds(void)
>         memblock_set_current_limit(memblock_limit);
>  }
>
> -static inline void prepare_page_table(void)
> +static __init void prepare_page_table(void)
>  {
>         unsigned long addr;
>         phys_addr_t end;
> --
> 2.29.2
>
