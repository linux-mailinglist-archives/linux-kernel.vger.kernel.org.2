Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBA1309990
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 02:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhAaBID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 20:08:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230360AbhAaBIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 20:08:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 869B464E1F
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 01:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612055239;
        bh=CxtVBtXG1RK6bEiRQ4utBsgHs1JtSV1USk9q5Y8AlQ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A5VJ/Cgy9E1tZpJUp/PPuUn1AiZxlm0kbfriMgkHIKggrl7xbpKeTJ7H/33/lIvbA
         raY2ISip/RmwNcgNpAbGPuENDDS2zMJRAk0JXYrroagXtWC776ePHUZQjRlUHIzxqt
         nNWoZiXaoLx4kBIl1TUDzfVSxe7STomiArm/KEghd9dlvU0Z93JWv08gOHiLX1rGx2
         wZTMyRzRtGSB+GhZ35wic8/YgxI/O6PW1azYYWbPqQ81pjkg+ewd6soxxgiFeoo6/J
         ocMKE414eWfHsIqKezJ61lxFFEroS+GoycXYrWEt2NGzbfplYuNhJPJwbeAsYJZ49t
         BYoIId1nJPDKQ==
Received: by mail-ej1-f47.google.com with SMTP id hs11so18728389ejc.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:07:19 -0800 (PST)
X-Gm-Message-State: AOAM530CpReec20oOani7b2qzc6b/Sr6133B+3SvAKuDx7WYXEDCJAm9
        WkpwLOf9Flg/9NbDsY1eKKzWVBRywO8HfgJSzb5gnA==
X-Google-Smtp-Source: ABdhPJwTJwsIAohpbUU9Mc/jhFIjadLasppT9SxsBt9kySMviKzZXjPr6SoBBE1Vo8/IoT9PoBWalpKBVKrYsiQ9PC0=
X-Received: by 2002:a17:906:c824:: with SMTP id dd4mr9914091ejb.253.1612055237934;
 Sat, 30 Jan 2021 17:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20210131001132.3368247-1-namit@vmware.com> <20210131001132.3368247-4-namit@vmware.com>
In-Reply-To: <20210131001132.3368247-4-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 30 Jan 2021 17:07:06 -0800
X-Gmail-Original-Message-ID: <CALCETrWxyMsD5zEoaFS-aVfkV=QiVWa7pCU_JE3AYDEEU8Hqvg@mail.gmail.com>
Message-ID: <CALCETrWxyMsD5zEoaFS-aVfkV=QiVWa7pCU_JE3AYDEEU8Hqvg@mail.gmail.com>
Subject: Re: [RFC 03/20] mm/mprotect: do not flush on permission promotion
To:     Nadav Amit <nadav.amit@gmail.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Andrew Cooper, who has a distressingly extensive understanding
of the x86 PTE magic.

On Sat, Jan 30, 2021 at 4:16 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> From: Nadav Amit <namit@vmware.com>
>
> Currently, using mprotect() to unprotect a memory region or uffd to
> unprotect a memory region causes a TLB flush. At least on x86, as
> protection is promoted, no TLB flush is needed.
>
> Add an arch-specific pte_may_need_flush() which tells whether a TLB
> flush is needed based on the old PTE and the new one. Implement an x86
> pte_may_need_flush().
>
> For x86, besides the simple logic that PTE protection promotion or
> changes of software bits does require a flush, also add logic that
> considers the dirty-bit. If the dirty-bit is clear and write-protect is
> set, no TLB flush is needed, as x86 updates the dirty-bit atomically
> on write, and if the bit is clear, the PTE is reread.
>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: x86@kernel.org
> ---
>  arch/x86/include/asm/tlbflush.h | 44 +++++++++++++++++++++++++++++++++
>  include/asm-generic/tlb.h       |  4 +++
>  mm/mprotect.c                   |  3 ++-
>  3 files changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index 8c87a2e0b660..a617dc0a9b06 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -255,6 +255,50 @@ static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
>
>  extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
>
> +static inline bool pte_may_need_flush(pte_t oldpte, pte_t newpte)
> +{
> +       const pteval_t ignore_mask = _PAGE_SOFTW1 | _PAGE_SOFTW2 |
> +                                    _PAGE_SOFTW3 | _PAGE_ACCESSED;

Why is accessed ignored?  Surely clearing the accessed bit needs a
flush if the old PTE is present.

> +       const pteval_t enable_mask = _PAGE_RW | _PAGE_DIRTY | _PAGE_GLOBAL;
> +       pteval_t oldval = pte_val(oldpte);
> +       pteval_t newval = pte_val(newpte);
> +       pteval_t diff = oldval ^ newval;
> +       pteval_t disable_mask = 0;
> +
> +       if (IS_ENABLED(CONFIG_X86_64) || IS_ENABLED(CONFIG_X86_PAE))
> +               disable_mask = _PAGE_NX;
> +
> +       /* new is non-present: need only if old is present */
> +       if (pte_none(newpte))
> +               return !pte_none(oldpte);
> +
> +       /*
> +        * If, excluding the ignored bits, only RW and dirty are cleared and the
> +        * old PTE does not have the dirty-bit set, we can avoid a flush. This
> +        * is possible since x86 architecture set the dirty bit atomically while

s/set/sets/

> +        * it caches the PTE in the TLB.
> +        *
> +        * The condition considers any change to RW and dirty as not requiring
> +        * flush if the old PTE is not dirty or not writable for simplification
> +        * of the code and to consider (unlikely) cases of changing dirty-bit of
> +        * write-protected PTE.
> +        */
> +       if (!(diff & ~(_PAGE_RW | _PAGE_DIRTY | ignore_mask)) &&
> +           (!(pte_dirty(oldpte) || !pte_write(oldpte))))
> +               return false;

This logic seems confusing to me.  Is your goal to say that, if the
old PTE was clean and writable and the new PTE is write-protected,
then no flush is needed?  If so, I would believe you're right, but I'm
not convinced you've actually implemented this.  Also, there may be
other things going on that need flushing, e.g. a change of the address
or an accessed bit or NX change.

Also, CET makes this extra bizarre.

> +
> +       /*
> +        * Any change of PFN and any flag other than those that we consider
> +        * requires a flush (e.g., PAT, protection keys). To save flushes we do
> +        * not consider the access bit as it is considered by the kernel as
> +        * best-effort.
> +        */
> +       return diff & ((oldval & enable_mask) |
> +                      (newval & disable_mask) |
> +                      ~(enable_mask | disable_mask | ignore_mask));
> +}
> +#define pte_may_need_flush pte_may_need_flush
> +
>  #endif /* !MODULE */
>
>  #endif /* _ASM_X86_TLBFLUSH_H */
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index eea113323468..c2deec0b6919 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -654,6 +654,10 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
>         } while (0)
>  #endif
>
> +#ifndef pte_may_need_flush
> +static inline bool pte_may_need_flush(pte_t oldpte, pte_t newpte) { return true; }
> +#endif
> +
>  #endif /* CONFIG_MMU */
>
>  #endif /* _ASM_GENERIC__TLB_H */
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 632d5a677d3f..b7473d2c9a1f 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -139,7 +139,8 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>                                 ptent = pte_mkwrite(ptent);
>                         }
>                         ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
> -                       tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
> +                       if (pte_may_need_flush(oldpte, ptent))
> +                               tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
>                         pages++;
>                 } else if (is_swap_pte(oldpte)) {
>                         swp_entry_t entry = pte_to_swp_entry(oldpte);
> --
> 2.25.1
>
