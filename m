Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9B7359608
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhDIHHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:07:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16428 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhDIHHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:07:17 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGpzv1r3pzlWvJ;
        Fri,  9 Apr 2021 15:05:15 +0800 (CST)
Received: from [10.174.179.9] (10.174.179.9) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 15:07:01 +0800
Subject: Re: [PATCH 4/4] mm/hugeltb: handle the error case in
 hugetlb_fix_reserve_counts()
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        <n-horiguchi@ah.jp.nec.com>, <hillf.zj@alibaba-inc.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210402093249.25137-1-linmiaohe@huawei.com>
 <20210402093249.25137-5-linmiaohe@huawei.com>
 <a61335c2-c6ab-6169-012c-5b5d2d9499da@oracle.com>
 <fe37dcbd-5604-8b43-c184-b7d991b16de8@huawei.com>
 <20210408220453.f95942bf20baadd8dbbc1488@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <bc24856e-78ca-b44a-bf33-4b540720f72a@huawei.com>
Date:   Fri, 9 Apr 2021 15:07:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210408220453.f95942bf20baadd8dbbc1488@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/9 13:04, Andrew Morton wrote:
> On Fri, 9 Apr 2021 11:17:49 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> On 2021/4/9 7:25, Mike Kravetz wrote:
>>> On 4/2/21 2:32 AM, Miaohe Lin wrote:
>>>> A rare out of memory error would prevent removal of the reserve map region
>>>> for a page. hugetlb_fix_reserve_counts() handles this rare case to avoid
>>>> dangling with incorrect counts. Unfortunately, hugepage_subpool_get_pages
>>>> and hugetlb_acct_memory could possibly fail too. We should correctly handle
>>>> these cases.
>>>
>>> Yes, this is a potential issue.
>>>
>>> The 'good news' is that hugetlb_fix_reserve_counts() is unlikely to ever
>>> be called.  To do so would imply we could not allocate a region entry
>>> which is only 6 words in size.  We also keep a 'cache' of entries so we
>>> may not even need to allocate.
>>>
>>> But, as mentioned it is a potential issue.
>>
>> Yes, a potential *theoretical* issue.
>>
>>>
>>>> Fixes: b5cec28d36f5 ("hugetlbfs: truncate_hugepages() takes a range of pages")
>>>
>>> This is likely going to make this get picked by by stable releases.
>>> That is unfortunate as mentioned above this is mostly theoretical.
>>>
>>
>> I will drop this. This does not worth backport.
>>
> 
> -stable have been asked not to backport MM patches unless MM patches
> include "cc:stable".  ie, no making our backporting decisions for us,
> please.
> 

Sorry about it! I would retain the Fixes tag.
Many thanks for pointing this out.

> .
> 
