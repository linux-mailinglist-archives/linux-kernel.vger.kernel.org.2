Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53819418DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 04:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhI0CR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 22:17:59 -0400
Received: from foss.arm.com ([217.140.110.172]:37310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhI0CR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 22:17:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0896D6E;
        Sun, 26 Sep 2021 19:16:20 -0700 (PDT)
Received: from [10.163.73.35] (unknown [10.163.73.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E7C03F718;
        Sun, 26 Sep 2021 19:16:18 -0700 (PDT)
Subject: Re: [PATCH V2] mm: debug_vm_pgtable: Don't use __P000 directly
To:     guoren@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
References: <20210924060821.1138281-1-guoren@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <30c10b5f-1b26-e0a8-8185-6fa3296d68dc@arm.com>
Date:   Mon, 27 Sep 2021 07:47:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210924060821.1138281-1-guoren@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/21 11:38 AM, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The __Pxxx/__Sxxx macros are only for protection_map[] init. All
> usage of them in linux should come from protection_map array.
> 
> Because a lot of architectures would re-initilize protection_map[]
> array, eg: x86-mem_encrypt, m68k-motorola, mips, arm, sparc.
> 
> Using __P000 is not rigorous.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>


> 
> ---
> 
> Changes since V2:
>  - s/init protection_map[]/protection_map[] init/
>  - s/Becasue/Because/
>  - Remove unclear part
>  - Replace __P000 and __S000 with protection_map[0] and
>    protection_map[8]
> ---
>  mm/debug_vm_pgtable.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 1403639302e4..228e3954b90c 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -1104,13 +1104,14 @@ static int __init init_args(struct pgtable_debug_args *args)
>  	/*
>  	 * Initialize the debugging data.
>  	 *
> -	 * __P000 (or even __S000) will help create page table entries with
> -	 * PROT_NONE permission as required for pxx_protnone_tests().
> +	 * protection_map[0] (or even protection_map[8]) will help create
> +	 * page table entries with PROT_NONE permission as required for
> +	 * pxx_protnone_tests().
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
