Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35D933A96C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 02:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhCOBur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 21:50:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13531 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhCOBu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 21:50:28 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DzK7P1ypvzNmsd;
        Mon, 15 Mar 2021 09:48:01 +0800 (CST)
Received: from [10.174.177.131] (10.174.177.131) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Mon, 15 Mar 2021 09:50:22 +0800
Subject: Re: [PATCH 5/5] mm/hugetlb: avoid calculating fault_mutex_hash in
 truncate_op case
To:     Mike Kravetz <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210308112809.26107-1-linmiaohe@huawei.com>
 <20210308112809.26107-6-linmiaohe@huawei.com>
 <2baf9a1b-1c69-8168-cfd9-5b5ad45a4cc8@oracle.com>
 <d40df812-7b02-78fd-65d4-41bbcc9d4c6d@huawei.com>
 <9f385943-4038-f457-c742-30982b8b7d5d@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <cc54508f-4feb-1ef6-c33d-5b2c9fcd99d1@huawei.com>
Date:   Mon, 15 Mar 2021 09:50:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <9f385943-4038-f457-c742-30982b8b7d5d@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.131]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/14 5:17, Mike Kravetz wrote:
> On 3/12/21 6:49 PM, Miaohe Lin wrote:
>> Hi:
>> On 2021/3/13 4:03, Mike Kravetz wrote:
>>> On 3/8/21 3:28 AM, Miaohe Lin wrote:
>>>> The fault_mutex hashing overhead can be avoided in truncate_op case because
>>>> page faults can not race with truncation in this routine. So calculate hash
>>>> for fault_mutex only in !truncate_op case to save some cpu cycles.
>>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>  fs/hugetlbfs/inode.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>>>> index c262566f7c5d..d81f52b87bd7 100644
>>>> --- a/fs/hugetlbfs/inode.c
>>>> +++ b/fs/hugetlbfs/inode.c
>>>> @@ -482,10 +482,9 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>>>>  
>>>>  		for (i = 0; i < pagevec_count(&pvec); ++i) {
>>>>  			struct page *page = pvec.pages[i];
>>>> -			u32 hash;
>>>> +			u32 hash = 0;
>>>
>>> Do we need to initialize hash here?
>>> I would not bring this up normally, but the purpose of the patch is to save
>>> cpu cycles.
>>
>> The hash is initialized here in order to avoid false positive
>> "uninitialized local variable used" warning. Or this is indeed unnecessary?
>>
> 
> Of course.  In this case we know more about usage then the compiler.
> You can add:
> 

I see. Many thanks. Am I supposed to resend the whole v2 patch series ? Or just a single v2 patch with change mentioned above?
Please let me know which is the easiest one for you.

> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>
