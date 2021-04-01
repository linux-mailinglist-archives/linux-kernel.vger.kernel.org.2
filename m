Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C41351E82
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241196AbhDASms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:42:48 -0400
Received: from foss.arm.com ([217.140.110.172]:46422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238210AbhDASUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:20:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E19FE15BE;
        Thu,  1 Apr 2021 07:40:43 -0700 (PDT)
Received: from [10.163.68.23] (unknown [10.163.68.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 583703F719;
        Thu,  1 Apr 2021 07:40:42 -0700 (PDT)
Subject: Re: [PATCH -next 3/3] mm/debug_vm_pgtable: Remove useless pfn_pmd()
To:     Shixin Liu <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210401022315.2911967-1-liushixin2@huawei.com>
 <20210401022315.2911967-3-liushixin2@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0ef29a80-5873-ddf6-bfb0-7d1b5c17b8c0@arm.com>
Date:   Thu, 1 Apr 2021 20:11:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210401022315.2911967-3-liushixin2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/21 7:53 AM, Shixin Liu wrote:
> The call to pfn_pmd() here is redundant.
> 
> Signed-off-by: Shixin Liu <liushixin2@huawei.com>
> ---
>  mm/debug_vm_pgtable.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index c379bbe42c2a..9f4c4a114229 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -196,7 +196,6 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>  
>  	pgtable_trans_huge_deposit(mm, pmdp, pgtable);
>  
> -	pmd = pfn_pmd(pfn, prot);
>  	set_pmd_at(mm, vaddr, pmdp, pmd);
>  	pmdp_set_wrprotect(mm, vaddr, pmdp);
>  	pmd = READ_ONCE(*pmdp);
> 

Instead drop the first pfn_pmd(), as that pmd would not be required
when THP is not enabled. Also, please fold this with the first patch.
