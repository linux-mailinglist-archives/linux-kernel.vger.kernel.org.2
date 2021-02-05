Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33BF31037F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 04:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhBEDXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 22:23:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11678 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhBEDXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 22:23:01 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DX0zp4RCvzlGfW;
        Fri,  5 Feb 2021 11:20:38 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 11:22:18 +0800
Subject: Re: [PATCH] mm/pgtable-generic.c: optimize the VM_BUG_ON condition in
 pmdp_huge_clear_flush()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210203084137.25522-1-linmiaohe@huawei.com>
 <20210204123605.GD308988@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <74f9fda6-b4f5-487d-67c3-788ae0c22fff@huawei.com>
Date:   Fri, 5 Feb 2021 11:22:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210204123605.GD308988@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/2/4 20:36, Matthew Wilcox wrote:
> On Wed, Feb 03, 2021 at 03:41:37AM -0500, Miaohe Lin wrote:
>> The developer will have trouble figuring out why the BUG actually triggered
>> when there is a complex expression in the VM_BUG_ON. Because we can only
>> identify the condition triggered BUG via line number provided by VM_BUG_ON.
>> Optimize this by spliting such a complex expression into two simple
>> conditions.
> 
>>  	pmd_t pmd;
>>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>> -	VM_BUG_ON(!pmd_present(*pmdp) || (!pmd_trans_huge(*pmdp) &&
>> -					  !pmd_devmap(*pmdp)));
>> +	VM_BUG_ON(!pmd_present(*pmdp));
>> +	/* Below assumes pmd_present() is true */
>> +	VM_BUG_ON(!pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
> 
> This is not a complex condition.  We're in the huge PMD handling case
> and we're looking at a PMD which either isn't present or isn't huge.
> It might be useful to print out the PMD in such a case, but splitting
> this into the two cases of pmd-not-present and pmd-isn't-huge isn't
> particularly useful.
> 

Many thanks for your time. You are right that it would be more helpful if we
had a VM_BUG_ON_PMD() that we could print the pmd's value and permit diagnosis
from that. I think splitting this into the two cases is the best we can do now
while lacking of such helper.

> I think you know that, or you wouldn't feel the need to put in a
> comment explaining it!
> .
> 

Thanks again.
