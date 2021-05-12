Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554D437B477
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhELDYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:24:36 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2362 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELDYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:24:35 -0400
Received: from dggeml717-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fg0Qq4N9Fz60XX;
        Wed, 12 May 2021 11:20:03 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggeml717-chm.china.huawei.com (10.3.17.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 12 May 2021 11:23:25 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 12 May 2021 11:23:25 +0800
Subject: Re: [PATCH 3/3] mm/debug: Check page poisoned firstly in dump_page()
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210512031057.13580-1-wangkefeng.wang@huawei.com>
 <20210512031057.13580-3-wangkefeng.wang@huawei.com>
 <YJtIRR2NfpRtYQrG@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <b6fb5bd9-8508-b180-3856-1be4b91b2825@huawei.com>
Date:   Wed, 12 May 2021 11:23:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YJtIRR2NfpRtYQrG@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/12 11:15, Matthew Wilcox wrote:
> On Wed, May 12, 2021 at 11:10:57AM +0800, Kefeng Wang wrote:
>> If page is poisoned, it will crash when we call some page related
>> functions, so must check whether the page is poisoned or not firstly.
> 
> https://lore.kernel.org/linux-mm/20210430145549.2662354-4-willy@infradead.org/

OK, please ignore them, I found this when debug arm issue in lts5.10, 
thanks.

> 
>> Fixes: 6197ab984b41 ("mm: improve dump_page() for compound pages")
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   mm/debug.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/debug.c b/mm/debug.c
>> index 84cdcd0f7bd3..cf84cd9df527 100644
>> --- a/mm/debug.c
>> +++ b/mm/debug.c
>> @@ -44,20 +44,19 @@ const struct trace_print_flags vmaflag_names[] = {
>>   
>>   static void __dump_page(struct page *page, const char *reason)
>>   {
>> -	struct page *head = compound_head(page);
>> +	struct page *head = NULL;
>>   	struct address_space *mapping;
>> -	bool page_poisoned = PagePoisoned(page);
>> -	bool compound = PageCompound(page);
>> +	bool compound;
>>   	/*
>>   	 * Accessing the pageblock without the zone lock. It could change to
>>   	 * "isolate" again in the meantime, but since we are just dumping the
>>   	 * state for debugging, it should be fine to accept a bit of
>>   	 * inaccuracy here due to racing.
>>   	 */
>> -	bool page_cma = is_migrate_cma_page(page);
>> +	bool page_cma;
>>   	int mapcount;
>>   	char *type = "";
>> -
>> +	bool page_poisoned = PagePoisoned(page);
>>   	/*
>>   	 * If struct page is poisoned don't access Page*() functions as that
>>   	 * leads to recursive loop. Page*() check for poisoned pages, and calls
>> @@ -68,6 +67,10 @@ static void __dump_page(struct page *page, const char *reason)
>>   		goto hex_only;
>>   	}
>>   
>> +	head = compound_head(page);
>> +	page_poisoned = PagePoisoned(page);
>> +	page_cma = is_migrate_cma_page(page);
>> +
>>   	if (page < head || (page >= head + MAX_ORDER_NR_PAGES)) {
>>   		/*
>>   		 * Corrupt page, so we cannot call page_mapping. Instead, do a
>> @@ -178,7 +181,7 @@ static void __dump_page(struct page *page, const char *reason)
>>   	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
>>   			sizeof(unsigned long), page,
>>   			sizeof(struct page), false);
>> -	if (head != page)
>> +	if (head && head != page)
>>   		print_hex_dump(KERN_WARNING, "head: ", DUMP_PREFIX_NONE, 32,
>>   			sizeof(unsigned long), head,
>>   			sizeof(struct page), false);
>> -- 
>> 2.26.2
>>
>>
> .
> 
