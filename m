Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8897D3CB099
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 03:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhGPB4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 21:56:50 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6940 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhGPB4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:56:48 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GQvMG1HdLz7vBy;
        Fri, 16 Jul 2021 09:50:18 +0800 (CST)
Received: from [10.174.178.125] (10.174.178.125) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 16 Jul 2021 09:53:52 +0800
Subject: Re: [PATCH 1/5] mm/vmscan: put the redirtied MADV_FREE pages back to
 anonymous LRU list
To:     John Hubbard <jhubbard@nvidia.com>
CC:     Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <vbabka@suse.cz>, <axboe@kernel.dk>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <apopple@nvidia.com>, <minchan@kernel.org>,
        <david@redhat.com>, <shli@fb.com>, <hillf.zj@alibaba-inc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20210710100329.49174-1-linmiaohe@huawei.com>
 <20210710100329.49174-2-linmiaohe@huawei.com>
 <YOvtmy9ggJA4KUIQ@dhcp22.suse.cz>
 <9409189e-44f7-2608-68af-851629b6d453@huawei.com>
 <YO1dGvcTLaRJplRQ@dhcp22.suse.cz>
 <ec86d902-1da5-2f49-7324-a796d32ac979@huawei.com>
 <YO2WUx0a5go71Vhm@casper.infradead.org>
 <b17caa5f-f3db-9fb0-fe1f-45510ff902c8@huawei.com>
 <YO7PJCm+1zFPZZPS@casper.infradead.org>
 <b7bb60b6-986d-02c5-e58a-d249c0185092@nvidia.com>
 <0634e9d6-9fcc-e65f-dc5e-bed13004b8fe@huawei.com>
 <a20a937e-da73-0aea-0373-36f01b3a6425@nvidia.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1e1ce97a-2a0c-d0a4-85ad-cf70a85d9146@huawei.com>
Date:   Fri, 16 Jul 2021 09:53:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <a20a937e-da73-0aea-0373-36f01b3a6425@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/16 8:01, John Hubbard wrote:
> On 7/15/21 4:30 AM, Miaohe Lin wrote:
> ...
>>>>> So, it seems lockless GUP can redirty the MADV_FREE page. But is it ok to just release
>>>>> a redirtied MADV_FREE pages? Because we hold the last reference here and the page will
>>>>> be freed anyway...
>>>>
>>>> I don't see how lockless GUP can redirty the page.  It can grab the
>>>> refcount, thus making the refcount here two.  Then the call to freeze
>>>> here fails and the page stays on the list.  But the lockless GUP checks
>>>> the page is still in the page table (and discovers it isn't, so releases
>>>> the reference count).  Am I missing a path that lets lockless GUP dirty
>>>> the page?
>>>>
>>>
>>> If a device driver pins some pages using gup, and the device then uses dma
>>> to write to those pages, then you could get there. That story is part of the
>>> reasoning that led to creating pin_user_pages(), which btw does not yet
>>> fully solve that case.
>>
>> Many thanks for your explanation.
>> So the similar scenario that is clarified in the __remove_mapping() is possible:
> 
> I probably should have added that the scenario I was describing is broken even
> before any patches that you might apply here. I was just trying to ensure that
> the complete list of scenarios was known.
> 

Many thanks for doing this! :)

> 
> 
> thanks,

