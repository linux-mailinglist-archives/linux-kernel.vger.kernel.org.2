Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55CA38B527
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhETR2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231680AbhETR2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:28:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75DE860240;
        Thu, 20 May 2021 17:27:18 +0000 (UTC)
Date:   Thu, 20 May 2021 18:27:16 +0100
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
Message-ID: <20210520172713.GF12251@arm.com>
References: <20210517123239.8025-1-steven.price@arm.com>
 <20210517123239.8025-8-steven.price@arm.com>
 <20210520120556.GC12251@arm.com>
 <dd5ab3a0-5a74-b145-2485-d6d871be945b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd5ab3a0-5a74-b145-2485-d6d871be945b@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 04:58:01PM +0100, Steven Price wrote:
> On 20/05/2021 13:05, Catalin Marinas wrote:
> > On Mon, May 17, 2021 at 01:32:38PM +0100, Steven Price wrote:
> >> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> >> index e89a5e275e25..4b6c83beb75d 100644
> >> --- a/arch/arm64/kvm/arm.c
> >> +++ b/arch/arm64/kvm/arm.c
> >> @@ -1309,6 +1309,65 @@ static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
> >>  	}
> >>  }
> >>  
> >> +static int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
> >> +				      struct kvm_arm_copy_mte_tags *copy_tags)
> >> +{
> >> +	gpa_t guest_ipa = copy_tags->guest_ipa;
> >> +	size_t length = copy_tags->length;
> >> +	void __user *tags = copy_tags->addr;
> >> +	gpa_t gfn;
> >> +	bool write = !(copy_tags->flags & KVM_ARM_TAGS_FROM_GUEST);
> >> +	int ret = 0;
> >> +
> >> +	if (copy_tags->reserved[0] || copy_tags->reserved[1])
> >> +		return -EINVAL;
> >> +
> >> +	if (copy_tags->flags & ~KVM_ARM_TAGS_FROM_GUEST)
> >> +		return -EINVAL;
> >> +
> >> +	if (length & ~PAGE_MASK || guest_ipa & ~PAGE_MASK)
> >> +		return -EINVAL;
> >> +
> >> +	gfn = gpa_to_gfn(guest_ipa);
> >> +
> >> +	mutex_lock(&kvm->slots_lock);
> >> +
> >> +	while (length > 0) {
> >> +		kvm_pfn_t pfn = gfn_to_pfn_prot(kvm, gfn, write, NULL);
> >> +		void *maddr;
> >> +		unsigned long num_tags = PAGE_SIZE / MTE_GRANULE_SIZE;
> >> +
> >> +		if (is_error_noslot_pfn(pfn)) {
> >> +			ret = -EFAULT;
> >> +			goto out;
> >> +		}
> >> +
> >> +		maddr = page_address(pfn_to_page(pfn));
> >> +
> >> +		if (!write) {
> >> +			num_tags = mte_copy_tags_to_user(tags, maddr, num_tags);
> >> +			kvm_release_pfn_clean(pfn);
> > 
> > Do we need to check if PG_mte_tagged is set? If the page was not faulted
> > into the guest address space but the VMM has the page, does the
> > gfn_to_pfn_prot() guarantee that a kvm_set_spte_gfn() was called? If
> > not, this may read stale tags.
> 
> Ah, I hadn't thought about that... No I don't believe gfn_to_pfn_prot()
> will fault it into the guest.

It doesn't indeed. What it does is a get_user_pages() but it's not of
much help since the VMM pte wouldn't be tagged (we would have solved
lots of problems if we required PROT_MTE in the VMM...)

> >> +		} else {
> >> +			num_tags = mte_copy_tags_from_user(maddr, tags,
> >> +							   num_tags);
> >> +			kvm_release_pfn_dirty(pfn);
> >> +		}
> > 
> > Same question here, if the we can't guarantee the stage 2 pte being set,
> > we'd need to set PG_mte_tagged.
> 
> This is arguably worse as we'll be writing tags into the guest but
> without setting PG_mte_tagged - so they'll be lost when the guest then
> faults the pages in. Which sounds like it should break migration.
> 
> I think the below should be safe, and avoids the overhead of setting the
> flag just for reads.
> 
> Thanks,
> 
> Steve
> 
> ----8<----
> 		page = pfn_to_page(pfn);
> 		maddr = page_address(page);
> 
> 		if (!write) {
> 			if (test_bit(PG_mte_tagged, &page->flags))
> 				num_tags = mte_copy_tags_to_user(tags, maddr,
> 							MTE_GRANULES_PER_PAGE);
> 			else
> 				/* No tags in memory, so write zeros */
> 				num_tags = MTE_GRANULES_PER_PAGE -
> 					clear_user(tag, MTE_GRANULES_PER_PAGE);
> 			kvm_release_pfn_clean(pfn);

For ptrace we return a -EOPNOTSUPP if the address doesn't have VM_MTE
but I don't think it makes sense here, so I'm fine with clearing the
destination and assuming that the tags are zero (as they'd be on
faulting into the guest.

Another thing I forgot to ask, what's guaranteeing that the page
supports tags? Does this ioctl ensure that it would attempt the tag
copying from some device mapping? Do we need some kvm_is_device_pfn()
check? I guess ZONE_DEVICE memory we just refuse to map in an earlier
patch.

> 		} else {
> 			num_tags = mte_copy_tags_from_user(maddr, tags,
> 							MTE_GRANULES_PER_PAGE);
> 			kvm_release_pfn_dirty(pfn);
> 		}
> 
> 		if (num_tags != MTE_GRANULES_PER_PAGE) {
> 			ret = -EFAULT;
> 			goto out;
> 		}
> 
> 		if (write)
> 			test_and_set_bit(PG_mte_tagged, &page->flags);

I think a set_bit() would do, I doubt it's any more efficient. But why
not add it in the 'else' block above where we actually wrote the tags?
The copy function may have failed part-way through. Maybe your logic is
correct though, there are invalid tags in the page. Just add a comment.

-- 
Catalin
