Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D906541B466
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241852AbhI1QtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229795AbhI1QtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:49:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94F4B61266;
        Tue, 28 Sep 2021 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632847652;
        bh=Pskz7v+W9MM9s2/wxgcD6ILNg+ssV/7prMMIUCcGGos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ukjaT8O8/K4SM65l1W1H/l90k2eWlyoxtNo8MnQV9+QqDl0uuiA1KiGwAmUgJ/Ppp
         nql/PAwihw/qfo7iCWE68KsA4LouMoNM2eRGU+3lu9f0jHm90+s/J9LUTkHeJ6KTW/
         9YqG3r5DfFVOnsgTmpxtoIEyRPNokl10iIN0CjDyA3Eh2PahR4gGfoUcR2Qd8QIo76
         3uNSgQ1x9riGgpBNEEaZegIZnJdUVNZ22Ggb0JviTofOlA2bAg8fJ1LWrMSLGYagvY
         rdQs+HJR4X14FDIujNjZX+YUSoH+wQ4bNdor6kQBWucDmpQLGZWixvrcYAoaXzQHwC
         KujanvGNePzLQ==
Date:   Tue, 28 Sep 2021 09:47:31 -0700
From:   Mike Rapoport <rppt@kernel.org>
To:     Zhenguo Yao <yaozhenguo1@gmail.com>
Cc:     mike.kravetz@oracle.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, corbet@lwn.net,
        akpm@linux-foundation.org, yaozhenguo@jd.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v7] hugetlbfs: Extend the definition of hugepages
 parameter to support node allocation
Message-ID: <YVNHIzpmxSotbbBX@kernel.org>
References: <20210927104149.46884-1-yaozhenguo1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927104149.46884-1-yaozhenguo1@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 27, 2021 at 06:41:49PM +0800, Zhenguo Yao wrote:
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
> Signed-off-by: Zhenguo Yao <yaozhenguo1@gmail.com>
> ---

...

> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 9a75ba078e1b..dd40ce6e7565 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -229,17 +229,22 @@ static int __init pseries_alloc_bootmem_huge_page(struct hstate *hstate)
>  	m->hstate = hstate;
>  	return 1;
>  }
> +
> +bool __init node_specific_alloc_support(void)

I'd suggest to namespace this to hugetlb, e.g.

hugetlb_node_alloc_supported()

> +{
> +	return false;
> +}
>  #endif
>  
>  
> -int __init alloc_bootmem_huge_page(struct hstate *h)
> +int __init alloc_bootmem_huge_page(struct hstate *h, int nid)
>  {
>  
>  #ifdef CONFIG_PPC_BOOK3S_64
>  	if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
>  		return pseries_alloc_bootmem_huge_page(h);
>  #endif
> -	return __alloc_bootmem_huge_page(h);
> +	return __alloc_bootmem_huge_page(h, nid);
>  }
>  
>  #ifndef CONFIG_PPC_BOOK3S_64

...

> @@ -2868,33 +2869,41 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  	return ERR_PTR(-ENOSPC);
>  }
>  
> -int alloc_bootmem_huge_page(struct hstate *h)
> +int alloc_bootmem_huge_page(struct hstate *h, int nid)
>  	__attribute__ ((weak, alias("__alloc_bootmem_huge_page")));
> -int __alloc_bootmem_huge_page(struct hstate *h)
> +int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>  {
>  	struct huge_bootmem_page *m;
>  	int nr_nodes, node;
>  
> +	if (nid >= nr_online_nodes)
> +		return 0;
> +	/* do node specific alloc */
> +	if (nid != NUMA_NO_NODE) {
> +		m = memblock_alloc_try_nid_raw(huge_page_size(h), huge_page_size(h),
> +				0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> +		if (m)
> +			goto found;
> +		else
> +			return 0;

Nit: you could make it a bit simpler with

		if (!m)
			return 0;
		goto found;

> +	}
> +	/* do all node balanced alloc */
>  	for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) {
> -		void *addr;
> -
> -		addr = memblock_alloc_try_nid_raw(
> +		m = memblock_alloc_try_nid_raw(
>  				huge_page_size(h), huge_page_size(h),
>  				0, MEMBLOCK_ALLOC_ACCESSIBLE, node);
> -		if (addr) {
> -			/*
> -			 * Use the beginning of the huge page to store the
> -			 * huge_bootmem_page struct (until gather_bootmem
> -			 * puts them into the mem_map).
> -			 */
> -			m = addr;
> +		/*
> +		 * Use the beginning of the huge page to store the
> +		 * huge_bootmem_page struct (until gather_bootmem
> +		 * puts them into the mem_map).
> +		 */
> +		if (m)
>  			goto found;
> -		}
> +		else
> +			return 0;

ditto

>  	}
> -	return 0;
>  
>  found:
> -	BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_size(h)));
>  	/* Put them into a private list first because mem_map is not up yet */
>  	INIT_LIST_HEAD(&m->list);
>  	list_add(&m->list, &huge_boot_pages);

-- 
Sincerely yours,
Mike.
