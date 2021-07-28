Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10413D8C74
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 13:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbhG1LHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 07:07:19 -0400
Received: from foss.arm.com ([217.140.110.172]:55138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231994AbhG1LHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 07:07:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B56C631B;
        Wed, 28 Jul 2021 04:07:16 -0700 (PDT)
Received: from [10.163.65.183] (unknown [10.163.65.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B3773F66F;
        Wed, 28 Jul 2021 04:07:13 -0700 (PDT)
Subject: Re: [PATCH v4 06/12] mm/debug_vm_pgtable: Use struct
 pgtable_debug_args in migration and thp tests
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
References: <20210727061401.592616-1-gshan@redhat.com>
 <20210727061401.592616-7-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <39de75d2-744a-9194-cbc2-14926b60e68e@arm.com>
Date:   Wed, 28 Jul 2021 16:38:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210727061401.592616-7-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/21 11:43 AM, Gavin Shan wrote:
> This uses struct pgtable_debug_args in the migration and thp test
> functions. It's notable that the pre-allocated page is used in
> swap_migration_tests() as set_pte_at() is used there.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  mm/debug_vm_pgtable.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index bc153cad9045..9136195efde3 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -845,7 +845,7 @@ static void __init pmd_swap_tests(struct pgtable_debug_args *args)
>  static void __init pmd_swap_tests(struct pgtable_debug_args *args) { }
>  #endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
>  
> -static void __init swap_migration_tests(void)
> +static void __init swap_migration_tests(struct pgtable_debug_args *args)
>  {
>  	struct page *page;
>  	swp_entry_t swp;
> @@ -861,9 +861,10 @@ static void __init swap_migration_tests(void)
>  	 * problematic. Lets allocate a dedicated page explicitly for this
>  	 * purpose that will be freed subsequently.
>  	 */
> -	page = alloc_page(GFP_KERNEL);
> +	page = (args->pte_pfn != ULONG_MAX) ?
> +	       pfn_to_page(args->pte_pfn) : NULL;
>  	if (!page) {
> -		pr_err("page allocation failed\n");
> +		pr_err("no page available\n");
>  		return;
>  	}

Please check for a valid page earlier in the function and return. Otherwise
this calls out the page unavailability (after starting the test), which is
inconsistent with all other functions like pxx_advanced_tests().

[    1.051633] debug_vm_pgtable: [pte_swap_tests           ]: Validating PTE swap
[    1.052697] debug_vm_pgtable: [pmd_swap_tests           ]: Validating PMD swap
[    1.053765] debug_vm_pgtable: [swap_migration_tests     ]: Validating swap migration <=====
[    1.054900] debug_vm_pgtable: [swap_migration_tests     ]: no page available         <=====

Should do this just before pr_info("Validating swap migration\n").

......
page = (args->pte_pfn != ULONG_MAX) ? pfn_to_page(args->pte_pfn) : NULL;
if (!page)
	return;
.....
