Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67AF38F2C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhEXSNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232789AbhEXSND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:13:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DF8E61403;
        Mon, 24 May 2021 18:11:31 +0000 (UTC)
Date:   Mon, 24 May 2021 19:11:29 +0100
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
Subject: Re: [PATCH v12 7/8] KVM: arm64: ioctl to fetch/store tags in a guest
Message-ID: <20210524181129.GI14645@arm.com>
References: <20210517123239.8025-1-steven.price@arm.com>
 <20210517123239.8025-8-steven.price@arm.com>
 <20210520120556.GC12251@arm.com>
 <dd5ab3a0-5a74-b145-2485-d6d871be945b@arm.com>
 <20210520172713.GF12251@arm.com>
 <5eec330f-63c0-2af8-70f8-ba9b643e2558@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eec330f-63c0-2af8-70f8-ba9b643e2558@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 10:42:09AM +0100, Steven Price wrote:
> On 20/05/2021 18:27, Catalin Marinas wrote:
> > On Thu, May 20, 2021 at 04:58:01PM +0100, Steven Price wrote:
> >> On 20/05/2021 13:05, Catalin Marinas wrote:
> >>> On Mon, May 17, 2021 at 01:32:38PM +0100, Steven Price wrote:
> >>>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> >>>> index e89a5e275e25..4b6c83beb75d 100644
> >>>> --- a/arch/arm64/kvm/arm.c
> >>>> +++ b/arch/arm64/kvm/arm.c
> >>>> @@ -1309,6 +1309,65 @@ static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
> >>>>  	}
> >>>>  }
> >>>>  
> >>>> +static int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
> >>>> +				      struct kvm_arm_copy_mte_tags *copy_tags)
> >>>> +{
> >>>> +	gpa_t guest_ipa = copy_tags->guest_ipa;
> >>>> +	size_t length = copy_tags->length;
> >>>> +	void __user *tags = copy_tags->addr;
> >>>> +	gpa_t gfn;
> >>>> +	bool write = !(copy_tags->flags & KVM_ARM_TAGS_FROM_GUEST);
> >>>> +	int ret = 0;
> >>>> +
> >>>> +	if (copy_tags->reserved[0] || copy_tags->reserved[1])
> >>>> +		return -EINVAL;
> >>>> +
> >>>> +	if (copy_tags->flags & ~KVM_ARM_TAGS_FROM_GUEST)
> >>>> +		return -EINVAL;
> >>>> +
> >>>> +	if (length & ~PAGE_MASK || guest_ipa & ~PAGE_MASK)
> >>>> +		return -EINVAL;
> >>>> +
> >>>> +	gfn = gpa_to_gfn(guest_ipa);
> >>>> +
> >>>> +	mutex_lock(&kvm->slots_lock);
> >>>> +
> >>>> +	while (length > 0) {
> >>>> +		kvm_pfn_t pfn = gfn_to_pfn_prot(kvm, gfn, write, NULL);
> >>>> +		void *maddr;
> >>>> +		unsigned long num_tags = PAGE_SIZE / MTE_GRANULE_SIZE;
> >>>> +
> >>>> +		if (is_error_noslot_pfn(pfn)) {
> >>>> +			ret = -EFAULT;
> >>>> +			goto out;
> >>>> +		}
> >>>> +
> >>>> +		maddr = page_address(pfn_to_page(pfn));
> >>>> +
> >>>> +		if (!write) {
> >>>> +			num_tags = mte_copy_tags_to_user(tags, maddr, num_tags);
> >>>> +			kvm_release_pfn_clean(pfn);
> >>>
> >>> Do we need to check if PG_mte_tagged is set? If the page was not faulted
> >>> into the guest address space but the VMM has the page, does the
> >>> gfn_to_pfn_prot() guarantee that a kvm_set_spte_gfn() was called? If
> >>> not, this may read stale tags.
> >>
> >> Ah, I hadn't thought about that... No I don't believe gfn_to_pfn_prot()
> >> will fault it into the guest.
> > 
> > It doesn't indeed. What it does is a get_user_pages() but it's not of
> > much help since the VMM pte wouldn't be tagged (we would have solved
> > lots of problems if we required PROT_MTE in the VMM...)
> 
> Sadly it solves some problems and creates others :(

I had some (random) thoughts on how to make things simpler, maybe. I
think most of these races would have been solved if we required PROT_MTE
in the VMM but this has an impact on the VMM if it wants to use MTE
itself. If such requirement was in place, all KVM needed to do is check
PG_mte_tagged.

So what we actually need is a set_pte_at() in the VMM to clear the tags
and set PG_mte_tagged. Currently, we only do this if the memory type is
tagged (PROT_MTE) but it's not strictly necessary.

As an optimisation for normal programs, we don't want to do this all the
time but the visible behaviour wouldn't change (well, maybe for ptrace
slightly). However, it doesn't mean we couldn't for a VMM, with an
opt-in via prctl(). This would add a MMCF_MTE_TAG_INIT bit (couldn't
think of a better name) to mm_context_t.flags and set_pte_at() would
behave as if the pte was tagged without actually mapping the memory in
user space as tagged (protection flags not changed). Pages that don't
support tagging are still safe, just some unnecessary ignored tag
writes. This would need to be set before the mmap() for the guest
memory.

If we want finer-grained control we'd have to store this information in
the vma flags, in addition to VM_MTE (e.g. VM_MTE_TAG_INIT) but without
affecting the actual memory type. The easiest would be another pte bit,
though we are short on them. A more intrusive (not too bad) approach is
to introduce a set_pte_at_vma() and read the flags directly in the arch
code. In most places where set_pte_at() is called on a user mm, the vma
is also available.

Anyway, I'm not saying we go this route, just thinking out loud, get
some opinions.

> > Another thing I forgot to ask, what's guaranteeing that the page
> > supports tags? Does this ioctl ensure that it would attempt the tag
> > copying from some device mapping? Do we need some kvm_is_device_pfn()
> > check? I guess ZONE_DEVICE memory we just refuse to map in an earlier
> > patch.
> 
> Hmm, nothing much. While reads are now fine (the memory won't have
> PG_mte_tagged), writes could potentially happen on ZONE_DEVICE memory.

I don't think it's a problem for writes either as the host wouldn't map
such memory as tagged. It's just that it returns zeros and writes are
ignored, so we could instead return an error (I haven't checked your
latest series yet).

> >> 		} else {
> >> 			num_tags = mte_copy_tags_from_user(maddr, tags,
> >> 							MTE_GRANULES_PER_PAGE);
> >> 			kvm_release_pfn_dirty(pfn);
> >> 		}
> >>
> >> 		if (num_tags != MTE_GRANULES_PER_PAGE) {
> >> 			ret = -EFAULT;
> >> 			goto out;
> >> 		}
> >>
> >> 		if (write)
> >> 			test_and_set_bit(PG_mte_tagged, &page->flags);
> > 
> > I think a set_bit() would do, I doubt it's any more efficient. But why
> 
> I'd seen test_and_set_bit() used elsewhere (I forget where now) as a
> slightly more efficient approach. It complies down to a READ_ONCE and a
> conditional atomic, vs a single non-conditional atomic. But I don't have
> any actual data on the performance and this isn't a hot path, so I'll
> switch to the more obvious set_bit().

Yeah, I think I've seen this as well. Anyway, it's probably lost in the
noise of tag writing here.

-- 
Catalin
