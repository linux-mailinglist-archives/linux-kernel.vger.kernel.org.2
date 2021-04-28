Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C832736D0BA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 05:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhD1DEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 23:04:07 -0400
Received: from foss.arm.com ([217.140.110.172]:59550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhD1DEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 23:04:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBC521FB;
        Tue, 27 Apr 2021 20:03:19 -0700 (PDT)
Received: from [10.163.76.81] (unknown [10.163.76.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6B423F694;
        Tue, 27 Apr 2021 20:03:14 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 1/5] mm/huge_memory.c: remove dedicated macro
 HPAGE_CACHE_INDEX_MASK
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     ziy@nvidia.com, william.kucharski@oracle.com, willy@infradead.org,
        yang.shi@linux.alibaba.com, aneesh.kumar@linux.ibm.com,
        rcampbell@nvidia.com, songliubraving@fb.com,
        kirill.shutemov@linux.intel.com, riel@surriel.com,
        hannes@cmpxchg.org, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210427133214.2270207-1-linmiaohe@huawei.com>
 <20210427133214.2270207-2-linmiaohe@huawei.com>
Message-ID: <b2cf99f9-bf6e-e87f-30a8-44aceed7ca03@arm.com>
Date:   Wed, 28 Apr 2021 08:34:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210427133214.2270207-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/27/21 7:02 PM, Miaohe Lin wrote:
> Rewrite the pgoff checking logic to remove macro HPAGE_CACHE_INDEX_MASK
> which is only used here to simplify the code.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/huge_mm.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 9626fda5efce..0a526f211fec 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -152,15 +152,13 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>  
>  bool transparent_hugepage_enabled(struct vm_area_struct *vma);
>  
> -#define HPAGE_CACHE_INDEX_MASK (HPAGE_PMD_NR - 1)
> -
>  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>  		unsigned long haddr)
>  {
>  	/* Don't have to check pgoff for anonymous vma */
>  	if (!vma_is_anonymous(vma)) {
> -		if (((vma->vm_start >> PAGE_SHIFT) & HPAGE_CACHE_INDEX_MASK) !=
> -			(vma->vm_pgoff & HPAGE_CACHE_INDEX_MASK))
> +		if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
> +				HPAGE_PMD_NR))
>  			return false;
>  	}
>  
> 

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
