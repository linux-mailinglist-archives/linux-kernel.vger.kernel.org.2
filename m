Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3463388BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhCLJcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:32:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232976AbhCLJcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:32:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E675364F00;
        Fri, 12 Mar 2021 09:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615541532;
        bh=QI5dJEwGdeMnTd1iHeXVNhRkfs1oEIF4TdgD0ZnWNGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AyDWB8WkHQay/ioJcVD8rXkR1MtA0JYVj9tt1qLNMcC9v33MM38l0Cv3ca94IRPjU
         OZRFfn8TM727w54GEAXvJ7s+CgQ3JXpOdFShFJJx+ALsyvCtyP6oB0TiZ/QwurHTV2
         V451b2lEf3lO9xB/K2YNPIBRpLt4yeiDRikB3tBqaYzIF/NPQ8T9DJaUfJ6FPKivYW
         ahQkeqBEOrk8S75OfFrgEzoE3ioA74qmPVOm/W/V+KumD0IKvV3WvGh09W7WId9Ix+
         TLOFOpnRR6WYZz+JlSletFlBRyfR4y++qiYCtMt/9yNS8W6EsPY9SMGxTHHQhtjHW8
         KoTJLJ8hBIkZw==
Date:   Fri, 12 Mar 2021 09:32:06 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 28/34] KVM: arm64: Use page-table to track page
 ownership
Message-ID: <20210312093205.GB32016@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-29-qperret@google.com>
 <20210311183834.GC31378@willie-the-truck>
 <YEsIxA/fKaDlSaio@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEsIxA/fKaDlSaio@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 06:23:00AM +0000, Quentin Perret wrote:
> On Thursday 11 Mar 2021 at 18:38:36 (+0000), Will Deacon wrote:
> > On Wed, Mar 10, 2021 at 05:57:45PM +0000, Quentin Perret wrote:
> > > As the host stage 2 will be identity mapped, all the .hyp memory regions
> > > and/or memory pages donated to protected guestis will have to marked
> > > invalid in the host stage 2 page-table. At the same time, the hypervisor
> > > will need a way to track the ownership of each physical page to ensure
> > > memory sharing or donation between entities (host, guests, hypervisor) is
> > > legal.
> > > 
> > > In order to enable this tracking at EL2, let's use the host stage 2
> > > page-table itself. The idea is to use the top bits of invalid mappings
> > > to store the unique identifier of the page owner. The page-table owner
> > > (the host) gets identifier 0 such that, at boot time, it owns the entire
> > > IPA space as the pgd starts zeroed.
> > > 
> > > Provide kvm_pgtable_stage2_set_owner() which allows to modify the
> > > ownership of pages in the host stage 2. It re-uses most of the map()
> > > logic, but ends up creating invalid mappings instead. This impacts
> > > how we do refcount as we now need to count invalid mappings when they
> > > are used for ownership tracking.
> > > 
> > > Signed-off-by: Quentin Perret <qperret@google.com>
> > > ---
> > >  arch/arm64/include/asm/kvm_pgtable.h | 21 +++++++
> > >  arch/arm64/kvm/hyp/pgtable.c         | 92 ++++++++++++++++++++++++----
> > >  2 files changed, 101 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > > index 4ae19247837b..b09af4612656 100644
> > > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > > @@ -238,6 +238,27 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
> > >  			   u64 phys, enum kvm_pgtable_prot prot,
> > >  			   void *mc);
> > >  
> > > +/**
> > > + * kvm_pgtable_stage2_set_owner() - Annotate invalid mappings with metadata
> > > + *				    encoding the ownership of a page in the
> > > + *				    IPA space.
> > > + * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init().
> > > + * @addr:	Intermediate physical address at which to place the annotation.
> > 
> > This confused me a bit, as the annotation is stored in the page-table, not
> > at the memory identified by @addr. How about:
> > 
> >   "Base intermediate physical address to annotate"
> > 
> > > + * @size:	Size of the IPA range to annotate.
> > 
> >   "Size of the annotated range"
> > 
> > > + * @mc:		Cache of pre-allocated and zeroed memory from which to allocate
> > > + *		page-table pages.
> > > + * @owner_id:	Unique identifier for the owner of the page.
> > > + *
> > > + * The page-table owner has identifier 0.
> > 
> > Perhaps, "By default, all page-tables are owned by identifier 0"
> 
> Ack all of the above.
> 
> > > + *
> > > + * Return: 0 on success, negative error code on failure.
> > > + */
> > > +int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
> > > +				 void *mc, u32 owner_id);
> > 
> > Is there a need for the owner_id to be 32-bit rather than e.g. 16-bit? Just
> > strikes me that it might be difficult to recover these bits in future if we
> > give them out freely now.
> 
> I figured we might want to use identifiers that are stable for the
> lifetime of protected VMs. I wasn't sure using e.g. VMIDs would be a
> better choice here as re-using them will cause a lot of pain for the
> host stage 2 pgtable maintenance.

I'm not saying to use the VMID directly, just that allocating half of the
pte feels a bit OTT given that the state of things after this patch series
is that we're using exactly 1 bit.

> > > @@ -517,28 +543,36 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
> > >  	if (!kvm_block_mapping_supported(addr, end, phys, level))
> > >  		return -E2BIG;
> > >  
> > > -	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
> > > -	if (kvm_pte_valid(old)) {
> > > +	if (kvm_pte_valid(data->attr))
> > 
> > This feels like a bit of a hack to me: the 'attr' field in stage2_map_data
> > is intended to correspond directly to the lower/upper attributes of the
> > descriptor as per the architecture, so tagging the valid bit in there is
> > pretty grotty. However, I can see the significant advantage in being able
> > to re-use the stage2_map_walker functionality, so about instead of nobbling
> > attr, you set phys to something invalid instead, e.g.:
> > 
> > 	#define KVM_PHYS_SET_OWNER	(-1ULL)
> 
> That'll confuse kvm_block_mapping_supported() and friends I think, at
> least in their current form. If you _really_ don't like this, maybe we
> could have an extra 'flags' field in stage2_map_data?

I was pondering this last night and I thought of two ways to do it:

1. Add a 'bool valid' and then stick the owner and the phys in a union.
   (yes, you'll need to update the block mapping checks to look at the
    valid flag)

2. Go with my latter suggestion:

> > Is there ever a reason to use kvm_pgtable_stage2_set_owner() to set an
> > owner of 0, or should you just use the map/unmap APIs for that? If so,
> > then maybe the key is simply if owner_id is non-zero, then an invalid
> > entry is installed?
> 
> I couldn't find a good reason to restrict it, as that wouldn't change
> the implementation much anyway. Also, if we added the right CMOs, we
> could probably remove the unmap walker and re-express it in terms of
> set_owner(0) ... But I suppose that is for later :-)

The idea being that if owner is 0, then we install a mapping for phys, but
if owner is !0 then we set the invalid mapping.

(1) is probably the less hacky option... what do you reckon?

Will
