Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B702425A85
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbhJGSTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243515AbhJGSTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:19:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95732C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 11:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6Jv2xmzifsa36oHOMgZyMER+nTIuNbeQjNfVYxzzvDc=; b=cVl5fkjNUSxaShByCUmYUABwBx
        T7jRESNjc81rm4VNE+vYkF5qmRDADbgf52husr6jUEw+LmvwzD8zNOw67rVpDIIjZVhtok2THzr5U
        2HxvbmXNgFpZE4tvav6OMeBxwohvnZRqGTqzBqSt6JTZ5oDR+yDOw7V650zaHMZGg+9y1rBnigUlc
        e0VckIO/wW8XMARUzwS5s7DkM/Cia8l9bcXHjZ+xcNUWJgoU3vXl0U+VSc3EkZEWJGFmTL+o2atIp
        UeiQ9+wD6LcfI0us07SeYMEOhcsq4aHAl5ix23QW3rANomA1sFu5ub8V077/VYHsL1JtHwN+i3boR
        F7bfJiVw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYXwM-0028BO-Cm; Thu, 07 Oct 2021 18:16:33 +0000
Date:   Thu, 7 Oct 2021 19:16:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] iommu: Use put_pages_list
Message-ID: <YV85dvlyj5LBdsro@casper.infradead.org>
References: <20210930162043.3111119-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930162043.3111119-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On Thu, Sep 30, 2021 at 05:20:42PM +0100, Matthew Wilcox (Oracle) wrote:
> page->freelist is for the use of slab.  We already have the ability
> to free a list of pages in the core mm, but it requires the use of a
> list_head and for the pages to be chained together through page->lru.
> Switch the iommu code over to using free_pages_list().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  drivers/iommu/amd/io_pgtable.c | 99 +++++++++++++++-------------------
>  drivers/iommu/dma-iommu.c      | 11 +---
>  drivers/iommu/intel/iommu.c    | 89 +++++++++++-------------------
>  include/linux/iommu.h          |  3 +-
>  4 files changed, 77 insertions(+), 125 deletions(-)
> 
> diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
> index 182c93a43efd..8dfa6ee58b76 100644
> --- a/drivers/iommu/amd/io_pgtable.c
> +++ b/drivers/iommu/amd/io_pgtable.c
> @@ -74,49 +74,37 @@ static u64 *first_pte_l7(u64 *pte, unsigned long *page_size,
>   *
>   ****************************************************************************/
>  
> -static void free_page_list(struct page *freelist)
> -{
> -	while (freelist != NULL) {
> -		unsigned long p = (unsigned long)page_address(freelist);
> -
> -		freelist = freelist->freelist;
> -		free_page(p);
> -	}
> -}
> -
> -static struct page *free_pt_page(unsigned long pt, struct page *freelist)
> +static void free_pt_page(unsigned long pt, struct list_head *list)
>  {
>  	struct page *p = virt_to_page((void *)pt);
>  
> -	p->freelist = freelist;
> -
> -	return p;
> +	list_add_tail(&p->lru, list);
>  }
>  
>  #define DEFINE_FREE_PT_FN(LVL, FN)						\
> -static struct page *free_pt_##LVL (unsigned long __pt, struct page *freelist)	\
> -{										\
> -	unsigned long p;							\
> -	u64 *pt;								\
> -	int i;									\
> -										\
> -	pt = (u64 *)__pt;							\
> -										\
> -	for (i = 0; i < 512; ++i) {						\
> -		/* PTE present? */						\
> -		if (!IOMMU_PTE_PRESENT(pt[i]))					\
> -			continue;						\
> -										\
> -		/* Large PTE? */						\
> -		if (PM_PTE_LEVEL(pt[i]) == 0 ||					\
> -		    PM_PTE_LEVEL(pt[i]) == 7)					\
> -			continue;						\
> -										\
> -		p = (unsigned long)IOMMU_PTE_PAGE(pt[i]);			\
> -		freelist = FN(p, freelist);					\
> -	}									\
> -										\
> -	return free_pt_page((unsigned long)pt, freelist);			\
> +static void free_pt_##LVL (unsigned long __pt, struct list_head *list)	\
> +{									\
> +	unsigned long p;						\
> +	u64 *pt;							\
> +	int i;								\
> +									\
> +	pt = (u64 *)__pt;						\
> +									\
> +	for (i = 0; i < 512; ++i) {					\
> +		/* PTE present? */					\
> +		if (!IOMMU_PTE_PRESENT(pt[i]))				\
> +			continue;					\
> +									\
> +		/* Large PTE? */					\
> +		if (PM_PTE_LEVEL(pt[i]) == 0 ||				\
> +		    PM_PTE_LEVEL(pt[i]) == 7)				\
> +			continue;					\
> +									\
> +		p = (unsigned long)IOMMU_PTE_PAGE(pt[i]);		\
> +		FN(p, list);						\
> +	}								\
> +									\
> +	free_pt_page((unsigned long)pt, list);				\
>  }
>  
>  DEFINE_FREE_PT_FN(l2, free_pt_page)
> @@ -125,36 +113,33 @@ DEFINE_FREE_PT_FN(l4, free_pt_l3)
>  DEFINE_FREE_PT_FN(l5, free_pt_l4)
>  DEFINE_FREE_PT_FN(l6, free_pt_l5)
>  
> -static struct page *free_sub_pt(unsigned long root, int mode,
> -				struct page *freelist)
> +static void free_sub_pt(unsigned long root, int mode, struct list_head *list)
>  {
>  	switch (mode) {
>  	case PAGE_MODE_NONE:
>  	case PAGE_MODE_7_LEVEL:
>  		break;
>  	case PAGE_MODE_1_LEVEL:
> -		freelist = free_pt_page(root, freelist);
> +		free_pt_page(root, list);
>  		break;
>  	case PAGE_MODE_2_LEVEL:
> -		freelist = free_pt_l2(root, freelist);
> +		free_pt_l2(root, list);
>  		break;
>  	case PAGE_MODE_3_LEVEL:
> -		freelist = free_pt_l3(root, freelist);
> +		free_pt_l3(root, list);
>  		break;
>  	case PAGE_MODE_4_LEVEL:
> -		freelist = free_pt_l4(root, freelist);
> +		free_pt_l4(root, list);
>  		break;
>  	case PAGE_MODE_5_LEVEL:
> -		freelist = free_pt_l5(root, freelist);
> +		free_pt_l5(root, list);
>  		break;
>  	case PAGE_MODE_6_LEVEL:
> -		freelist = free_pt_l6(root, freelist);
> +		free_pt_l6(root, list);
>  		break;
>  	default:
>  		BUG();
>  	}
> -
> -	return freelist;
>  }
>  
>  void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
> @@ -362,7 +347,7 @@ static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
>  	return pte;
>  }
>  
> -static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
> +static void free_clear_pte(u64 *pte, u64 pteval, struct list_head *list)
>  {
>  	unsigned long pt;
>  	int mode;
> @@ -373,12 +358,12 @@ static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
>  	}
>  
>  	if (!IOMMU_PTE_PRESENT(pteval))
> -		return freelist;
> +		return;
>  
>  	pt   = (unsigned long)IOMMU_PTE_PAGE(pteval);
>  	mode = IOMMU_PTE_MODE(pteval);
>  
> -	return free_sub_pt(pt, mode, freelist);
> +	free_sub_pt(pt, mode, list);
>  }
>  
>  /*
> @@ -392,7 +377,7 @@ static int iommu_v1_map_page(struct io_pgtable_ops *ops, unsigned long iova,
>  			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
>  {
>  	struct protection_domain *dom = io_pgtable_ops_to_domain(ops);
> -	struct page *freelist = NULL;
> +	LIST_HEAD(freelist);
>  	bool updated = false;
>  	u64 __pte, *pte;
>  	int ret, i, count;
> @@ -412,9 +397,9 @@ static int iommu_v1_map_page(struct io_pgtable_ops *ops, unsigned long iova,
>  		goto out;
>  
>  	for (i = 0; i < count; ++i)
> -		freelist = free_clear_pte(&pte[i], pte[i], freelist);
> +		free_clear_pte(&pte[i], pte[i], &freelist);
>  
> -	if (freelist != NULL)
> +	if (!list_empty(&freelist))
>  		updated = true;
>  
>  	if (count > 1) {
> @@ -449,7 +434,7 @@ static int iommu_v1_map_page(struct io_pgtable_ops *ops, unsigned long iova,
>  	}
>  
>  	/* Everything flushed out, free pages now */
> -	free_page_list(freelist);
> +	put_pages_list(&freelist);
>  
>  	return ret;
>  }
> @@ -511,7 +496,7 @@ static void v1_free_pgtable(struct io_pgtable *iop)
>  {
>  	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, iop);
>  	struct protection_domain *dom;
> -	struct page *freelist = NULL;
> +	LIST_HEAD(freelist);
>  	unsigned long root;
>  
>  	if (pgtable->mode == PAGE_MODE_NONE)
> @@ -530,9 +515,9 @@ static void v1_free_pgtable(struct io_pgtable *iop)
>  	       pgtable->mode > PAGE_MODE_6_LEVEL);
>  
>  	root = (unsigned long)pgtable->root;
> -	freelist = free_sub_pt(root, pgtable->mode, freelist);
> +	free_sub_pt(root, pgtable->mode, &freelist);
>  
> -	free_page_list(freelist);
> +	put_pages_list(&freelist);
>  }
>  
>  static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 896bea04c347..16742d9d8a1a 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -66,14 +66,7 @@ early_param("iommu.forcedac", iommu_dma_forcedac_setup);
>  
>  static void iommu_dma_entry_dtor(unsigned long data)
>  {
> -	struct page *freelist = (struct page *)data;
> -
> -	while (freelist) {
> -		unsigned long p = (unsigned long)page_address(freelist);
> -
> -		freelist = freelist->freelist;
> -		free_page(p);
> -	}
> +	put_pages_list((struct list_head *)data);
>  }
>  
>  static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
> @@ -481,7 +474,7 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
>  	else if (gather && gather->queued)
>  		queue_iova(iovad, iova_pfn(iovad, iova),
>  				size >> iova_shift(iovad),
> -				(unsigned long)gather->freelist);
> +				(unsigned long)&gather->freelist);
>  	else
>  		free_iova_fast(iovad, iova_pfn(iovad, iova),
>  				size >> iova_shift(iovad));
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d75f59ae28e6..eaaff646e1b4 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1186,35 +1186,30 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
>     know the hardware page-walk will no longer touch them.
>     The 'pte' argument is the *parent* PTE, pointing to the page that is to
>     be freed. */
> -static struct page *dma_pte_list_pagetables(struct dmar_domain *domain,
> -					    int level, struct dma_pte *pte,
> -					    struct page *freelist)
> +static void dma_pte_list_pagetables(struct dmar_domain *domain,
> +				    int level, struct dma_pte *pte,
> +				    struct list_head *list)
>  {
>  	struct page *pg;
>  
>  	pg = pfn_to_page(dma_pte_addr(pte) >> PAGE_SHIFT);
> -	pg->freelist = freelist;
> -	freelist = pg;
> +	list_add_tail(&pg->lru, list);
>  
>  	if (level == 1)
> -		return freelist;
> +		return;
>  
>  	pte = page_address(pg);
>  	do {
>  		if (dma_pte_present(pte) && !dma_pte_superpage(pte))
> -			freelist = dma_pte_list_pagetables(domain, level - 1,
> -							   pte, freelist);
> +			dma_pte_list_pagetables(domain, level - 1, pte, list);
>  		pte++;
>  	} while (!first_pte_in_page(pte));
> -
> -	return freelist;
>  }
>  
> -static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
> -					struct dma_pte *pte, unsigned long pfn,
> -					unsigned long start_pfn,
> -					unsigned long last_pfn,
> -					struct page *freelist)
> +static void dma_pte_clear_level(struct dmar_domain *domain, int level,
> +				struct dma_pte *pte, unsigned long pfn,
> +				unsigned long start_pfn, unsigned long last_pfn,
> +				struct list_head *list)
>  {
>  	struct dma_pte *first_pte = NULL, *last_pte = NULL;
>  
> @@ -1235,7 +1230,7 @@ static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
>  			/* These suborbinate page tables are going away entirely. Don't
>  			   bother to clear them; we're just going to *free* them. */
>  			if (level > 1 && !dma_pte_superpage(pte))
> -				freelist = dma_pte_list_pagetables(domain, level - 1, pte, freelist);
> +				dma_pte_list_pagetables(domain, level - 1, pte, list);
>  
>  			dma_clear_pte(pte);
>  			if (!first_pte)
> @@ -1243,10 +1238,10 @@ static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
>  			last_pte = pte;
>  		} else if (level > 1) {
>  			/* Recurse down into a level that isn't *entirely* obsolete */
> -			freelist = dma_pte_clear_level(domain, level - 1,
> -						       phys_to_virt(dma_pte_addr(pte)),
> -						       level_pfn, start_pfn, last_pfn,
> -						       freelist);
> +			dma_pte_clear_level(domain, level - 1,
> +					    phys_to_virt(dma_pte_addr(pte)),
> +					    level_pfn, start_pfn, last_pfn,
> +					    list);
>  		}
>  next:
>  		pfn += level_size(level);
> @@ -1255,47 +1250,28 @@ static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
>  	if (first_pte)
>  		domain_flush_cache(domain, first_pte,
>  				   (void *)++last_pte - (void *)first_pte);
> -
> -	return freelist;
>  }
>  
>  /* We can't just free the pages because the IOMMU may still be walking
>     the page tables, and may have cached the intermediate levels. The
>     pages can only be freed after the IOTLB flush has been done. */
> -static struct page *domain_unmap(struct dmar_domain *domain,
> -				 unsigned long start_pfn,
> -				 unsigned long last_pfn,
> -				 struct page *freelist)
> +static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
> +			 unsigned long last_pfn, struct list_head *list)
>  {
>  	BUG_ON(!domain_pfn_supported(domain, start_pfn));
>  	BUG_ON(!domain_pfn_supported(domain, last_pfn));
>  	BUG_ON(start_pfn > last_pfn);
>  
>  	/* we don't need lock here; nobody else touches the iova range */
> -	freelist = dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
> -				       domain->pgd, 0, start_pfn, last_pfn,
> -				       freelist);
> +	dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
> +			    domain->pgd, 0, start_pfn, last_pfn, list);
>  
>  	/* free pgd */
>  	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
>  		struct page *pgd_page = virt_to_page(domain->pgd);
> -		pgd_page->freelist = freelist;
> -		freelist = pgd_page;
> -
> +		list_add_tail(&pgd_page->lru, list);
>  		domain->pgd = NULL;
>  	}
> -
> -	return freelist;
> -}
> -
> -static void dma_free_pagelist(struct page *freelist)
> -{
> -	struct page *pg;
> -
> -	while ((pg = freelist)) {
> -		freelist = pg->freelist;
> -		free_pgtable_page(page_address(pg));
> -	}
>  }
>  
>  /* iommu handling */
> @@ -1972,11 +1948,10 @@ static void domain_exit(struct dmar_domain *domain)
>  	domain_remove_dev_info(domain);
>  
>  	if (domain->pgd) {
> -		struct page *freelist;
> +		LIST_HEAD(pages);
>  
> -		freelist = domain_unmap(domain, 0,
> -					DOMAIN_MAX_PFN(domain->gaw), NULL);
> -		dma_free_pagelist(freelist);
> +		domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw), &pages);
> +		put_pages_list(&pages);
>  	}
>  
>  	free_domain_mem(domain);
> @@ -4068,19 +4043,17 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
>  		{
>  			struct dmar_drhd_unit *drhd;
>  			struct intel_iommu *iommu;
> -			struct page *freelist;
> +			LIST_HEAD(pages);
>  
> -			freelist = domain_unmap(si_domain,
> -						start_vpfn, last_vpfn,
> -						NULL);
> +			domain_unmap(si_domain, start_vpfn, last_vpfn, &pages);
>  
>  			rcu_read_lock();
>  			for_each_active_iommu(iommu, drhd)
>  				iommu_flush_iotlb_psi(iommu, si_domain,
>  					start_vpfn, mhp->nr_pages,
> -					!freelist, 0);
> +					list_empty(&pages), 0);
>  			rcu_read_unlock();
> -			dma_free_pagelist(freelist);
> +			put_pages_list(&pages);
>  		}
>  		break;
>  	}
> @@ -5087,8 +5060,7 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
>  	start_pfn = iova >> VTD_PAGE_SHIFT;
>  	last_pfn = (iova + size - 1) >> VTD_PAGE_SHIFT;
>  
> -	gather->freelist = domain_unmap(dmar_domain, start_pfn,
> -					last_pfn, gather->freelist);
> +	domain_unmap(dmar_domain, start_pfn, last_pfn, &gather->freelist);
>  
>  	if (dmar_domain->max_addr == iova + size)
>  		dmar_domain->max_addr = iova;
> @@ -5124,9 +5096,10 @@ static void intel_iommu_tlb_sync(struct iommu_domain *domain,
>  
>  	for_each_domain_iommu(iommu_id, dmar_domain)
>  		iommu_flush_iotlb_psi(g_iommus[iommu_id], dmar_domain,
> -				      start_pfn, nrpages, !gather->freelist, 0);
> +				      start_pfn, nrpages,
> +				      list_empty(&gather->freelist), 0);
>  
> -	dma_free_pagelist(gather->freelist);
> +	put_pages_list(&gather->freelist);
>  }
>  
>  static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index d2f3435e7d17..de0c57a567c8 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -186,7 +186,7 @@ struct iommu_iotlb_gather {
>  	unsigned long		start;
>  	unsigned long		end;
>  	size_t			pgsize;
> -	struct page		*freelist;
> +	struct list_head	freelist;
>  	bool			queued;
>  };
>  
> @@ -399,6 +399,7 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
>  {
>  	*gather = (struct iommu_iotlb_gather) {
>  		.start	= ULONG_MAX,
> +		.freelist = LIST_HEAD_INIT(gather->freelist),
>  	};
>  }
>  
> -- 
> 2.32.0
