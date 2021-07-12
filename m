Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846FF3C5B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbhGLLVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:21:25 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:11263 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbhGLLTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:19:38 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GNh0J6FPSz1CJ2k;
        Mon, 12 Jul 2021 19:11:12 +0800 (CST)
Received: from [10.174.178.125] (10.174.178.125) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 12 Jul 2021 19:16:47 +0800
Subject: Re: [PATCH 5/5] mm/vmscan: fix misleading comment in
 isolate_lru_pages()
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <vbabka@suse.cz>, <axboe@kernel.dk>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <apopple@nvidia.com>, <willy@infradead.org>,
        <minchan@kernel.org>, <david@redhat.com>, <shli@fb.com>,
        <hillf.zj@alibaba-inc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210710100329.49174-1-linmiaohe@huawei.com>
 <20210710100329.49174-6-linmiaohe@huawei.com>
 <YOvvFaYMBhISeGEI@dhcp22.suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ed30bbc5-8438-d399-a9ef-462eda1b6d4e@huawei.com>
Date:   Mon, 12 Jul 2021 19:16:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YOvvFaYMBhISeGEI@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/12 15:28, Michal Hocko wrote:
> On Sat 10-07-21 18:03:29, Miaohe Lin wrote:
>> We couldn't know whether the page is being freed elsewhere until we failed
>> to increase the page count.
> 
> This is moving a hard to understand comment from one place to another.

If get_page_unless_zero failed, the page could have been freed elsewhere. I think
this looks straightforward but doesn't help a lot. Are you preferring to just
remove this comment ?

Thank you.

> If anything this would benefit from what that elsewhere might be
> typically or simply drop the comment altogether.
> 
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/vmscan.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index a74760c48bd8..6e26b3c93242 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1891,7 +1891,6 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>>  		 */
>>  		scan += nr_pages;
>>  		if (!__isolate_lru_page_prepare(page, mode)) {
>> -			/* It is being freed elsewhere */
>>  			list_move(&page->lru, src);
>>  			continue;
>>  		}
>> @@ -1901,6 +1900,7 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>>  		 * page release code relies on it.
>>  		 */
>>  		if (unlikely(!get_page_unless_zero(page))) {
>> +			/* It is being freed elsewhere. */
>>  			list_move(&page->lru, src);
>>  			continue;
>>  		}
>> -- 
>> 2.23.0
> 

