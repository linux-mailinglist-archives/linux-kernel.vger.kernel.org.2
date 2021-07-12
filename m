Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94C53C5B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhGLLM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:12:56 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:11262 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbhGLLMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:12:55 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GNgrX6KKwz1CJ5j;
        Mon, 12 Jul 2021 19:04:28 +0800 (CST)
Received: from [10.174.178.125] (10.174.178.125) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 12 Jul 2021 19:10:03 +0800
Subject: Re: [PATCH 2/5] mm/vmscan: remove misleading setting to sc->priority
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <vbabka@suse.cz>, <axboe@kernel.dk>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <apopple@nvidia.com>, <willy@infradead.org>,
        <minchan@kernel.org>, <david@redhat.com>, <shli@fb.com>,
        <hillf.zj@alibaba-inc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210710100329.49174-1-linmiaohe@huawei.com>
 <20210710100329.49174-3-linmiaohe@huawei.com>
 <YOvuKZ4kZ/1BJ5VC@dhcp22.suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <af188933-9677-c733-00f4-1d042425522f@huawei.com>
Date:   Mon, 12 Jul 2021 19:10:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YOvuKZ4kZ/1BJ5VC@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/12 15:24, Michal Hocko wrote:
> On Sat 10-07-21 18:03:26, Miaohe Lin wrote:
>> The priority field of sc is used to control how many pages we should scan
>> at once while we always traverse the list to shrink the pages in these
>> functions. So these settings are unneeded and misleading.
> 
> I dunno. I agree that priority is not really used as these operate on
> page lists but I am not sure this is worth touching.

When I investigated the vmscan code, I thought the order here would control the
proportion of the pages in the list to shrink. So I prefer to remove these.

Thanks a lot for review and reply!

> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/vmscan.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 6483fe0e2065..fbe53e60b248 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1702,7 +1702,6 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>>  {
>>  	struct scan_control sc = {
>>  		.gfp_mask = GFP_KERNEL,
>> -		.priority = DEF_PRIORITY,
>>  		.may_unmap = 1,
>>  	};
>>  	struct reclaim_stat stat;
>> @@ -2327,7 +2326,6 @@ unsigned long reclaim_pages(struct list_head *page_list)
>>  	unsigned int noreclaim_flag;
>>  	struct scan_control sc = {
>>  		.gfp_mask = GFP_KERNEL,
>> -		.priority = DEF_PRIORITY,
>>  		.may_writepage = 1,
>>  		.may_unmap = 1,
>>  		.may_swap = 1,
>> -- 
>> 2.23.0
> 

