Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9F032D6B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhCDPbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:31:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232171AbhCDPbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:31:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F057A64F21;
        Thu,  4 Mar 2021 15:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614871842;
        bh=zcvP/xRNovmcUNqEXMV6SKPJwphc6KAygaqAb/6nSsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LADuN40EQStLkH6O6LUzMIxhc/aLZYRwZKhO9mkajUqlnhNqVCpweEwDTWfe/rlFO
         1uQCI+qt3ZZN1DOkNmnQe1WEpAOpg+1xC++v9qwF9uND09qh5dh9soS9HnTO9ml74b
         b19FJ4Ma/0z5HrqtqOZrTUhKPKI4qgfRfgkAnyix0VgknVwyKyMu04vrSE44IXyPCg
         BmPKyobfvS7+/1bL+Ue+5VOJAyrGb4U1Im9vvRkmZkXTxt6xqmXsmb9bncj+iQeQnP
         WgKxC+ZQ7pQPsKNNYzx7rkiyzoluF2q4M3OwXSoy8LrssD3fUB8E4IrcEcf4ZCzi3V
         zhLZ8/pyh3I3A==
Date:   Thu, 4 Mar 2021 15:30:36 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 12/32] KVM: arm64: Introduce a Hyp buddy page allocator
Message-ID: <20210304153036.GA21507@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-13-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-13-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:59:42PM +0000, Quentin Perret wrote:
> When memory protection is enabled, the hyp code will require a basic
> form of memory management in order to allocate and free memory pages at
> EL2. This is needed for various use-cases, including the creation of hyp
> mappings or the allocation of stage 2 page tables.
> 
> To address these use-case, introduce a simple memory allocator in the
> hyp code. The allocator is designed as a conventional 'buddy allocator',
> working with a page granularity. It allows to allocate and free
> physically contiguous pages from memory 'pools', with a guaranteed order
> alignment in the PA space. Each page in a memory pool is associated
> with a struct hyp_page which holds the page's metadata, including its
> refcount, as well as its current order, hence mimicking the kernel's
> buddy system in the GFP infrastructure. The hyp_page metadata are made
> accessible through a hyp_vmemmap, following the concept of
> SPARSE_VMEMMAP in the kernel.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/gfp.h    |  55 +++++++
>  arch/arm64/kvm/hyp/include/nvhe/memory.h |  28 ++++
>  arch/arm64/kvm/hyp/nvhe/Makefile         |   2 +-
>  arch/arm64/kvm/hyp/nvhe/page_alloc.c     | 195 +++++++++++++++++++++++
>  4 files changed, 279 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kvm/hyp/include/nvhe/gfp.h
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/page_alloc.c

[...]

> +static void __hyp_attach_page(struct hyp_pool *pool,
> +			      struct hyp_page *p)
> +{
> +	unsigned int order = p->order;
> +	struct hyp_page *buddy;
> +
> +	memset(hyp_page_to_virt(p), 0, PAGE_SIZE << p->order);
> +
> +	/*
> +	 * Only the first struct hyp_page of a high-order page (otherwise known
> +	 * as the 'head') should have p->order set. The non-head pages should
> +	 * have p->order = HYP_NO_ORDER. Here @p may no longer be the head
> +	 * after coallescing, so make sure to mark it HYP_NO_ORDER proactively.
> +	 */
> +	p->order = HYP_NO_ORDER;
> +	for (; (order + 1) < pool->max_order; order++) {
> +		buddy = __find_buddy_avail(pool, p, order);
> +		if (!buddy)
> +			break;
> +
> +		/* Take the buddy out of its list, and coallesce with @p */
> +		list_del_init(&buddy->node);
> +		buddy->order = HYP_NO_ORDER;
> +		p = (p < buddy) ? p : buddy;

nit: this is min()

> +	}
> +
> +	/* Mark the new head, and insert it */
> +	p->order = order;
> +	list_add_tail(&p->node, &pool->free_area[order]);
> +}
> +
> +static void hyp_attach_page(struct hyp_page *p)
> +{
> +	struct hyp_pool *pool = hyp_page_to_pool(p);
> +
> +	hyp_spin_lock(&pool->lock);
> +	__hyp_attach_page(pool, p);
> +	hyp_spin_unlock(&pool->lock);
> +}
> +
> +static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
> +					   struct hyp_page *p,
> +					   unsigned int order)
> +{
> +	struct hyp_page *buddy;
> +
> +	list_del_init(&p->node);
> +	while (p->order > order) {
> +		/*
> +		 * The buddy of order n - 1 currently has HYP_NO_ORDER as it
> +		 * is covered by a higher-level page (whose head is @p). Use
> +		 * __find_buddy_nocheck() to find it and inject it in the
> +		 * free_list[n - 1], effectively splitting @p in half.
> +		 */
> +		p->order--;
> +		buddy = __find_buddy_nocheck(pool, p, p->order);
> +		buddy->order = p->order;
> +		list_add_tail(&buddy->node, &pool->free_area[buddy->order]);
> +	}
> +
> +	return p;
> +}
> +
> +void hyp_put_page(void *addr)
> +{
> +	struct hyp_page *p = hyp_virt_to_page(addr);
> +
> +	if (hyp_page_ref_dec_and_test(p))
> +		hyp_attach_page(p);
> +}
> +
> +void hyp_get_page(void *addr)
> +{
> +	struct hyp_page *p = hyp_virt_to_page(addr);
> +
> +	hyp_page_ref_inc(p);
> +}
> +
> +void *hyp_alloc_pages(struct hyp_pool *pool, unsigned int order)
> +{
> +	unsigned int i = order;
> +	struct hyp_page *p;
> +
> +	hyp_spin_lock(&pool->lock);
> +
> +	/* Look for a high-enough-order page */
> +	while (i < pool->max_order && list_empty(&pool->free_area[i]))
> +		i++;
> +	if (i >= pool->max_order) {
> +		hyp_spin_unlock(&pool->lock);
> +		return NULL;
> +	}
> +
> +	/* Extract it from the tree at the right order */
> +	p = list_first_entry(&pool->free_area[i], struct hyp_page, node);
> +	p = __hyp_extract_page(pool, p, order);
> +
> +	hyp_spin_unlock(&pool->lock);
> +	hyp_page_ref_inc(p);

I find this a little scary, as we momentarily drop the lock. It think
it's ok because the reference count on the page must be 0 at this point,
but actually then I think it would be clearer to have a
hyp_page_ref_init() function which could take the lock, check that the
refcount is indeed 0 and then set it to 1.

What do you think?

Will
