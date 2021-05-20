Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E781138AD96
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242170AbhETMHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241940AbhETMHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:07:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07E1661059;
        Thu, 20 May 2021 12:05:58 +0000 (UTC)
Date:   Thu, 20 May 2021 13:05:56 +0100
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
Message-ID: <20210520120556.GC12251@arm.com>
References: <20210517123239.8025-1-steven.price@arm.com>
 <20210517123239.8025-8-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517123239.8025-8-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 01:32:38PM +0100, Steven Price wrote:
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 24223adae150..b3edde68bc3e 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -184,6 +184,17 @@ struct kvm_vcpu_events {
>  	__u32 reserved[12];
>  };
>  
> +struct kvm_arm_copy_mte_tags {
> +	__u64 guest_ipa;
> +	__u64 length;
> +	void __user *addr;
> +	__u64 flags;
> +	__u64 reserved[2];

I forgot the past discussions, what's the reserved for? Future
expansion?

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index e89a5e275e25..4b6c83beb75d 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1309,6 +1309,65 @@ static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
>  	}
>  }
>  
> +static int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
> +				      struct kvm_arm_copy_mte_tags *copy_tags)
> +{
> +	gpa_t guest_ipa = copy_tags->guest_ipa;
> +	size_t length = copy_tags->length;
> +	void __user *tags = copy_tags->addr;
> +	gpa_t gfn;
> +	bool write = !(copy_tags->flags & KVM_ARM_TAGS_FROM_GUEST);
> +	int ret = 0;
> +
> +	if (copy_tags->reserved[0] || copy_tags->reserved[1])
> +		return -EINVAL;
> +
> +	if (copy_tags->flags & ~KVM_ARM_TAGS_FROM_GUEST)
> +		return -EINVAL;
> +
> +	if (length & ~PAGE_MASK || guest_ipa & ~PAGE_MASK)
> +		return -EINVAL;
> +
> +	gfn = gpa_to_gfn(guest_ipa);
> +
> +	mutex_lock(&kvm->slots_lock);
> +
> +	while (length > 0) {
> +		kvm_pfn_t pfn = gfn_to_pfn_prot(kvm, gfn, write, NULL);
> +		void *maddr;
> +		unsigned long num_tags = PAGE_SIZE / MTE_GRANULE_SIZE;
> +
> +		if (is_error_noslot_pfn(pfn)) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +
> +		maddr = page_address(pfn_to_page(pfn));
> +
> +		if (!write) {
> +			num_tags = mte_copy_tags_to_user(tags, maddr, num_tags);
> +			kvm_release_pfn_clean(pfn);

Do we need to check if PG_mte_tagged is set? If the page was not faulted
into the guest address space but the VMM has the page, does the
gfn_to_pfn_prot() guarantee that a kvm_set_spte_gfn() was called? If
not, this may read stale tags.

> +		} else {
> +			num_tags = mte_copy_tags_from_user(maddr, tags,
> +							   num_tags);
> +			kvm_release_pfn_dirty(pfn);
> +		}

Same question here, if the we can't guarantee the stage 2 pte being set,
we'd need to set PG_mte_tagged.

> +
> +		if (num_tags != PAGE_SIZE / MTE_GRANULE_SIZE) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +
> +		gfn++;
> +		tags += num_tags;
> +		length -= PAGE_SIZE;
> +	}
> +
> +out:
> +	mutex_unlock(&kvm->slots_lock);
> +	return ret;
> +}
> +

-- 
Catalin
