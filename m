Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A637459FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbhKWKBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:01:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231221AbhKWKBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:01:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59EC361078
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637661482;
        bh=c2af4cD82ZvlTLcEtFj3WN6w9IAHd0AVMeQM3gBpzWY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KhB9zgBoY3dmtZR935W/ITrcH9pIB5gJwopsE2S7wAw73csvtucfJKOaKi8nEfqRA
         uR6WkaUYKWgCU0TtkYWiVJUhSyA+lOJiIWuIQBrh9Tz79Dk5NAgFGtL/ULwxJVHNuz
         f8ig5ftJp9Mapie97yPIcRg99MaJwmAgd5u695ByLrUJ3vjEWasQYwjaZ99cl5L5UU
         /OZ5T75ZXpcTSY8gMZQViqEUIvYJWVNFN8AtI1cZxUpk/cLf4Pz+B1yyxgLKSpC2rb
         IuIAYheemRZuCGiUyAFe2x5rPMxGwR96xOYa7f/zunzW0gcbQBHI83tyQF8zK5Z/Po
         zUB2eNxf0eH1A==
Received: by mail-ot1-f50.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so14530306otv.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 01:58:02 -0800 (PST)
X-Gm-Message-State: AOAM5322DvLbnc4s7vD2RcxZXn6MkeEGvOJcT0UqxLhdz91pvtlyb8pl
        eMfuldAH3RYy3VaS6laRfjZtGgqi9G7WsWODKM4=
X-Google-Smtp-Source: ABdhPJx/bR0UUrC75aFHTkOtBjjnustA215aKRj+dEMm+J+VaQwZu36SrrjAOxDGbtWuBoOU8cT/kuqaPS1nnmMm+/s=
X-Received: by 2002:a05:6830:1514:: with SMTP id k20mr3024125otp.147.1637661481511;
 Tue, 23 Nov 2021 01:58:01 -0800 (PST)
MIME-Version: 1.0
References: <1637658760-5813-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1637658760-5813-1-git-send-email-huangzhaoyang@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 23 Nov 2021 10:57:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGLRr8bnhLPseW=gSj6kA1TKqAC0Bs0Loj8gkpgaMB8MA@mail.gmail.com>
Message-ID: <CAMj1kXGLRr8bnhLPseW=gSj6kA1TKqAC0Bs0Loj8gkpgaMB8MA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: introduce alloc hook to apply PTE_CONT
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jonathan Marek <jonathan@marek.ca>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 at 10:13, Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Since there is no PTE_CONT when rodata_full in ARM64, introducing a
> hook function to apply PTE_CONT on the proper page blocks.
>

Given the discussion around your previous patch, I would expect a
meticulous explanation here why it is guaranteed to be safe to
manipulate the PTE_CONT attribute like this, and how the proposed
logic is correct for all supported page sizes.

Without using an intermediate invalid mapping for the entire range,
this is never going to work reliably (this is the break-before-make
requirement). And given that marking the entire block invalid will
create intermediate states that are not permitted (a valid PTE_CONT
mapping and an invalid ~PTE_CONT mapping covering the same VA), the
only way to apply changes like these is to temporarily switch all CPUs
to a different translation via TTBR1. And this is not going to happen.

Also, you never replied to my question regarding the use case and the
performance gain.

In summary, NAK to this patch or any of the previous ones regarding
PTE_CONT. If you do insist on pursuing this further, please provide an
elaborate and rock solid explanation why your approach is 100% valid
and correct (for all page sizes). And make sure you include an
explanation how your changes comply with the architectural
break-before-make requirements around PTE_CONT attributes.



> ---
>  arch/arm64/include/asm/page.h |  5 +++++
>  arch/arm64/mm/pageattr.c      | 45 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> index f98c91b..53cdd09 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -46,6 +46,11 @@ struct page *alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
>
>  #include <asm/memory.h>
>
> +#define HAVE_ARCH_ALLOC_PAGE
> +#define HAVE_ARCH_FREE_PAGE
> +
> +extern void arch_alloc_page(struct page *page, int order);
> +extern void arch_free_page(struct page *page, int order);
>  #endif /* !__ASSEMBLY__ */
>
>  #define VM_DATA_DEFAULT_FLAGS  (VM_DATA_FLAGS_TSK_EXEC | VM_MTE_ALLOWED)
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index a3bacd7..815a06d 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -239,3 +239,48 @@ bool kernel_page_present(struct page *page)
>         ptep = pte_offset_kernel(pmdp, addr);
>         return pte_valid(READ_ONCE(*ptep));
>  }
> +
> +void arch_alloc_page(struct page *page, int order)
> +{
> +       unsigned long addr;
> +       unsigned long cont_pte_low_bound;
> +
> +       if (!rodata_full)
> +               return;
> +
> +       addr = (u64)page_address(page);
> +       if ((order >= 4) && (addr & ~CONT_PTE_MASK) == 0) {
> +               order -= 4;
> +               do {
> +                       cont_pte_low_bound = addr & CONT_PTE_MASK;
> +                       __change_memory_common(cont_pte_low_bound,
> +                                       (~CONT_PTE_MASK + 1), __pgprot(PTE_CONT), __pgprot(0));
> +                       addr = (u64)page_address(page);
> +                       page += 4;
> +                       order--;
> +               }while (order >= 0);
> +       }
> +}
> +
> +void arch_free_page(struct page *page, int order)
> +{
> +       unsigned long addr;
> +       unsigned long cont_pte_low_bound;
> +
> +       if (!rodata_full)
> +               return;
> +
> +       addr = (u64)page_address(page);
> +       if ((order >= 4) && (addr & ~CONT_PTE_MASK) == 0) {
> +               order -= 4;
> +               do {
> +                       cont_pte_low_bound = addr & CONT_PTE_MASK;
> +                       __change_memory_common(cont_pte_low_bound,
> +                                       (~CONT_PTE_MASK + 1), __pgprot(0), __pgprot(PTE_CONT));
> +                       addr = (u64)page_address(page);
> +                       page += 4;
> +                       order--;
> +               }while (order >= 0);
> +       }
> +}
> +
> --
> 1.9.1
>
