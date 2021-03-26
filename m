Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FE034AED9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhCZS5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230194AbhCZS5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:57:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F6AA619F7;
        Fri, 26 Mar 2021 18:56:56 +0000 (UTC)
Date:   Fri, 26 Mar 2021 18:56:54 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v10 1/6] arm64: mte: Sync tags for pages where PTE is
 untagged
Message-ID: <20210326185653.GG5126@arm.com>
References: <20210312151902.17853-1-steven.price@arm.com>
 <20210312151902.17853-2-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312151902.17853-2-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Fri, Mar 12, 2021 at 03:18:57PM +0000, Steven Price wrote:
> A KVM guest could store tags in a page even if the VMM hasn't mapped
> the page with PROT_MTE. So when restoring pages from swap we will
> need to check to see if there are any saved tags even if !pte_tagged().
> 
> However don't check pages which are !pte_valid_user() as these will
> not have been swapped out.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h |  2 +-
>  arch/arm64/kernel/mte.c          | 16 ++++++++++++----
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index e17b96d0e4b5..84166625c989 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -312,7 +312,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>  		__sync_icache_dcache(pte);
>  
>  	if (system_supports_mte() &&
> -	    pte_present(pte) && pte_tagged(pte) && !pte_special(pte))
> +	    pte_present(pte) && pte_valid_user(pte) && !pte_special(pte))
>  		mte_sync_tags(ptep, pte);

With the EPAN patches queued in for-next/epan, pte_valid_user()
disappeared as its semantics weren't very clear.

So this relies on the set_pte_at() being done on the VMM address space.
I wonder, if the VMM did an mprotect(PROT_NONE), can the VM still access
it via stage 2? If yes, the pte_valid_user() test wouldn't work. We need
something like pte_present() && addr <= user_addr_max().

BTW, ignoring virtualisation, can we ever bring a page in from swap on a
PROT_NONE mapping (say fault-around)? It's not too bad if we keep the
metadata around for when the pte becomes accessible but I suspect we
remove it if the page is removed from swap.

-- 
Catalin
