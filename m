Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C66437A338
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhEKJOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230442AbhEKJOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:14:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCB3A61927
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 09:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620724421;
        bh=BR81VXadwSN0Wb8eCKd0AEu/wCwHkOKE2OFkPtdge9I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cVEP6IKtG+wR7W4R/gvZnVy/MTprx9+SnnZsvKnvbHIkQbFP7u87QPfWYPsQUNuhG
         PSuKxOBVC4a213TyvE/Ofw8TqmmYGnA/mcLmB8gm+c8H0X1JNbuwhEkvcjPO9Jv5H3
         6XXEQRd6lDHMpZYoKzhE8g8GmMx1lfIQQZAzyc6k7jbVJFNTxq2AFvSXtnTbPvqWWu
         t3Gf9g4o8R9AiqpTO6MHwQyhzBFbt6eIxB7rZ/3G+mXdlRFYRV+yLjbu4m+mKOkkIS
         5slYSQXFMoallYRE24BsFU1pge8ldW6sL+QrAi/H3z6HLCw1e5w6aWaeR2Mxp/Md02
         ElBMCPkzn2vUA==
Received: by mail-oi1-f182.google.com with SMTP id w16so10255339oiv.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 02:13:41 -0700 (PDT)
X-Gm-Message-State: AOAM533Z/N+vX8MTHuwDVXRaxGV9x8jkcOWu9Ylc7NHGQ2ATSLFKvkbv
        mPtLhLU1crOQw7k9yMo/teH7iGpqnHhOLCdcLmg=
X-Google-Smtp-Source: ABdhPJx9zC1SejZv808n7w5SuuidqWsE6YY630XuCVsbreWZYfVnf6PKHZ8mH+jyGaF/1OIqhQ6jFs4ouSJneTxTo9I=
X-Received: by 2002:aca:4056:: with SMTP id n83mr2784337oia.47.1620724421115;
 Tue, 11 May 2021 02:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210511090318.478586-1-arnd@kernel.org>
In-Reply-To: <20210511090318.478586-1-arnd@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 11 May 2021 11:13:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG7+g-LmqNeh61eJCe2VUwvjCDqoGfpUPsp7p_MfpQ=Rw@mail.gmail.com>
Message-ID: <CAMj1kXG7+g-LmqNeh61eJCe2VUwvjCDqoGfpUPsp7p_MfpQ=Rw@mail.gmail.com>
Subject: Re: [PATCH] ARM: mark prepare_page_table as __init
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hailong Liu <carver4lio@163.com>,
        Changbin Du <changbin.du@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 at 11:04, Arnd Bergmann <arnd@kernel.org> wrote:
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
> inlining.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I think the inline should be dropped here. Either inlining is
absolutely required for correct code generation (which is rare), or
the inline is optional, and better left up to the compiler, especially
given that this is __init code so the time/space tradeoff is moot
anyway.

With or without that change,

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm/mm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 051f4f82414b..5220b8147f40 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1246,7 +1246,7 @@ void __init adjust_lowmem_bounds(void)
>         memblock_set_current_limit(memblock_limit);
>  }
>
> -static inline void prepare_page_table(void)
> +static inline __init void prepare_page_table(void)
>  {
>         unsigned long addr;
>         phys_addr_t end;
> --
> 2.29.2
>
