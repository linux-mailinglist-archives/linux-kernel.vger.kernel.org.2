Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26513D5229
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 06:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhGZDZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 23:25:18 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12307 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhGZDZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 23:25:17 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GY5nX0b6Sz7x8t;
        Mon, 26 Jul 2021 12:01:04 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 12:05:45 +0800
Received: from [10.174.179.191] (10.174.179.191) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 12:05:44 +0800
Subject: Re: [PATCH] mm/vmalloc: add missing __GFP_HIGHMEM flag for vmalloc
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <weiyongjun1@huawei.com>
References: <20210726032333.3404164-1-chenwandun@huawei.com>
 <YP4rM7qtSet+H+nG@casper.infradead.org>
From:   Chen Wandun <chenwandun@huawei.com>
Message-ID: <f064b046-8831-2aa9-2234-63e867e28dc1@huawei.com>
Date:   Mon, 26 Jul 2021 12:05:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YP4rM7qtSet+H+nG@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.191]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/26 11:25, Matthew Wilcox 写道:
> On Mon, Jul 26, 2021 at 11:23:33AM +0800, Chen Wandun wrote:
>> struct page array can also be allocated in highmem during vmalloc,
>> that will ease the low memory stress in 32bit system.
> Huh?  Where does it get kmapped in order to access it?

The struct page array contain numbers of pointer of struct page, it is used to save

pages that allocated for vmalloc mapping in vmap_pages_range, it does't need to kmap.


The main idea of this patch is come from:

https://lore.kernel.org/lkml/20170307141020.29107-1-mhocko@kernel.org/

>
>> Fixes: f255935b9767 ("mm: cleanup the gfp_mask handling in __vmalloc_area_node")
>> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
>> ---
>>   mm/vmalloc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 3824dc16ce1c..8d9b0b08a6dc 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -2885,7 +2885,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>>   
>>   	/* Please note that the recursion is strictly bounded. */
>>   	if (array_size > PAGE_SIZE) {
>> -		area->pages = __vmalloc_node(array_size, 1, nested_gfp, node,
>> +		area->pages = __vmalloc_node(array_size, 1,
>> +					nested_gfp | __GFP_HIGHMEM, node,
>>   					area->caller);
>>   	} else {
>>   		area->pages = kmalloc_node(array_size, nested_gfp, node);
>> -- 
>> 2.25.1
>>
>>
> .
