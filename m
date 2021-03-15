Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C8C33A985
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 03:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhCOCEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 22:04:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14335 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhCOCEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 22:04:38 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DzKSF3ByZz8yPD;
        Mon, 15 Mar 2021 10:02:37 +0800 (CST)
Received: from [10.174.177.131] (10.174.177.131) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Mon, 15 Mar 2021 10:04:24 +0800
Subject: Re: [PATCH 1/6] mm/huge_memory.c: rework the function
 vma_adjust_trans_huge()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <ziy@nvidia.com>,
        <william.kucharski@oracle.com>, <vbabka@suse.cz>,
        <richard.weiyang@linux.alibaba.com>, <peterx@redhat.com>,
        <anshuman.khandual@arm.com>, <thomas_os@shipmail.org>,
        <rcampbell@nvidia.com>, <aneesh.kumar@linux.ibm.com>,
        <yang.shi@linux.alibaba.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210313103225.16607-1-linmiaohe@huawei.com>
 <20210313103225.16607-2-linmiaohe@huawei.com>
 <20210313200359.GL2577561@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <641f4d6d-97d2-63a8-c61b-a42f71dcba6c@huawei.com>
Date:   Mon, 15 Mar 2021 10:04:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210313200359.GL2577561@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.131]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/3/14 4:03, Matthew Wilcox wrote:
> On Sat, Mar 13, 2021 at 05:32:19AM -0500, Miaohe Lin wrote:
>> +static inline void try_to_split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address)
>> +{
>> +	if (address & ~HPAGE_PMD_MASK &&
>> +	    range_in_vma(vma, address & HPAGE_PMD_MASK,
>> +			 (address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE))
>> +		split_huge_pmd_address(vma, address, false, NULL);
>> +}
> 
> This isn't "try to split".  This is "split if needed".  I think the
> comments also need to be moved up here.
> 

Make sense. Would do it in v2! Thanks!

> I'm not even sure this is really an improvement.
> .
> 

At least we can eliminate a couple of duplicated lines and use helper range_in_vma() to improve
the readability slightly. Right? :)
