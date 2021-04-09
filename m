Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140C93592EC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhDIDSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:18:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15634 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhDIDSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:18:06 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGjtK2qtvznZ6Q;
        Fri,  9 Apr 2021 11:15:05 +0800 (CST)
Received: from [10.174.179.9] (10.174.179.9) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 11:17:49 +0800
Subject: Re: [PATCH 4/4] mm/hugeltb: handle the error case in
 hugetlb_fix_reserve_counts()
To:     Mike Kravetz <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
CC:     <n-horiguchi@ah.jp.nec.com>, <hillf.zj@alibaba-inc.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210402093249.25137-1-linmiaohe@huawei.com>
 <20210402093249.25137-5-linmiaohe@huawei.com>
 <a61335c2-c6ab-6169-012c-5b5d2d9499da@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <fe37dcbd-5604-8b43-c184-b7d991b16de8@huawei.com>
Date:   Fri, 9 Apr 2021 11:17:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <a61335c2-c6ab-6169-012c-5b5d2d9499da@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/9 7:25, Mike Kravetz wrote:
> On 4/2/21 2:32 AM, Miaohe Lin wrote:
>> A rare out of memory error would prevent removal of the reserve map region
>> for a page. hugetlb_fix_reserve_counts() handles this rare case to avoid
>> dangling with incorrect counts. Unfortunately, hugepage_subpool_get_pages
>> and hugetlb_acct_memory could possibly fail too. We should correctly handle
>> these cases.
> 
> Yes, this is a potential issue.
> 
> The 'good news' is that hugetlb_fix_reserve_counts() is unlikely to ever
> be called.  To do so would imply we could not allocate a region entry
> which is only 6 words in size.  We also keep a 'cache' of entries so we
> may not even need to allocate.
> 
> But, as mentioned it is a potential issue.

Yes, a potential *theoretical* issue.

> 
>> Fixes: b5cec28d36f5 ("hugetlbfs: truncate_hugepages() takes a range of pages")
> 
> This is likely going to make this get picked by by stable releases.
> That is unfortunate as mentioned above this is mostly theoretical.
> 

I will drop this. This does not worth backport.

>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/hugetlb.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index bdff8d23803f..ca5464ed04b7 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -745,13 +745,20 @@ void hugetlb_fix_reserve_counts(struct inode *inode)
>>  {
>>  	struct hugepage_subpool *spool = subpool_inode(inode);
>>  	long rsv_adjust;
>> +	bool reserved = false;
>>  
>>  	rsv_adjust = hugepage_subpool_get_pages(spool, 1);
>> -	if (rsv_adjust) {
>> +	if (rsv_adjust > 0) {
>>  		struct hstate *h = hstate_inode(inode);
>>  
>> -		hugetlb_acct_memory(h, 1);
>> +		if (!hugetlb_acct_memory(h, 1))
>> +			reserved = true;
>> +	} else if (!rsv_adjust) {
>> +		reserved = true;
>>  	}
>> +
>> +	if (!reserved)
>> +		pr_warn("hugetlb: fix reserve count failed\n");
> 
> We should expand this warning message a bit to indicate what this may
> mean to the user.  Add something like"
> 	"Huge Page Reserved count may go negative".
> 

Will add it in v2. Many thanks for review and nice suggestion ! :)
