Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D81388E2E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbhESMhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:37:06 -0400
Received: from foss.arm.com ([217.140.110.172]:35750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353396AbhESMhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:37:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 803D5101E;
        Wed, 19 May 2021 05:35:41 -0700 (PDT)
Received: from [10.163.79.253] (unknown [10.163.79.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33E683F73B;
        Wed, 19 May 2021 05:35:36 -0700 (PDT)
Subject: Re: [PATCH] arm64: mm: hugetlb: add support for free vmemmap pages of
 HugeTLB
To:     Muchun Song <songmuchun@bytedance.com>, will@kernel.org,
        akpm@linux-foundation.org, david@redhat.com, bodeddub@amazon.com,
        osalvador@suse.de, mike.kravetz@oracle.com, rientjes@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, zhengqi.arch@bytedance.com
References: <20210518091826.36937-1-songmuchun@bytedance.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5ae7a4be-dfd5-faf6-a75c-a2adf5a344b2@arm.com>
Date:   Wed, 19 May 2021 18:06:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210518091826.36937-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/18/21 2:48 PM, Muchun Song wrote:
> The preparation of supporting freeing vmemmap associated with each
> HugeTLB page is ready, so we can support this feature for arm64.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/arm64/mm/mmu.c | 5 +++++
>  fs/Kconfig          | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 5d37e461c41f..967b01ce468d 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -23,6 +23,7 @@
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
> +#include <linux/hugetlb.h>
>  
>  #include <asm/barrier.h>
>  #include <asm/cputype.h>
> @@ -1134,6 +1135,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  	pmd_t *pmdp;
>  
>  	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
> +
> +	if (is_hugetlb_free_vmemmap_enabled() && !altmap)
> +		return vmemmap_populate_basepages(start, end, node, altmap);
> +
>  	do {
>  		next = pmd_addr_end(addr, end);
>  
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 6ce6fdac00a3..02c2d3bf1cb8 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -242,7 +242,7 @@ config HUGETLB_PAGE
>  
>  config HUGETLB_PAGE_FREE_VMEMMAP
>  	def_bool HUGETLB_PAGE
> -	depends on X86_64
> +	depends on X86_64 || ARM64
>  	depends on SPARSEMEM_VMEMMAP
>  
>  config MEMFD_CREATE
> 

How does this interact with HugeTLB migration as such which might iterate
over individual constituent struct pages (overriding the same struct page
for all tail pages when this feature is enabled). A simple test involving
madvise(ptr, size, MADV_SOFT_OFFLINE) fails on various HugeTLB page sizes,
with this patch applied. Although I have not debugged this any further.

Soft offlining pfn 0x101c00 at process virtual address 0xffff7fa00000
soft offline: 0x101c00: hugepage migration failed 1, type bfffc0000010006 
              (referenced|uptodate|head|node=0|zone=2|lastcpupid=0xffff)

