Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487BD32EDA4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCEPD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhCEPDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:03:41 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88195C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 07:03:40 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n22so1726909wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 07:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GpKc+xvCgCJSH13ZTIZLN2AMkxZK13gtHVewqGBpJ68=;
        b=cDP6bYf/Jne/eaTwyPukya/ajVOlbRSFeM9DU5NkgFY1C1PufCEwfcmjD4flOs6vvQ
         cEXq4jeuNQ9SwRjtFAmF8obyb3gMoMTaAKh6efRRsmNNQfTCbE0OIEg4yl2PRe4BWq94
         68tqXY756a6i6ineeXI+cO6KLABD1tkD0X33Vn11m9z8aKu5ToC3QPn/6v2buKjvnS6Y
         TbTrKWqjFHE8tW0/nt9TvX4zEF4yv1Jozi0/1i3+ZyguoIMJDww8jaK5s5drDILD7BsK
         sswTxLXiNvjLhxpVc+b4VWnNKKD8uVRNUiIilKtA6LZSyPmdQcH/Rw/MF9mj2rDNkhOE
         7miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GpKc+xvCgCJSH13ZTIZLN2AMkxZK13gtHVewqGBpJ68=;
        b=eYcBexaTFUn3tfoWvKEx0iflctu00wN4xSKeiKLmcahdrlcXWIohd29r59CJa0xBkC
         yiYtUfoW/s0iFCv1y1yfIcEKBAr3iNrVgk/fX1LAJK+I4ogVCYd4TkxTQiDGZnuKigGW
         GhfnvMKmSChwK5wHWJU6jlnx1vC9MvD1h5o4TFlG7txN0kNsigICdzF7vgmux/N+hlic
         lznrT6b/WnbcMrCvbc2DsLsNv5qm+cMkM5+mflJB7bE/gpR0A3ivI1fkvHCXZyUVeDcn
         0t0MZPbg18ZR3aSXhFuTtMmpv34AyWr45+ERO3zpXkFWZYlNVKkzpZOWnzQbN6HxF+hh
         6IMQ==
X-Gm-Message-State: AOAM5327ThvG5WFbvmfvp9/TNoXviu7+IvWnyY4in+mjBbt0xrLZwJIw
        ZKOb8yiYX+fFnO5qOrmptFyTPg==
X-Google-Smtp-Source: ABdhPJyIVygS7OGfQ/tnLuo3JNzZV/t4cpIfs6xJ3+AzFEa7C1ZYEN/vjbSjEeIhwx5P2PjxYvt8TA==
X-Received: by 2002:a7b:c151:: with SMTP id z17mr9405485wmi.189.1614956619109;
        Fri, 05 Mar 2021 07:03:39 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id v9sm4931146wrn.86.2021.03.05.07.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 07:03:38 -0800 (PST)
Date:   Fri, 5 Mar 2021 15:03:36 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 28/32] KVM: arm64: Add
 kvm_pgtable_stage2_idmap_greedy()
Message-ID: <YEJISCQOHNbs363+@google.com>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-29-qperret@google.com>
 <20210305143941.GA23017@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305143941.GA23017@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 Mar 2021 at 14:39:42 (+0000), Will Deacon wrote:
> On Tue, Mar 02, 2021 at 02:59:58PM +0000, Quentin Perret wrote:
> > +/**
> > + * kvm_pgtable_stage2_idmap_greedy() - Identity-map an Intermediate Physical
> > + *				       Address with a leaf entry at the highest
> > + *				       possible level.
> 
> Not sure it's worth mentioning "highest possible level" here, as
> realistically the caller still has to provide a memcache to deal with the
> worst case and the structure of the page-table shouldn't matter.

Right, we need to pass a range so I suppose that should be enough to
say 'this tries to cover large portions of memory'.

> > + * @pgt:	Page-table structure initialised by kvm_pgtable_*_init().
> > + * @addr:	Input address to identity-map.
> > + * @prot:	Permissions and attributes for the mapping.
> > + * @range:	Boundaries of the maximum memory region to map.
> > + * @mc:		Cache of pre-allocated memory from which to allocate page-table
> > + *		pages.
> > + *
> > + * This function attempts to install high-level identity-mappings covering @addr
> 
> "high-level"? (again, I think I'd just drop this)
> 
> > + * without overriding existing mappings with incompatible permissions or
> > + * attributes. An existing table entry may be coalesced into a block mapping
> > + * if and only if it covers @addr and all its leafs are either invalid and/or
> 
> s/leafs/leaf entries/

Ack for both.

> > + * have permissions and attributes strictly matching @prot. The mapping is
> > + * guaranteed to be contained within the boundaries specified by @range at call
> > + * time. If only a subset of the memory specified by @range is mapped (because
> > + * of e.g. alignment issues or existing incompatible mappings), @range will be
> > + * updated accordingly.
> > + *
> > + * Return: 0 on success, negative error code on failure.
> > + */
> > +int kvm_pgtable_stage2_idmap_greedy(struct kvm_pgtable *pgt, u64 addr,
> > +				    enum kvm_pgtable_prot prot,
> > +				    struct kvm_mem_range *range,
> > +				    void *mc);
> >  #endif	/* __ARM64_KVM_PGTABLE_H__ */
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index 8aa01a9e2603..6897d771e2b2 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -987,3 +987,122 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
> >  	pgt->mm_ops->free_pages_exact(pgt->pgd, pgd_sz);
> >  	pgt->pgd = NULL;
> >  }
> > +
> > +struct stage2_reduce_range_data {
> > +	kvm_pte_t attr;
> > +	u64 target_addr;
> > +	u32 start_level;
> > +	struct kvm_mem_range *range;
> > +};
> > +
> > +static int __stage2_reduce_range(struct stage2_reduce_range_data *data, u64 addr)
> > +{
> > +	u32 level = data->start_level;
> > +
> > +	for (; level < KVM_PGTABLE_MAX_LEVELS; level++) {
> > +		u64 granule = kvm_granule_size(level);
> > +		u64 start = ALIGN_DOWN(data->target_addr, granule);
> > +		u64 end = start + granule;
> > +
> > +		/*
> > +		 * The pinned address is in the current range, try one level
> > +		 * deeper.
> > +		 */
> > +		if (start == ALIGN_DOWN(addr, granule))
> > +			continue;
> > +
> > +		/*
> > +		 * Make sure the current range is a reduction of the existing
> > +		 * range before updating it.
> > +		 */
> > +		if (data->range->start <= start && end <= data->range->end) {
> > +			data->start_level = level;
> > +			data->range->start = start;
> > +			data->range->end = end;
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +#define KVM_PTE_LEAF_S2_COMPAT_MASK	(KVM_PTE_LEAF_ATTR_S2_PERMS | \
> > +					 KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR | \
> > +					 KVM_PTE_LEAF_SW_BIT_PROT_NONE)
> > +
> > +static int stage2_reduce_range_walker(u64 addr, u64 end, u32 level,
> > +				      kvm_pte_t *ptep,
> > +				      enum kvm_pgtable_walk_flags flag,
> > +				      void * const arg)
> > +{
> > +	struct stage2_reduce_range_data *data = arg;
> > +	kvm_pte_t attr;
> > +	int ret;
> > +
> > +	if (addr < data->range->start || addr >= data->range->end)
> > +		return 0;
> > +
> > +	attr = *ptep & KVM_PTE_LEAF_S2_COMPAT_MASK;
> > +	if (!attr || attr == data->attr)
> > +		return 0;
> > +
> > +	/*
> > +	 * An existing mapping with incompatible protection attributes is
> > +	 * 'pinned', so reduce the range if we hit one.
> > +	 */
> > +	ret = __stage2_reduce_range(data, addr);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return -EAGAIN;
> > +}
> > +
> > +static int stage2_reduce_range(struct kvm_pgtable *pgt, u64 addr,
> > +			       enum kvm_pgtable_prot prot,
> > +			       struct kvm_mem_range *range)
> > +{
> > +	struct stage2_reduce_range_data data = {
> > +		.start_level	= pgt->start_level,
> > +		.range		= range,
> > +		.target_addr	= addr,
> > +	};
> > +	struct kvm_pgtable_walker walker = {
> > +		.cb		= stage2_reduce_range_walker,
> > +		.flags		= KVM_PGTABLE_WALK_LEAF,
> > +		.arg		= &data,
> > +	};
> > +	int ret;
> > +
> > +	data.attr = stage2_get_prot_attr(prot) & KVM_PTE_LEAF_S2_COMPAT_MASK;
> > +	if (!data.attr)
> > +		return -EINVAL;
> 
> (this will need updating based on the other discussion we had)

Ack.

> > +	/* Reduce the kvm_mem_range to a granule size */
> > +	ret = __stage2_reduce_range(&data, range->end);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Walk the range to check permissions and reduce further if needed */
> > +	do {
> > +		ret = kvm_pgtable_walk(pgt, range->start, range->end, &walker);
> 
> (we spent some time debugging an issue here and you spotted that you're
> passing range->end instead of the size ;)

Yep, I have the fix applied locally, and ready to fly in v4 :)

> > +	} while (ret == -EAGAIN);
> 
> I'm a bit nervous about this loop -- what guarantees forward progress here?
> Can we return to the host after a few tries instead?

-EAGAIN only happens when we've been able to successfully reduce the
range to a potentially valid granule size. That can't happen infinitely.

We're guaranteed to fail when trying to reduce the range to a
granularity smaller than PAGE_SIZE (the -EINVAL case of
__stage2_reduce_range), which is indicative of a host memory abort in a
page it should not access (because marked PROT_NONE for instance).

Cheers,
Quentin
