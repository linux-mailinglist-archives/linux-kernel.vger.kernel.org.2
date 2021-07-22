Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2653D1D26
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 06:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhGVEKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 00:10:22 -0400
Received: from foss.arm.com ([217.140.110.172]:43488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhGVEKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 00:10:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47E6CD6E;
        Wed, 21 Jul 2021 21:50:57 -0700 (PDT)
Received: from [10.163.65.134] (unknown [10.163.65.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CFA23F66F;
        Wed, 21 Jul 2021 21:50:54 -0700 (PDT)
Subject: Re: [PATCH v3 11/12] mm/debug_vm_pgtable: Remove unused code
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210719130613.334901-1-gshan@redhat.com>
 <20210719130613.334901-12-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e2983a3d-0bfa-46e5-fbb8-d953860bc323@arm.com>
Date:   Thu, 22 Jul 2021 10:21:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210719130613.334901-12-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small nit for the subject line.

s/Remove unused code/Remove unused page table debug elements/

On 7/19/21 6:36 PM, Gavin Shan wrote:
> The variables used by old implementation isn't needed as we switched
> to "struct pgtable_debug_args". Lets remove them and related code in
> debug_vm_pgtable().
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  mm/debug_vm_pgtable.c | 54 -------------------------------------------
>  1 file changed, 54 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 5ebacc940b68..4f7bf1c9724a 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -1124,14 +1124,6 @@ static int __init init_args(struct pgtable_debug_args *args)
>  static int __init debug_vm_pgtable(void)
>  {
>  	struct pgtable_debug_args args;
> -	struct vm_area_struct *vma;
> -	struct mm_struct *mm;
> -	pgd_t *pgdp;
> -	p4d_t *p4dp;
> -	pud_t *pudp;
> -	pmd_t *pmdp, *saved_pmdp, pmd;
> -	pgtable_t saved_ptep;
> -	unsigned long vaddr;
>  	spinlock_t *ptl = NULL;
>  	int idx, ret;
>  
> @@ -1140,41 +1132,6 @@ static int __init debug_vm_pgtable(void)
>  	if (ret)
>  		return ret;
>  
> -	vaddr = get_random_vaddr();
> -	mm = mm_alloc();
> -	if (!mm) {
> -		pr_err("mm_struct allocation failed\n");
> -		return 1;
> -	}
> -
> -	vma = vm_area_alloc(mm);
> -	if (!vma) {
> -		pr_err("vma allocation failed\n");
> -		return 1;
> -	}
> -
> -	pgdp = pgd_offset(mm, vaddr);
> -	p4dp = p4d_alloc(mm, pgdp, vaddr);
> -	pudp = pud_alloc(mm, p4dp, vaddr);
> -	pmdp = pmd_alloc(mm, pudp, vaddr);
> -	/*
> -	 * Allocate pgtable_t
> -	 */
> -	if (pte_alloc(mm, pmdp)) {
> -		pr_err("pgtable allocation failed\n");
> -		return 1;
> -	}
> -
> -	/*
> -	 * Save all the page table page addresses as the page table
> -	 * entries will be used for testing with random or garbage
> -	 * values. These saved addresses will be used for freeing
> -	 * page table pages.
> -	 */

Please move this comment as is to the right place inside init_args()
in the first patch itself. If possible all comments should be moved
during the first patch and just the code gets dropped here.

> -	pmd = READ_ONCE(*pmdp);
> -	saved_pmdp = pmd_offset(pudp, 0UL);
> -	saved_ptep = pmd_pgtable(pmd);
> -
>  	/*
>  	 * Iterate over the protection_map[] to make sure that all
>  	 * the basic page table transformation validations just hold
> @@ -1256,17 +1213,6 @@ static int __init debug_vm_pgtable(void)
>  	pgd_populate_tests(&args);
>  	spin_unlock(&(args.mm->page_table_lock));
>  
> -	p4d_free(mm, p4d_offset(pgdp, 0UL));
> -	pud_free(mm, pud_offset(p4dp, 0UL));
> -	pmd_free(mm, saved_pmdp);
> -	pte_free(mm, saved_ptep);
> -
> -	vm_area_free(vma);
> -	mm_dec_nr_puds(mm);
> -	mm_dec_nr_pmds(mm);
> -	mm_dec_nr_ptes(mm);
> -	mmdrop(mm);
> -
>  	destroy_args(&args);
>  	return 0;
>  }
> 
