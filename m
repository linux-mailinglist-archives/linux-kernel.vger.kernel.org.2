Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DEB41085E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 21:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbhIRTaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 15:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233010AbhIRTaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 15:30:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7998461100;
        Sat, 18 Sep 2021 19:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631993338;
        bh=672WtfU3kCq0R78tYvtyPMWKcaThtaEK1vpPMZUuzDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=snu+S3vs8NptfTNBz+21n3jlTMQ/KWDbeqFoI9RLuzpgoHgD8YvFL0RHlfvTlOE0w
         285XidcMb36lPzJ3vXw8Nw5/UbSlozjmwPnvoYfVoAlUwXSSkFFO+WoDARGQNiwCLn
         iMxgTJZ0dmlJxCxOyJPCis3Rhl+SpuEM2FDa+TJHv4l2bVKG6l/mnuwPr+H7oCmcKE
         T6G+sHgyAEyZopLM1p0+gU0A2w1FV4IrevKDMaCL8vhd7+7do2m6vrgl8ujdhD5hYI
         /yuXi8NDXptMJsKjTqsoeOZwMgEbQR5LtDO6RPTnE8NSaUbCqZmf0T08VEeKbivyMP
         HDUiir5wgy29w==
Date:   Sat, 18 Sep 2021 22:28:51 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     yaozhenguo <yaozhenguo1@gmail.com>
Cc:     mike.kravetz@oracle.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, corbet@lwn.net,
        akpm@linux-foundation.org, yaozhenguo@jd.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v5] hugetlbfs: Extend the definition of hugepages
 parameter to support node allocation
Message-ID: <YUY989PRsrVdHmSq@kernel.org>
References: <20210918113201.4133-1-yaozhenguo1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918113201.4133-1-yaozhenguo1@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 07:32:01PM +0800, yaozhenguo wrote:
> We can specify the number of hugepages to allocate at boot. But the
> hugepages is balanced in all nodes at present. In some scenarios,
> we only need hugepages in one node. For example: DPDK needs hugepages
> which are in the same node as NIC. if DPDK needs four hugepages of 1G
> size in node1 and system has 16 numa nodes. We must reserve 64 hugepages
> in kernel cmdline. But, only four hugepages are used. The others should
> be free after boot. If the system memory is low(for example: 64G), it will
> be an impossible task. So, Extending hugepages parameter to support
> specifying hugepages at a specific node.
> For example add following parameter:
> 
> hugepagesz=1G hugepages=0:1,1:3
> 
> It will allocate 1 hugepage in node0 and 3 hugepages in node1.
> 
> Signed-off-by: yaozhenguo <yaozhenguo1@gmail.com>
> ---
> v4->v5 changes:
> 	- remove BUG_ON in __alloc_bootmem_huge_page.
> 	- add nid parameter in __alloc_bootmem_huge_page to support
> 	  called in both specific node alloc and normal alloc.
> 	- do normal alloc if architecture can't support node specific alloc.
> 	- return -1 in powerpc version of alloc_bootmem_huge_page when
> 	  nid is not NUMA_NO_NODE. 

I think, node format should not be enabled on powerpc.  Rather than add a
new return value to alloc_bootmem_huge_page() and add complex checks for
-1, 0 and 1, it would be simpler to add a new weak function. The default
implementation will return true and powerpc will have an override that
returns false.
This function can be called during command line parsing and if it returned
false the entire per-node allocation path would be disabled.

>
> ---
>  .../admin-guide/kernel-parameters.txt         |   8 +-
>  Documentation/admin-guide/mm/hugetlbpage.rst  |  12 +-
>  arch/powerpc/mm/hugetlbpage.c                 |   8 +-
>  include/linux/hugetlb.h                       |   5 +-
>  mm/hugetlb.c                                  | 155 ++++++++++++++++--
>  5 files changed, 166 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bdb22006f..a2046b2c5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1588,9 +1588,11 @@
>  			the number of pages of hugepagesz to be allocated.
>  			If this is the first HugeTLB parameter on the command
>  			line, it specifies the number of pages to allocate for
> -			the default huge page size.  See also
> -			Documentation/admin-guide/mm/hugetlbpage.rst.
> -			Format: <integer>
> +			the default huge page size. If using node format, the
> +			number of pages to allocate per-node can be specified.
> +			See also Documentation/admin-guide/mm/hugetlbpage.rst.
> +			Format: <integer> or (node format)
> +				<node>:<integer>[,<node>:<integer>]
>  
>  	hugepagesz=
>  			[HW] The size of the HugeTLB pages.  This is used in
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index 8abaeb144..d70828c07 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -128,7 +128,9 @@ hugepages
>  	implicitly specifies the number of huge pages of default size to
>  	allocate.  If the number of huge pages of default size is implicitly
>  	specified, it can not be overwritten by a hugepagesz,hugepages
> -	parameter pair for the default size.
> +	parameter pair for the default size.  This parameter also has a
> +	node format.  The node format specifies the number of huge pages
> +	to allocate on specific nodes.
>  
>  	For example, on an architecture with 2M default huge page size::
>  
> @@ -138,6 +140,14 @@ hugepages
>  	indicating that the hugepages=512 parameter is ignored.  If a hugepages
>  	parameter is preceded by an invalid hugepagesz parameter, it will
>  	be ignored.
> +
> +	Node format example::
> +
> +		hugepagesz=2M hugepages=0:1,1:2
> +
> +	It will allocate 1 2M hugepage on node0 and 2 2M hugepages on node1.
> +	If the node number is invalid,  the parameter will be ignored.
> +
>  default_hugepagesz
>  	Specify the default huge page size.  This parameter can
>  	only be specified once on the command line.  default_hugepagesz can
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 9a75ba078..4a9cea714 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -19,6 +19,7 @@
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
>  #include <linux/kmemleak.h>
> +#include <linux/numa.h>
>  #include <asm/pgalloc.h>
>  #include <asm/tlb.h>
>  #include <asm/setup.h>
> @@ -232,14 +233,17 @@ static int __init pseries_alloc_bootmem_huge_page(struct hstate *hstate)
>  #endif
>  
>  
> -int __init alloc_bootmem_huge_page(struct hstate *h)
> +int __init alloc_bootmem_huge_page(struct hstate *h, int nid)
>  {
>  
>  #ifdef CONFIG_PPC_BOOK3S_64
> +	/* Don't support node specific alloc */
> +	if (nid != NUMA_NO_NODE)
> +		return -1;
>  	if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
>  		return pseries_alloc_bootmem_huge_page(h);
>  #endif
> -	return __alloc_bootmem_huge_page(h);
> +	return __alloc_bootmem_huge_page(h, nid);
>  }
>  
>  #ifndef CONFIG_PPC_BOOK3S_64
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index f7ca1a387..a9bdbc870 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -605,6 +605,7 @@ struct hstate {
>  	unsigned long nr_overcommit_huge_pages;
>  	struct list_head hugepage_activelist;
>  	struct list_head hugepage_freelists[MAX_NUMNODES];
> +	unsigned int max_huge_pages_node[MAX_NUMNODES];
>  	unsigned int nr_huge_pages_node[MAX_NUMNODES];
>  	unsigned int free_huge_pages_node[MAX_NUMNODES];
>  	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
> @@ -637,8 +638,8 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
>  				unsigned long address, struct page *page);
>  
>  /* arch callback */
> -int __init __alloc_bootmem_huge_page(struct hstate *h);
> -int __init alloc_bootmem_huge_page(struct hstate *h);
> +int __init __alloc_bootmem_huge_page(struct hstate *h, int nid);
> +int __init alloc_bootmem_huge_page(struct hstate *h, int nid);
>  
>  void __init hugetlb_add_hstate(unsigned order);
>  bool __init arch_hugetlb_valid_size(unsigned long size);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index dfc940d52..f7aaca6ff 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -66,6 +66,7 @@ static struct hstate * __initdata parsed_hstate;
>  static unsigned long __initdata default_hstate_max_huge_pages;
>  static bool __initdata parsed_valid_hugepagesz = true;
>  static bool __initdata parsed_default_hugepagesz;
> +static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
>  
>  /*
>   * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
> @@ -2774,17 +2775,30 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  	vma_end_reservation(h, vma, addr);
>  	return ERR_PTR(-ENOSPC);
>  }
> -
> -int alloc_bootmem_huge_page(struct hstate *h)
> +/*
> + * Architecture version must provide there own node specific hugepage

                                       ^ its

> + * allocation code. If not, please return -1 when nid is not NUMA_NO_NODE.
> + */
> +int alloc_bootmem_huge_page(struct hstate *h, int nid)
>  	__attribute__ ((weak, alias("__alloc_bootmem_huge_page")));
> -int __alloc_bootmem_huge_page(struct hstate *h)
> +int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>  {
>  	struct huge_bootmem_page *m;
>  	int nr_nodes, node;
> +	void *addr = NULL;
>  
> +	/* do node specific alloc */
> +	if (nid != NUMA_NO_NODE && nid < nodes_weight(node_states[N_MEMORY])) {
> +		addr = memblock_alloc_try_nid_raw(huge_page_size(h), huge_page_size(h),
> +				0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> +		if (addr) {
> +			m = addr;
> +			goto found;
> +		} else {
> +			return 0;
> +		}

		if (!addr)
			return 0;
		m = addr;
		goto found;

seems simpler to me.

Besides, I think addr is not needed at all, m can be assigned directly. I'd
also rename it to e.g. page.

> +	}
>  	for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) {
> -		void *addr;
> -
>  		addr = memblock_alloc_try_nid_raw(
>  				huge_page_size(h), huge_page_size(h),
>  				0, MEMBLOCK_ALLOC_ACCESSIBLE, node);
> @@ -2801,7 +2815,6 @@ int __alloc_bootmem_huge_page(struct hstate *h)
>  	return 0;
>  
>  found:
> -	BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_size(h)));
>  	/* Put them into a private list first because mem_map is not up yet */
>  	INIT_LIST_HEAD(&m->list);
>  	list_add(&m->list, &huge_boot_pages);
> @@ -2841,11 +2854,83 @@ static void __init gather_bootmem_prealloc(void)
>  		cond_resched();
>  	}
>  }
> +/*
> + * do node specific hugepage allocation
> + * return  0: allocation is failed
> + *	   1: allocation is successful
> + *	   -1: alloc_bootmem_huge_page can't support node specific allocation
> + */
> +static int __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
> +{
> +	unsigned long i;
> +	char buf[32];
> +	int ret = 1;
> +
> +	for (i = 0; i < h->max_huge_pages_node[nid]; ++i) {
> +		if (hstate_is_gigantic(h)) {
> +			ret = alloc_bootmem_huge_page(h, nid);
> +			if (ret == 0 || ret == -1)
> +				break;
> +		} else {
> +			struct page *page;
> +			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
> +
> +			page = alloc_fresh_huge_page(h, gfp_mask, nid,
> +					&node_states[N_MEMORY], NULL);
> +			if (!page) {
> +				ret = 0;
> +				break;
> +			}
> +			put_page(page); /* free it into the hugepage allocator */
> +		}
> +		cond_resched();
> +	}
> +	if (i == h->max_huge_pages_node[nid])
> +		return ret;
> +
> +	string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> +	pr_warn("HugeTLB: allocating %u of page size %s failed node%d.  Only allocated %lu hugepages.\n",
> +		h->max_huge_pages_node[nid], buf, nid, i);
> +	/*
> +	 * we need h->max_huge_pages to do normal alloc,
> +	 * when alloc_bootm_huge_page can't support node specific allocation.
> +	 */
> +	if (ret != -1)
> +		h->max_huge_pages -= (h->max_huge_pages_node[nid] - i);
> +	h->max_huge_pages_node[nid] = i;
> +	return ret;
> +}
>  
>  static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>  {
>  	unsigned long i;
>  	nodemask_t *node_alloc_noretry;
> +	bool hugetlb_node_set = false;
> +
> +	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
> +	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
> +		pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
> +		return;
> +	}
> +
> +	/* do node alloc */
> +	for (i = 0; i < nodes_weight(node_states[N_MEMORY]); i++) {
> +		if (h->max_huge_pages_node[i] > 0) {
> +			/*
> +			 * if hugetlb_hstate_alloc_pages_onenode return -1
> +			 * architecture version alloc_bootmem_huge_page
> +			 * can't support node specific alloc for gigantic
> +			 * hugepage, so goto normal alloc.
> +			 */
> +			if (hugetlb_hstate_alloc_pages_onenode(h, i) == -1)
> +				pr_warn_once("HugeTLB: architecture can't support node specific alloc, skip!\n");
> +			else
> +				hugetlb_node_set = true;
> +		}
> +	}
> +
> +	if (hugetlb_node_set)
> +		return;

If I understand correctly, this means that even if the allocation fails for
some of the nodes explicitly set in hugepages=nid:pages,..., we won't try
allocate more huge pages and silently ignore the failure. Is this the
intended behaviour?

>  
>  	if (!hstate_is_gigantic(h)) {
>  		/*
> @@ -2867,11 +2952,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>  
>  	for (i = 0; i < h->max_huge_pages; ++i) {
>  		if (hstate_is_gigantic(h)) {
> -			if (hugetlb_cma_size) {
> -				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
> -				goto free;
> -			}
> -			if (!alloc_bootmem_huge_page(h))
> +			if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
>  				break;
>  		} else if (!alloc_pool_huge_page(h,
>  					 &node_states[N_MEMORY],
> @@ -2887,7 +2968,6 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>  			h->max_huge_pages, buf, i);
>  		h->max_huge_pages = i;
>  	}
> -free:
>  	kfree(node_alloc_noretry);
>  }
>  

-- 
Sincerely yours,
Mike.
