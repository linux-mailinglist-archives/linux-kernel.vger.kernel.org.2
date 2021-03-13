Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AC4339B64
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 03:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhCMCuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 21:50:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13889 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCMCtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 21:49:36 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Dy6Y921MKz8xKG;
        Sat, 13 Mar 2021 10:47:41 +0800 (CST)
Received: from [10.174.179.232] (10.174.179.232) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 13 Mar 2021 10:49:26 +0800
Subject: Re: [PATCH 5/5] mm/hugetlb: avoid calculating fault_mutex_hash in
 truncate_op case
To:     Mike Kravetz <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210308112809.26107-1-linmiaohe@huawei.com>
 <20210308112809.26107-6-linmiaohe@huawei.com>
 <2baf9a1b-1c69-8168-cfd9-5b5ad45a4cc8@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d40df812-7b02-78fd-65d4-41bbcc9d4c6d@huawei.com>
Date:   Sat, 13 Mar 2021 10:49:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2baf9a1b-1c69-8168-cfd9-5b5ad45a4cc8@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.232]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/3/13 4:03, Mike Kravetz wrote:
> On 3/8/21 3:28 AM, Miaohe Lin wrote:
>> The fault_mutex hashing overhead can be avoided in truncate_op case because
>> page faults can not race with truncation in this routine. So calculate hash
>> for fault_mutex only in !truncate_op case to save some cpu cycles.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  fs/hugetlbfs/inode.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index c262566f7c5d..d81f52b87bd7 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -482,10 +482,9 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>>  
>>  		for (i = 0; i < pagevec_count(&pvec); ++i) {
>>  			struct page *page = pvec.pages[i];
>> -			u32 hash;
>> +			u32 hash = 0;
> 
> Do we need to initialize hash here?
> I would not bring this up normally, but the purpose of the patch is to save
> cpu cycles.

The hash is initialized here in order to avoid false positive
"uninitialized local variable used" warning. Or this is indeed unnecessary?

Many thanks for review.

> 

