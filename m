Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551EB372CED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhEDPam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:30:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhEDPal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:30:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BDA060FDC;
        Tue,  4 May 2021 15:29:42 +0000 (UTC)
Date:   Tue, 4 May 2021 16:29:40 +0100
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
Subject: Re: [PATCH v11 1/6] arm64: mte: Sync tags for pages where PTE is
 untagged
Message-ID: <20210504152938.GC8078@arm.com>
References: <20210416154309.22129-1-steven.price@arm.com>
 <20210416154309.22129-2-steven.price@arm.com>
 <20210427174357.GA17872@arm.com>
 <0ab0017c-1eaf-201e-587f-101e03da6b80@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ab0017c-1eaf-201e-587f-101e03da6b80@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 05:06:05PM +0100, Steven Price wrote:
> On 27/04/2021 18:43, Catalin Marinas wrote:
> > On Fri, Apr 16, 2021 at 04:43:04PM +0100, Steven Price wrote:
> > > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > > index e17b96d0e4b5..cf4b52a33b3c 100644
> > > --- a/arch/arm64/include/asm/pgtable.h
> > > +++ b/arch/arm64/include/asm/pgtable.h
> > > @@ -312,7 +312,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> > >   		__sync_icache_dcache(pte);
> > >   	if (system_supports_mte() &&
> > > -	    pte_present(pte) && pte_tagged(pte) && !pte_special(pte))
> > > +	    pte_present(pte) && (pte_val(pte) & PTE_USER) && !pte_special(pte))
> > 
> > I would add a pte_user() macro here or, if we restore the tags only when
> > the page is readable, use pte_access_permitted(pte, false). Also add a
> > comment why we do this.
> 
> pte_access_permitted() looks like it describes what we want (user space can
> access the memory). I'll add the following comment:
> 
>  /*
>   * If the PTE would provide user space will access to the tags

I think drop "will".

>   * associated with it then ensure that the MTE tags are synchronised.
>   * Exec-only mappings don't expose tags (instruction fetches don't
>   * check tags).
>   */

Sounds fine.

> > There's also the pte_user_exec() case which may not have the PTE_USER
> > set (exec-only permission) but I don't think it matters. We don't do tag
> > checking on instruction fetches, so if the user adds a PROT_READ to it,
> > it would go through set_pte_at() again. I'm not sure KVM does anything
> > special with exec-only mappings at stage 2, I suspect they won't be
> > accessible by the guest (but needs checking).
> 
> It comes down to the behaviour of get_user_pages(). AFAICT that will fail if
> the memory is exec-only, so no stage 2 mapping will be created. Which of
> course means the guest can't do anything with that memory. That certainly
> seems like the only sane behaviour even without MTE.

That's my understanding as well. The get_user_pages_fast() path uses
pte_access_permitted() and should return false. The slower
get_user_pages() relies on checking the vma flags and it checks for
VM_READ.

-- 
Catalin
