Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579BA3894C7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 19:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhESRtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 13:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhESRtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 13:49:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 232EC611BF;
        Wed, 19 May 2021 17:48:11 +0000 (UTC)
Date:   Wed, 19 May 2021 18:48:08 +0100
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
Message-ID: <20210519174808.GD21619@arm.com>
References: <20210517123239.8025-1-steven.price@arm.com>
 <20210517123239.8025-4-steven.price@arm.com>
 <87y2cdtk09.wl-maz@kernel.org>
 <f3a3f560-4d2b-9cd3-bbf4-ea8135ab4d17@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3a3f560-4d2b-9cd3-bbf4-ea8135ab4d17@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:32:01AM +0100, Steven Price wrote:
> On 17/05/2021 17:14, Marc Zyngier wrote:
> > On Mon, 17 May 2021 13:32:34 +0100,
> > Steven Price <steven.price@arm.com> wrote:
> >>
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
> > 
> > I'm not sure I understand this comment. Of course, execution doesn't
> > match tags. But the memory could still have tags associated with
> > it. Does this mean such a page would lose its tags is swapped out?
> 
> Hmm, I probably should have reread that - the context of the comment is
> lost.
> 
> I added the comment when changing to pte_access_permitted(), and the
> comment on pte_access_permitted() explains a potential gotcha:
> 
>  * p??_access_permitted() is true for valid user mappings (PTE_USER
>  * bit set, subject to the write permission check). For execute-only
>  * mappings, like PROT_EXEC with EPAN (both PTE_USER and PTE_UXN bits
>  * not set) must return false. PROT_NONE mappings do not have the
>  * PTE_VALID bit set.
> 
> So execute-only mappings return false even though that is effectively a
> type of user access. However, because MTE checks are not performed by
> the PE for instruction fetches this doesn't matter. I'll update the
> comment, how about:
> 
> /*
>  * If the PTE would provide user space access to the tags associated
>  * with it then ensure that the MTE tags are synchronised.  Although
>  * pte_access_permitted() returns false for exec only mappings, they
>  * don't expose tags (instruction fetches don't check tags).
>  */

This looks fine to me. We basically want to check the PTE_VALID and
PTE_USER bits and pte_access_permitted() does this (we could come up
with a new macro name like pte_valid_user() but since we don't care
about execute-only, it gets unnecessarily complicated).

-- 
Catalin
