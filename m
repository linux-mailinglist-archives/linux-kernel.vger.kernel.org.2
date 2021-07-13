Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C920D3C70B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 14:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbhGMMxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 08:53:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:15009 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbhGMMxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 08:53:30 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GPL4p2P4szbbyh;
        Tue, 13 Jul 2021 20:47:22 +0800 (CST)
Received: from [10.174.178.125] (10.174.178.125) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 13 Jul 2021 20:50:38 +0800
Subject: Re: [PATCH 5/5] mm/vmscan: fix misleading comment in
 isolate_lru_pages()
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <vbabka@suse.cz>, <axboe@kernel.dk>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <apopple@nvidia.com>, <willy@infradead.org>,
        <minchan@kernel.org>, <david@redhat.com>, <shli@fb.com>,
        <hillf.zj@alibaba-inc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210710100329.49174-1-linmiaohe@huawei.com>
 <20210710100329.49174-6-linmiaohe@huawei.com>
 <YOvvFaYMBhISeGEI@dhcp22.suse.cz>
 <ed30bbc5-8438-d399-a9ef-462eda1b6d4e@huawei.com>
 <YO1drWweAjSz8Oa+@dhcp22.suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4ecacfca-4aba-b2c2-bc61-56a7a5d0fb2b@huawei.com>
Date:   Tue, 13 Jul 2021 20:50:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YO1drWweAjSz8Oa+@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/13 17:32, Michal Hocko wrote:
> On Mon 12-07-21 19:16:47, Miaohe Lin wrote:
>> On 2021/7/12 15:28, Michal Hocko wrote:
>>> On Sat 10-07-21 18:03:29, Miaohe Lin wrote:
>>>> We couldn't know whether the page is being freed elsewhere until we failed
>>>> to increase the page count.
>>>
>>> This is moving a hard to understand comment from one place to another.
>>
>> If get_page_unless_zero failed, the page could have been freed elsewhere. I think
>> this looks straightforward but doesn't help a lot. Are you preferring to just
>> remove this comment ?
> 
> Yes the comment in its current form is not really helpful much. Does it
> deserve a single liner to drop it? Likely not on its own without more
> changes in that area.

Sure, I will drop this single patch. And I would send a new patch when I collect enough
misleading/obsolete comments to fix.

Thanks.

> 

