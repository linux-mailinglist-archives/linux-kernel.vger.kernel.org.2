Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D488F36D403
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbhD1Ic6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:32:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16493 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbhD1Ic5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:32:57 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FVWyb4ZDDzvSYG;
        Wed, 28 Apr 2021 16:29:43 +0800 (CST)
Received: from [10.174.176.174] (10.174.176.174) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 28 Apr 2021 16:32:06 +0800
Subject: Re: [PATCH 0/5] Cleanup and fixup for huge_memory
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <william.kucharski@oracle.com>,
        <willy@infradead.org>, <yang.shi@linux.alibaba.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <songliubraving@fb.com>, <kirill.shutemov@linux.intel.com>,
        <riel@surriel.com>, <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210427133214.2270207-1-linmiaohe@huawei.com>
 <1d86c821-89f6-cc46-ceb4-fac7748212e5@arm.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a4e851c9-9754-dd2a-c7a4-37bbefca704a@huawei.com>
Date:   Wed, 28 Apr 2021 16:32:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1d86c821-89f6-cc46-ceb4-fac7748212e5@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/28 11:10, Anshuman Khandual wrote:
> 
> 
> On 4/27/21 7:02 PM, Miaohe Lin wrote:
>> Hi all,
>> This series contains cleanups to remove dedicated macro and remove
>> unnecessary tlb_remove_page_size() for huge zero pmd. Also this adds
>> missing read-only THP checking for transparent_hugepage_enabled() and
>> avoids discarding hugepage if other processes are mapping it. More
>> details can be found in the respective changelogs. Thanks!
>>
>> Miaohe Lin (5):
>>   mm/huge_memory.c: remove dedicated macro HPAGE_CACHE_INDEX_MASK
>>   mm/huge_memory.c: use page->deferred_list
>>   mm/huge_memory.c: add missing read-only THP checking in
>>     transparent_hugepage_enabled()
>>   mm/huge_memory.c: remove unnecessary tlb_remove_page_size() for huge
>>     zero pmd
>>   mm/huge_memory.c: don't discard hugepage if other processes are
>>     mapping it
> 
> I guess it might be just better to split the series into cleans-ups
> without functional change and then fixes separately.

Sounds reasonable. But IMO all of these changes are pretty simple and independent,
maybe it's ok to keep these together?

Many thanks for comment.

> .
> 

