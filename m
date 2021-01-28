Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF596306ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 02:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhA1Bz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 20:55:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11204 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhA1Bzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:55:40 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DR3Qc2hXHzlBX4;
        Thu, 28 Jan 2021 09:53:12 +0800 (CST)
Received: from [10.174.179.117] (10.174.179.117) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Thu, 28 Jan 2021 09:54:41 +0800
Subject: Re: [PATCH] mm/rmap: Fix potential pte_unmap on an not mapped pte
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <shakeelb@google.com>,
        <hannes@cmpxchg.org>, <vbabka@suse.cz>, <walken@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210127093349.39081-1-linmiaohe@huawei.com>
 <20210127160921.989f01c83d6703148f6bc316@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3f924e26-57f3-863e-435f-115dbdf01ffc@huawei.com>
Date:   Thu, 28 Jan 2021 09:54:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210127160921.989f01c83d6703148f6bc316@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/1/28 8:09, Andrew Morton wrote:
> On Wed, 27 Jan 2021 04:33:49 -0500 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> For PMD-mapped page (usually THP), pvmw->pte is NULL. For PTE-mapped THP,
>> pvmw->pte is mapped. But for HugeTLB pages, pvmw->pte is not mapped and set
>> to the relevant page table entry. So in page_vma_mapped_walk_done(), we may
>> do pte_unmap() for HugeTLB pte which is not mapped. Fix this by checking
>> pvmw->page against PageHuge before trying to do pte_unmap().
>>
> 
> What are the runtime consequences of this?  Is there a workload which
> is known to trigger it?
> 

Not yet. This should not be backported. My bad. Sorry about it.

> IOW, how do we justify a -stable backport of this fix?
> >>
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -213,7 +213,8 @@ struct page_vma_mapped_walk {
>>  
>>  static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
>>  {
>> -	if (pvmw->pte)
>> +	/* HugeTLB pte is set to the relevant page table entry without pte_mapped. */
>> +	if (pvmw->pte && !PageHuge(pvmw->page))
>>  		pte_unmap(pvmw->pte);
>>  	if (pvmw->ptl)
>>  		spin_unlock(pvmw->ptl);
>> -- 
>> 2.19.1
> .
> 

