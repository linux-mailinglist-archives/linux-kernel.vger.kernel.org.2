Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AD330BE46
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhBBMe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhBBMex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:34:53 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E01DC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 04:34:12 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jj19so1986941ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 04:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6I4haZIWsliPsnrnAX2Sa5cCONJWo9DW/MGCmG1Xqs=;
        b=B6s/bm1bx2jJs7NjaP2KkMMPw2RkI4o0/Ofwvv28y/sK/siYEsHeEJv0MSPg6ZrZuN
         /0wneE7wmT0nVZiqb9K7TWvi/JMBr353Lpm/ZMQpRMlBzwqNUilxWA9hFI/02MKGr0YL
         BVX7S58ZXAA/bBwX+LePiINcnbEleALJhmn2RgzPtzFFjrqbCYJDte2+VyA1XEALeAfk
         vc0JmayBG3sglnUGMjC9KA134ZiZsxvc9FkB6YjqzH4fIm0gDHUfIq1eM5fCfr9a3UcT
         Y+xuxPpMAOxOa1cf+ib03BLfeHxz+SUZHCQUxOq0e9vM+kTex1I1YyNvJivVExTmSEIw
         Sa5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6I4haZIWsliPsnrnAX2Sa5cCONJWo9DW/MGCmG1Xqs=;
        b=pt2vCcEZ/LL7TONqK8Ht5Sa5+KNwgIKYTjg7ozL8ytprtLVzRo54UesuUm3CAhIkmM
         hPAebeDTOATmh/rRkkMJ8S2Z18JJpwrttGrkjuLTKtVUsd/AVJ9ax7F2fiFL05knVAzf
         r6n5un2p6a9YOqH1sz2ltVYRuO0TGwWSdwvqDtvTh1rbhgQFQ9ku9UnPjescF3+C2zJj
         NtJ1AwFA8k/eRbQTFshLfHJOwz2iwY+nri1Hhly+caMABHL7QR4RuwOyOmlXrOSPH5nJ
         3oTrN0WP6DR3DpH7mMIs8u42trd/C73OqLVpjqRBpy5W46kCQIIz/l5p5b0CYYngCZ8p
         EJBg==
X-Gm-Message-State: AOAM530IG7r0OjIMNm8A+LFc7hCxmgYPN7xl9kk5XyI7tYf3TjjUjsj6
        eAHM1VKU/+wFBa5asN8m46d7Jx9RERvq74IgTd5RyiKrHHLcbbgn
X-Google-Smtp-Source: ABdhPJyBObMI6HVIwZFhh6uneucrTYozkMY2kZMk7G6l1eSmZHS5s8FGqHfk8sZlRTuEMN37HKtc4bLPTK+KsqW37Ag=
X-Received: by 2002:a17:907:20aa:: with SMTP id pw10mr22204602ejb.314.1612269251060;
 Tue, 02 Feb 2021 04:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20210202200324.5179db33@canb.auug.org.au> <CAMuHMdXcKrCBq7gytvD07NBRjuLMdJRahQ3Dfa_mMdZBHdds6w@mail.gmail.com>
In-Reply-To: <CAMuHMdXcKrCBq7gytvD07NBRjuLMdJRahQ3Dfa_mMdZBHdds6w@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 2 Feb 2021 07:33:34 -0500
Message-ID: <CA+CK2bBrU2Ky2TL0o_4Ugt+NW6MArTPKexczRij-V5BHgxh7rA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

The fix is here:
https://lore.kernel.org/linux-mm/CA+CK2bBjC8=cRsL5VhWkcevPsqSXWhsANVjsFNMERLT8vWtiQw@mail.gmail.com/

Thank you,
Pasha

On Tue, Feb 2, 2021 at 5:35 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Tue, Feb 2, 2021 at 10:13 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > After merging the akpm-current tree, today's linux-next build (x86_64
> > allnoconfig) failed like this:
> >
> > In file included from arch/x86/include/asm/page.h:76,
> >                  from arch/x86/include/asm/thread_info.h:12,
> >                  from include/linux/thread_info.h:56,
> >                  from arch/x86/include/asm/preempt.h:7,
> >                  from include/linux/preempt.h:78,
> >                  from include/linux/spinlock.h:51,
> >                  from include/linux/mmzone.h:8,
> >                  from include/linux/gfp.h:6,
> >                  from include/linux/slab.h:15,
> >                  from include/linux/crypto.h:20,
> >                  from arch/x86/kernel/asm-offsets.c:9:
> > include/linux/mm.h: In function 'is_pinnable_page':
> > include/asm-generic/memory_model.h:64:14: error: implicit declaration of function 'page_to_section'; did you mean 'present_section'? [-Werror=implicit-function-declaration]
> >    64 |  int __sec = page_to_section(__pg);   \
> >       |              ^~~~~~~~~~~~~~~
> > include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
> >    81 | #define page_to_pfn __page_to_pfn
> >       |                     ^~~~~~~~~~~~~
> > include/linux/mm.h:1134:15: note: in expansion of macro 'page_to_pfn'
> >  1134 |   is_zero_pfn(page_to_pfn(page));
> >       |               ^~~~~~~~~~~
>
> In addition, noreply@ellerman.id.au reports for m68k/m5272c3_defconfig:
>
>     include/linux/mm.h:1133:3: error: implicit declaration of function
> 'is_zero_pfn'; did you mean 'is_zero_ino'?
> [-Werror=implicit-function-declaration]
>
> is_zero_pfn() is only defined if CONFIG_MMU=y.
>
> Hence using it in mm/gup.c in commit 3f509f6aef4bb868 ("mm/gup: migrate
> pinned pages out of movable zone") breaks compilation of gup.c, too.
>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
