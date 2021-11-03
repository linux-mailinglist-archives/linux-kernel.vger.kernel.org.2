Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F5C443BF2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 04:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhKCDoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 23:44:12 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15351 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhKCDoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 23:44:11 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HkXcj11vrz90gD;
        Wed,  3 Nov 2021 11:41:25 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (7.185.36.10) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 11:41:27 +0800
Received: from [10.174.176.231] (10.174.176.231) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 11:41:26 +0800
Subject: Re: [PATCH v2] mm, slub: emit the "free" trace report before freeing
 memory in kmem_cache_free()
To:     John Hubbard <jhubbard@nvidia.com>, <cl@linux.com>,
        <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <songmuchun@bytedance.com>, <willy@infradead.org>,
        <wuxu.wu@huawei.com>, Hewenliang <hewenliang4@huawei.com>
References: <a6824ebe-a0ad-fedb-ada3-c362f9c8f363@huawei.com>
 <6ba0f3d0-cf93-9fb3-d691-962e1cb65eb4@nvidia.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <a0217bfe-87da-8f2a-6a40-edd061baad26@huawei.com>
Date:   Wed, 3 Nov 2021 11:41:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6ba0f3d0-cf93-9fb3-d691-962e1cb65eb4@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.231]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/3 2:37, John Hubbard wrote:
> On 11/2/21 04:43, Yunfeng Ye wrote:
>> After the memory is freed, it can be immediately allocated by other
>> CPUs, before the "free" trace report has been emitted. This causes
>> inaccurate traces.
>>
>> For example, if the following sequence of events occurs:
>>
>>      CPU 0                 CPU 1
>>
>>    (1) alloc xxxxxx
>>    (2) free  xxxxxx
>>                           (3) alloc xxxxxx
>>                           (4) free  xxxxxx
>>
>> Then they will be inaccurately reported via tracing, so that they appear
>> to have happened in this order:
>>
>>      CPU 0                 CPU 1
>>
>>    (1) alloc xxxxxx
>>                           (2) alloc xxxxxx
>>    (3) free  xxxxxx
>>                           (4) free  xxxxxx
>>
>> This makes it look like CPU 1 somehow managed to allocate mmemory that
> 
> 
> I see I created a typo for you, sorry about that: s/mmemory/memory/
> 
> But anyway, the wording looks good now. Please feel free to add:
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> 
Ok, I will fix the typo in the v3 patch.

Thanks.

> 
> thanks,
