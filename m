Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3482F42D566
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 10:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhJNIwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 04:52:41 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13738 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhJNIwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 04:52:40 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HVNNm3srgzWrbl;
        Thu, 14 Oct 2021 16:48:56 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 16:50:34 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 16:50:34 +0800
Message-ID: <9d6f8c72-8bcb-39ce-baa8-00e42e5e97da@huawei.com>
Date:   Thu, 14 Oct 2021 16:50:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] mm/vmalloc: fix numa spreading for large hash tables
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <npiggin@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <edumazet@google.com>,
        <wangkefeng.wang@huawei.com>, <guohanjun@huawei.com>
References: <20210928121040.2547407-1-chenwandun@huawei.com>
 <20210928153302.f87537b5faac8637c3c5eb53@linux-foundation.org>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <20210928153302.f87537b5faac8637c3c5eb53@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/9/29 6:33, Andrew Morton 写道:
> On Tue, 28 Sep 2021 20:10:40 +0800 Chen Wandun <chenwandun@huawei.com> wrote:
> 
>> Eric Dumazet reported a strange numa spreading info in [1], and found
>> commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings") introduced
>> this issue [2].
>>
>> Dig into the difference before and after this patch, page allocation has
>> some difference:
>>
>> before:
>> alloc_large_system_hash
>>      __vmalloc
>>          __vmalloc_node(..., NUMA_NO_NODE, ...)
>>              __vmalloc_node_range
>>                  __vmalloc_area_node
>>                      alloc_page /* because NUMA_NO_NODE, so choose alloc_page branch */
>>                          alloc_pages_current
>>                              alloc_page_interleave /* can be proved by print policy mode */
>>
>> after:
>> alloc_large_system_hash
>>      __vmalloc
>>          __vmalloc_node(..., NUMA_NO_NODE, ...)
>>              __vmalloc_node_range
>>                  __vmalloc_area_node
>>                      alloc_pages_node /* choose nid by nuam_mem_id() */
>>                          __alloc_pages_node(nid, ....)
>>
>> So after commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings"),
>> it will allocate memory in current node instead of interleaving allocate
>> memory.
>>
>> [1]
>> https://lore.kernel.org/linux-mm/CANn89iL6AAyWhfxdHO+jaT075iOa3XcYn9k6JJc7JR2XYn6k_Q@mail.gmail.com/
>>
>> [2]
>> https://lore.kernel.org/linux-mm/CANn89iLofTR=AK-QOZY87RdUZENCZUT4O6a0hvhu3_EwRMerOg@mail.gmail.com/
>>
>> Fixes: 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings")
>> Reported-by: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> 
> This seems like it could cause significant performance regressions in
> some situations?
Yes，I indeed will cause some performance regressions, I will send a 
optimization patch based on this patch.
> 
> If "yes" then wouldn't a cc:stable be appropriate?  And some (perhaps
> handwavy) quantification of the slowdown would help people understand
> why we're recommending a backport.
> 
> If "no" then why the heck do we have that feature in there anyway ;)
> 
> .
> 
