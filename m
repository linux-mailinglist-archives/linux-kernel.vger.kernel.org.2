Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BE33C9DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240939AbhGOLda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 07:33:30 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:11281 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240679AbhGOLd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 07:33:29 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GQX8l2drwz1CK4j;
        Thu, 15 Jul 2021 19:24:55 +0800 (CST)
Received: from [10.174.178.125] (10.174.178.125) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 15 Jul 2021 19:30:33 +0800
Subject: Re: [PATCH 1/5] mm/vmscan: put the redirtied MADV_FREE pages back to
 anonymous LRU list
To:     John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <vbabka@suse.cz>, <axboe@kernel.dk>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <apopple@nvidia.com>, <minchan@kernel.org>,
        <david@redhat.com>, <shli@fb.com>, <hillf.zj@alibaba-inc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
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
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0634e9d6-9fcc-e65f-dc5e-bed13004b8fe@huawei.com>
Date:   Thu, 15 Jul 2021 19:30:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b7bb60b6-986d-02c5-e58a-d249c0185092@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/15 3:43, John Hubbard wrote:
> On 7/14/21 4:48 AM, Matthew Wilcox wrote:
>> On Wed, Jul 14, 2021 at 07:36:57PM +0800, Miaohe Lin wrote:
>>> On 2021/7/13 21:34, Matthew Wilcox wrote:
>>>> On Tue, Jul 13, 2021 at 09:13:51PM +0800, Miaohe Lin wrote:
>>>>>>> When the MADV_FREE pages are redirtied before they could be reclaimed, the pages
>>>>>>> should be put back to anonymous LRU list by setting SwapBacked flag, thus the
>>>>>>> pages will be reclaimed in normal swapout way.
>>>>>>
>>>>>> Agreed. But the question is why this needs an explicit handling here
>>>>>> when we already do handle this case when trying to unmap the page.
>>>>>
>>>>> This makes me think more. It seems even the page_ref_freeze call is guaranteed to
>>>>> success as no one can grab the page refcnt after the page is successfully unmapped.
>>>>
>>>> NO!  This is wrong.  Every page can have its refcount speculatively raised
>>>> (and then lowered).  The two prime candidates for this are lockless GUP
>>>> and page cache lookups, but there can be others too.
>>>>
>>>
>>> Many thanks for pointing this out. My overlook! Sorry!
>>> So, it seems lockless GUP can redirty the MADV_FREE page. But is it ok to just release
>>> a redirtied MADV_FREE pages? Because we hold the last reference here and the page will
>>> be freed anyway...
>>
>> I don't see how lockless GUP can redirty the page.  It can grab the
>> refcount, thus making the refcount here two.  Then the call to freeze
>> here fails and the page stays on the list.  But the lockless GUP checks
>> the page is still in the page table (and discovers it isn't, so releases
>> the reference count).  Am I missing a path that lets lockless GUP dirty
>> the page?
>>
> 
> If a device driver pins some pages using gup, and the device then uses dma
> to write to those pages, then you could get there. That story is part of the
> reasoning that led to creating pin_user_pages(), which btw does not yet
> fully solve that case.

Many thanks for your explanation.
So the similar scenario that is clarified in the __remove_mapping() is possible:

get_user_pages(&page);
[user mapping goes away]
write_to(page);
				!PageDirty(page)    [good]
SetPageDirty(page);
put_page(page);
				!page_count(page)   [good, discard it]

[oops, our write_to data is lost]

The page can be redirtied after the page is unmapped. And there is no way to restore the page
table as clean MADV_FREE page is simply cleared from page table via the try_to_unmap path.
Is it ok to just release the redirtied MADV_FREE pages here as we hold the last reference
and the page will be freed anyway... ?

> 
> Basically, though, unless a non-CPU device has access to the page, it's
> hard to see how gup itself can lead to a page getting dirtied.
> 
> thanks,

