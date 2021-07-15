Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0A93C9EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 14:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbhGOMr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:47:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:15022 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhGOMr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:47:56 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GQYsL4bDXzbcyL;
        Thu, 15 Jul 2021 20:41:42 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 20:45:00 +0800
Received: from [10.174.179.191] (10.174.179.191) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 20:45:00 +0800
Subject: Re: [PATCH] mm/vmalloc: fix wrong behavior in vread
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     <akpm@linux-foundation.org>, <serapheim.dimitro@delphix.com>,
        <wangkefeng.wang@huawei.com>, <weiyongjun1@huawei.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
References: <20210714015959.3204871-1-chenwandun@huawei.com>
 <20210715105813.GA1879@pc638.lan>
From:   Chen Wandun <chenwandun@huawei.com>
Message-ID: <8ece1d71-5b0d-331a-a170-0d5e8cdbedae@huawei.com>
Date:   Thu, 15 Jul 2021 20:44:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715105813.GA1879@pc638.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.191]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/15 18:58, Uladzislau Rezki 写道:
> On Wed, Jul 14, 2021 at 09:59:59AM +0800, Chen Wandun wrote:
>> commit f608788cd2d6 ("mm/vmalloc: use rb_tree instead of list for vread()
>> lookups") use rb_tree instread of list to speed up lookup, but function
>> __find_vmap_area is try to find a vmap_area that include target address,
>> if target address is smaller than the leftmost node in vmap_area_root,
>> it will return NULL, then vread will read nothing. This behavior is
>> different from the primitive semantics.
>>
>> The correct way is find the first vmap_are that bigger than target addr,
>> that is what function find_vmap_area_exceed_addr does.
>>
>> Fixes: f608788cd2d6 ("mm/vmalloc: use rb_tree instead of list for vread() lookups")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
>> ---
>>   mm/vmalloc.c | 29 ++++++++++++++++++++++++++++-
>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index d5cd52805149..47c3a551b6dc 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -787,6 +787,28 @@ unsigned long vmalloc_nr_pages(void)
>>   	return atomic_long_read(&nr_vmalloc_pages);
>>   }
>>   
>> +static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr)
>> +{
>> +	struct vmap_area *va = NULL;
>> +	struct rb_node *n = vmap_area_root.rb_node;
>> +
>> +	while (n) {
>> +		struct vmap_area *tmp;
>> +
>> +		tmp = rb_entry(n, struct vmap_area, rb_node);
>> +		if (tmp->va_end > addr) {
>> +			va = tmp;
>> +			if (tmp->va_start <= addr)
>> +				break;
>> +
>> +			n = n->rb_left;
>> +		} else
>> +			n = n->rb_right;
>> +	}
>> +
>> +	return va;
>> +}
>> +
> Can we combine pvm_find_va_enclose_addr() with your new function
> making it as one function? The aim is to reduce copy-paste and
> not create such new "find" functions.
>
> The pvm_find_va_enclose_addr() seems does the same but only in
> reverse order. So something like:
>
> find_vmap_area_exceed_addr(bool reverse)

I dig into the two function, and found the lookup logic is some big difference between them.

pvm_find_va_enclose_addr is to find the highest vmap_area whose va_start is little than target address.

find_vmap_area_exceed_addr is to find the lowest vmap_area whose va_end that bigger than target address.

Two function maybe more clear.

But some refactor work can be done to make the code more readable and more common to use, I'm trying it.


Thanks for your suggestion.

Wandun


>
> Thanks!
>
> --
> Vlad Rezki
> .
