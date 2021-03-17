Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D6433E6B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 03:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCQCTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 22:19:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13972 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCQCSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 22:18:48 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F0Ygn1xNBzrXbV;
        Wed, 17 Mar 2021 10:16:53 +0800 (CST)
Received: from [10.174.177.131] (10.174.177.131) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 10:18:41 +0800
Subject: Re: [PATCH v2 1/6] mm/huge_memory.c: rework the function
 vma_adjust_trans_huge()
To:     Peter Xu <peterx@redhat.com>
CC:     <akpm@linux-foundation.org>, <ziy@nvidia.com>,
        <willy@infradead.org>, <william.kucharski@oracle.com>,
        <vbabka@suse.cz>, <yulei.kernel@gmail.com>, <walken@google.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <thomas_os@shipmail.org>, <yang.shi@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210316124007.20474-1-linmiaohe@huawei.com>
 <20210316124007.20474-2-linmiaohe@huawei.com> <20210316204034.GE395976@xz-x1>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f4bc08ee-36a0-0018-251b-16399a3182ad@huawei.com>
Date:   Wed, 17 Mar 2021 10:18:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210316204034.GE395976@xz-x1>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.131]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/3/17 4:40, Peter Xu wrote:
> On Tue, Mar 16, 2021 at 08:40:02AM -0400, Miaohe Lin wrote:
>> +static inline void split_huge_pmd_if_needed(struct vm_area_struct *vma, unsigned long address)
>> +{
>> +	/*
>> +	 * If the new address isn't hpage aligned and it could previously
>> +	 * contain an hugepage: check if we need to split an huge pmd.
>> +	 */
>> +	if (address & ~HPAGE_PMD_MASK &&
>> +	    range_in_vma(vma, address & HPAGE_PMD_MASK,
>> +			 (address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE))
> 
> Since you're at it, maybe use ALIGN/ALIGN_DOWN too against HPAGE_PMD_SIZE?
> 

Many thanks for reply. Sounds good. :) Do you mean this?

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bff92dea5ab3..ae16a82da823 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2301,44 +2301,38 @@ void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
        __split_huge_pmd(vma, pmd, address, freeze, page);
 }

+static inline void split_huge_pmd_if_needed(struct vm_area_struct *vma, unsigned long address)
+{
+       /*
+        * If the new address isn't hpage aligned and it could previously
+        * contain an hugepage: check if we need to split an huge pmd.
+        */
+       if (!IS_ALIGNED(address, HPAGE_PMD_SIZE) &&
+           range_in_vma(vma, ALIGN_DOWN(address, HPAGE_PMD_SIZE),
+                        ALIGN(address, HPAGE_PMD_SIZE)))
+               split_huge_pmd_address(vma, address, false, NULL);
+}
+

>> +		split_huge_pmd_address(vma, address, false, NULL);
>> +}
>
