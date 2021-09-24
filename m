Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00302416A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 05:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244011AbhIXDcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 23:32:02 -0400
Received: from foss.arm.com ([217.140.110.172]:42100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235369AbhIXDcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 23:32:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EED9D6E;
        Thu, 23 Sep 2021 20:30:28 -0700 (PDT)
Received: from [10.163.73.119] (unknown [10.163.73.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D554E3F59C;
        Thu, 23 Sep 2021 20:30:26 -0700 (PDT)
Subject: Re: [PATCH] mm: debug_vm_pgtable: Don't use __P000 directly
To:     guoren@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
References: <20210921201815.284412-1-guoren@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ab52f71f-0419-fd22-d59e-a87713886cfd@arm.com>
Date:   Fri, 24 Sep 2021 09:01:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210921201815.284412-1-guoren@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guo,

On 9/22/21 1:48 AM, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The __Pxxx/__Sxxx macros are only for init protection_map[]. All

s/init protection_map[]/protection_map[] int/

Or rephrase with something similar.

> usage of them in linux should come from protection_map array.

Agreed.

> 
> Becasue a lot of architectures would re-initilize protection_map[]

s/Becasue/Because/

./scripts/checkpatch.pl ./0001-mm-debug_vm_pgtable-Don-t-use-__P000-directly.patch 
WARNING: 'Becasue' may be misspelled - perhaps 'Because'?
#9: 
Becasue a lot of architectures would re-initilize protection_map[]
^^^^^^^

total: 0 errors, 1 warnings, 15 lines checked

> array, eg: x86-mem_encrypt, m68k-motorola, mips, arm, sparc.
> 
> Using __P000 maybe won't cause bug because hw would deny access

Not very clear. Could you please rephrase.

> with PROT_NONE permission, but it's not rigorous.

Agreed.

> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/debug_vm_pgtable.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 1403639302e4..a6ebbf6e53dd 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -1104,13 +1104,13 @@ static int __init init_args(struct pgtable_debug_args *args)
>  	/*
>  	 * Initialize the debugging data.
>  	 *
> -	 * __P000 (or even __S000) will help create page table entries with
> +	 * __P000 (protection_map[0]) will help create page table entries with

Please just replace __P000 and __S000 with protection_map[0] and
protection_map[8] respectively. Also reformat this comment section
if required.

>  	 * PROT_NONE permission as required for pxx_protnone_tests().
>  	 */
>  	memset(args, 0, sizeof(*args));
>  	args->vaddr              = get_random_vaddr();
>  	args->page_prot          = vm_get_page_prot(VMFLAGS);
> -	args->page_prot_none     = __P000;
> +	args->page_prot_none     = protection_map[0];
>  	args->is_contiguous_page = false;
>  	args->pud_pfn            = ULONG_MAX;
>  	args->pmd_pfn            = ULONG_MAX;
> 

With the above changes in place.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
