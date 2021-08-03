Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9863DF093
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbhHCOpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:45:16 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:13272 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbhHCOpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:45:12 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GfHbD2QVmz81hq;
        Tue,  3 Aug 2021 22:40:08 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 3 Aug 2021 22:44:58 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 3 Aug 2021 22:44:56 +0800
Subject: Re: [PATCH] slub: fix unreclaimable slab stat for bulk free
To:     Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>, "Roman Gushchin" <guro@fb.com>,
        Wang Hai <wanghai38@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Linux MM" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210728155354.3440560-1-shakeelb@google.com>
 <8c14efe2-69dc-6eab-3cd5-c042576770e7@huawei.com>
 <CALvZod6usxk99KFhQVXGxBadsYpUyQ3QuwfSDa_sbqSLjBEgnA@mail.gmail.com>
 <35a0b75a-f348-d21c-4ff4-fadba0c4db02@huawei.com>
 <43cf4e71-4dd4-dc37-a70f-553fe5cba126@suse.cz>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <c5d57083-3666-ef75-4269-fbeb5809ddfd@huawei.com>
Date:   Tue, 3 Aug 2021 22:44:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <43cf4e71-4dd4-dc37-a70f-553fe5cba126@suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/8/3 22:29, Vlastimil Babka wrote:
> On 8/3/21 4:24 PM, Kefeng Wang wrote:
>> On 2021/7/29 22:03, Shakeel Butt wrote:
>>> On Wed, Jul 28, 2021 at 11:52 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>> On 2021/7/28 23:53, Shakeel Butt wrote:
>>> I don't have a strong opinion on this. Please send a patch with
>>> reasoning if you want WARN_ON_ONCE here.
>> Ok, we met a BUG_ON(!PageCompound(page)) in kfree() twice in lts4.4, we are
>> still debugging it.
>>
>> It's different to analyses due to no vmcore, and can't be reproduced.
>>
>> WARN_ON() here could help us to notice the issue.
>>
>> Also is there any experience or known fix/way to debug this kinds of issue?
>> memory corruption?
> This would typically be a use-after-free/double-free - a problem of the slab
> user, not slab itself.

We enable KASAN to find whether or not there are some UAF/double free, 
no related

log for now.

>
>> Any suggestion will be appreciated, thanks.
> debug_pagealloc could help to catch a use-after-free earlier

OK, will try this, thanks.

>
>>> .
>>>
> .
>
