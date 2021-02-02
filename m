Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1141E30B50F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 03:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhBBCKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 21:10:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12002 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBBCKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 21:10:42 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DV7XC4Dh3zjHJp;
        Tue,  2 Feb 2021 10:08:43 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 10:09:59 +0800
Subject: Re: [PATCH] mm: simplify the VM_BUG_ON condition in
 pmdp_huge_clear_flush()
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210201114319.34720-1-linmiaohe@huawei.com>
 <20210201153354.e640247cb5ab306e909322d0@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2e2c1d42-9492-4e30-9646-bfa06b2d14d7@huawei.com>
Date:   Tue, 2 Feb 2021 10:09:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210201153354.e640247cb5ab306e909322d0@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/2/2 7:33, Andrew Morton wrote:
> On Mon, 1 Feb 2021 06:43:19 -0500 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> The condition (A && !C && !D) || !A is equivalent to !A || (A && !C && !D)
>> and can be further simplified to !A || (!C && !D).
>>
>> ..
>>
>> --- a/mm/pgtable-generic.c
>> +++ b/mm/pgtable-generic.c
>> @@ -135,8 +135,8 @@ pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
>>  {
>>  	pmd_t pmd;
>>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>> -	VM_BUG_ON((pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
>> -			   !pmd_devmap(*pmdp)) || !pmd_present(*pmdp));
>> +	VM_BUG_ON(!pmd_present(*pmdp) || (!pmd_trans_huge(*pmdp) &&
>> +					  !pmd_devmap(*pmdp)));
>>  	pmd = pmdp_huge_get_and_clear(vma->vm_mm, address, pmdp);
>>  	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>>  	return pmd;
> 
> True, and the resulting code is still readable enough.
> 
> But a problem with such a complex expression is that the developer will
> have trouble figuring out why the BUG actually triggered.
> 

Agree! We can determine which condition is failing through the line number __but__
we can't figure out exactly which one triggered BUG for a complex expression.

> If we had a VM_BUG_ON_PMD() then we could print the pmd's value and
> permit diagnosis from that.  But we don't have such a thing.
> 
> So I suggest that it would be better to have
> 
> 	VM_BUG_ON((pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
> 			   !pmd_devmap(*pmdp)));
> 	VM_BUG_ON(!pmd_present(*pmdp));
> 
> This way, the BUG()'s file-n-line output will tell us more about why the
> kernel went splat.
> 
> 
> I suppose maybe this could be optimized the same way, as
> 
> 	VM_BUG_ON(!pmd_present(*pmdp));
> 	/* Below assumes pmd_present() is true */
> 	VM_BUG_ON(!pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));

This one looks good and provide more information than before. I can send another patch to do this (and feel free to merge into
this one), should I ?

Many thanks.

> 
> Which works because VM_BUG_ON is, depending up Kconfig, either a no-op
> or a noreturn-if-it-triggered.  I'm not sure if I like this trick much though.
> 
> .
> 
