Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1E73120DC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 03:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhBGCVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 21:21:22 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12079 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhBGCVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 21:21:19 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DYCWY749czMWBZ;
        Sun,  7 Feb 2021 10:18:49 +0800 (CST)
Received: from [10.174.179.149] (10.174.179.149) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 10:20:28 +0800
Subject: Re: [PATCH] mm/hugetlb: use helper huge_page_size() to simplify the
 hugetlb_vm_op_pagesize()
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210205092209.16024-1-linmiaohe@huawei.com>
 <2743477c-a256-0295-884d-5354c634508d@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <82eecd04-c669-7697-a593-30aedae94a3b@huawei.com>
Date:   Sun, 7 Feb 2021 10:20:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2743477c-a256-0295-884d-5354c634508d@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/6 0:12, David Hildenbrand wrote:
> On 05.02.21 10:22, Miaohe Lin wrote:
>> We can use helper huge_page_size() to get the size of the pages allocated
>> when backing a VMA directly to make the code more simplified.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   mm/hugetlb.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 18628f8dbfb0..3eea2a34d9f5 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3647,9 +3647,7 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
>>     static unsigned long hugetlb_vm_op_pagesize(struct vm_area_struct *vma)
>>   {
>> -    struct hstate *hstate = hstate_vma(vma);
>> -
>> -    return 1UL << huge_page_shift(hstate);
>> +    return huge_page_size(hstate_vma(vma));
>>   }
> 
> Maybe it makes sense to squash all of these individual patches you send that do the same things/perform the same cleanups. Shouldn't be to hard to identify all these cases using simple "git grep".
> 

Many thanks for your advice. I'am studying the mm code and find these cleanups when I come across these code.
I postponed these cleanups but forgot trying to squash the patches that do the same things. I would try to
identify all the same cases using "git grep" rather than relying on code review.

> Makes life of reviewers and maintainers easier ...
> 

My bad. Sorry.

> 

Thanks again.
