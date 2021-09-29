Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C2B41BC82
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 03:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243695AbhI2CAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 22:00:50 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:22381 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243628AbhI2CAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 22:00:45 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HJzvp31LszRfdL;
        Wed, 29 Sep 2021 09:54:46 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 29 Sep 2021 09:59:03 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 29 Sep 2021 09:59:02 +0800
Message-ID: <285af4a7-0053-b3e3-1cf0-2ed481210271@huawei.com>
Date:   Wed, 29 Sep 2021 09:59:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2] slub: Add back check for free nonslab objects
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>
CC:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        "Pekka Enberg" <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>
References: <20210927122646.91934-1-wangkefeng.wang@huawei.com>
 <CALvZod568vL3Eg54srOKVg+TMtuPpLJhxbqGi7HS2oaMLUXvAQ@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CALvZod568vL3Eg54srOKVg+TMtuPpLJhxbqGi7HS2oaMLUXvAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/28 23:09, Shakeel Butt wrote:
> On Mon, Sep 27, 2021 at 5:24 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>> After commit ("f227f0faf63b slub: fix unreclaimable slab stat for bulk
>> free"), the check for free nonslab page is replaced by VM_BUG_ON_PAGE,
>> which only check with CONFIG_DEBUG_VM enabled, but this config may
>> impact performance, so it only for debug.
>>
>> Commit ("0937502af7c9 slub: Add check for kfree() of non slab objects.")
>> add the ability, which should be needed in any configs to catch the
>> invalid free, they even could be potential issue, eg, memory corruption,
>> use after free and double-free, so replace VM_BUG_ON_PAGE to WARN_ON, add
>> dump_page() and object address printing to help use to debug the issue.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>> v2: Add object address printing suggested by Matthew Wilcox
>>
>>   mm/slub.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 3095b889fab4..157973e22faf 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3522,7 +3522,11 @@ static inline void free_nonslab_page(struct page *page, void *object)
>>   {
>>          unsigned int order = compound_order(page);
>>
>> -       VM_BUG_ON_PAGE(!PageCompound(page), page);
>> +       if (WARN_ON(!PageCompound(page))) {
> 
> If there is a problem then this would be too noisy. Why not WARN_ON_ONCE()?

If lots of abnormal/illegal pages are freed to freelist, the system
could be crash much more easier, with that in mind, I think the original 
logical use BUG_ON().

The ksize() use WARN_ON, looks no one report about too much log.

If we don't want too much dump, I will change it in v3.

> 
>> +               dump_page(page, "invalid free nonslab page");
>> +               pr_warn("object pointer: 0x%p\n", object);
> 
> Actually why not add 'once' semantics for the whole if-block?
> 
>> +       }
>> +
>>          kfree_hook(object);
>>          mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B, -(PAGE_SIZE << order));
>>          __free_pages(page, order);
>> --
>> 2.26.2
>>
> .
> 
