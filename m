Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F10323BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 13:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhBXMfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 07:35:51 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:51981 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhBXMfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 07:35:47 -0500
X-Originating-IP: 81.185.165.217
Received: from [192.168.43.237] (217.165.185.81.rev.sfr.net [81.185.165.217])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id DFE59240005;
        Wed, 24 Feb 2021 12:34:56 +0000 (UTC)
Subject: Re: [PATCH] riscv: mm: Remove the copy operation of pmd
To:     Chuanhua Han <hanchuanhua@fishsemi.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     sfr@canb.auug.org.au, schwab@suse.de, Anup.Patel@wdc.com,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-riscv@lists.infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, shihpo.hung@sifive.com,
        tglx@linutronix.de
References: <20200330115319.1507-1-hanchuanhua@fishsemi.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <d10ea4ba-0aa5-4c70-8c3a-4a970d61f4fb@ghiti.fr>
Date:   Wed, 24 Feb 2021 07:34:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20200330115319.1507-1-hanchuanhua@fishsemi.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 3/30/20 à 7:53 AM, Chuanhua Han a écrit :
> Since all processes share the kernel address space,
> we only need to copy pgd in case of a vmalloc page
> fault exception, the other levels of page tables are
> shared, so the operation of copying pmd is unnecessary.
> 
> Signed-off-by: Chuanhua Han <hanchuanhua@fishsemi.com>
> ---
>   arch/riscv/mm/fault.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index be84e32adc4c..24f4ebfd2df8 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -208,9 +208,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>   vmalloc_fault:
>   	{
>   		pgd_t *pgd, *pgd_k;
> -		pud_t *pud, *pud_k;
> -		p4d_t *p4d, *p4d_k;
> -		pmd_t *pmd, *pmd_k;
> +		pud_t *pud_k;
> +		p4d_t *p4d_k;
> +		pmd_t *pmd_k;
>   		pte_t *pte_k;
>   		int index;
>   
> @@ -234,12 +234,10 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>   			goto no_context;
>   		set_pgd(pgd, *pgd_k);
>   
> -		p4d = p4d_offset(pgd, addr);
>   		p4d_k = p4d_offset(pgd_k, addr);
>   		if (!p4d_present(*p4d_k))
>   			goto no_context;
>   
> -		pud = pud_offset(p4d, addr);
>   		pud_k = pud_offset(p4d_k, addr);
>   		if (!pud_present(*pud_k))
>   			goto no_context;
> @@ -248,11 +246,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>   		 * Since the vmalloc area is global, it is unnecessary
>   		 * to copy individual PTEs
>   		 */
> -		pmd = pmd_offset(pud, addr);
>   		pmd_k = pmd_offset(pud_k, addr);
>   		if (!pmd_present(*pmd_k))
>   			goto no_context;
> -		set_pmd(pmd, *pmd_k);
>   
>   		/*
>   		 * Make sure the actual PTE exists as well to
> 

Better late than never: I do agree with this patch, once the PGD is 
copied into the user page table, it "comes with all its mappings" so 
there is no need to copy PMD, the only thing left to do is to make sure 
the mapping does exists in the kernel page table.

So feel free to add:

Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
Tested-by: Alexandre Ghiti <alex@ghiti.fr>

Thanks,

Alex
