Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648B4401AA6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 13:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbhIFLny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 07:43:54 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15295 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhIFLnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 07:43:53 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H362N10Y7z8sqS;
        Mon,  6 Sep 2021 19:42:20 +0800 (CST)
Received: from [10.174.178.100] (10.174.178.100) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 6 Sep 2021 19:42:47 +0800
Subject: Re: [PATCH] mm/page_isolation: fix potential missing call to
 unset_migratetype_isolate()
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <mhocko@suse.com>, <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210904092053.33037-1-linmiaohe@huawei.com>
 <dcfcacf2-0018-3b91-6da5-2420bad889c1@redhat.com>
 <ebbef13c-921e-c385-1233-a7aeecec6127@huawei.com>
 <ec7fd827-55c8-120f-4c68-ec0076797d36@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b9e53a7a-b1ae-a581-af3c-6848dada9449@huawei.com>
Date:   Mon, 6 Sep 2021 19:42:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ec7fd827-55c8-120f-4c68-ec0076797d36@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.100]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/6 17:46, David Hildenbrand wrote:
> On 06.09.21 11:38, Miaohe Lin wrote:
>> On 2021/9/6 17:27, David Hildenbrand wrote:
>>> On 04.09.21 11:20, Miaohe Lin wrote:
>>>> In start_isolate_page_range() undo path, pfn_to_online_page() just checks
>>>> the first pfn in a pageblock while __first_valid_page() will traverse the
>>>> pageblock until the first online pfn is found. So we may miss the call to
>>>> unset_migratetype_isolate() in undo path and pages will remain isolated
>>>> unexpectedly. Fix this by calling undo_isolate_page_range() and this will
>>>> also help to remove some duplicated codes.
>>>>
>>>> Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
>>>
>>> While that is true, we shouldn't ever trigger, neither via cma, virtio-mem nor memory offlining, because essentially all operate on MAX_ORDER -1 -aligned ranges without memory holes.
>>
>> I think this should never trigger too. It's a theoretical issue. So is the Fixes tag necessary ?
>>
> 
> I think it's one of these "let's add Fixes: but no need for Cc: stable".
> 
> BUT in older kernels we could have triggered this via memory offlining eventually ... before c5e79ef561b0 ("mm/memory_hotplug.c: don't allow to online/offline memory blocks with holes") ... so maybe even a Cc: stable?

Looks like it could happen in older kernels. Maybe a Cc: stable is necessary.
Many thanks.

> 

