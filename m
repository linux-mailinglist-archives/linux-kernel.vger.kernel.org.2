Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1E83D9D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 07:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbhG2FvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 01:51:05 -0400
Received: from foss.arm.com ([217.140.110.172]:41002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233739AbhG2FvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 01:51:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDD876D;
        Wed, 28 Jul 2021 22:51:00 -0700 (PDT)
Received: from [10.163.65.237] (unknown [10.163.65.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 713BD3F66F;
        Wed, 28 Jul 2021 22:50:57 -0700 (PDT)
Subject: Re: [PATCH v4 10/12] mm/debug_vm_pgtable: Use struct
 pgtable_debug_args in PGD and P4D modifying tests
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
References: <20210727061401.592616-1-gshan@redhat.com>
 <20210727061401.592616-11-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d373368a-52c9-30b8-5300-edaacad077ef@arm.com>
Date:   Thu, 29 Jul 2021 11:21:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210727061401.592616-11-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/21 11:43 AM, Gavin Shan wrote:
> This uses struct pgtable_debug_args in PGD/P4D modifying tests. No
> allocated huge page is used in these tests. Besides, the unused
> variable @saved_p4dp and @saved_pudp are dropped.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  mm/debug_vm_pgtable.c | 86 +++++++++++++++++++------------------------
>  1 file changed, 38 insertions(+), 48 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 863871e70268..0611b5f31e89 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -518,27 +518,26 @@ static void __init pud_populate_tests(struct pgtable_debug_args *args) { }
>  #endif /* PAGETABLE_PUD_FOLDED */
>  
>  #ifndef __PAGETABLE_P4D_FOLDED
> -static void __init p4d_clear_tests(struct mm_struct *mm, p4d_t *p4dp)
> +static void __init p4d_clear_tests(struct pgtable_debug_args *args)
>  {
> -	p4d_t p4d = READ_ONCE(*p4dp);
> +	p4d_t p4d = READ_ONCE(*args->p4dp);
>  
> -	if (mm_pud_folded(mm))
> +	if (mm_pud_folded(args->mm))
>  		return;
>  
>  	pr_debug("Validating P4D clear\n");
>  	p4d = __p4d(p4d_val(p4d) | RANDOM_ORVALUE);
> -	WRITE_ONCE(*p4dp, p4d);
> -	p4d_clear(p4dp);
> -	p4d = READ_ONCE(*p4dp);
> +	WRITE_ONCE(*args->p4dp, p4d);
> +	p4d_clear(args->p4dp);
> +	p4d = READ_ONCE(*args->p4dp);
>  	WARN_ON(!p4d_none(p4d));
>  }
>  
> -static void __init p4d_populate_tests(struct mm_struct *mm, p4d_t *p4dp,
> -				      pud_t *pudp)
> +static void __init p4d_populate_tests(struct pgtable_debug_args *args)
>  {
>  	p4d_t p4d;
>  
> -	if (mm_pud_folded(mm))
> +	if (mm_pud_folded(args->mm))
>  		return;
>  
>  	pr_debug("Validating P4D populate\n");
> @@ -546,34 +545,33 @@ static void __init p4d_populate_tests(struct mm_struct *mm, p4d_t *p4dp,
>  	 * This entry points to next level page table page.
>  	 * Hence this must not qualify as p4d_bad().
>  	 */
> -	pud_clear(pudp);
> -	p4d_clear(p4dp);
> -	p4d_populate(mm, p4dp, pudp);
> -	p4d = READ_ONCE(*p4dp);
> +	pud_clear(args->pudp);
> +	p4d_clear(args->p4dp);
> +	p4d_populate(args->mm, args->p4dp, args->start_pudp);
> +	p4d = READ_ONCE(*args->p4dp);
>  	WARN_ON(p4d_bad(p4d));
>  }
>  
> -static void __init pgd_clear_tests(struct mm_struct *mm, pgd_t *pgdp)
> +static void __init pgd_clear_tests(struct pgtable_debug_args *args)
>  {
> -	pgd_t pgd = READ_ONCE(*pgdp);
> +	pgd_t pgd = READ_ONCE(*(args->pgdp));
>  
> -	if (mm_p4d_folded(mm))
> +	if (mm_p4d_folded(args->mm))
>  		return;
>  
>  	pr_debug("Validating PGD clear\n");
>  	pgd = __pgd(pgd_val(pgd) | RANDOM_ORVALUE);
> -	WRITE_ONCE(*pgdp, pgd);
> -	pgd_clear(pgdp);
> -	pgd = READ_ONCE(*pgdp);
> +	WRITE_ONCE(*args->pgdp, pgd);
> +	pgd_clear(args->pgdp);
> +	pgd = READ_ONCE(*args->pgdp);
>  	WARN_ON(!pgd_none(pgd));
>  }
>  
> -static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
> -				      p4d_t *p4dp)
> +static void __init pgd_populate_tests(struct pgtable_debug_args *args)
>  {
>  	pgd_t pgd;
>  
> -	if (mm_p4d_folded(mm))
> +	if (mm_p4d_folded(args->mm))
>  		return;
>  
>  	pr_debug("Validating PGD populate\n");
> @@ -581,23 +579,17 @@ static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
>  	 * This entry points to next level page table page.
>  	 * Hence this must not qualify as pgd_bad().
>  	 */
> -	p4d_clear(p4dp);
> -	pgd_clear(pgdp);
> -	pgd_populate(mm, pgdp, p4dp);
> -	pgd = READ_ONCE(*pgdp);
> +	p4d_clear(args->p4dp);
> +	pgd_clear(args->pgdp);
> +	pgd_populate(args->mm, args->pgdp, args->start_p4dp);
> +	pgd = READ_ONCE(*args->pgdp);
>  	WARN_ON(pgd_bad(pgd));
>  }
>  #else  /* !__PAGETABLE_P4D_FOLDED */
> -static void __init p4d_clear_tests(struct mm_struct *mm, p4d_t *p4dp) { }
> -static void __init pgd_clear_tests(struct mm_struct *mm, pgd_t *pgdp) { }
> -static void __init p4d_populate_tests(struct mm_struct *mm, p4d_t *p4dp,
> -				      pud_t *pudp)
> -{
> -}
> -static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
> -				      p4d_t *p4dp)
> -{
> -}
> +static void __init p4d_clear_tests(struct pgtable_debug_args *args) { }
> +static void __init pgd_clear_tests(struct pgtable_debug_args *args) { }
> +static void __init p4d_populate_tests(struct pgtable_debug_args *args) { }
> +static void __init pgd_populate_tests(struct pgtable_debug_args *args) { }
>  #endif /* PAGETABLE_P4D_FOLDED */
>  
>  static void __init pte_clear_tests(struct pgtable_debug_args *args)
> @@ -1212,8 +1204,8 @@ static int __init debug_vm_pgtable(void)
>  	struct vm_area_struct *vma;
>  	struct mm_struct *mm;
>  	pgd_t *pgdp;
> -	p4d_t *p4dp, *saved_p4dp;
> -	pud_t *pudp, *saved_pudp;
> +	p4d_t *p4dp;
> +	pud_t *pudp;
>  	pmd_t *pmdp, *saved_pmdp, pmd;
>  	pte_t *ptep;
>  	pgtable_t saved_ptep;
> @@ -1258,8 +1250,6 @@ static int __init debug_vm_pgtable(void)
>  	 * page table pages.
>  	 */
>  	pmd = READ_ONCE(*pmdp);
> -	saved_p4dp = p4d_offset(pgdp, 0UL);
> -	saved_pudp = pud_offset(p4dp, 0UL);
>  	saved_pmdp = pmd_offset(pudp, 0UL);
>  	saved_ptep = pmd_pgtable(pmd);
>  
> @@ -1338,15 +1328,15 @@ static int __init debug_vm_pgtable(void)
>  	pud_populate_tests(&args);
>  	spin_unlock(ptl);
>  
> -	spin_lock(&mm->page_table_lock);
> -	p4d_clear_tests(mm, p4dp);
> -	pgd_clear_tests(mm, pgdp);
> -	p4d_populate_tests(mm, p4dp, saved_pudp);
> -	pgd_populate_tests(mm, pgdp, saved_p4dp);
> -	spin_unlock(&mm->page_table_lock);
> +	spin_lock(&(args.mm->page_table_lock));
> +	p4d_clear_tests(&args);
> +	pgd_clear_tests(&args);
> +	p4d_populate_tests(&args);
> +	pgd_populate_tests(&args);
> +	spin_unlock(&(args.mm->page_table_lock));
>  
> -	p4d_free(mm, saved_p4dp);
> -	pud_free(mm, saved_pudp);
> +	p4d_free(mm, p4d_offset(pgdp, 0UL));
> +	pud_free(mm, pud_offset(p4dp, 0UL));
>  	pmd_free(mm, saved_pmdp);
>  	pte_free(mm, saved_ptep);
>  
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
