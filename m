Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18E0443BF1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 04:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhKCDmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 23:42:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15350 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhKCDma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 23:42:30 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HkXZl2FVDz90ks;
        Wed,  3 Nov 2021 11:39:43 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (7.185.36.10) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 11:39:52 +0800
Received: from [10.174.176.231] (10.174.176.231) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 11:39:51 +0800
Subject: Re: [PATCH v2] mm, slub: emit the "free" trace report before freeing
 memory in kmem_cache_free()
To:     Vlastimil Babka <vbabka@suse.cz>,
        Tang Yizhou <tangyizhou@huawei.com>, <cl@linux.com>,
        <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <jhubbard@nvidia.com>, <songmuchun@bytedance.com>,
        <willy@infradead.org>, <wuxu.wu@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <a6824ebe-a0ad-fedb-ada3-c362f9c8f363@huawei.com>
 <ee45ee4c-0993-e752-f4fc-fed519b67525@huawei.com>
 <5f3b17ae-bff5-fd0f-cd1e-fa481f100149@suse.cz>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <b15e0bd0-14f3-3fd3-87a5-fe1b0889ad0b@huawei.com>
Date:   Wed, 3 Nov 2021 11:39:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5f3b17ae-bff5-fd0f-cd1e-fa481f100149@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.231]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/2 22:39, Vlastimil Babka wrote:
> On 11/2/21 14:53, Tang Yizhou wrote:
>> On 2021/11/2 19:43, Yunfeng Ye wrote:
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -3526,8 +3526,8 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
>>>  	s = cache_from_obj(s, x);
>>>  	if (!s)
>>>  		return;
>>> -	slab_free(s, virt_to_head_page(x), x, NULL, 1, _RET_IP_);
>>>  	trace_kmem_cache_free(_RET_IP_, x, s->name);
>>> +	slab_free(s, virt_to_head_page(x), x, NULL, 1, _RET_IP_);
>>>  }
>>
>> It seems that kmem_cache_free() in mm/slab.c has the same problem.
>> We can fix it. Thanks.
> 
> Doh, true. Should go best before the local_irq_save() there.
> And also kmem_cache_free() in mm/slob.c.
> 
Yes, I will fix the same problem together in the v3 patch.

Thanks.


> Interestingly kfree() is already OK in all 3 implementations.
> 
>>>  EXPORT_SYMBOL(kmem_cache_free);
>>>
>>
> 
> .
> 
