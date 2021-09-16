Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCE340E1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbhIPQdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 12:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241228AbhIPQZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 12:25:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7040F613C8;
        Thu, 16 Sep 2021 16:16:32 +0000 (UTC)
Date:   Thu, 16 Sep 2021 17:16:29 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        suzuki.poulose@arm.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Add pud_sect_supported()
Message-ID: <YUNt3btNlYVGDTkX@arm.com>
References: <1631677459-28383-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631677459-28383-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 09:14:19AM +0530, Anshuman Khandual wrote:
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 23505fc35324..641854f0e8ee 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -40,11 +40,10 @@ void __init arm64_hugetlb_cma_reserve(void)
>  {
>  	int order;
>  
> -#ifdef CONFIG_ARM64_4K_PAGES
> -	order = PUD_SHIFT - PAGE_SHIFT;
> -#else
> -	order = CONT_PMD_SHIFT + PMD_SHIFT - PAGE_SHIFT;
> -#endif
> +	if (pud_sect_supported())
> +		order = PUD_SHIFT - PAGE_SHIFT;
> +	else
> +		order = CONT_PMD_SHIFT + PMD_SHIFT - PAGE_SHIFT;
>  	/*
>  	 * HugeTLB CMA reservation is required for gigantic
>  	 * huge pages which could not be allocated via the
> @@ -62,8 +61,9 @@ bool arch_hugetlb_migration_supported(struct hstate *h)
>  	size_t pagesize = huge_page_size(h);
>  
>  	switch (pagesize) {
> -#ifdef CONFIG_ARM64_4K_PAGES
> +#ifndef __PAGETABLE_PUD_FOLDED
>  	case PUD_SIZE:
> +		return pud_sect_supported();
>  #endif
>  	case PMD_SIZE:
>  	case CONT_PMD_SIZE:

Is this the same thing? With 4K pages and 3-levels (39-bit VA), the PUD
is folded but we do have a valid PUD_SIZE == PGDIR_SIZE and different
from PMD_SIZE. Do we disallow section mappings at the top level in this
case? If not, we should have check for __PAGETABLE_PMD_FOLDED instead.

> @@ -126,8 +126,11 @@ static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
>  	*pgsize = size;
>  
>  	switch (size) {
> -#ifdef CONFIG_ARM64_4K_PAGES
> +#ifndef __PAGETABLE_PUD_FOLDED
>  	case PUD_SIZE:
> +		if (pud_sect_supported())
> +			contig_ptes = 1;
> +		break;
>  #endif
>  	case PMD_SIZE:
>  		contig_ptes = 1;

Same here.

> @@ -489,9 +492,9 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  
>  static int __init hugetlbpage_init(void)
>  {
> -#ifdef CONFIG_ARM64_4K_PAGES
> -	hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
> -#endif
> +	if (pud_sect_supported())
> +		hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
> +
>  	hugetlb_add_hstate(CONT_PMD_SHIFT - PAGE_SHIFT);
>  	hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
>  	hugetlb_add_hstate(CONT_PTE_SHIFT - PAGE_SHIFT);
> @@ -503,8 +506,9 @@ arch_initcall(hugetlbpage_init);
>  bool __init arch_hugetlb_valid_size(unsigned long size)
>  {
>  	switch (size) {
> -#ifdef CONFIG_ARM64_4K_PAGES
> +#ifndef __PAGETABLE_PUD_FOLDED
>  	case PUD_SIZE:
> +		return pud_sect_supported();
>  #endif
>  	case CONT_PMD_SIZE:
>  	case PMD_SIZE:

And here.

-- 
Catalin
