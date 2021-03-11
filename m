Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE36337D26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 20:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCKTEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 14:04:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhCKTEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:04:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1E3264FA6;
        Thu, 11 Mar 2021 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615489454;
        bh=t8eueLxeeVg4vUyao0XhLG9F4jzDPqN36yFqpSverxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OvJoXsqdrc8zTKUVPMsikqYXQZq8/sJvgDAbuOq7MS7/EFZ2bERblckWLryUlVJWX
         LDymvo2Nl4XwuWGC0079jXKpBUkwoB9IIuO7jE7LfPspCA1vP91HyOHGYBJfHomAf9
         DqEIvX+/VHNQy9NxD17j+N9vHk0ERuFOsH5xHsZq90vSAevLrMr9QHe/74f2LJ3QZ2
         9nM93lY7Dmq4P9uaPmMAs5XbWpZw63bWeuDn9Nrzks9NuSQPUD/vHGGfEM3Ia+DG4R
         SnzreKH0C1euCQKKNYlcnYnIqqhfrg0EFRgG28Rpo88EHB++gbQg06lwgKaZbvfvlt
         hICLiyZQ2a+fA==
Date:   Thu, 11 Mar 2021 19:04:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 30/34] KVM: arm64: Add kvm_pgtable_stage2_find_range()
Message-ID: <20210311190406.GB31586@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-31-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310175751.3320106-31-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:57:47PM +0000, Quentin Perret wrote:
> Since the host stage 2 will be identity mapped, and since it will own
> most of memory, it would preferable for performance to try and use large
> block mappings whenever that is possible. To ease this, introduce a new
> helper in the KVM page-table code which allows to search for large
> ranges of available IPA space. This will be used in the host memory
> abort path to greedily idmap large portion of the PA space.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 30 ++++++++++
>  arch/arm64/kvm/hyp/pgtable.c         | 90 +++++++++++++++++++++++++++-
>  2 files changed, 117 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index b09af4612656..477bf10c48a9 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -94,6 +94,16 @@ enum kvm_pgtable_prot {
>  #define PAGE_HYP_RO		(KVM_PGTABLE_PROT_R)
>  #define PAGE_HYP_DEVICE		(PAGE_HYP | KVM_PGTABLE_PROT_DEVICE)
>  
> +/**
> + * struct kvm_mem_range - Range of Intermediate Physical Addresses
> + * @start:	Start of the range.
> + * @end:	End of the range.
> + */
> +struct kvm_mem_range {
> +	u64 start;
> +	u64 end;
> +};
> +
>  /**
>   * enum kvm_pgtable_walk_flags - Flags to control a depth-first page-table walk.
>   * @KVM_PGTABLE_WALK_LEAF:		Visit leaf entries, including invalid
> @@ -398,4 +408,24 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size);
>  int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
>  		     struct kvm_pgtable_walker *walker);
>  
> +/**
> + * kvm_pgtable_stage2_find_range() - Find a range of Intermediate Physical
> + *				     Addresses with compatible permission
> + *				     attributes.
> + * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init().
> + * @addr:	Address that must be covered by the range.
> + * @prot:	Protection attributes that the range must be compatible with.
> + * @range:	Range structure used to limit the search space at call time and
> + *		that will hold the result.
> + *
> + * The offset of @addr within a page is ignored. An existing mapping is defined
> + * as compatible with @prot if it is invalid and not owned by another entity, or
> + * if its permission attributes are strictly similar to @prot and it has no
> + * software bits set.

nit: I think the 'or' is ambigious here, as it makes it sound like an
invalid entry that _is_ owned by another entity is compatible if the
permissions attribute match. How about:

  | An IPA is compatible with prot iff its corresponding stage-2 page-table
  | entry has default ownership and, if valid, is mapped with protection
  | attributes identical to @prot.

> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int kvm_pgtable_stage2_find_range(struct kvm_pgtable *pgt, u64 addr,
> +				  enum kvm_pgtable_prot prot,
> +				  struct kvm_mem_range *range);
>  #endif	/* __ARM64_KVM_PGTABLE_H__ */
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index c16e0306dd9a..f20287bb3e41 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -48,6 +48,8 @@
>  					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
>  					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
>  
> +#define KVM_PTE_LEAF_ATTR_S2_RES	GENMASK(58, 55)

Please make this IGN instead of RES, to match the architecture (and because
RES is usually used in the context of RES0 or RES1).

>  #define KVM_INVALID_PTE_OWNER_MASK	GENMASK(63, 32)
>  
>  struct kvm_pgtable_walk_data {
> @@ -69,10 +71,8 @@ static u64 kvm_granule_size(u32 level)
>  	return BIT(kvm_granule_shift(level));
>  }
>  
> -static bool kvm_block_mapping_supported(u64 addr, u64 end, u64 phys, u32 level)
> +static bool kvm_level_support_block_mappings(u32 level)
>  {
> -	u64 granule = kvm_granule_size(level);
> -
>  	/*
>  	 * Reject invalid block mappings and don't bother with 4TB mappings for
>  	 * 52-bit PAs.
> @@ -80,6 +80,16 @@ static bool kvm_block_mapping_supported(u64 addr, u64 end, u64 phys, u32 level)
>  	if (level == 0 || (PAGE_SIZE != SZ_4K && level == 1))
>  		return false;
>  
> +	return true;

return !(level == 0 || (PAGE_SIZE != SZ_4K && level == 1));

> +static bool kvm_block_mapping_supported(u64 addr, u64 end, u64 phys, u32 level)
> +{
> +	u64 granule = kvm_granule_size(level);
> +
> +	if (!kvm_level_support_block_mappings(level))
> +		return false;
> +
>  	if (granule > (end - addr))
>  		return false;
>  
> @@ -1042,3 +1052,77 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
>  	pgt->mm_ops->free_pages_exact(pgt->pgd, pgd_sz);
>  	pgt->pgd = NULL;
>  }
> +
> +#define KVM_PTE_LEAF_S2_COMPAT_MASK	(KVM_PTE_LEAF_ATTR_S2_PERMS | \
> +					 KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR | \
> +					 KVM_PTE_LEAF_ATTR_S2_RES)
> +
> +static int stage2_check_permission_walker(u64 addr, u64 end, u32 level,
> +					  kvm_pte_t *ptep,
> +					  enum kvm_pgtable_walk_flags flag,
> +					  void * const arg)
> +{
> +	kvm_pte_t old_attr, pte = *ptep, *new_attr = arg;
> +
> +	/*
> +	 * Compatible mappings are either invalid and owned by the page-table
> +	 * owner (whose id is 0), or valid with matching permission attributes.
> +	 */
> +	if (kvm_pte_valid(pte)) {
> +		old_attr = pte & KVM_PTE_LEAF_S2_COMPAT_MASK;
> +		if (old_attr != *new_attr)
> +			return -EEXIST;
> +	} else if (pte) {
> +		return -EEXIST;
> +	}
> +
> +	return 0;
> +}
> +
> +int kvm_pgtable_stage2_find_range(struct kvm_pgtable *pgt, u64 addr,
> +				  enum kvm_pgtable_prot prot,
> +				  struct kvm_mem_range *range)
> +{
> +	kvm_pte_t attr;
> +	struct kvm_pgtable_walker check_perm_walker = {
> +		.cb		= stage2_check_permission_walker,
> +		.flags		= KVM_PGTABLE_WALK_LEAF,
> +		.arg		= &attr,
> +	};
> +	u64 granule, start, end;
> +	u32 level;
> +	int ret;
> +
> +	ret = stage2_set_prot_attr(prot, &attr);
> +	if (ret)
> +		return ret;
> +	attr &= KVM_PTE_LEAF_S2_COMPAT_MASK;
> +
> +	for (level = pgt->start_level; level < KVM_PGTABLE_MAX_LEVELS; level++) {
> +		granule = kvm_granule_size(level);
> +		start = ALIGN_DOWN(addr, granule);
> +		end = start + granule;
> +
> +		if (!kvm_level_support_block_mappings(level))
> +			continue;
> +
> +		if (start < range->start || range->end < end)
> +			continue;
> +
> +		/*
> +		 * Check the presence of existing mappings with incompatible
> +		 * permissions within the current block range, and try one level
> +		 * deeper if one is found.
> +		 */
> +		ret = kvm_pgtable_walk(pgt, start, granule, &check_perm_walker);
> +		if (ret != -EEXIST)
> +			break;
> +	}

Can you write this as a:

	do {
		...
	} while (level < KVM_PGTABLE_MAX_LEVELS && ret == -EEXIST);

loop?

Will
