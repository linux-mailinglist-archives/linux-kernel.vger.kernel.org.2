Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D8638AE2C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhETM23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235459AbhETM1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:27:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5391A6124C;
        Thu, 20 May 2021 12:25:53 +0000 (UTC)
Date:   Thu, 20 May 2021 13:25:50 +0100
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
Subject: Re: [PATCH v12 3/8] arm64: mte: Sync tags for pages where PTE is
 untagged
Message-ID: <20210520122550.GD12251@arm.com>
References: <20210517123239.8025-1-steven.price@arm.com>
 <20210517123239.8025-4-steven.price@arm.com>
 <20210519180610.GE21619@arm.com>
 <3bac3a47-9f96-c7bf-e401-fdef60dcc9d8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bac3a47-9f96-c7bf-e401-fdef60dcc9d8@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 12:55:21PM +0100, Steven Price wrote:
> On 19/05/2021 19:06, Catalin Marinas wrote:
> > On Mon, May 17, 2021 at 01:32:34PM +0100, Steven Price wrote:
> >> A KVM guest could store tags in a page even if the VMM hasn't mapped
> >> the page with PROT_MTE. So when restoring pages from swap we will
> >> need to check to see if there are any saved tags even if !pte_tagged().
> >>
> >> However don't check pages for which pte_access_permitted() returns false
> >> as these will not have been swapped out.
> >>
> >> Signed-off-by: Steven Price <steven.price@arm.com>
> >> ---
> >>  arch/arm64/include/asm/pgtable.h |  9 +++++++--
> >>  arch/arm64/kernel/mte.c          | 16 ++++++++++++++--
> >>  2 files changed, 21 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> >> index 0b10204e72fc..275178a810c1 100644
> >> --- a/arch/arm64/include/asm/pgtable.h
> >> +++ b/arch/arm64/include/asm/pgtable.h
> >> @@ -314,8 +314,13 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> >>  	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
> >>  		__sync_icache_dcache(pte);
> >>  
> >> -	if (system_supports_mte() &&
> >> -	    pte_present(pte) && pte_tagged(pte) && !pte_special(pte))
> >> +	/*
> >> +	 * If the PTE would provide user space access to the tags associated
> >> +	 * with it then ensure that the MTE tags are synchronised.  Exec-only
> >> +	 * mappings don't expose tags (instruction fetches don't check tags).
> >> +	 */
> >> +	if (system_supports_mte() && pte_present(pte) &&
> >> +	    pte_access_permitted(pte, false) && !pte_special(pte))
> >>  		mte_sync_tags(ptep, pte);
> > 
> > Looking at the mte_sync_page_tags() logic, we bail out early if it's the
> > old pte is not a swap one and the new pte is not tagged. So we only need
> > to call mte_sync_tags() if it's a tagged new pte or the old one is swap.
> > What about changing the set_pte_at() test to:
> > 
> > 	if (system_supports_mte() && pte_present(pte) && !pte_special(pte) &&
> > 	    (pte_tagged(pte) || is_swap_pte(READ_ONCE(*ptep))))
> > 		mte_sync_tags(ptep, pte);
> > 
> > We can even change mte_sync_tags() to take the old pte directly:
> > 
> > 	if (system_supports_mte() && pte_present(pte) && !pte_special(pte)) {
> > 		pte_t old_pte = READ_ONCE(*ptep);
> > 		if (pte_tagged(pte) || is_swap_pte(old_pte))
> > 			mte_sync_tags(old_pte, pte);
> > 	}
> > 
> > It would save a function call in most cases where the page is not
> > tagged.
> 
> Yes that looks like a good optimisation - although you've missed the
> pte_access_permitted() part of the check ;)

I was actually wondering if we could remove it. I don't think it buys us
much as we have a pte_present() check already, so we know it is pointing
to a valid page. Currently we'd only get a tagged pte on user mappings,
same with swap entries.

When vmalloc kasan_hw will be added, I think we have a set_pte_at() with
a tagged pte but init_mm and high address (we might as well add a
warning if addr > TASK_SIZE_64 on the mte_sync_tags path so that we
don't forget).

> The problem I hit is one of include dependencies:
> 
> is_swap_pte() is defined (as a static inline) in
> include/linux/swapops.h. However the definition depends on
> pte_none()/pte_present() which are defined in pgtable.h - so there's a
> circular dependency.
> 
> Open coding is_swap_pte() in set_pte_at() works, but it's a bit ugly.
> Any ideas on how to improve on the below?
> 
> 	if (system_supports_mte() && pte_present(pte) &&
> 	    pte_access_permitted(pte, false) && !pte_special(pte)) {
> 		pte_t old_pte = READ_ONCE(*ptep);
> 		/*
> 		 * We only need to synchronise if the new PTE has tags enabled
> 		 * or if swapping in (in which case another mapping may have
> 		 * set tags in the past even if this PTE isn't tagged).
> 		 * (!pte_none() && !pte_present()) is an open coded version of
> 		 * is_swap_pte()
> 		 */
> 		if (pte_tagged(pte) || (!pte_none(pte) && !pte_present(pte)))
> 			mte_sync_tags(old_pte, pte);
> 	}

That's why I avoided testing my suggestion ;). I think we should just
add !pte_none() in there with a comment that it may be a swap pte and
use the is_swap_pte() again on the mte_sync_tags() path. We already have
the pte_present() check.

-- 
Catalin
