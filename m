Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F4A3C83F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 13:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhGNLjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 07:39:52 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:11276 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhGNLjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 07:39:52 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GPwLd0rQxz1CJld;
        Wed, 14 Jul 2021 19:31:21 +0800 (CST)
Received: from [10.174.178.125] (10.174.178.125) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 14 Jul 2021 19:36:58 +0800
Subject: Re: [PATCH 1/5] mm/vmscan: put the redirtied MADV_FREE pages back to
 anonymous LRU list
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>
CC:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
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
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b17caa5f-f3db-9fb0-fe1f-45510ff902c8@huawei.com>
Date:   Wed, 14 Jul 2021 19:36:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YO2WUx0a5go71Vhm@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/13 21:34, Matthew Wilcox wrote:
> On Tue, Jul 13, 2021 at 09:13:51PM +0800, Miaohe Lin wrote:
>>>> When the MADV_FREE pages are redirtied before they could be reclaimed, the pages
>>>> should be put back to anonymous LRU list by setting SwapBacked flag, thus the
>>>> pages will be reclaimed in normal swapout way.
>>>
>>> Agreed. But the question is why this needs an explicit handling here
>>> when we already do handle this case when trying to unmap the page.
>>
>> This makes me think more. It seems even the page_ref_freeze call is guaranteed to
>> success as no one can grab the page refcnt after the page is successfully unmapped.
> 
> NO!  This is wrong.  Every page can have its refcount speculatively raised
> (and then lowered).  The two prime candidates for this are lockless GUP
> and page cache lookups, but there can be others too.
> 

Many thanks for pointing this out. My overlook! Sorry!
So, it seems lockless GUP can redirty the MADV_FREE page. But is it ok to just release
a redirtied MADV_FREE pages? Because we hold the last reference here and the page will
be freed anyway...

> .
> 

