Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1525A419040
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhI0Hzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:55:40 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:21356 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhI0Hzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:55:37 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HHvtG4Pw1zRG6N;
        Mon, 27 Sep 2021 15:49:42 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 15:53:48 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 15:53:47 +0800
Subject: Re: [PATCH resend] slub: Add back check for free nonslab objects
To:     Vlastimil Babka <vbabka@suse.cz>, <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210927021538.155991-1-wangkefeng.wang@huawei.com>
 <566f2009-6acf-4fb9-f7c0-edc1d6ce6561@suse.cz>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <73b662cc-ab1f-b3bf-468a-4cd744e92d71@huawei.com>
Date:   Mon, 27 Sep 2021 15:53:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <566f2009-6acf-4fb9-f7c0-edc1d6ce6561@suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/9/27 15:22, Vlastimil Babka wrote:
> On 9/27/21 04:15, Kefeng Wang wrote:
>> After commit ("f227f0faf63b slub: fix unreclaimable slab stat for bulk
>> free"), the check for free nonslab page is replaced by VM_BUG_ON_PAGE,
>> which only check with CONFIG_DEBUG_VM enabled, but this config may
>> impact performance, so it only for debug.
>>
>> Commit ("0937502af7c9 slub: Add check for kfree() of non slab objects.")
>> add the ability, which should be needed in any configs to catch the
>> invalid free, they even could be potential issue, eg, memory corruption,
>> use after free and double-free, so replace VM_BUG_ON_PAGE to WARN_ON, and
>> add dump_page() to help use to debug the issue.
> There are other situations in SLUB (such as with smaller allocations that
> don't go directly to page allocator) where use after free and double-free
> are undetected in non-debug configs, and it's expected that anyone debugging
> them will enable slub_debug or even DEBUG_VM. Why should this special case
> with nonslab pages be different?

I want the check back in kfree, this one is used  widely in driver, and 
the probability

of problem occurred is bigger in driver, especially in some out of tree 
drivers.

>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   mm/slub.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 3095b889fab4..555c2e6ccfca 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3522,7 +3522,8 @@ static inline void free_nonslab_page(struct page *page, void *object)
>>   {
>>   	unsigned int order = compound_order(page);
>>   
>> -	VM_BUG_ON_PAGE(!PageCompound(page), page);
>> +	if (WARN_ON(!PageCompound(page)))
>> +		dump_page(page, "invalid free nonslab page");
>>   	kfree_hook(object);
>>   	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B, -(PAGE_SIZE << order));
>>   	__free_pages(page, order);
>>
> .
>
