Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376FB351DD2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbhDAScJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:32:09 -0400
Received: from foss.arm.com ([217.140.110.172]:46004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238775AbhDASKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:10:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E714315AD;
        Thu,  1 Apr 2021 07:34:07 -0700 (PDT)
Received: from [10.163.68.23] (unknown [10.163.68.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C0033F719;
        Thu,  1 Apr 2021 07:34:06 -0700 (PDT)
Subject: Re: [PATCH -next 1/3] mm/debug_vm_pgtable: Fix one comment mistake
To:     Shixin Liu <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210401022315.2911967-1-liushixin2@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e157988e-2698-9aff-eff1-58aa0ec70fed@arm.com>
Date:   Thu, 1 Apr 2021 20:04:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210401022315.2911967-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/21 7:53 AM, Shixin Liu wrote:
> The branch condition should be CONFIG_TRANSPARENT_HUGEPAGE instead of
> CONFIG_ARCH_HAS_PTE_DEVMAP.
> 
> Signed-off-by: Shixin Liu <liushixin2@huawei.com>
> ---
>  mm/debug_vm_pgtable.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 05efe98a9ac2..a5c71a94e804 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -755,12 +755,12 @@ static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
>  	WARN_ON(!pmd_swp_soft_dirty(pmd_swp_mksoft_dirty(pmd)));
>  	WARN_ON(pmd_swp_soft_dirty(pmd_swp_clear_soft_dirty(pmd)));
>  }
> -#else  /* !CONFIG_ARCH_HAS_PTE_DEVMAP */
> +#else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
>  static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot) { }
>  static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
>  {
>  }
> -#endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  static void __init pte_swap_tests(unsigned long pfn, pgprot_t prot)
>  {
> 

LGTM, thanks for catching. But does not need a patch of it's
own, instead should be folded with other potential clean ups.
