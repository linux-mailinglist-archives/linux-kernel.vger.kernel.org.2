Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23331388D28
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352187AbhESLpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:45:53 -0400
Received: from foss.arm.com ([217.140.110.172]:34272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234661AbhESLpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:45:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A333101E;
        Wed, 19 May 2021 04:44:24 -0700 (PDT)
Received: from [10.163.79.253] (unknown [10.163.79.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07DD13F719;
        Wed, 19 May 2021 04:44:19 -0700 (PDT)
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
Message-ID: <1b9d008a-7544-cc85-5c2f-532b984eb5b5@arm.com>
Date:   Wed, 19 May 2021 17:15:03 +0530
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

Not considering the fact that this will force the kernel to have only
base page size mapping for vmemmap (unless altmap is also requested)
which might reduce the performance, it also enables vmemmap mapping to
be teared down or build up at runtime which could potentially collide
with other kernel page table walkers like ptdump or memory hotremove
operation ! How those possible collisions are protected right now ?

Does not this vmemmap operation increase latency for HugeTLB usage ?
Should not this runtime enablement also take into account some other
qualifying information apart from potential memory save from struct
page areas. Just wondering.

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
